Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162237AbWLBCND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162237AbWLBCND (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 21:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162714AbWLBCND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 21:13:03 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:34989 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1162237AbWLBCNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 21:13:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:mime-version:content-transfer-encoding:message-id:content-type:to:subject:date:x-mailer:from;
        b=FjUYJ+GtBia4z8EgohT50AUrIQK5AzLiNAGhzY9ZWBTg3cHfahvH9SDjtpTiGe5ZFs2iZ/YsTgP1tEmKoaFEniDNWK/cYbHByH1VtpK9noowcB+p2DErU/3QCb6exNPQqr2LctzZRzsFnqgmKigh65RIv9/zMtxlTqtJjGkz8Fo=
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Transfer-Encoding: 7bit
Message-Id: <61D44F12-D09C-4A6F-9FC7-4AC49FEC757B@gmail.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
Subject: hang booting onboard HPT 366 with libata (PATA)
Date: Fri, 1 Dec 2006 21:13:00 -0500
X-Mailer: Apple Mail (2.752.2)
From: Ricardo Lugo <ricardolugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

With the release of libata PATA support in 2.6.19, I am trying out  
libata with my HPT366 (built-on to motherboard), and it hangs at  
bootup while scanning for partitions. Additionally, it complains of  
abnormal status? Related information about my setup below:

- Abit BP6 motherboard running BIOS RV with HPT 1.28 (ie has  
functional ACPI DSDT table), has been recapped, not overclocked
- onboard HPT366 controller functions fine with the old IDE drivers  
(but only so long as I use UDMA mode <=3, mode 4 has reported  
problems on BP6)
- hard drive is an 80GB seagate 7200.1-ish that supports UDMA mode 5,  
partition scheme is (1-xfs, 2-swap)
- this hard drive is the only drive connected, but the kernel  
discovers one empty pata_piix controller and one empty pata_hpt366  
controller before it.

Related boot messages:

---

ACPI: PCI Interrup 0000:00:13.1[B] -> GSI 18 (level, low) -> IRQ 16
ata5: PATA max UDMA/66 cmd 0xE400 ctl 0xE802 bmdma 0xEC00 irq 16
ata6: PATA max UDMA/66 cmd 0x0 ctl 0x2 bmdma 0xEC08 irq 16
scsi4 : pata_hpt366
ata5.00: ATA-6, max UDMA/100, 156301488 sectors: LBA48
ata5.00: ata5: dev 0 multi count 16
ata5.00 configured for UDMA/33
scsi5 : pata_hpt366
ATA: abnormal status 0x1C on port 0x7
scsi 4:0:0:0: Direct-Access     ATA      ST380011A         3.06 PQ: 0  
ANSI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
sda:_

---

If there is anything I can test to help fix this issue or further  
diagnose it, please let me know.

	- Ricardo
