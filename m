Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288560AbSADJZl>; Fri, 4 Jan 2002 04:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288561AbSADJZc>; Fri, 4 Jan 2002 04:25:32 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:36869 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S288560AbSADJZR>; Fri, 4 Jan 2002 04:25:17 -0500
Date: Fri, 4 Jan 2002 10:25:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitri Pogosyan <pogosyan@phys.ualberta.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ASUS KT266A/VT8233 board and UDMA setting
Message-ID: <20020104102507.A20412@suse.cz>
In-Reply-To: <Pine.GSO.4.33.0201021812560.28783-100000@sweetums.bluetronic.net> <Pine.LNX.4.33.0201022010340.10236-100000@coffee.psychology.mcmaster.ca> <20020104025424.GP28238@auctionwatch.com> <3C352FAA.3AB8C520@phys.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C352FAA.3AB8C520@phys.ualberta.ca>; from pogosyan@phys.ualberta.ca on Thu, Jan 03, 2002 at 09:29:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 09:29:30PM -0700, Dmitri Pogosyan wrote:
> Hi everybody,
> sorry for the trivial question, but maybe you can give me some pointers.
> 
> I'm setting up Linux on ASUS A7V266-E board,  Athlon XP 1800+ machine
> and
> have the following problem:
> 
> My new IBM 40GB   hard drive  on ide0  (alone,   master)  controller  is
> always get set at boot
>  to UDMA2 mode,  not UDMA5.
> The second identical drive on onboard promise controller is getting set
> to UDMA5
> and runs much faster.
> 
> I looked in BIOS setup, and BIOS sets the first ide0 drive to UDMA5,
> which at least says that
> cable is the correct one, and that it is linux boot which changes the
> setting to udma2.
> 
> Here are the related pieces of dmesg. As you see I use RH rawhide 2.4.16
> kernel,  which is
> something like 2.4.17-pre8,   I think

Some RH kernels (may include yours) deliberately disable UDMA3, 4 and 5
on any VIA IDE controller. I don't know why. Unpatch your kernel and
it'll likely work.

> 
> # dmesg
> Linux version 2.4.16-0.13 (bhcompile@stripples.devel.redhat.com) (gcc
> version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Dec 14 05:30:28
> EST 2001
> ...............................
> Fri Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
> Kernel command line: auto BOOT_IMAGE=linux-16 ro root=301
> BOOT_FILE=/boot/vmlinuz-2.4.16-0.13 hdc=ide-scsi
> ide_setup: hdc=ide-scsi
> Initializing CPU#0
> Detected 1544.511 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 3080.19 BogoMIPS
> Memory: 1544904k/1572784k available (1560k kernel code, 27492k reserved,
> 316k data, 248k init, 655280k highmem)
>  .............
> 
> PCI: PCI BIOS revision 2.10 entry at 0xf0df0, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Unknown bridge resource 0: assuming transparent
> PCI: Using IRQ router VIA [1106/3074] at 00:11.0
> PCI: Found IRQ 11 for device 00:11.1
> PCI: Sharing IRQ 11 with 01:00.0
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
> Starting kswapd
> allocated 64 pages and 64 bhs reserved for the highmem bounces
> VFS: Diskquotas version dquot_6.5.0 initialized
> pty: 2048 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT
> SHARE_IRQ SERIAL_PCI ISAPNP enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> Real Time Clock Driver v1.10e
> block: 128 slots per queue, batch=32
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> PDC20265: IDE controller on PCI bus 00 dev 30
> PCI: Found IRQ 9 for device 00:06.0
> PCI: Sharing IRQ 9 with 00:11.2
> PCI: Sharing IRQ 9 with 00:11.3
> PCI: Sharing IRQ 9 with 00:11.4
> PDC20265: chipset revision 2
> PDC20265: not 100% native mode: will probe irqs later
> PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
>     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:DMA
>     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:DMA, hdh:pio
> VP_IDE: IDE controller on PCI bus 00 dev 89
> PCI: Found IRQ 11 for device 00:11.1
> PCI: Sharing IRQ 11 with 01:00.0
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
>     ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:DMA
> hda: IC35L040AVER07-0, ATA DISK drive
> hdc: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
> hdd: ASUS CD-S520/A, ATAPI CD/DVD-ROM drive
> hdg: IC35L040AVER07-0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide3 at 0xb800-0xb807,0xb402 on irq 9
> hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63,
> UDMA(33)     <----  problem
> hdg: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63,
> UDMA(100)
> ide-floppy driver 0.97.sv
> .....................................................
> 
> Any  clues   ?   As well, could somebody explain me, what exactly is the
> device on IRQ 11 (00:11.1)
> 
>         Thank you very much, Dmitri
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
