Return-Path: <linux-kernel-owner+w=401wt.eu-S965051AbWLTNjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWLTNjG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWLTNjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:39:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:39905 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965051AbWLTNjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:39:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=jXqX/VTw0D1LhUuOKbndyfitfkJN1L2DGO2Hnu6ycUoQA3lF6TVp9FDEP6X18rG3fSFiS9kblfjyLRiqUA0Q/K0BtB5eolpma2PYeY5BC/uLe7ukNmLmhA+OgWomdoh5G+TkvrXM/yGfYFpkKdCabrgAdriRtF1dqnXmqij+pXM=
Message-ID: <45893CAD.9050909@gmail.com>
Date: Wed, 20 Dec 2006 14:37:49 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: PATA -- pata_amd on 2.6.19 fails to IDENTIFY my DVD-ROM 
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day.

I just tried the PATA driver for my AMD756 chip. During boot, it hangs 
for 3 minutes failing to identify my DVD-ROM (secondary slave) and does 
not give me access to it after it timed out.

Situation is AMD756 (a UDMA66 chipset), both channels 80w cables:

1. Primary Master	: UDMA133 disk, works fine
2. Primary Slave	: Empty
3. Secondary Master	: Plextor Premium CD-RW (UDMA33), works fine
4. Secondary Slave	: Plextor PX-116A DVD-ROM (UDMA66), does not

All are using cable select and work fine with the old IDE driver and 
also with an earlier version of the PATA code; I used 2.6.17-rc4-ide1 
(which I see is still the latest standalone patch) without problems before.

The 2.6.17-rc4-ide pata_amd version was 0.1.7 and current is 0.2.4. Did 
try a quick diff between them, but it seems the difference is mostly 
infrastructural, so the problem is probably further on up.

Excerpt from boot-log (this takes 3 minutes):

===
pata_amd 0000:00:07.1: version 0.2.4
ata1: PATA max UDMA/66 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : pata_amd
ata1.00: ATA-7, max UDMA/133, 240121728 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/66
scsi1 : pata_amd
ata2.00: ATAPI, max UDMA/33
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0xd8)
ata2: port failed to respond (30 secs, Status 0xd8)
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0xd8)
ata2: port failed to respond (30 secs, Status 0xd8)
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0xd8)
ata2: port failed to respond (30 secs, Status 0xd8)
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y120P0   YAR4 PQ: 0 ANSI: 5
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 < sda5 sda6 sda7 sda8 > sda2 sda3 sda4
  sda2: <minix: sda9 sda10 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            PLEXTOR  CD-R   PREMIUM   1.07 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
===

By the way -- PATA interfaces (ata1, ata2) start counting at 1 while 
their devices (.00, .01) start counting at 0 which sort of sucks. While 
looking at "ata2.01" during boot (with the rest scrolled away) I thought 
I was looking at secondary master initially. If they can still be named 
ata0 and ata1, I'd consider that better.

Anyways, as said, all worked fine on 2.6.17-rc4-ide1 including I believe 
with secondary master tuned to UDMA33 and slave to UDMA66 according to 
their device capabilities.

Happy to provide more or other information if needed.

Rene.

