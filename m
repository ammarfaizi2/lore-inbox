Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280915AbRKLSdW>; Mon, 12 Nov 2001 13:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280911AbRKLSdM>; Mon, 12 Nov 2001 13:33:12 -0500
Received: from sttldslgw16poolA74.sttl.uswest.net ([63.231.36.74]:603 "EHLO
	jerry-garcia.accessgroupinc.com") by vger.kernel.org with ESMTP
	id <S280915AbRKLSdH>; Mon, 12 Nov 2001 13:33:07 -0500
Date: Mon, 12 Nov 2001 10:32:23 -0800
Message-Id: <200111121832.KAA11536@jerry-garcia.accessgroupinc.com>
From: Bob Ramstad <rramstad@alum.mit.edu>
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
In-Reply-To: <E163Lbk-0006eA-00@the-village.bc.nu> (message from Alan Cox on
	Mon, 12 Nov 2001 18:14:56 +0000 (GMT))
Subject: Re: IDE SiS730 / SiS5513 incorrect defaults kernel 2.4.9
In-Reply-To: <E163Lbk-0006eA-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   > Oct 22 12:46:12 accessgroupinc kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
   > Oct 22 12:46:12 accessgroupinc kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }

   Cable error. At least thats what the drive saw and the checksum is
   computed controller<->drive without our involvement

A cable problem seems doubtful to me, but then again, I don't know
anything about how this code works.

I think it is important to remember that the earlier kernel versions
did NOT give me any errors.  Errors occur with more recent kernels
with the exact same cables.  (FYI, I read the archives, knew this was
a possible problem, the cables are new, I've swapped them with others
that I have handy with no change in behavior... they are 80 conductor
brand new Cables To Go ATA100 UDMA5 cables.)

   > My primary concern is that the IDE driver seems to be making different
   > choices in 2.4.9-13 for this chipset, and earlier kernels are making
   > better choices -- or possibly failing silently?  In any case, I

   It may be the new kernel is smart enough to enable UDMA 100 and the cables
   are marginal. The CRC error is a corruption that is then retried. Multiple
   retries cause the kernel to drop to a lower UDMA speed

Right, except that my hdparm settings manually enable UDMA 100 with
absolutely no problem, and this occurs AFTER the errors.

Using "hdparm -Tt /dev/hdb" "hdparm /dev/hdb" "hdparm -i /dev/hdb" it
appears that the settings have worked, the disks are running in UDMA
100 with no errors except during the boot sequence.

I don't know how to get the system to tell me what initial settings
have been tried, but after the errors and the ide bus reset,
rc.sysinit sets parameters for the disks, and everything is fine from
there.

-- Bob

