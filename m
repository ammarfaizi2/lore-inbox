Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWKEOgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWKEOgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 09:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWKEOgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 09:36:38 -0500
Received: from ns2.ngi.it ([88.149.128.3]:43180 "EHLO maya.ngi.it")
	by vger.kernel.org with ESMTP id S1030261AbWKEOgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 09:36:37 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org
Subject: SATA ICH5 not detected at boot, mm-kernels
Date: Sun, 5 Nov 2006 15:36:33 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611051536.35333.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all; It seems that problems like this has been already reported, but not 
exactly the same, so maybe thsi can add some infos. Otherwise, sorry for the 
noise.

Starting from 2.6.19-rc1-mm1 and up to rc4-mm2, at boot the kernel is unable 
to detect two sata disks, connected to a ICH5 controller. Latest mm working 
kernel seems to be 2.6.18-mm3; 2.6.19-rc4 works just fine.

On rc-4 (vanilla) the log is this:
Nov  5 13:26:37 kefk libata version 2.00 loaded.
Nov  5 13:26:37 kefk ata_piix 0000:00:1f.2: version 2.00ac6
Nov  5 13:26:37 kefk ata_piix 0000:00:1f.2: MAP [ P0 P1 IDE IDE ]
Nov  5 13:26:37 kefk ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, 
low) -> IRQ 17
Nov  5 13:26:37 kefk ata: 0x170 IDE port busy
Nov  5 13:26:37 kefk ata: conflict with ide1
Nov  5 13:26:37 kefk PCI: Setting latency timer of device 0000:00:1f.2 to 64
Nov  5 13:26:37 kefk ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 
irq 14
Nov  5 13:26:37 kefk ata2: DUMMY
Nov  5 13:26:37 kefk scsi1 : ata_piix
Nov  5 13:26:37 kefk ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 
NCQ (depth 0/32)
Nov  5 13:26:37 kefk ata1.00: ata1: dev 0 multi count 16
Nov  5 13:26:37 kefk ata1.01: ATA-7, max UDMA/133, 586114704 sectors: LBA48 
NCQ (depth 0/32)
Nov  5 13:26:37 kefk ata1.01: ata1: dev 1 multi count 16
Nov  5 13:26:37 kefk ata1.00: configured for UDMA/133
Nov  5 13:26:37 kefk ata1.01: configured for UDMA/133


With -mm kernels, I see only the third disk, but attached to a different 
controller (output from rc4 vanilla):

Nov  5 13:26:37 kefk ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, 
low) -> IRQ 18
Nov  5 13:26:37 kefk ata3: SATA max UDMA/100 cmd 0xF8804080 ctl 0xF880408A 
bmdma 0xF8804000 irq 18
Nov  5 13:26:37 kefk ata4: SATA max UDMA/100 cmd 0xF88040C0 ctl 0xF88040CA 
bmdma 0xF8804008 irq 18
Nov  5 13:26:37 kefk scsi3 : sata_sil
Nov  5 13:26:37 kefk ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov  5 13:26:37 kefk ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 
NCQ (depth 0/32)
Nov  5 13:26:37 kefk ata3.00: ata3: dev 0 multi count 0
Nov  5 13:26:37 kefk ata3.00: configured for UDMA/100
Nov  5 13:26:37 kefk scsi4 : sata_sil
Nov  5 13:26:37 kefk ata4: SATA link down (SStatus 0 SControl 310)
Nov  5 13:26:37 kefk scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6V320F0   
VA11 PQ: 0 ANSI: 5
Nov  5 13:26:37 kefk SCSI device sdc: 625142448 512-byte hdwr sectors (320073 
MB)
Nov  5 13:26:37 kefk sdc: Write Protect is off

-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
