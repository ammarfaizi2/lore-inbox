Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSCXIWf>; Sun, 24 Mar 2002 03:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311753AbSCXIW0>; Sun, 24 Mar 2002 03:22:26 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:40196
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311752AbSCXIWM>; Sun, 24 Mar 2002 03:22:12 -0500
Date: Sun, 24 Mar 2002 00:21:52 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18: many IDE errors
In-Reply-To: <3C9D8844.8DA9298C@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.10.10203240014430.2377-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is not a case of bad cables but maybe cable routing.
Also, four 160GB disks eat power!

I have a box dual athlon similar setup w/ 460W ps
I have to wait for the PS to warm up or there is not enough juice to
properly spin up the last drive.  However if I replace the four 160GB's
with four 20GB Seagate's no problem.

You are going to need at least a 400W PS w/ almost no ripple to make it
work.  If you have this then check the cable routing.

Also hdparm -i /dev/hdX to see if their transfer rates are reduced.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 24 Mar 2002, Eyal Lebedinsky wrote:

> I have six disks in the machine, each a master on the cable. Two are
> on the on-board controller and Four are on two PCI ATA-100 cards.
> 
> I am getting disk error (BadCRC) on all disks, intermittently.
> 
> I upgraded from RH 2.4.9 (with SGI xfs) to 2.4.18+xfs. Same problem.
> I then applied the 2.4.18-rc1 IDE patches with no improvement (well,
> the four 160GB disks are now fully visible and not clipped to 28bits
> which is a nice surprise).
> 
> I checked the memory, replaced the power supply with a hefty 400W,
> I even used a recent mobo (Gigabyte GA-6VTXE). No beef, practically
> the same rate of errors.
> 
> I do not believe all six cables are bad (80w all). This is a UP, and
> I did not enalbe local APIC. Should I?
> 
> Any ideas where to go from here? On request I have boot messages
> (with errors) and lspci output - I prefer not to overload the list.
> 
> The setup is two WD 60GB disks (hda/hdc) which host the root fs (ext2)
> a working area (md2=RAID0, most of the space) and an xfs log
> (md1=RAID1).
> 
> hde/g/i/k are Maxtor 160GB, RAID5, xfs (with external log on md0).
> 
> I get errors intermittently on all, here is an example after a boot
> following the creation of the raid5 (so a sync was running for about
> two hours).
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide0: reset: success

Safe transfer rate down grade!

> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide1: reset: success

Safe transfer rate down grade!

> hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
> md: md1: sync done.
> raid5: resync finished.
> hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
> invalidate: busy buffer

GAK!


