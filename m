Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755006AbWKLGuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbWKLGuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 01:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755007AbWKLGuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 01:50:46 -0500
Received: from smtp-4.smtp.ucla.edu ([169.232.46.137]:43687 "EHLO
	smtp-4.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1755005AbWKLGup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 01:50:45 -0500
Message-ID: <4556C41E.2050608@cogweb.net>
Date: Sat, 11 Nov 2006 22:50:06 -0800
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jeff Garzik <jeff@garzik.org>, Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: smartmontools' Automatic Offline Testing fails on sata_sil
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smartmontools Automatic Offline Testing fails on drives connected to a sata_sil controller. 

Bruce Allen, the smartmontools maintainer, suggests the problem may be that the Auto-offline command sticks large values in the ATA sector count register WITHOUT transfering any data. 

Can the sata_sil driver be fixed to accomodate this?

In smartd.conf:

/dev/sdc -d sat -a -o on -S on -s (S/../.././02|L/../../6/03)

Result:

Device: /dev/sdc, opened
Device: /dev/sdc, not found in smartd database.
Device: /dev/sdc, enabled SMART Attribute Autosave.
kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
kernel: ata1: EH complete
smartd[20488]: Device: /dev/sdc, enabled SMART Automatic Offline Testing.
kernel: SCSI device sdc: 1465149168 512-byte hdwr sectors (750156 MB)
kernel: sdc: Write Protect is off
kernel: sdc: Mode Sense: 00 3a 00 00
smartd[20488]: Device: /dev/sdc, is SMART capable. Adding to "monitor" list.
kernel: SCSI device sdc: drive cache: write back

The same model drives work fine with smartmontools cvs on the sata_nv and 3ware 8500 controllers.

Here's dmesg for 2.6.18:

sata_sil 0000:02:0d.0: version 2.0
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC2] -> GSI 17 (level,low) -> IRQ 16
ata1: SATA max UDMA/100 cmd 0xFFFFC2000000E080 ctl 0xFFFFC2000000E08A bmdma 0xFFFFC2000000E000 irq 16
ata2: SATA max UDMA/100 cmd 0xFFFFC2000000E0C0 ctl 0xFFFFC2000000E0CA bmdma 0xFFFFC2000000E008 irq 16
scsi0 : sata_sil
ata1: SATA link down (SStatus 0 SControl 310)
scsi1 : sata_sil
ata2: SATA link down (SStatus 0 SControl 310)

lspci -vvv:

02:0d.0 Mass storage controller: Silicon Image, Inc. SiI 3512 [SATALink/SATARaid] Serial ATA Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3512 SATALink Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 9400 [size=8]
        Region 1: I/O ports at 9800 [size=4]
        Region 2: I/O ports at 9c00 [size=8]
        Region 3: I/O ports at a000 [size=4]
        Region 4: I/O ports at a400 [size=16]
        Region 5: Memory at f700c000 (32-bit, non-prefetchable) [size=512]
        [virtual] Expansion ROM at 50000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


Dave

