Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbUAUNla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 08:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUAUNla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 08:41:30 -0500
Received: from amazone.ujf-grenoble.fr ([193.54.238.254]:25314 "EHLO
	amazone.ujf-grenoble.fr") by vger.kernel.org with ESMTP
	id S263452AbUAUNl0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 08:41:26 -0500
From: Mickael Marchand <marchand@kde.org>
To: "Lars =?iso-8859-15?q?T=E4uber?=" <taeuber@bbaw.de>
Subject: Re: 2.6.2-rc1 / libata 0.81 / sata_sil 0.52
Date: Wed, 21 Jan 2004 14:41:15 +0100
User-Agent: KMail/1.5.94
Cc: linux-kernel@vger.kernel.org
References: <20040121142558.6a7fbd25.taeuber@bbaw.de>
In-Reply-To: <20040121142558.6a7fbd25.taeuber@bbaw.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401211441.15666.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been reported this bug a few days ago by somebody else.
I am waiting for his feedback on a patch.

you can try the patch at ftp://ftp-fourier.ujf-grenoble.fr/kernel/2.6.2-rc1/

I am really not sure of it (because I am no kernel hacker, so backup datas :), 
but maybe it will help.
please report if you try it :)

this is probably the same problem as the adaptec 1210sa but on a 3114 chip so 
I guess we need to enable DMA interrupts for 4 ports.

Cheers,
Mik

Le Mercredi 21 Janvier 2004 14:25, Lars Täuber a écrit :
> Hallo everybody,
>
> I'm not subscribed to this list! But I read the archive nearly regularly.
>
> But I want to offer a bug-/problem-report.
>
> We have here a dual opteron on a tyan K8S Pro (S2882) with an onbaord
> SiI3114 and liked to get the system booting from the SATA disks attached to
> this controller. (SuSE 9.0 x86_64)
>
> The driver works really good if you attach at most 2 disks on certain
> channels.
>
> After realizing that this kernel (and previous kernels with patches from
> Jeff Garzik) won't boot with 3 or 4 disks attached we compiled the sata_sil
> driver as a modules and boot from an scsi disk.
>
> The controller seems to have some connections between the 1st and the 3rd
> channel as well as between the 2nd and the 4th channel.
>
> If we attach disks on the [1st and (the 2nd xor the 4th)] channel every
> thins works as expected. The same behaviour if we connect disks on the [3rd
> and (the 2nd xor the 4th)] channel.
>
> But if we connect disks on the 1st and the 3rd channel the 'modprobe
> sata_sil' hangs an we get the following log: [same when we connect disks on
> 2nd and 4th channel]
>
>
> Jan 21 14:56:44 inst-temp kernel: libata version 0.81 loaded.
> Jan 21 14:56:44 inst-temp kernel: sata_sil version 0.52
> Jan 21 14:56:44 inst-temp kernel: ata1: SATA max UDMA/133 cmd
> 0xFFFFFF000007BC80 ctl 0xFFFFFF000007BC8A bmdma 0xFFFFFF000007BC00 irq 19
> Jan 21 14:56:44 inst-temp kernel: ata2: SATA max UDMA/133 cmd
> 0xFFFFFF000007BCC0 ctl 0xFFFFFF000007BCCA bmdma 0xFFFFFF000007BC08 irq 19
> Jan 21 14:56:44 inst-temp kernel: ata3: SATA max UDMA/133 cmd
> 0xFFFFFF000007BE80 ctl 0xFFFFFF000007BE8A bmdma 0xFFFFFF000007BE00 irq 19
> Jan 21 14:56:44 inst-temp kernel: ata4: SATA max UDMA/133 cmd
> 0xFFFFFF000007BEC0 ctl 0xFFFFFF000007BECA bmdma 0xFFFFFF000007BE08 irq 19
> Jan 21 14:56:44 inst-temp kernel: ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09
> 84:4003 85:7c69 86:3e01 87:4003 88:207f Jan 21 14:56:44 inst-temp kernel:
> ata1: dev 0 ATA, max UDMA/133, 490234752 sectors (lba48) Jan 21 14:56:44
> inst-temp kernel: ata1: dev 0 configured for UDMA/133 Jan 21 14:56:44
> inst-temp kernel: scsi2 : sata_sil
> Jan 21 14:56:45 inst-temp kernel: ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09
> 84:4003 85:7c69 86:3e01 87:4003 88:207f Jan 21 14:56:45 inst-temp kernel:
> ata2: dev 0 ATA, max UDMA/133, 490234752 sectors (lba48) Jan 21 14:56:45
> inst-temp kernel: ata2: dev 0 configured for UDMA/133 Jan 21 14:56:45
> inst-temp kernel: scsi3 : sata_sil
> Jan 21 14:56:45 inst-temp kernel: ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09
> 84:4003 85:7c69 86:3e01 87:4003 88:207f Jan 21 14:56:45 inst-temp kernel:
> ata3: dev 0 ATA, max UDMA/133, 490234752 sectors (lba48) Jan 21 14:56:45
> inst-temp kernel: ata3: dev 0 configured for UDMA/133 Jan 21 14:56:45
> inst-temp kernel: scsi4 : sata_sil
> Jan 21 14:56:45 inst-temp kernel: ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09
> 84:4003 85:7c69 86:3e01 87:4003 88:207f Jan 21 14:56:45 inst-temp kernel:
> ata4: dev 0 ATA, max UDMA/133, 490234752 sectors (lba48) Jan 21 14:56:45
> inst-temp kernel: ata4: dev 0 configured for UDMA/133 Jan 21 14:56:45
> inst-temp kernel: scsi5 : sata_sil
> Jan 21 14:56:45 inst-temp kernel:   Vendor: ATA       Model: Maxtor 7Y250M0
>    Rev: 0.81 Jan 21 14:56:45 inst-temp kernel:   Type:   Direct-Access     
>                 ANSI SCSI revision: 05 Jan 21 14:56:45 inst-temp kernel:
> SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB) Jan 21
> 14:56:45 inst-temp kernel: SCSI device sdb: drive cache: write through Jan
> 21 14:56:45 inst-temp kernel:  sdb:
> Jan 21 14:56:45 inst-temp kernel: Attached scsi disk sdb at scsi2, channel
> 0, id 0, lun 0 Jan 21 14:56:45 inst-temp kernel:   Vendor: ATA       Model:
> Maxtor 7Y250M0    Rev: 0.81 Jan 21 14:56:45 inst-temp kernel:   Type:  
> Direct-Access                      ANSI SCSI revision: 05 Jan 21 14:56:45
> inst-temp kernel: SCSI device sdc: 490234752 512-byte hdwr sectors (251000
> MB) Jan 21 14:56:45 inst-temp kernel: SCSI device sdc: drive cache: write
> through Jan 21 14:56:45 inst-temp kernel:  sdc:
> Jan 21 14:56:45 inst-temp kernel: Attached scsi disk sdc at scsi3, channel
> 0, id 0, lun 0 Jan 21 14:56:45 inst-temp kernel:   Vendor: ATA       Model:
> Maxtor 7Y250M0    Rev: 0.81 Jan 21 14:56:45 inst-temp kernel:   Type:  
> Direct-Access                      ANSI SCSI revision: 05 Jan 21 14:56:45
> inst-temp kernel: SCSI device sdd: 490234752 512-byte hdwr sectors (251000
> MB) Jan 21 14:56:45 inst-temp kernel: SCSI device sdd: drive cache: write
> through Jan 21 14:57:15 inst-temp kernel:  sdd:<3>ata3: DMA timeout, stat
> 0x4
>
>
> If we can help with further log or testing please contact me at my original
> mail address. But I'll read the mailing list to form time to time.
>
>
> Sorry for my poor english.
> Greatings
> Lars Täuber
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
