Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbTBHWZv>; Sat, 8 Feb 2003 17:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbTBHWZv>; Sat, 8 Feb 2003 17:25:51 -0500
Received: from h-64-105-35-123.SNVACAID.covad.net ([64.105.35.123]:47850 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267122AbTBHWZu>; Sat, 8 Feb 2003 17:25:50 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 8 Feb 2003 14:35:23 -0800
Message-Id: <200302082235.OAA26038@adam.yggdrasil.com>
To: gf@unixsol.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Feb 2003, Georgi Chorbadzhiyski wrote:
>Jochen Hein wrote:
>> Andrew Morton <akpm@digeo.com> writes:
>>>. Adam's cleanup and cutdown of devfs has been put back in again.  We
>>>  really need devfs users to test this and to report, please.  (And not just
>>>  to me!  I'll only bounce it to Adam J.  Richter <adam@yggdrasil.com>
>>>  anyway)
>> 
>> Ok, I patched 2.5.59 with Adam's patch and it boots fine.  I miss the
>> file /dev/.devfsd - Debian uses that file to detect devfs and act
>> accordingly.  Still in the first minutes, I'll get back when Linus has

>Slackware does the same.

	Distributions that want to do something different for devfs
can parse /proc/mounts, or, less reliably, do statfs("/dev", &statfs_buf)
and look at statfs_buf.f_type.  So, you still have this ability without
the need for additional kernel code.

	It's worth noting that some devfs users may want the non-devfs
behavior (which I assume means creating /dev files during some
installation process) because they may have a script to save /dev
before shutdown and restore their additional /dev nodes at boot, so
you probably want to centralize this decision in some little script
anyhow.  The devfsd (for the stock devfs) has a couple of commands
designed for this, although this can just as easily be done in scripts
for boot and shutdowns.

	Also, I suppose that checking for /dev/.devfsd is an easy way
to detect _which_ devfs you are using, although I don't know if such a
check is useful, since you could start devfsd unconditionally and it
should just exit if the old devfs is not present.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
