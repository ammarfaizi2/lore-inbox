Return-Path: <linux-kernel-owner+w=401wt.eu-S1751332AbXAOTA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbXAOTA0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbXAOTA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:00:26 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:34320 "EHLO
	imf22aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751332AbXAOTAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:00:25 -0500
Message-ID: <45ABCF44.3080101@bellsouth.net>
Date: Mon, 15 Jan 2007 13:00:20 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Jose Alberto Reguero <jareguero@telefonica.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add suport for Marvell 88SE6121 in pata_marvell
References: <200701061324.47993.jareguero@telefonica.net>
In-Reply-To: <200701061324.47993.jareguero@telefonica.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Alberto Reguero wrote:
> Marvell 88SE6121 

[snip]

> ------------------------------------------------------------------------
> 
> --- linux-2.6.20-rc3/drivers/ata/pata_marvell.c	2007-01-01 01:53:20.000000000 +0100
> +++ linux-2.6.20-rc3.new/drivers/ata/pata_marvell.c	2007-01-06 12:33:03.000000000 +0100
> @@ -49,7 +49,7 @@

[snip]

Works-for-me: Jay Cliburn <jacliburn@bellsouth.net>

The following dmesg snippet after applying the patch shows life from the 
hitherto unsupported device:  (I connected an unpartitioned SATA HDD to it.)
==============
[   39.789326] PCI: Setting latency timer of device 0000:06:00.0 to 64
[   39.789436] ata3: PATA max UDMA/100 cmd 0xEC00 ctl 0xE882 bmdma 
0xE400 irq 28
[   39.789541] ata4: PATA max UDMA/133 cmd 0xE800 ctl 0xE482 bmdma 
0xE408 irq 28
[   39.789559] scsi2 : pata_marvell
[   39.790121] BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 
08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00
[   39.790152] ata3: port disabled. ignoring.
[   39.790154] ata3: reset failed, giving up
[   39.790161] scsi3 : pata_marvell
[   39.790589] BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 
08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00
[   39.958055] ATA: abnormal status 0x7F on port 0xE807
[   39.968869] ATA: abnormal status 0x7F on port 0xE807
[   39.979450] ata4.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48
[   39.979453] ata4.00: ata4: dev 0 multi count 16
[   39.987443] ata4.00: configured for UDMA/133
[   39.987628] scsi 3:0:0:0: Direct-Access     ATA      WDC WD2500KS-00M 
02.0 PQ: 0 ANSI: 5
[   39.988524] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   39.988546] sdb: Write Protect is off
[   39.988548] sdb: Mode Sense: 00 3a 00 00
[   39.988583] SCSI device sdb: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   39.988695] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   39.988713] sdb: Write Protect is off
[   39.988715] sdb: Mode Sense: 00 3a 00 00
[   39.988749] SCSI device sdb: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   39.988781]  sdb: unknown partition table
[   39.994867] sd 3:0:0:0: Attached scsi disk sdb
[   39.994990] sd 3:0:0:0: Attached scsi generic sg1 type 0


This is the relevant portion of lspci:
==============
06:00.0 SATA controller: Marvell Technology Group Ltd. Unknown device 
6121 (rev b0) (prog-if 8f)
         Subsystem: ASUSTeK Computer Inc. Unknown device 8212
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 28
         Region 0: I/O ports at ec00 [size=8]
         Region 1: I/O ports at e880 [size=4]
         Region 2: I/O ports at e800 [size=8]
         Region 3: I/O ports at e480 [size=4]
         Region 4: I/O ports at e400 [size=16]
         Region 5: Memory at fbeffc00 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Message Signalled Interrupts: 64bit- 
Queue=0/0 Enable
-
                 Address: 00000000  Data: 0000
         Capabilities: [e0] Express Legacy Endpoint IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                 Device: Latency L0s unlimited, L1 unlimited
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
                 Link: Latency L0s <256ns, L1 unlimited
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x1
00: ab 11 21 61 07 01 10 00 b0 8f 06 01 10 00 00 00
10: 01 ec 00 00 81 e8 00 00 01 e8 00 00 81 e4 00 00
20: 01 e4 00 00 00 fc ef fb 00 00 00 00 43 10 12 82
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 01 00 00
40: 24 c9 c0 00 1f 80 00 00 01 50 02 5a 00 20 00 13
50: 05 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 58 c4 21 40 b0 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 00 11 00 c0 0f 18 00 00 24 08 00 11 a4 03 01
f0: 00 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00

