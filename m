Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752944AbWKFMoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbWKFMoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbWKFMoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:44:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:400 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752944AbWKFMoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:44:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ggu4XtYbqWNAlgxRsel2cN7LpK51VyFMdbP+PFVfFmMD6PJ4HYHZtkECM0vGv9KeA6XBjn/GG+ByUIjU6mDAlKSBMsDvJdi33LNVA930JMyLJ14Z9W9GDHeuZ1257tco4Fxr9puBJ6f/u/NLy4amE5yHYEDmpnVAuaRDX0aY/uU=
Message-ID: <454F2E0F.3010804@gmail.com>
Date: Mon, 06 Nov 2006 21:43:59 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Fabio Coatti <cova@ferrara.linux.it>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA ICH5 not detected at boot, mm-kernels
References: <200611051536.35333.cova@ferrara.linux.it> <20061105161725.1a326135.akpm@osdl.org>
In-Reply-To: <20061105161725.1a326135.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andrew Morton wrote:
> On Sun, 5 Nov 2006 15:36:33 +0100
> Fabio Coatti <cova@ferrara.linux.it> wrote:
> 
>> Hi all; It seems that problems like this has been already reported, but not 
>> exactly the same, so maybe thsi can add some infos. Otherwise, sorry for the 
>> noise.
>>
>> Starting from 2.6.19-rc1-mm1 and up to rc4-mm2, at boot the kernel is unable 
>> to detect two sata disks, connected to a ICH5 controller. Latest mm working 
>> kernel seems to be 2.6.18-mm3; 2.6.19-rc4 works just fine.
>>
>> On rc-4 (vanilla) the log is this:
>> Nov  5 13:26:37 kefk libata version 2.00 loaded.
>> Nov  5 13:26:37 kefk ata_piix 0000:00:1f.2: version 2.00ac6
>> Nov  5 13:26:37 kefk ata_piix 0000:00:1f.2: MAP [ P0 P1 IDE IDE ]
>> Nov  5 13:26:37 kefk ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, 
>> low) -> IRQ 17
>> Nov  5 13:26:37 kefk ata: 0x170 IDE port busy
>> Nov  5 13:26:37 kefk ata: conflict with ide1
> 
> hm.  What does that mean?

It means that IDE layer claimed the port.  It can be overridden by 
combined_mode kernel parameter.

>> Nov  5 13:26:37 kefk PCI: Setting latency timer of device 0000:00:1f.2 to 64
>> Nov  5 13:26:37 kefk ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 
>> irq 14
>> Nov  5 13:26:37 kefk ata2: DUMMY
>> Nov  5 13:26:37 kefk scsi1 : ata_piix
>> Nov  5 13:26:37 kefk ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 
>> NCQ (depth 0/32)
>> Nov  5 13:26:37 kefk ata1.00: ata1: dev 0 multi count 16
>> Nov  5 13:26:37 kefk ata1.01: ATA-7, max UDMA/133, 586114704 sectors: LBA48 
>> NCQ (depth 0/32)
>> Nov  5 13:26:37 kefk ata1.01: ata1: dev 1 multi count 16
>> Nov  5 13:26:37 kefk ata1.00: configured for UDMA/133
>> Nov  5 13:26:37 kefk ata1.01: configured for UDMA/133
>>
>>
>> With -mm kernels, I see only the third disk, but attached to a different 
>> controller (output from rc4 vanilla):
>>
>> Nov  5 13:26:37 kefk ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, 
>> low) -> IRQ 18
>> Nov  5 13:26:37 kefk ata3: SATA max UDMA/100 cmd 0xF8804080 ctl 0xF880408A 
>> bmdma 0xF8804000 irq 18
>> Nov  5 13:26:37 kefk ata4: SATA max UDMA/100 cmd 0xF88040C0 ctl 0xF88040CA 
>> bmdma 0xF8804008 irq 18
>> Nov  5 13:26:37 kefk scsi3 : sata_sil
>> Nov  5 13:26:37 kefk ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> Nov  5 13:26:37 kefk ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 
>> NCQ (depth 0/32)
>> Nov  5 13:26:37 kefk ata3.00: ata3: dev 0 multi count 0
>> Nov  5 13:26:37 kefk ata3.00: configured for UDMA/100
>> Nov  5 13:26:37 kefk scsi4 : sata_sil
>> Nov  5 13:26:37 kefk ata4: SATA link down (SStatus 0 SControl 310)
>> Nov  5 13:26:37 kefk scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6V320F0   
>> VA11 PQ: 0 ANSI: 5
>> Nov  5 13:26:37 kefk SCSI device sdc: 625142448 512-byte hdwr sectors (320073 
>> MB)
>> Nov  5 13:26:37 kefk sdc: Write Protect is off
>>
> 
> And why doesn't -mm report the same conflict?  I assume the .config is the
> same?

Also, please post full dmesg of both kernels.

Thanks.

-- 
tejun
