Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRAMXgg>; Sat, 13 Jan 2001 18:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbRAMXg1>; Sat, 13 Jan 2001 18:36:27 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:13060 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129669AbRAMXgN>;
	Sat, 13 Jan 2001 18:36:13 -0500
Date: Sat, 13 Jan 2001 23:36:13 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount, getting closer
In-Reply-To: <Pine.LNX.4.30.0101131700230.1112-100000@svea.tellus>
Message-ID: <Pine.LNX.4.30.0101132300080.1502-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have now tried the SAMSUNG VG34323A disk with two other controllers at
home (Promise ATA100 an VIA vt82c686a rev 0x22, both on an ASUS A7V
motherboard), and there are no problems to be found with DMA enabled.
Streaming 10 MB/s without glitches.

However, writing to the SAMSUNG VG34323A disk with DMA enabled on either
this machine [1] (at work, using the VIA IDE driver version 3.11)

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 23)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)

or this machine [2] (at work, using the VIA IDE driver version 2.1e)

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 1b)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)

I get exactly the following errors on both machines

hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }

no matter what cable I use.  When I get this, the machine does not recover
most of the time, and I have to reset or power cycle.  This disc works
flawlessly on two other IDE controllers, so I do not think that the disk
is completely broken. It must be either these chipsets or the driver in
combination with this disk.  Note that I _can_ use another UDMA66 disk
_with_ DMA enabled on both machine [1] and [2] above without problems.
Also, 2.2.16-22 seems to work with DMA enabled on machine [1].  I have not
tried 2.2.16-22 with DMA enabled on machine [2].

The problem I reported at first, hence the nasty subject, was a hang and a
nasty fs corruption when RH7 tried to remount the root fs read-write.  I
examined the RH7 init scripts, or more precisely /etc/rc.sysinit, and
discovered, to my great disgust, that the stupid thing disables the dmesg
output on the console very early in the script.  It is thus entirely
possible that I do get the above mentioned errors when the computer seems
to hang, and my fs gets corrupted.  I will fix the script tomorrow to see
if my assumption is correct.

SUMMARY:  I have a disk that with DMA enabled give me CRC errors on two
machines, but not on two other, independent on the cable.  Both troubling
machines do not recover from these errors.  Linux 2.2.16-22 from RedHat
works fine with DMA enabled on machine [1], [2] is unknown.

I hope this makes things a lot clearer.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
