Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319520AbSIGVX7>; Sat, 7 Sep 2002 17:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319521AbSIGVX7>; Sat, 7 Sep 2002 17:23:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:29419 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S319520AbSIGVX5> convert rfc822-to-8bit; Sat, 7 Sep 2002 17:23:57 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac4
Date: Sat, 7 Sep 2002 23:28:27 +0200
User-Agent: KMail/1.4.2
References: <200209061500.g86F08m12929@devserv.devel.redhat.com>
In-Reply-To: <200209061500.g86F08m12929@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209072328.27543.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Andre, and friends,

this happens predictably on dvd mount via ide-scsi with 20-pre5-ac4:

udf: registering filesystem
UDF-fs DEBUG lowlevel.c:57:udf_get_last_session: XA disk: no, vol_desc_start=0
UDF-fs DEBUG super.c:1421:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte sectors)
kernel BUG at /usr/src/linux/include/linux/blkdev.h:153!
invalid operand: 0000
CPU:    0
EIP:    0010:[ide_build_sglist+73/384]    Tainted: PF
EFLAGS: 00210206
eax: 0000005a   ebx: effc9000   ecx: c02c73c0   edx: e9445140
esi: 00000000   edi: e9445140   ebp: e2e11ba0   esp: e2e11b80
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 1440, stackpage=e2e11000)
Stack: effc9000 c02c7470 e9445140 e4448e80 00000003 0000000d c02c7470 c19f6000
       e2e11bcc c019c4a1 c02c73c0 e9445140 c02c73c0 c02c7470 e9445140 ef57c140
       00000000 00000000 c02c73c0 e2e11bec c019c97a c02c7470 e9445140 c02c7470
Call Trace:    [ide_build_dmatable+81/400] [__ide_dma_read+42/288]·
[nfsd:__insmod_nfsd_O/lib/modules/2.4.20-pre5-ac3/kernel/fs/nfsd/+-30237/96] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.20-pre5-ac3/kernel/fs/nfsd/+-29862/96] 
[start_request+389/480] [ide_do_request+597/672] [ide_do_drive_cmd+204/256] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.20-pre5-ac3/kernel/fs/nfsd/+-26784/96] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.20-pre5-ac3/kernel/fs/nfsd/+-100640/96] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.20-pre5-ac3/kernel/fs/nfsd/+-125027/96] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.20-pre5-ac3/kernel/fs/nfsd/+-100096/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.20-pre5-ac3/kernel/fs/nfsd/+-93731/96] 
[<f29e9ee0>] [generic_unplug_device+34/48] [__run_task_queue+76/96] 
[__wait_on_buffer+86/144] [bread+79/112] [<f29fa1b1>] [<f29f658f>] [<f29f7b6e>] 
[<f29f8446>] [<f29fccce>] [<f29fc459>] [<f29fc451>] [<f29fcca8>] 
[get_sb_bdev+438/544] [<f29fd700>] [<f29fd700>] [alloc_vfsmnt+137/224]
[do_kern_mount+86/256] [<f29fd700>] [do_add_mount+102/336] [do_mount+317/352] 
[copy_mount_options+80/176] [sys_mount+124/192] [system_call+51/56]

Code: 0f 0b 99 00 a0 b8 22 c0 8b 45 08 c7 80 24 04 00 00 01 00 00

ide config:

CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDECD_BAILOUT=y
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_IDE=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IDE_TASK_IOCTL=y

general setup:

CONFIG_EXPERIMENTAL=y
CONFIG_KMOD=y
CONFIG_MICROCODE=m
CONFIG_MK7=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_MTRR=y
CONFIG_NOHIGHMEM=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_UID16=y
CONFIG_X86=y
CONFIG_X86_BSWAP=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_CPUID=m
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INVLPG=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_MCE=y
CONFIG_X86_MSR=m
CONFIG_X86_PGE=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_XADD=y

dmesg:

<4>Kernel command line: rw root=/dev/nfs nfsroot=/netboot/%%s,v3 
   ip=172.16.24.108:172.16.24.102:172.16.24.1:255.255.255.0: 
   video=matrox:vesa:0x11b,k:200MHz,fh:93kHz,fv:150 hda=ide-scsi hdg=ide-scsi 
<4>ide_setup: hda=ide-scsi
<4>ide_setup: hdg=ide-scsi

<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>VP_IDE: IDE controller on PCI bus 00 dev 21
<4>VP_IDE: chipset revision 16
<4>VP_IDE: not 100%% native mode: will probe irqs later
<6>VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
<4>    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
<4>PDC20265: IDE controller on PCI bus 00 dev 88
<6>PCI: Found IRQ 10 for device 00:11.0
<6>PCI: Sharing IRQ 10 with 00:0b.0
<4>PDC20265: chipset revision 2
<4>PDC20265: not 100%% native mode: will probe irqs later
<4>PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
<4>    ide2: BM-DMA at 0x8000-0x8007, BIOS settings: hde:DMA, hdf:pio
<4>    ide3: BM-DMA at 0x8008-0x800f, BIOS settings: hdg:DMA, hdh:DMA
<4>hda: TOSHIBA DVD-ROM SD-M1502, ATAPI CD/DVD-ROM drive
<4>hdc: IBM-DPTA-372050, ATA DISK drive
<4>hde: IBM-DTLA-307060, ATA DISK drive
<4>hdg: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide2 at 0x9400-0x9407,0x9002 on irq 10
<4>ide3 at 0x8800-0x8807,0x8402 on irq 10

<6>SCSI subsystem driver Revision: 1.00
<6>scsi0 : SCSI host adapter emulation for IDE ATAPI devices
<4>  Vendor: TOSHIBA   Model: DVD-ROM SD-M1502  Rev: 1012
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>  Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.05
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<6>hdc: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=39770/16/63, UDMA(66)
<6>hde: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(100)
<6>Partition check:
<6> hdc: [PTBL] [2495/255/63] hdc1 hdc2 < hdc5 >
<6> hde: hde1

Anything missing? Just ask. 18-pre4 does that mount smoothly. Besides this glitch, 
20-pre5-ac4 "feels" a bit more interactively responsive..

Hans-Peter
