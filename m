Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUF3Llu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUF3Llu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 07:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266625AbUF3LjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 07:39:15 -0400
Received: from duchamp.tecgraf.puc-rio.br ([139.82.85.1]:48396 "EHLO
	tecgraf.puc-rio.br") by vger.kernel.org with ESMTP id S266628AbUF3Lgm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 07:36:42 -0400
Date: Wed, 30 Jun 2004 08:41:42 -0300
From: Andre Costa <costa@tecgraf.puc-rio.br>
To: linux-kernel@vger.kernel.org
Subject: 2.4.26: IDE drives become unavailable randomly
Message-Id: <20040630084142.10a3598b.costa@tecgraf.puc-rio.br>
Organization: TecGraf
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc me on any replies, because I am not subscribed to this list;
if I do need to subscribe, just let me know)

Hi,

I am using 2.4.26 SMP on a ABIT AT7 mobo, with a 2.8GHz P4 processor
with hyper-threading enabled. I have one 80GB Seagate IDE disk
as /dev/hda, and from time to time it seems to "disappear", usually
after these messages appear a couple of trimes on/var/log/messages:

Jun 27 17:15:00 dali kernel: hda: status timeout: status=0x80 { Busy }
Jun 27 17:15:00 dali kernel: 
Jun 27 17:15:00 dali kernel: hda: drive not ready for command
Jun 27 17:15:03 dali kernel: ide0: reset: success

I already had some ide-related issues, namely the one mentioned here:

http://www.x86-64.org/lists/discuss/msg04679.html

Due to that, I am booting with:

hdc=ide-scsi apm=off acpi=ht noapic

Turning off APIC and keeping ACPI to a minimum seems to have fixed the
"dma status == 0x24" problem, but I still experience the "status
timeout" above, which is very frustrating because this is supposed to be
a server for our intranet.

I tried turning off APM for this disk with 'hdparm -B255 /dev/hda', but
it didn't work:

hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }

I have turned off spindown with 'hdparm -S0 /dev/hda', but frankly I am
not sure this will help (besides being bad for harddisk lifetime).

So, given this scenario, I would really appreciate any suggestions on
how to workaround this issue... Please, let me know if you need
additional info. I am attaching below the output of 'hdparm -I /dev/hda'
in case it helps. I am running Fedora Core 1.

TIA

Andre

-------- output of 'hdparm -I /dev/hda' -------- 

/dev/hda:

ATA device, with non-removable media
	Model Number:       ST380011A                               
	Serial Number:      3JV78385            
	Firmware Revision:  3.06    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	65535
	heads		16	1
	sectors/track	63	63
	--
	CHS current addressable sectors:    4128705
	LBA    user addressable sectors:  156301488
	LBA48  user addressable sectors:  156301488
	device size with M = 1024*1024:       76319 MBytes
	device size with M = 1000*1000:       80026 MBytes (80 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 128, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct


-- 
Andre Oliveira da Costa
(costa@tecgraf.puc-rio.br)
