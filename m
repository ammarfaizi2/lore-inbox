Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWDNRoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWDNRoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWDNRoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:44:06 -0400
Received: from main.gmane.org ([80.91.229.2]:19604 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751330AbWDNRoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:44:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Badness in __msleep at drivers/scsi/sata_mv.c:1733
Date: Fri, 14 Apr 2006 11:43:32 -0600
Message-ID: <e1on08$7ok$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Thunderbird 1.5 (X11/20060313)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Fedora Core 5 dual xeon box with kernel 2.6.16-1.2069_FC4smp 
which is closest to 2.6.16.1.

Card is:
Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller 
(rev 09)
Class 0100: 11ab:6081 (rev 09)


sata_mv 0000:02:01.0: version 0.5
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 48 (level, low) -> IRQ 19
sata_mv 0000:02:01.0: 32 slots 8 ports SCSI mode IRQ via INTx
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xF89A2120 bmdma 0x0 irq 19
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF89A4120 bmdma 0x0 irq 19
ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF89A6120 bmdma 0x0 irq 19
ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF89A8120 bmdma 0x0 irq 19
ata9: SATA max UDMA/133 cmd 0x0 ctl 0xF89B2120 bmdma 0x0 irq 19
ata10: SATA max UDMA/133 cmd 0x0 ctl 0xF89B4120 bmdma 0x0 irq 19
ata11: SATA max UDMA/133 cmd 0x0 ctl 0xF89B6120 bmdma 0x0 irq 19
ata12: SATA max UDMA/133 cmd 0x0 ctl 0xF89B8120 bmdma 0x0 irq 19
Badness in __msleep at drivers/scsi/sata_mv.c:1733 (Not tainted)
  [<f88d27f9>] __mv_phy_reset+0x23b/0x400 [sata_mv]     [<f88d1853>] 
mv_scr_write+0xe/0x40
  [sata_mv]
  [<f88d2d4c>] mv_interrupt+0x2c9/0x399 [sata_mv]     [<c014836d>] 
handle_IRQ_event+0x2e/0
x5a
  [<c014842a>] __do_IRQ+0x91/0xe7     [<c0106335>] do_IRQ+0x4e/0x86
  =======================
  [<c01048be>] common_interrupt+0x1a/0x20     [<c01048be>] 
common_interrupt+0x1a/0x20
  [<c0111844>] get_offset_pmtmr+0x11/0x7cd     [<c01072b0>] 
do_gettimeofday+0x20/0xd1
  [<c0129701>] getnstimeofday+0xd/0x2f     [<c013a39e>] 
ktime_get_real+0xe/0x2d
  [<c013a7da>] hrtimer_run_queues+0x2c/0xec     [<c010633c>] 
do_IRQ+0x55/0x86
  [<c012e023>] run_timer_softirq+0x22/0x1b7     [<c012a0e5>] 
__do_softirq+0x70/0xda
  [<c01063b8>] do_softirq+0x4b/0x4f     =======================
  [<c010494c>] apic_timer_interrupt+0x1c/0x24
  [<c0102b96>] default_idle+0x0/0x55     [<c0102bc2>] default_idle+0x2c/0x55
  [<c0102c5d>] cpu_idle+0x72/0xad    <7>ata5: dev 0 cfg 49:2f00 82:74eb 
83:7fea 84:4023 85
:74e9 86:3c02 87:4023 88:003f
ata5: dev 0 ATA-6, max UDMA/100, 488397168 sectors: LBA48
ata5: dev 0 configured for UDMA/100
scsi7 : sata_mv
ata6: dev 0 cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e8 86:3c03 87:4123 
88:007f
ata6: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata6: dev 0 configured for UDMA/133

No other trouble so far.

