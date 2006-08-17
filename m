Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWHQOBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWHQOBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWHQOBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:01:17 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:60808 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S932504AbWHQOBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:01:14 -0400
Date: Thu, 17 Aug 2006 10:01:15 -0400
From: mikepolniak <mikpolniak@adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: JMicron SATA/IDE and 2.6.18-rc4 fails to detect CDROM
Message-ID: <20060817140115.GA3808@debamd64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.18-rc4 and CONFIG_SCSI_SATA_AHCI=m, fails to detect ide cdrom.

lspci

03:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363
AHCI
Controller (rev02)

and from dmesg|grep -i ide

BIOS-provided physical RAM map:
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Boot video device is 0000:01:00.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2 ide: Assuming
33MHz system bus speed for PIO modes; override with idebus=xx Probing IDE
interface ide0...
Probing IDE interface ide1...

If i modprobe ahci dmesg shows:

ahci 0000:03:00.0: version 2.0
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 17 PCI:
Setting latency timer of device 0000:03:00.0 to 64 ahci 0000:03:00.0:
AHCI
0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode ahci 0000:03:00.0:
flags: 64bit ncq pm led clo pmp pio slum part ata5: SATA max UDMA/133 cmd
0xFFFFC2000002C100 ctl 0x0 bmdma 0x0 irq 17 ata6: SATA max UDMA/133 cmd
0xFFFFC2000002C180 ctl 0x0 bmdma 0x0 irq 17 scsi6 : ahci
ata5: SATA link down (SStatus 0 SControl 300) scsi7 : ahci
ata6: SATA link down (SStatus 0 SControl 300)

The BIOS sees the CDROM but it is not detected by ide driver.
