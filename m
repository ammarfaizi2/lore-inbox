Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSGAUpj>; Mon, 1 Jul 2002 16:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSGAUpi>; Mon, 1 Jul 2002 16:45:38 -0400
Received: from mail.inin.com ([204.180.46.4]:56681 "EHLO
	i3exchange.i3domain.inin.com") by vger.kernel.org with ESMTP
	id <S316500AbSGAUph> convert rfc822-to-8bit; Mon, 1 Jul 2002 16:45:37 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: yet another VIA IDE corruption (NOT Southbridge)
Date: Mon, 1 Jul 2002 15:48:00 -0500
Message-ID: <58A40B582A73F54AB5D8739C0678F3A8BC489B@i3exchange.i3domain.inin.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: yet another VIA IDE corruption (NOT Southbridge)
Thread-Index: AcIhQJYr6mvmSZhpR/+BhGqC0bZ3Nw==
From: "Fuller, Rob" <Rob.Fuller@inin.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure everybody is as sick of reading about these problems as I am,
but it is a pretty frustrating experience, and maybe another data point
will help.

I used my system without trouble for roughly two years
before enabling DMA in December 2001.  The DMA makes a huge difference
in terms of performance.  (No waiting for my keystrokes to display
during heavy disk IO.)

I have two Ultra-DMA hard drives on a Tyan Tiger 133 motherboard
(Tyan part S1834) with a VIA chipset and dual Intel Pentium III's.
Both drives are on the primary IDE interface.  I have the correct
80-wire IDE cables.  The system is on an APC UPS, and the network line
is filtered.  The memory in the system is fine (at least I never
see any unusual signals when compiling with gcc.)

I finally got bitten (by VIA? by Creative Labs? by Linux?) Saturday.
One of the two Ultra-DMA drives had two partitions each of which
had corrupt superblocks.  I tried to restore these two partitions
with their backup superblocks, and discovered massive inode table
corruption.  The root partition was about 50% recovered,
and the home partition was complete soup when fsck was done.

The second hard drive's single partition had a corrupt superblock.
The backup superblock was fine.  This drive was completely recovered.
I use it for mirroring FTP sites.  Thus, the drive is filled with .gz,
.zip, and .bz2 files that pass their integrity checks.  I don't think
I did much with this file system the last time that system was booted.

I re-installed Debian after the corruption.  Then I built and installed
kernel-2.2.21 in order to see if the "SouthBridge fix" would display
the message, "Applying VIA southbridge workaround."  The answer is NO.
I have the kernel built with PCI quirks included.  Perhaps this controller
ISN'T one of the suspected VIA parts?

Anyway, here are the PCI bus details:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 23)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050 (rev 30)
00:10.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 02)
00:11.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
00:11.1 Input device controller: Creative Labs SB Live! (rev 08)
00:12.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 03)
00:12.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5144

This last device is an ATI Radeon 32 MB video controller.

Here are the hard drives:

/dev/hda:

 Model=QUANTUM FIREBALLP LM30, FwRev=A35.0700, SerialNo=186014438960
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=3(DualPortCache), BuffSize=1900kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=58633344
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2 
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 mode3 *mode4 

/dev/hdb:

 Model=Maxtor 96147U8, FwRev=BAC51KJ0, SerialNo=N8058L8C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=120060864
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2 
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 mode3 *mode4 

Please advise.  Do I replace the motherboard, the sound board, the OS?
There's really nothing else available I'd rather run than Linux,
but my files are kind of important to me :-)
