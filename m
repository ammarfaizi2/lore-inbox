Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVF2WwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVF2WwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVF2WwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:52:22 -0400
Received: from smtp1.irishbroadband.ie ([62.231.32.12]:47837 "EHLO
	smtp1.irishbroadband.ie") by vger.kernel.org with ESMTP
	id S262707AbVF2Wvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:51:43 -0400
Subject: aic7xxx regression occuring after 2.6.12 final
From: Tony Vroon <chainsaw@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Content-Type: text/plain
Organization: Gentoo Linux
Date: Wed, 29 Jun 2005 23:50:46 +0100
Message-Id: <1120085446.9743.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

For my Adaptec 29160 card; I see a regression after 2.6.12 final.
To be exact, these releases work for me:
2.6.12
2.6.12.1

These releases do not work for me:
2.6.12-mm1
2.6.12-mm2
2.6.12-git7
2.6.13-rc1

On a working kernel; I see the following:
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] -> GSI 18 (level,
high) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: FUJITSU   Model: MAP3367NP         Rev: 0106
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
 target0:0:0: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:0): 6.600MB/s transfers (16bit)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
 target0:0:0: Ending Domain Validation

On a failing kernel, I see:
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] -> GSI 18 (level,
high) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

target0:0:0: asynchronous
  Vendor: FUJITSU   Model: MAP3367NP         Rev: 0106
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
(scsi0:A:0): refuses tagged commands. Performing non-tagged I/O
 target0:0:0: asynchronous
[The PC hangs at this point]


lspci output for the adapter:
0000:01:08.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160 Ultra160 SCSI Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
        BIST result: 00
        I/O ports at d800 [disabled] [size=256]
        Memory at db000000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

Please let me know if there are specific patches I need to apply or
revert to debug this. I have more drives on this controller; to be exact
I have 2 U320-capable drives and one U160-capable drive on wide channel
A; and 3 removable media units (CD-R, DVD, CD-ROM) on the 50-pin
SCSI-bus.

Thanks,
Tony.
(Please CC replies to me as I am not subscribed to LKML or linux-scsi)

