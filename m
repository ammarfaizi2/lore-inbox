Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265220AbRF0DdV>; Tue, 26 Jun 2001 23:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbRF0DdL>; Tue, 26 Jun 2001 23:33:11 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:9992 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265220AbRF0DdC>;
	Tue, 26 Jun 2001 23:33:02 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106270332.f5R3WxU277042@saturn.cs.uml.edu>
Subject: Re: [PATCH] User chroot
To: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 26 Jun 2001 23:32:59 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9hb6rq$49j$1@cesium.transmeta.com> from "H. Peter Anvin" at Jun 26, 2001 04:46:02 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> [somebody]

>> Have you ever wondered why normal users are not allowed to chroot?
>>
>> I have. The reasons I can figure out are:
>>
>> * Changing root makes it trivial to trick suid/sgid binaries to do
>>   nasty things.
>>
>> * If root calls chroot and changes uid, he expects that the process
>>   can not escape to the old root by calling chroot again.
>>
>> If we only allow user chroots for processes that have never been
>> chrooted before, and if the suid/sgid bits won't have any effect under
>> the new root, it should be perfectly safe to allow any user to chroot.
>
> Safe, perhaps, but also completely useless: there is no way the user
> can set up a functional environment inside the chroot.  In other
> words, it's all pain, no gain.

Normal users can use an environment provided for them.

While trying to figure out why the "heyu" program would not
work on a Red Hat box, I did just this. As root I set up all
the device files needed, along Debian libraries and the heyu
executable itself. It was annoying that I couldn't try out
my chroot environment as a regular user.

Creating the device files isn't a big deal. It wouldn't be
hard to write a setuid app to make the few needed devices.
If we had per-user limits, "mount --bind /dev/zero /foo/zero"
could be allowed. One way or another, devices can be provided.


