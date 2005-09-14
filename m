Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbVINJmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVINJmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVINJmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:42:39 -0400
Received: from easyconnect2121136-192.clients.easynet.fr ([212.11.36.192]:8070
	"EHLO mail.aerostyle.com") by vger.kernel.org with ESMTP
	id S965121AbVINJmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:42:38 -0400
Message-ID: <33296.85.68.36.53.1126690932.squirrel@212.11.36.192>
In-Reply-To: <43272B9D.1030301@zytor.com>
References: <33542.85.68.36.53.1126619176.squirrel@212.11.36.192>
    <432722A1.8030302@tuxrocks.com> <43272B9D.1030301@zytor.com>
Date: Wed, 14 Sep 2005 11:42:12 +0200 (CEST)
Subject: Re: [i386 BOOT CODE] kernel bootable again
From: "Pascal Bellard" <pascal.bellard@ads-lu.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Frank Sorenson" <frank@tuxrocks.com>, pascal.bellard@ads-lu.com,
       riley@williams.name, linux-kernel@vger.kernel.org
Reply-To: pascal.bellard@ads-lu.com
User-Agent: SquirrelMail/1.4.2
X-Priority: 3
Importance: Normal
X-Sanitizer: Advosys mail filter
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Frank Sorenson wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Pascal Bellard wrote:
>>
>>>Hello,
>>>
>>>Please find attached a patch to build i386/x86_64 kernel directly
>>>bootable. It may be usefull for rescue floppies and installation
>>>floppies.
>>
>>
>> Pascal,
>>
>> In commit f8eeaaf4180334a8e5c3582fe62a5f8176a8c124, build.c has already
>> changed, and I don't believe it's very compatible with this change.
>>
>> See
>> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8eeaaf4180334a8e5c3582fe62a5f8176a8c124
>>
>> Also, we'll need to see comments from H. Peter Anvin on this patch.
>> CC'ing him.
>>
>
> Geometry detection by looking for error returns is fundamentally broken.
>   Way too many non-traditional floppies (USB, IDE...) do not handle this
> at all, they will return successfully, with the data being the data from
> a sector from another track, and thus you end up with aliasing and a
> corrupt boot.  You can do it with fingerprinting, but that's complex and
> error-prone.
>
The bootblock code is 497 bytes long. It must as simple as possible.
Complex algorithms like fingerprinting can't be used.

Geometry detection works with usual floppies. This patch goal is to
support them like < 2.6 bootblocks did and fix 1M limitation and
special formatting like 1.68M floppies.

Geometry detection may work with non-traditional floppies but is not
designed to.

BTW, if this kind of floppies doesn't handle error, it's a bug in the
firmware, but not in bootblock code !

> In short, this made sense in 1991, but it hasn't made sense for a very
> long time now.  Resurrecting bootsect.S is *NOT* a good idea.
>
1.44M floppies are told dead for more than 10 years. In 2005 most of
computers are sold with these drives. Sometime I have to boot with
a floppy when nothing works (blush).

Kernel code is always growing. The bootblock spares filesystem and
external kernel loader overhead.

While linux kernel has a floppy driver the bootblock is usefull.

Now two solutions:

- without this patch = linux kernel are never directly bootable
- with this patch = linux kernel is directly bootable with some
  devices.

What is the better idea ?

-pascal
