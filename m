Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSHHJEp>; Thu, 8 Aug 2002 05:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSHHJEp>; Thu, 8 Aug 2002 05:04:45 -0400
Received: from h-66-134-202-172.SNVACAID.covad.net ([66.134.202.172]:6576 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317399AbSHHJEn>; Thu, 8 Aug 2002 05:04:43 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 8 Aug 2002 02:08:10 -0700
Message-Id: <200208080908.CAA10230@adam.yggdrasil.com>
To: mingo@elte.hu
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
Cc: alan@lxorguk.ukuu.org.uk, Andries.Brouwer@cwi.nl, dalecki@evision.ag,
       johninsd@san.rr.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
>Hi Inusing 2.5.29 (vanilla or BK-curr) i cannot use /sbin/lilo anymore to
>update the partition table.
>
>if i do it then the partition table gets corrupted and the system does not
>boot - it stops at 'LI'. (iirc meaning that the second-stage loader does
>not load?) Using a recovery CD fixes the problem, so it's only the
>partition info that got trashed, not the filesystem.
>
>i use IDE disks.
>
>this makes development under 2.5.29 quite inconvenient - i have to boot
>back into another kernel whenever loading a new kernel.

Hi Ingo,

	It might clarify things if you could identify:

	o the last version of 2.5 that worked for you,
	o the version of 2.4 that works for you,
	o the version of lilo that you are using for all of this.

	Back in May, I experienced some similar problem and discussed
it with John Coffman, the lilo maintainer, whom I am cc'ing.

	I'll just quote two parts of an email that he sent me during
our discussion.  It's a little more relevant to your message if I
quote them out of order:

| The head/sector mismatch check (fn 8h/fn 48h) has actually been in LILO
| since last year (22.0), and the (kernel/bios) check since 22.2.  It has
| only been seriously visible since the introduction of the 2.4.18 kernel.
| The IDE disk drivers are now reporting actual IDE disk geometry, rather
| than the mapped BIOS geometry, which was reported by all previous kernels.
| This change in the results returned by the IOCTL used to get the disk
| geometry has been extremely annoying.  It also leads to complaints about
| the format of the partition table.

	Earlier in that seem email, he indicated that he was
thinking about giving precedence to the BIOS geometry in future
versions of lilo (this was 22.3, and I believe the current version is
now 22.3.1):

| Actually, on serious reflection on the issue, there is no choice:  the
| value returned by (int 13h/fn 8h) should be used, if it is available.  This
| is the value used by the conversion routine (linear/lba32 -> geometric) in
| the boot loader (read.S).  Currently, the kernel value is given precedence;
| I am seriously reviewing this issue.

	I just wonder if this is the problem that you are experiencing
rather than anything that was new in 2.5.29.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
