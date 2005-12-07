Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVLGLqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVLGLqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVLGLqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:46:05 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:56528 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750891AbVLGLqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:46:04 -0500
Message-ID: <4396CB79.5040408@bootc.net>
Date: Wed, 07 Dec 2005 11:46:01 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mail/News 1.5 (X11/20051130)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc5-mm1 sata_sil regression
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just upgraded to 2.6.15-rc5-mm1 from 2.6.15-rc2-mm1 and sata_sil 
refused to recognise the two SATA drives that are connected to it:

[4294671.418000] libata version 1.20 loaded.
[4294671.419000] sata_sil 0000:00:0a.0: version 0.9
[4294671.419000] ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, 
low) -> IRQ 169
[4294671.429000] ata1: SATA max UDMA/100 cmd 0xF8802080 ctl 0xF880208A 
bmdma 0xF8802010 irq 169
[4294671.440000] ata2: SATA max UDMA/100 cmd 0xF88020C0 ctl 0xF88020CA 
bmdma 0xF8802018 irq 169
[4294671.652000] ata1: SATA link up 1.5 Gbps (SStatus 113)
[4294671.809000] ata1: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 
86:0000 87:0000 88:0000
[4294671.809000] ata1: no dma
[4294671.809000] ata1: dev 0 not supported, ignoring
[4294671.815000] scsi0 : sata_sil
[4294671.839000] input: AT Translated Set 2 keyboard as /class/input/input0
[4294671.850000] atkbd.c: Spurious ACK on isa0060/serio0. Some program, 
like XFree86, might be trying access hardware directly.
[4294672.021000] ata2: SATA link up 1.5 Gbps (SStatus 113)
[4294672.069000] input: AT Translated Set 2 keyboard as /class/input/input1
[4294672.178000] ata2: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 
86:0000 87:0000 88:0000
[4294672.178000] ata2: no dma
[4294672.178000] ata2: dev 0 not supported, ignoring
[4294672.184000] scsi1 : sata_sil

My sata_via controller, also with 2 identical drives on it, works fine:

[4294672.731000] scsi2 : sata_via
[4294672.971000] ata4: SATA link up 1.5 Gbps (SStatus 113)
[4294673.163000] ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 
86:3c01 87:4023 88:407f
[4294673.163000] ata4: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
[4294673.207000] ata4: dev 0 configured for UDMA/133
[4294673.248000] scsi3 : sata_via
[4294673.288000]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[4294673.332000]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[4294673.377000]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[4294673.422000]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[4294673.467000] SCSI device sda: 488397168 512-byte hdwr sectors 
(250059 MB)
[4294673.512000] SCSI device sda: drive cache: write back
[4294673.554000] SCSI device sda: 488397168 512-byte hdwr sectors 
(250059 MB)
[4294673.599000] SCSI device sda: drive cache: write back
[4294673.642000]  sda: sda1 sda2 sda3
[4294673.704000] sd 2:0:0:0: Attached scsi disk sda
[4294673.746000] SCSI device sdb: 488397168 512-byte hdwr sectors 
(250059 MB)
[4294673.791000] SCSI device sdb: drive cache: write back
[4294673.834000] SCSI device sdb: 488397168 512-byte hdwr sectors 
(250059 MB)
[4294673.878000] SCSI device sdb: drive cache: write back
[4294673.920000]  sdb: sdb1 sdb2 sdb3
[4294673.979000] sd 3:0:0:0: Attached scsi disk sdb
[4294674.021000] sd 2:0:0:0: Attached scsi generic sg0 type 0
[4294674.063000] sd 3:0:0:0: Attached scsi generic sg1 type 0

The controller is:

00:0a.0 Mass storage controller: Silicon Image, Inc. SiI 3112 
[SATALink/SATARaid] Serial ATA Controller (rev 02) (prog-if 01)
         Subsystem: Adaptec SATAConnect 1205SA Host Controller
         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 169
         I/O ports at a400 [size=8]
         I/O ports at a800 [size=4]
         I/O ports at ac00 [size=8]
         I/O ports at b000 [size=4]
         I/O ports at b400 [size=16]
         Memory at ea001000 (32-bit, non-prefetchable) [size=512]
         [virtual] Expansion ROM at 50000000 [disabled] [size=512K]
         Capabilities: [60] Power Management version 2
00: 95 10 12 31 07 00 b0 02 02 01 80 01 08 20 00 00
10: 01 a4 00 00 01 a8 00 00 01 ac 00 00 01 b0 00 00
20: 01 b4 00 00 00 10 00 ea 00 00 00 00 05 90 50 02
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 00 00

This all used to work fine in 2.6.15-rc2-mm1. Any ideas? Need any more 
information?

Cheers,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
