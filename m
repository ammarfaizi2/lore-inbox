Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWHCQbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWHCQbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWHCQbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:31:09 -0400
Received: from customer-domains.icp-qv1-irony8.iinet.net.au ([203.59.1.133]:24255
	"EHLO customer-domains.icp-qv1-irony8.iinet.net.au")
	by vger.kernel.org with ESMTP id S964818AbWHCQbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:31:08 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.07,209,1151856000"; 
   d="scan'208"; a="420801177:sNHT14861236"
From: "Marc" <linux-kernel@liquid-nexus.net>
To: linux-kernel@vger.kernel.org
Subject: sata_promise / libata defaulting to UDMA/33
Date: Fri, 4 Aug 2006 00:31:05 +0800
Message-Id: <20060803163002.M27080@liquid-nexus.net>
X-Mailer: Open WebMail 2.51 20050627
X-OriginatingIP: 192.168.127.244 (marc)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. 

I'm having great difficulty solving a problem I've encountered. I have a
Promise Fastrak TX4000 card:

0000:00:08.0 RAID bus controller: Promise Technology, Inc. PDC20619 (FastTrak
TX4000) (rev 02)
        Subsystem: Promise Technology, Inc. PDC20619 (FastTrak TX4000)
        Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 137

For some strange reason all drives are set to UDMA/33 mode when the module is
loaded and I haven't found a way of changing the UDMA mode (hdparm -X doesn't
work: HDIO_DRIVE_CMD(setxfermode) failed: Input/output error).

Extract from dmesg:

libata version 1.20 loaded.
sata_promise 0000:00:08.0: version 1.04
ata1: PATA max UDMA/133 cmd 0xF8ABC200 ctl 0xF8ABC238 bmdma 0x0 irq 137
ata2: PATA max UDMA/133 cmd 0xF8ABC280 ctl 0xF8ABC2B8 bmdma 0x0 irq 137
ata3: PATA max UDMA/133 cmd 0xF8ABC300 ctl 0xF8ABC338 bmdma 0x0 irq 137
ata4: PATA max UDMA/133 cmd 0xF8ABC380 ctl 0xF8ABC3B8 bmdma 0x0 irq 137
ata1: disabling port
scsi1 : sata_promise
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:203f
ata2: dev 0 ATA-6, max UDMA/100, 312581808 sectors: LBA48
<b>ata2: dev 0 configured for UDMA/33</b>
scsi2 : sata_promise
ata3: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4633 85:7469 86:3c01 87:4623 88:203f
ata3: dev 0 ATA-7, max UDMA/100, 312581808 sectors: LBA48
<b>ata3: dev 0 configured for UDMA/33</b>
scsi3 : sata_promise
ata4: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:203f
ata4: dev 0 ATA-6, max UDMA/100, 312581808 sectors: LBA48
<b>ata4: dev 0 configured for UDMA/33</b>
scsi4 : sata_promise
  Vendor: ATA       Model: WDC WD1600JB-00E  Rev: 15.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD1600JB-00R  Rev: 20.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD1600JB-00E  Rev: 15.0
  Type:   Direct-Access                      ANSI SCSI revision: 05

I'm currently running kernel 2.6.17.3. In the controller's BIOS I've created 3
'stripe' arrays with 1 disk per array, the BIOS shows the 3 drives as U5 (UDMA
mode 5 - which is UDMA/100 right?).

I've searched high and low but haven't found an answer to this problem. Help
appreciated. Please - I'm getting dismal performance.

Regards,




--
