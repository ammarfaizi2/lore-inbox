Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311739AbSCXIDk>; Sun, 24 Mar 2002 03:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311743AbSCXIDa>; Sun, 24 Mar 2002 03:03:30 -0500
Received: from CPE-203-51-26-136.nsw.bigpond.net.au ([203.51.26.136]:43257
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S311739AbSCXIDU>; Sun, 24 Mar 2002 03:03:20 -0500
Message-ID: <3C9D8844.8DA9298C@eyal.emu.id.au>
Date: Sun, 24 Mar 2002 19:03:16 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.18: many IDE errors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have six disks in the machine, each a master on the cable. Two are
on the on-board controller and Four are on two PCI ATA-100 cards.

I am getting disk error (BadCRC) on all disks, intermittently.

I upgraded from RH 2.4.9 (with SGI xfs) to 2.4.18+xfs. Same problem.
I then applied the 2.4.18-rc1 IDE patches with no improvement (well,
the four 160GB disks are now fully visible and not clipped to 28bits
which is a nice surprise).

I checked the memory, replaced the power supply with a hefty 400W,
I even used a recent mobo (Gigabyte GA-6VTXE). No beef, practically
the same rate of errors.

I do not believe all six cables are bad (80w all). This is a UP, and
I did not enalbe local APIC. Should I?

Any ideas where to go from here? On request I have boot messages
(with errors) and lspci output - I prefer not to overload the list.

The setup is two WD 60GB disks (hda/hdc) which host the root fs (ext2)
a working area (md2=RAID0, most of the space) and an xfs log
(md1=RAID1).

hde/g/i/k are Maxtor 160GB, RAID5, xfs (with external log on md0).

I get errors intermittently on all, here is an example after a boot
following the creation of the raid5 (so a sync was running for about
two hours).

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide1: reset: success
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
md: md1: sync done.
raid5: resync finished.
hdi: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdi: dma_intr: error=0x84 { DriveStatusError BadCRC }
invalidate: busy buffer


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
