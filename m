Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWDZO3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWDZO3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWDZO3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:29:17 -0400
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:39120 "EHLO
	ecstlaurent8.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S932438AbWDZO3Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:29:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
Date: Wed, 26 Apr 2006 10:28:56 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7011B2606@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
Thread-Index: AcZpPTGnYE8gcVxGSPKnw3oVSgWGCgAAAZRQ
From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
To: "Roger Heflin" <rheflin@atipa.com>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
X-OriginalArrivalTime: 26 Apr 2006 14:29:13.0055 (UTC) FILETIME=[CA0F26F0:01C6693D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think I might be having the "same type of bug" or something related using sata_via?
Bug opened at bugzilla: http://bugzilla.kernel.org/show_bug.cgi?id=6317

This started appearing with 2.6.16.  It often does it using only one SATA HD.  It does not do it at every boot but often starts doing it after a little while (a few hours...) and finally hanging my PC.

- vin

-----Message d'origine-----
De : linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] De la part de Roger Heflin
Envoyé : 26 avril 2006 09:17
À : Roger Heflin
Cc : Linux-Kernel; linux-ide@vger.kernel.org
Objet : Re: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2

Roger Heflin wrote:
> Hello,
> 
> I have several machines configured (10+) with K8N-DRE motherboards, 
> which have Nvidia CK804 chipsets and Sata controllers, all seem to
> exhibit this behavior.   All machines have 16GB of ram, and are
> running x86_64 versions.
> 
> With one disk running everything is fine, and there are no problems, 
> so if I do "dd if=/dev/sda of=/dev/null bs=64k" everything works, if I 
> background the command and start a second dd on sdb the io rate about 
> doubles (to 130k was about 65k) for about 1-2 seconds and then goes to 
> 0 and the machine hangs up (the dd's can be killed with alt-sysrq keys 
> or issuing a kill against the processes-but the processes are in disk 
> wait so it takes 10-30 seconds before the kill actually does
> its job).   After the kill completes everything seems ok again, it
> looks like access to the disks is completely blocked when this 
> happens, I cannot get anything that accesses the disks to run once the 
> dd's hang up.
> 
> I get these messages from dmesg when the event happens on 2.6.16:
> 
> ata1: command 0x25 timeout, stat 0x50 host_stat 0x24
> ata2: command 0x25 timeout, stat 0x50 host_stat 0x24
> 
> On 2.6.17-rc2 the messages look slightly different:
> 
> 
> ata1: command 0xc8 timeout, stat 0x50 host_stat 0x24
> ata1: status=0x50 { DriveReady SeekComplete }
> sda: Current: sense key: No Sense
>     Additional sense: No additional sense information Info 
> fld=0x3481ff
> ata2: command 0xc8 timeout, stat 0x50 host_stat 0x24
> ata2: status=0x50 { DriveReady SeekComplete }
> sdb: Current: sense key: No Sense
>     Additional sense: No additional sense information Info fld=0x166ff
> ata1: command 0xc8 timeout, stat 0x50 host_stat 0x24
> ata1: status=0x50 { DriveReady SeekComplete }
> sda: Current: sense key: No Sense
>     Additional sense: No additional sense information Info 
> fld=0x3482ff
> ata2: command 0xc8 timeout, stat 0x50 host_stat 0x24
> ata2: status=0x50 { DriveReady SeekComplete }
> sdb: Current: sense key: No Sense
>     Additional sense: No additional sense information Info fld=0x167ff
> ata1: command 0xca timeout, stat 0x50 host_stat 0x24
> ata1: status=0x50 { DriveReady SeekComplete }
> 
> 
> The bootup messages for the disks look like this:
> 
> SCSI subsystem initialized
> libata version 1.20 loaded.
> sata_nv 0000:00:07.0: version 0.8
> PCI: Setting latency timer of device 0000:00:07.0 to 64
> ata1: SATA max UDMA/133 cmd 0xF000 ctl 0xEC02 bmdma 0xE000 irq 7
> ata2: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xE008 irq 7
> logips2pp: Detected unknown logitech mouse model 1
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 
> 87:4003 88:203f
> ata1: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
> nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
> ata1: dev 0 configured for UDMA/100
> scsi0 : sata_nv
> ata2: SATA link up 1.5 Gbps (SStatus 113)
> input: PS/2 Logitech Mouse as /class/input/input1
> ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 
> 87:4003 88:203f
> ata2: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
> nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
> ata2: dev 0 configured for UDMA/100
> scsi1 : sata_nv
>   Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back SCSI device sda: 625142448 
> 512-byte hdwr sectors (320073 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda:<4>nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
>  sda1
> sd 0:0:0:0: Attached scsi disk sda
>   Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
> sdb: Write Protect is offsdb: Mode Sense: 00 3a 00 00 SCSI device sdb: 
> drive cache: write back SCSI device sdb: 625142448 512-byte hdwr 
> sectors (320073 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
>  sdb:<4>nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
>  sdb1
> nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
> sd 1:0:0:0: Attached scsi disk sdb
> PCI: Setting latency timer of device 0000:00:08.0 to 64
> ata3: SATA max UDMA/133 cmd 0xDC00 ctl 0xD802 bmdma 0xCC00 irq 5
> ata4: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xCC08 irq 5
> ata3: SATA link down (SStatus 0)
> scsi2 : sata_nv
> ata4: SATA link down (SStatus 0)
> scsi3 : sata_nv
> 
> I have not been able (so far) to get these messages only running one 
> disk at a time.  And it appears that I can run either disk by itself 
> with no issues.
> 
> I tested with 2 different FC5 2.6.16 variants, and with 2.6.17-rc2, 
> and both exhibit the same behavior.
> 
> What can I try to debug this?
> 
>                      Roger Heflin


And if anyone is interested in trying to debug this, I can give full access to the machine and I can probably provide whatever setup is best for debugging this sort of issue.

                                  Roger
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



