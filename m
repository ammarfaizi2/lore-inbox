Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVIBMlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVIBMlf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 08:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVIBMlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 08:41:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:59605 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751260AbVIBMle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 08:41:34 -0400
Subject: Re: IDE HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: ataraid-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f0509020027212e6c42@mail.gmail.com>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Sep 2005 14:05:32 +0100
Message-Id: <1125666332.30867.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the formula is to fix all the userspace apps to take into account a
> potential HPA, then eg. FDISK + SFDISK + Disk Druid et al should also
> be fixed.  Because if you create a partition spanning your entire
> disk, including the HPA area, and your boot files by some coincidence
> ends up in the HPA part of the disk, the BIOS won't be able to read
> them, and your system will not boot.  And if you fix those tools now,

The distribution vendors already put the boot area low down the disk to
handle a whole variety of problems like this and the 1024 cylinder limit
on old BIOSes. 

> what about users that use older Linux distributions?  They'll have a
> parade of problems coming to them with their new HPA-enabled disks
> because every userspace tool assumes that <BIOS sector count == Linux
> sector count>.

I work for a vendor. I get most of our IDE layer bugs. And do you know
HPA doesn't really feature. The broken locking does, the hangs on
changing down speed by CRC do, numerous fascinating platform specific
bugs do, people with cables backwards do. HPA doesn't. It just works out
for people.

> > It isnt the kernels fault if you compute from of end of disk rather than
> > from end of non reserved area is it ?
> 
> I agree that the entire disk should be visible under Linux.  But
> instead of fixing every userspace app that assumes <BIOS sector count
> == Linux sector count> (I'm guessing that's a lot), how about simply
> exporting the HPA as /dev/ide/hostX/busY/targetZ/lunA/hpa, next to the
> 'disc' device ?


A lot of applications assume Linux reported size == real disk size. It
also wouldn't solve the case of a file system that spans both inside and
outside the HPA.

Alan

