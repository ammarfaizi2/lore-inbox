Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVHLK55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVHLK55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 06:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVHLK55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 06:57:57 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:22988 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750971AbVHLK54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 06:57:56 -0400
In-Reply-To: <42FC166A.3020505@gmail.com>
References: <12872CA9-F089-4955-8751-8CC4E7B2140A@bootc.net> <42FC166A.3020505@gmail.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0FDE8D5B-CFF2-44F9-8C98-9C5EC5CDAE92@bootc.net>
Cc: Linux-ide <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: SiI 3112A + Seagate HDs = still no go?
Date: Fri, 12 Aug 2005 11:57:37 +0100
To: Tejun Heo <htejun@gmail.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Aug 2005, at 4:24, Tejun Heo wrote:

> Chris Boot wrote:
>
>> Hi all,
>> I just recently took the plunge and bought 4 250 GB Seagate  
>> drives  and a 2 port Silicon Image 3112A controller card for the 2  
>> drives my  motherboard doesn't handle. No matter how hard I try, I  
>> can't get the  hard drives to work: they are detected correctly  
>> and work reasonably  well under _very_ light load, but anything  
>> like building a RAID array  is a bit much and the whole controller  
>> seems to lock up.
>> I've tried adding the drive to the blacklist in the sata_sil.c  
>> driver  and I still have the same trouble: as you can see the  
>> messages below  relate to my patched kernel with the blacklist  
>> fix. I've seen that  this was discussed just yesterday, but that  
>> seemed to give nothing:  http://www.ussg.iu.edu/hypermail/linux/ 
>> kernel/0508.1/0310.html
>> Ready and willing to hack my kernel to pieces; this machine is no  
>> use  until I get all the drives working! Needless to say the  
>> drives  connected to the on-board VIA controller work fine, as do  
>> the drives  currently on the SiI controller if I swap them around.
>> Any ideas?
>> TIA
>> Chris
>>
>
> [added linux-ide to cc list]
>
>  Can you please try w/ vanilla kernel (2.6.12 or 2.6.13-rc)?  And  
> w/ one drive only?

I unplugged both drives from my on-board SATA controller and left  
just one connected to the 3112A controller. Rebooted with a fresh,  
vanilla 2.6.13-rc6 and ran:

dd if=/dev/zero of=test.img bs=1M count=16384

After about 30 seconds I got the crash and the kernel started  
repeating every 30 seconds (with different sector numbers):

ata1: command 0x35 timeout, stat 0xd9 host_stat 0x1
ata1: status=0xd9 { Busy }
SCSI error : <0 0 0 0> return code = 0x80000002
sda: Current: sense key=0xb
ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sda, sector 14937602
ATA: abnormal status 0xD9 on port E0802087
ATA: abnormal status 0xD9 on port E0802087
ATA: abnormal status 0xD9 on port E0802087

dmesg:
Linux version 2.6.13-rc6 (bootc@arcadia.bootc.net) (gcc version  
3.3.5-20050130 (Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1,  
pie-8.7.7.1)) #1 Fri Aug 12 12:31:25 BST 2005
...
libata version 1.11 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 177
ata1: SATA max UDMA/100 cmd 0xE0802080 ctl 0xE080208A bmdma  
0xE0802000 irq 177
ata2: SATA max UDMA/100 cmd 0xE08020C0 ctl 0xE08020CA bmdma  
0xE0802008 irq 177
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01  
87:4023 88:207f
ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level,  
low) -> IRQ 169
PCI: Via IRQ fixup for 0000:00:0f.0, from 11 to 9
sata_via(0000:00:0f.0): routed to hard irq line 9
ata3: SATA max UDMA/133 cmd 0xB400 ctl 0xB802 bmdma 0xC400 irq 169
ata4: SATA max UDMA/133 cmd 0xBC00 ctl 0xC002 bmdma 0xC408 irq 169
ata3: no device found (phy stat 00000000)
scsi2 : sata_via
ata4: no device found (phy stat 00000000)
scsi3 : sata_via
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

I forgot to mention previously but I even tried with "noapic nolapic  
acpi=off pci=routeirq" and got the same trouble.

Thanks,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


