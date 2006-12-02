Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936561AbWLBSy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936561AbWLBSy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936563AbWLBSy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:54:27 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:19573 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S936561AbWLBSy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:54:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=hmp2Y8xdDP79AWQtA+7o0uIoxL8M76nTRn5idZejQHoh7rSRsGE3NVTJRcsd7GsMDhW+AC74uLuJXJ5TjjaWmlSpTm0uM0j62PulolIyDKX9TW1+Br+iTzZFlKjKWs2WM2MbRKY9gnQzt9Cog2Pv8zOvANmsil5Xo91M4hZul24=
In-Reply-To: <20061202130317.273abf75@localhost.localdomain>
References: <61D44F12-D09C-4A6F-9FC7-4AC49FEC757B@gmail.com> <20061202111928.428e83d2@localhost.localdomain> <20061202130317.273abf75@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F9FBBC4B-BDB9-49E5-8089-3D6E8BFE0FA0@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>
Content-Transfer-Encoding: 7bit
From: Ricardo Lugo <ricardolugo@gmail.com>
Subject: Re: hang booting onboard HPT 366 with libata (PATA)
Date: Sat, 2 Dec 2006 13:54:24 -0500
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 2, 2006, at 8:03 AM, Alan wrote:

> On Sat, 2 Dec 2006 11:19:28 +0000
> Alan <alan@lxorguk.ukuu.org.uk> wrote:
>
>>> ACPI: PCI Interrup 0000:00:13.1[B] -> GSI 18 (level, low) -> IRQ 16
>>> ata5: PATA max UDMA/66 cmd 0xE400 ctl 0xE802 bmdma 0xEC00 irq 16
>>> ata6: PATA max UDMA/66 cmd 0x0 ctl 0x2 bmdma 0xEC08 irq 16
>>
>> Ok so the underlying problem seems to be that the second channel  
>> of the
>> card had no I/O resource assigned to it, presumably because it  
>> wasn't in
>> use. We check various other "not in use" things but not that one.
>>
>> I'll fix that up. I think it just needs another check in libata-sff.
>
> Try the following

That certainly sped up the bootup process, but still hangs at the  
same place. Interestingly, if I append "nosmp" to kernel params, it  
hangs earlier and I get a different error. Specifics below:

ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 16
ata3: PATA max UDMA/66 cmd 0xD800 ctl 0xDC02 bmdma 0xE000 irq 16
scsi2: pata_hpt366
ATA: abnormal status 0x8 on port 0xD807
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 18 (level, low) -> IRQ 16
ata4: PATA max UDMA/66 cmd 0xE400 ctl 0xE802 bmdma 0xEC00 irq 16
scsi3: pata_hpt366
ata4.00: ATA-6, max UDMA/100, 156301488 sectors: LBA48
ata4.00: configured for UDMA/33
scsi 3:0:0:0: Direct-Access     ATA       ST380011A 3.06 PQ: 0 ANSI: 5
SCSI device sda: 156301488 512-byte hdrwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdrwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
sda:_

--- nosmp ---
...
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 18 (level, low) -> IRQ 16
ata4: PATA max UDMA/66 cmd 0xE400 ctl 0xE802 bmdma 0xEC00 irq 16
scsi3: pata_hpt366
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)

- Rick
