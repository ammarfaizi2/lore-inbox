Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265403AbRF0U4U>; Wed, 27 Jun 2001 16:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265398AbRF0U4K>; Wed, 27 Jun 2001 16:56:10 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:33033 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265403AbRF0Uz7>;
	Wed, 27 Jun 2001 16:55:59 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106272055.f5RKtur331470@saturn.cs.uml.edu>
Subject: Re: [PATCH] User chroot
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 27 Jun 2001 16:55:56 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <3B395FE5.1070208@zytor.com> from "H. Peter Anvin" at Jun 26, 2001 09:24:05 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Albert D. Cahalan wrote:

>> Normal users can use an environment provided for them.
>>
>> While trying to figure out why the "heyu" program would not
>> work on a Red Hat box, I did just this. As root I set up all
>> the device files needed, along Debian libraries and the heyu
>> executable itself. It was annoying that I couldn't try out
>> my chroot environment as a regular user.
>>
>> Creating the device files isn't a big deal. It wouldn't be
>> hard to write a setuid app to make the few needed devices.
>> If we had per-user limits, "mount --bind /dev/zero /foo/zero"
>> could be allowed. One way or another, devices can be provided.
>
> Hell no!  This would give the user a way to subvert root or other
> system-provided things by having device nodes or such appear where
> they aren't expected.  NOT GOOD.

On every normal (default Red Hat or Debian at least) system
this is already trivial:

ln /dev/zero /tmp/zero
ln /dev/hda ~/hda
ln /dev/mem /var/tmp/README

So the user often can provide device nodes. The above is _worse_
than allowing "mount --bind ..." because the admin has to search
the whole filesystem to find such links.

Never mind that though; it doesn't matter how the devices are
created. Social engineering can work. Once the device problem
is taken care of, chroot() becomes useful for normal users.

BTW, it is way wrong that /dev/zero should be needed at all.
Such use is undocumented ("man zero", "man mmap") anyway, and
AFAIK one should use mmap() with MAP_ANON instead. Not that
the documentation on MAP_ANON is any good either, but at least
the mere existence of the flag is mentioned.


