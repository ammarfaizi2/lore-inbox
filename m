Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWI0QI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWI0QI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWI0QI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:08:29 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:33162 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S965117AbWI0QI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:08:28 -0400
From: ygosset <ygosset@free.fr>
Organization: none
To: linux-kernel@vger.kernel.org
Subject: Help needed on 2.6.18, Irq and SATA controler.
Date: Wed, 27 Sep 2006 18:08:04 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271808.04956.ygosset@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I boot on an SATA drive,
with this kernel:2.6.12-12mdk .

Here is an lspci on my sata controler:
"
01:08.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
Controller (rev 50)
        Subsystem: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at a000 [size=8]
        Region 1: I/O ports at a400 [size=4]
        Region 2: I/O ports at a800 [size=8]
        Region 3: I/O ports at ac00 [size=4]
        Region 4: I/O ports at b000 [size=16]
        Region 5: I/O ports at b400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
..
01:08.0 Class 0104: 1106:3149 (rev 50)
..

I have tried to compile and install the latest kernel: 2.6.18,
and I can't boot.
I have found a little difference in log between this kernel:
in 2.6.18, I haven't a line "PCI: Via IRQ fixup for 0000:01:08.0, from 11 to 
0",
I have this choice for the irq on 2.6.18:
"sata_via(0000:01:08.0): routed to hard irq line 11"
and after these errors:
"ata 1.00 : qc timeout (cmd 0xec)
..
ata 1: port is slow to respond
Kernel panic
".

I have this from the first kernel (v2.6.12)  in syslog:
"Sep 26 12:15:38 mybox kernel: PCI: Via IRQ fixup for 0000:01:08.0, from 11 to 
0"
"Sep 26 12:15:38 mybox kernel: sata_via(0000:01:08.0): routed to hard irq line 
0"


So, in the file quirks.c from 2.6.18 kernel,
I have added this line
"
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237_SATA, 
quirk_via_irq);"

I have still the same error:
Via IRQ fixup is applied but it is impossible to boot,
even with append=" acpi=off pci=biosirq " in lilo.conf.

Thanks!

Yvan Gosset.
--
ygosset@free.fr

