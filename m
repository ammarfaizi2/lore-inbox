Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSHZTOT>; Mon, 26 Aug 2002 15:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSHZTOT>; Mon, 26 Aug 2002 15:14:19 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:6163 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S317742AbSHZTOQ>;
	Mon, 26 Aug 2002 15:14:16 -0400
Date: Mon, 26 Aug 2002 21:17:32 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: IDE?  IDE-TNG driver
To: andre@linux-ide.org, linux-kernel@vger.kernel.org
Message-id: <3D6A7ECC.E2DFE661@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick (andre@linux-ide.org) wrote :
> I will hand it to you guys on a silver platter IDE-TNG. 
> 
> Below yields modular chipsets and channel index registration. 
> Selectable IOPS for arch independent Taskfile Transport layers. 
> Now to finish the job with device class link lists to address fully 
> modular subdrivers. It also includes 1st generation of device open and 
> select calls of subdrivers. 

Will it support DISCONNECT/RECONNECT ( of course named differently
in ATA, "overlapped command feature" if I'm not mistaken ) ?

If not, consider this as a request for implementation :-)
I can offer (beta)testing ( I have two ATAPI CD-ROMs ( one is a
rewriter ) and a HD , that all claim ( according to hdparm -I output )
to support overlapped commands ) and maybe money, if everything else
fails :-)

I expect this to improve performance ( latency actually ) on the ATA
channel when slow devices are involved ( and even fast devices can have
slow moments, like a read of a slightly broken sector ).

Best regards,
david balazic

 
> You have ide-cd registered on a cdrw and you want to burn a cd? 
> open(/dev/hdX) transform_subdriver_scsi close(/dev/hdX) 
> open(/dev/sg) and burn baby burn. 
> close(/dev/sg) releases transform_subdriver_scsi 
> open(/dev/hdX) load native atapi transport. 
> 
> Will do it for TAPE-FLOPPY-DVDCD/RW ... 
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.31 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
> SiI680: IDE controller on PCI bus 00 dev 90 
> SiI680: chipset revision 1 
> SiI680: not 100% native mode: will probe irqs later 
> SiI680: BASE CLOCK == 133 
>     ide0: MMIO-DMA at 0xe080df00-0xe080df07, BIOS settings: hda:pio, hdb:pio 
>     ide1: MMIO-DMA at 0xe080df08-0xe080df0f, BIOS settings: hdc:pio, hdd:pio 
> hda: Maxtor 4G160J8, ATA DISK drive 
> hdb: Maxtor 4G160J8, ATA DISK drive 
> ide0 at 0xe080df80-0xe080df87,0xe080df8a on irq 9 
> hda: host protected area => 1 
> hda: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133) 
> hdb: host protected area => 1 
> hdb: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133) 
> hdc: Maxtor 4G160J8, ATA DISK drive 
> hdd: Maxtor 4G160J8, ATA DISK drive 
> ide1 at 0xe080dfc0-0xe080dfc7,0xe080dfca on irq 9 
> hdc: host protected area => 1 
> hdc: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133) 
> hdd: host protected area => 1 
> hdd: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133) 
> PIIX3: IDE controller on PCI bus 00 dev 39 
> PIIX3: chipset revision 0 
> PIIX3: not 100% native mode: will probe irqs later 
>     ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hde:DMA, hdf:DMA 
>     ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdg:pio, hdh:pio 
> hde: ATAPI 44X CDROM, ATAPI CD/DVD-ROM drive 
> hdf: CREATIVEDVD5240E-1, ATAPI CD/DVD-ROM drive 
> ide2 at 0x1f0-0x1f7,0x3f6 on irq 14 
> hde: ATAPI 40X CD-ROM drive, 128kB Cache, (U)DMA 
> Uniform CD-ROM driver Revision: 3.12 
> hdf: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA 
> Partition check: 
>  /dev/ide/host0/bus0/target0/lun0: p1 
>  /dev/ide/host0/bus0/target1/lun0: p1 
>  /dev/ide/host0/bus1/target0/lun0: p1 
>  /dev/ide/host0/bus1/target1/lun0: p1 
> 
> If this is what you want, this is what I have to put on the table. 
> If you do not I will delete the code. 
> 
> Regards, 
> 
> Andre Hedrick 
> LAD Storage Consulting Group
