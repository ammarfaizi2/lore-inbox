Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWCMQQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWCMQQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWCMQQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:16:43 -0500
Received: from main.gmane.org ([80.91.229.2]:23250 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932141AbWCMQQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:16:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: jtjm@xenoclast.org (Julian T. J. Midgley)
Subject: ATA command timeouts, ata_piix 2.6.15.6
Date: Mon, 13 Mar 2006 16:10:11 +0000 (UTC)
Message-ID: <dv45h3$d82$2@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: hanjague.menavaur.org
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: jtjm@hanjague.menavaur.org (Julian T. J. Midgley)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Dell Latitude D610 that is brought to its knees by ata
timeouts intermittently (about once a day, on average).  Rebooting
has always recovered thus far.

Kernel 2.6.15.6 (with Suspend2 2.2 patch), using ata_piix - kernel
.config at: http://b.xenoclast.org/config_ata_prob

At the point the machine becomes unusable, I get the following on the
console:

ata1: command 0x35 timeout, stat 0xd0 host_stat 0x21 
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Buffer I/O error on device sda3, logical block 1533312 
ata1: command 0x35 timeout, stat 0xd0 host_stat 0x21
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Buffer I/O error on device sda3, logical block 1533546
ata1: command 0x25 timeout, stat 0xd0 host_stat 0x21
...

Any thoughts would be much appreciated. lspci/hdparm output below.

Julian

lspci 
0000:00:1f.2 IDE interface: Intel Corp. 82801FBM (ICH6M) SATA Controller (rev 03
) (prog-if 80 [Master])
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 209
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at bfa0 [size=16]
        Capabilities: [70] Power Management version 2


hdparm -I /dev/sda
/dev/sda:

ATA device, with non-removable media
	Model Number:       ST960822A                               
	Serial Number:      3LF3FBFK
	Firmware Revision:  8.03    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  117210240
	LBA48  user addressable sectors:  117210240
	device size with M = 1024*1024:       57231 MBytes
	device size with M = 1000*1000:       60011 MBytes (60 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 8
	Advanced power management level: unknown setting (0x8080)
	Recommended acoustic management value: 254, current value: 0
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
		Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
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
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by CSEL
Checksum: correct

-- 
Julian T. J. Midgley                       http://www.xenoclast.org/
Cambridge, England.
PGP: BCC7863F FP: 52D9 1750 5721 7E58 C9E1  A7D5 3027 2F2E BCC7 863F

