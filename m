Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSH1R5Z>; Wed, 28 Aug 2002 13:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSH1R5Z>; Wed, 28 Aug 2002 13:57:25 -0400
Received: from p50846B1C.dip.t-dialin.net ([80.132.107.28]:40935 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S316795AbSH1R5X>;
	Wed, 28 Aug 2002 13:57:23 -0400
To: linux-kernel@vger.kernel.org
Subject: PDC20262 IDE - DMA no go?
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Wed, 28 Aug 2002 20:01:41 +0200
Message-ID: <m31y8iooai.fsf@terra.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Common Lisp,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

OK, I'll just tell the story in the order it happened:

A. I'm using 2.4.19-rc1-ac2, UDMA(66) enabled on primary master
(Maxtor 6L060J3, 60G). Works flawlessly under normal workloads, stress
testing not done - no observed problems. IDE DMA does not work against
the PX-W1610 on the second channel of the PDC (IDE channel/writer
completely hang when I try to enable it), well, it sucks (12x upwards
burning is impossible without BurnProof - no problem under Winblows),
but I can live with that for a few kernel versions.

B. The 60G disk breaks (bad sectors), I get a Maxtor 4G120J6 (120G)
drive as a temporary replacement. The planned course of action was to
block-copy from the old to the new drive, see what is salvagaeable and
what has to be restored from tapes (not all file systems on the disk
in question are on backup, such as the "gaming os"). That way I can
block-copy back when the replacement 60G arrives.  Fun: The kernel on
the RH 7.3 install cds does not like the 120G disk (hangs on ide drive
detection). OK, so I boot from the old drive, umount/remount -o ro,
and do the block copy (using dd_rescue; total of ~20 bad sectors).

C. Copy is done, boot from the new drive. The 2.4.19-rc1-ac2 works,
but will not get the filesystems consistently fixed - i.e. it shows
problems, I let it fix them, I run fsck again, it shows different
problems, and so on.

D. I think the fs is hosed, format it and restore from backup. Next
fsck shows it has errors. Correct them. Just to be on the safe side,
reboot and fsck again. Guess what. So it seems that in this
configuration an fsck under 2.4.19-rc1-ac2 would corrupt the fs it's
trying to fix.

E. OK, so I compile more current kernels. 2.4.19 (final),
2.4.19-ac4. They don't like the disk either, hang forever (> 10 mins)
at "checking partitions: hde:" (hde is the only hdd connected to the
PDC).

F. Try 2.4.20-pre4-ac2. Warns about UDMA66 only possible with a
80-conductor cable, and that it is downgrading to UDMA33. Huh? The
"game OSs" on the same box do use the disk in UDMA66 mode without
further hiccups. Still hangs at "checking partitions: hde:", but only
for about 30 seconds. Then it complains about "Timeout waiting for
DMA", "dma_timer_expiry: dma status == 0x21"; says it's resetting the
primary channel. After a few repetitions of this it continues booting
with DMA disabled. So far, the system is stable in that configuration;
but not much fun :-(

Other important machine data:
GigaByte GA-6BX7+ (Intel 440BX, OnBoard PDC 20262)
Intel Pentium III 800
Matrox G450 32MB
NetGear FA-311
Adaptec 2940 (legacy scanner, cdrom, dvd-rom)

Is there "land in sight" regarding the PDC20262 support? Digging
around on the mailing list etc. shows mostly things like "except in
the known bad configurations", "has been like <this> forever", etc. -
Is there someplace I can get concise information about the state of
IDE support in particular? A listing of all the "black magic" options
which is not a year or more out of date would be nice, too...

>From my other point of view, as a system builder/integrator: Which
("cost-effective") IDE controllers or chipsets *do* work fast and
stable under Linux, and are supposed to stay that way a little while?


-- Warning -- rant ahead --

Are we going back to the times where you *require* SCSI to get decent
disk support in Unix? Except now it's not (purely) the hardware's
fault? Do not take this as an offence, please - just being frustrated
here. It's just that the main advantage of *ix over certain other OSs
- "no matter how hard I push it, it won't shred my data" - wich used
to hold true to Linux since at least 0.99.14 as well - seems to slowly
be going down the drain. Yes, I *could* run a kernel "old enough" to
be stable, but then I'd also like to take advantage of "average"
hardware and its new features. Not that the machine in question is
particularly 'cutting edge'. To make myself clear: Since I got that
machine a good 2 years ago I'm waiting for fast and stable IDE
support...

Sorry, that needed out... Anyway, keep up the great work!


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
