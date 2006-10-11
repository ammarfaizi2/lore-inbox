Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030797AbWJKFLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030797AbWJKFLE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 01:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030799AbWJKFLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 01:11:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:42729 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030797AbWJKFLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 01:11:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kRMP7ksgz8ufwc3eqa02EXfJfgzxRdp4ONiJOw/b5kzoZRbSryTuMeB1sa8Ny2cJEcr1Kd3aHlupQU8WwZ9gHbbT+K6oB8MFuclRKNbSUMLe3ooa42t7mIcsG0rQs49u0yJ9iaz2NYDIj0jJ3V2YT+C7+gXic9qRow74KMG8Gn4=
Message-ID: <3b0ffc1f0610102210o15d52d95n28d2963164c4dd23@mail.gmail.com>
Date: Wed, 11 Oct 2006 01:10:59 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       jgarzik@pobox.com
Subject: [BUG] 2.6.19-rc1: ata_piix takes excessively long to probe a nonexistent device
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using ata_piix on a Fujitsu laptop with an ICH4-M and a HD on the
first channel and a DVD/CDRW drive on the second channel, I see this:

ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/100, 156301488 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ata_piix
ata2.00: ATAPI, max UDMA/33
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHT2080A 0022 PQ: 0 ANSI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 > sda3
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: CD-ROM            MATSHITA UJDA755 DVD/CDRW 1.00 PQ: 0 ANSI: 5

The timeout/retry periods add an extra minute or two to kernel boot
process. This did not occur with 2.6.17 + Alan's PATA patches
(although I did see a single message about dev 1 failing to IDENTIFY
with that).

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
