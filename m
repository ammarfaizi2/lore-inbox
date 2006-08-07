Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWHGAc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWHGAc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 20:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWHGAc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 20:32:29 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:17474 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750846AbWHGAc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 20:32:29 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Mismatch between hdaprm and sdparm output
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Aug 2006 10:32:26 +1000
Message-ID: <23691.1154910746@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NEC Versa S5200 laptop with FUJITSU MHV2080B SATA disk.  Kernel
2.6.16.21-0.13-smp (suselinux 10.1) using ata_piix.  hdparm and sdparm
give inconsistent results, which one should I believe?  My main concern
is write caching (XFS filesystem).

hdparm -I

/dev/sda:

ATA device, with non-removable media
	Model Number:       FUJITSU MHV2080BH
	Serial Number:      NW28T62255WF
	Firmware Revision:  00000028
Standards:
	Supported: 7 6 5 4
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  156301488
	LBA48  user addressable sectors:  156301488
	device size with M = 1024*1024:       76319 MBytes
	device size with M = 1000*1000:       80026 MBytes (80 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: 128 (0x80)
	Recommended acoustic management value: 254, current value: 254
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
		Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command
	   *	Device Configuration Overlay feature set
	   *	48-bit Address feature set
	   *	Automatic Acoustic Management feature set
	   *	SET MAX security extension
	   *	Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	General Purpose Logging feature set
	   *	SMART self-test
	   *	SMART error logging
Security:
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
	80min for SECURITY ERASE UNIT.
Checksum: correct


sdparm --get=WCE

    /dev/sda: ATA       FUJITSU MHV2080B  0000
WCE         1

hdparm -A 1/0 can set/clear write cache, sdparm --set=WCE=0/1 always
gets an error:

sdparm --set=WCE=0 /dev/sda
    /dev/sda: ATA       FUJITSU MHV2080B  0000
    change_mode_page: failed setting page: Caching (SBC)

