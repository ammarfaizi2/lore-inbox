Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280725AbRKYE5n>; Sat, 24 Nov 2001 23:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280718AbRKYE5d>; Sat, 24 Nov 2001 23:57:33 -0500
Received: from jik-0.dsl.speakeasy.net ([66.92.77.120]:4868 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id <S280709AbRKYE5U>; Sat, 24 Nov 2001 23:57:20 -0500
Date: Sat, 24 Nov 2001 23:57:18 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
Message-Id: <200111250457.fAP4vIt03205@jik.kamens.brookline.ma.us>
To: linux-kernel@vger.kernel.org
Subject: IDE: 2.2.19+IDE patches works fine; 2.4.x fails miserably;
   please help me figure out why!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For months now, I've been trying every 2.4.x kernel as it comes out.
Every time, I start getting IDE errors shortly after booting into the
2.4.x kernel.  My filesystems aren't totally trashed, but lots of the
new data being written to the filesystems are trashed and I have to
fix a bunch of errors with fsck and recreate those trashed new files
after reverting to my 2.2.19 kernel (to which I have applied Andre's
IDE patches).

When I use "hdparm" to examine the settings of all of my hard drives
in 2.2.19 and 2.4.x, the only difference is that the 2.4.x kernel
sets multcount to 16 by default while 2.2.19 sets it to 0 by default.
Setting multcount to 0 with 2.4.x for all my drives does not help -- I
still get the errors as soon as I start trying to do lots of disk
activities.

Here's an example of the errors I got in the last go-around before I
gave up on 2.4.16-pre1 (with irrelevant fields removed to make the
syslog output easier to read):

  22:58:56 hde: timeout waiting for DMA
  22:58:58 hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  22:58:58 hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  22:58:59 hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  22:58:59 hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  22:58:59 hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  22:58:59 hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  22:58:59 hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  22:58:59 hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  22:59:19 hde: timeout waiting for DMA
  23:00:23 hde: timeout waiting for DMA
  23:00:24 hde: timeout waiting for DMA
  23:00:24 hdg: timeout waiting for DMA
  23:00:31 hdg: timeout waiting for DMA
  23:00:33 hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  23:00:33 hdg: drive not ready for command

I've seen people mention in comp.os.linux.development.system that the
BadCRC error may indicate a cable problem.  However, (a) I'm pretty
certain that I'm using Ultra66 cables for both hde and hdg, and (b) if
that's the problem, why don't I get the same errors with 2.2.19?

As for (a), I believe I've got the right cables because I checked when
I installed them and because the controller (Promise Ultra66)
recognizes both hde and hdg as Ultra-capable drives when it starts up
(which it wouldn't do if I didn't have the correct cables -- I know
this because it wasn't doing it when I didn't have the correct cables
;-).

As for (b), is 2.4.x more paranoid about and/or better at checking
CRCs than 2.2.19 was?

I should note that when the errors shown in the log above are
happening, I'm also seeing "Lost interrupt" messages on my console for
hde or hdg.

Appended below are the pertinent details about the two drives that are
giving me trouble.  If anyone can offer *any* insights into what I can
do to debug and solve this problem, I'd much appreciate it.  Until I
can solve it, I'm stuck using 2.2.x, which is unfortunate since (a)
Andre has stopped maintaining his IDE backport patches for new 2.2.x
versions and (b) there's functionality in 2.4.x that I want to use.

Thank you,

  Jonathan Kamens

		      *************************

/dev/hde:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 524/255/63, sectors = 8421840, start = 0

/dev/hde:

non-removable ATA device, with non-removable media
	Model Number:		SAMSUNG SV0432D                         
	Serial Number:		0125J1EK821690	Firmware Revision:	KS100   
Standards:
	Supported: 1 2 3 
	Likely used: 4
Configuration:
	Logical		max	current
	cylinders	8912	8912
	heads		15	15
	sectors/track	63	63
	bytes/track:	32256		(obsolete)
	bytes/sector:	512		(obsolete)
	current sector capacity: 8421840
	LBA user addressable sectors = 8421840
Capabilities:
	LBA, IORDY(can be disabled)
	Buffer size: 480.0kB	ECC bytes: 4	Queue depth: 1
	Standby timer values: spec'd by Vendor
	r/w multiple sector transfer: Max = 16	Current = 0
	DMA: sdma0 sdma1 sdma2 *mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 (?)
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
		Host Protected Area feature set
		Power Management feature set
		SMART feature set
		DOWNLOAD MICROCODE cmd

/dev/hdg:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1868/255/63, sectors = 30015216, start = 0

/dev/hdg:

non-removable ATA device, with non-removable media
	Model Number:		Maxtor 51536U3                          
	Serial Number:		K3H0XSDC            
	Firmware Revision:	DA620CQ0
Standards:
	Used: ATA/ATAPI-4 T13 1153D revision 17 
	Supported: 1 2 3 4 5 & some of 5
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	bytes/track:	0		(obsolete)
	bytes/sector:	0		(obsolete)
	current sector capacity: 16514064
	LBA user addressable sectors = 30015216
Capabilities:
	LBA, IORDY(can be disabled)
	Buffer size: 2048.0kB	ECC bytes: 57	Queue depth: 1
	Standby timer values: spec'd by standard, no device specific minimum
	r/w multiple sector transfer: Max = 16	Current = 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	look-ahead
	   *	write cache
	   *	Power Management feature set
		SMART feature set
		Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct
