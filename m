Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269036AbUHMIQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269036AbUHMIQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 04:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269037AbUHMIQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 04:16:30 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:16684 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269029AbUHMIPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 04:15:44 -0400
Message-ID: <9dda349204081301151a7331be@mail.gmail.com>
Date: Fri, 13 Aug 2004 04:15:42 -0400
From: Paul Blazejowski <diffie@gmail.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.8-rc4-mm1
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200408121721.46807.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_400_30355832.1092384942610"
References: <9dda3492040812114929cf8dcc@mail.gmail.com> <200408121721.46807.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_400_30355832.1092384942610
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Bjorn,

Thank you for the patch. I applied it and now the kernel boots fine.

Attached is the dmesg from successful boot.

Regards,

Paul
-- 
FreeBSD the Power to Serve!


On Thu, 12 Aug 2004 17:21:46 -0600, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> Thank you very much for the pictures and the transcript.  I found a
> couple bugs in the iteraid driver.  Could you please try the attached
> patch?
> 
> --- 2.6.8-rc4-mm1/drivers/scsi/iteraid.h.orig   2004-08-12 16:50:38.483419878 -0600
> +++ 2.6.8-rc4-mm1/drivers/scsi/iteraid.h        2004-08-12 17:16:08.569338635 -0600
> @@ -1203,8 +1203,8 @@
>  typedef struct _Adapter {
>         char *name;             /* Adapter's name               */
>         u8 num_channels;        /* How many channels support    */
> -       u8 irq;                 /* irq number                   */
> -       u8 irqOwned;            /* If any irq is use            */
> +       unsigned int irq;       /* irq number                   */
> +       unsigned int irqOwned;  /* If any irq is use            */
>         u8 pci_bus;             /* PCI bus number               */
>         u8 devfn;               /* Device and function number   */
>         u8 offline;             /* On line or off line          */
> --- 2.6.8-rc4-mm1/drivers/scsi/iteraid.c.orig   2004-08-12 16:43:38.700221895 -0600
> +++ 2.6.8-rc4-mm1/drivers/scsi/iteraid.c        2004-08-12 17:18:19.419922969 -0600
> @@ -4798,6 +4798,7 @@
>                                pAdap->name);
>                         return -1;
>                 }
> +               printk("%s: IRQ %d for device at %s\n", __FUNCTION__, pAdap->irq, pci_name(pPciDev));
>                 pAdap->irqOwned = pAdap->irq;
>         }
> 
> @@ -4901,12 +4902,17 @@
>                 if (PCI_FUNC(pPciDev->devfn))
>                         continue;
> 
> +               if (pci_enable_device(pPciDev))
> +                       continue;
> +
> +               printk("%s: device at %s\n", __FUNCTION__, pci_name(pPciDev));
>                 /*
>                  * Allocate memory for Adapter.
>                  */
>                 pAdap = (PITE_ADAPTER) kmalloc(sizeof(ITE_ADAPTER), GFP_ATOMIC);
>                 if (pAdap == NULL) {
>                         printk("iteraid_detect: pAdap allocate failed.\n");
> +                       pci_disable_device(pPciDev);
>                         continue;
>                 }
>                 memset(pAdap, 0, sizeof(ITE_ADAPTER));
> @@ -5016,6 +5022,7 @@
>                 if (pAdap->IDEChannel != NULL) {
>                         kfree(pAdap->IDEChannel);
>                 }
> +               pci_disable_device(pAdap->pci_dev);
>                 if (pAdap != NULL) {
>                         kfree(pAdap);
>                 }
>

------=_Part_400_30355832.1092384942610
Content-Type: text/plain; name="2.6.8-rc4-mm1-patchup-dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="2.6.8-rc4-mm1-patchup-dmesg.txt"

Linux version 2.6.8-rc4-mm1 (root@blaze) (gcc version 3.4.1) #2 Fri Aug 13 =
03:00:04 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5360
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6d70
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff7640
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=3DSlackware ro root=3D801 console=3DttyS0,5=
7600n8 console=3Dtty0 rootflags=3Dquota
CPU 0 irqstacks, hard=3Dc0439000 soft=3Dc0438000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2204.979 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035116k/1048512k available (2304k kernel code, 12744k reserved, 78=
4k data, 180k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok=
.
Calibrating delay loop... 4358.14 BogoMIPS (lpj=3D2179072)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 3200+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
checking if image is initramfs...it isn't (ungzip failed); looks like an in=
itrd
Freeing initrd memory: 56k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfaee0, last bus=3D3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=3Drouteirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, size 3072k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D9
vesafb: protected mode interface info at c000:581c
vesafb: scrolling: redraw
vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Console: switching to colour frame buffer device 128x48
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD300BB-00AUA1, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: Host Protected Area detected.
=09current capacity is 58631231 sectors (30019 MB)
=09native  capacity is 58633344 sectors (30020 MB)
hda: 58631231 sectors (30019 MB) w/2048KiB Cache, CHS=3D58165/16/63, UDMA(1=
00)
hda: cache flushes not supported
 hda: hda1
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 17
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

(scsi0:A:3): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
  Vendor: PLEXTOR   Model: CD-ROM PX-40TW    Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:6): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 17 (level, high) -> IRQ 17
iteraid_detect: device at 0000:01:0c.0
Found Controller: IT8212 UDMA/ATA133 RAID Controller
iteraid_init: IRQ 17 for device at 0000:01:0c.0
FindDevices: device 0 is IDE
Channel[0] BM-DMA at 0x9800-0x9807
Channel[1] BM-DMA at 0x9808-0x980F
scsi1 : ITE RAIDExpress133
  Vendor: ITE       Model: IT8212F           Rev: 1.45
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sdb: 468883200 512-byte hdwr sectors (240068 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices:=20
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1=20
BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
RAMDISK: Couldn't find valid RAM disk image starting at 0.
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding 248968k swap on /dev/sda7.  Priority:-1 extents:1
Real Time Clock Driver v1.12
XFS mounting filesystem sda2
Ending clean XFS mount for filesystem: sda2
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
XFS mounting filesystem sda5
Ending clean XFS mount for filesystem: sda5
XFS mounting filesystem sda6
Ending clean XFS mount for filesystem: sda6
XFS mounting filesystem sdb1
Ending clean XFS mount for filesystem: sdb1
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 16 (level, high) -> IRQ 16
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[22]  MMIO=3D[e6084000-e6084=
7ff]  Max Packet=3D[2048]
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49414 usecs
intel8x0: clocking to 47437
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 20 (level, high) -> IRQ 20
PCI: Setting latency timer of device 0000:00:04.0 to 64
ohci1394: fw-host0: SelfID received outside of bus reset sequence
eth1: no link during initialization.
eth1: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:04.0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 22 (level, high) -> IRQ 22
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 22, pci mem f8bea000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 21 (level, high) -> IRQ 21
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[8a1cc7ffff0020ed]
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 21, pci mem f8bec000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ip1394: $Rev: 1231 $ Ben Collins <bcollins@debian.org>
ip1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 20 (level, high) -> IRQ 20
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 20, pci mem f8c80000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0xb0000000
ohci_hcd 0000:00:02.1: wakeup
usb 2-1: new low speed USB device using address 2
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with Intelli=
Eye(TM)] on usb-0000:00:02.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 2-2: new full speed USB device using address 3
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 3 ports detected
usb 3-1: new full speed USB device using address 2
usb 2-2.1: new low speed USB device using address 4
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on usb-0000:=
00:02.0-2.1
input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on usb-0000:00=
:02.0-2.1
USB Universal Host Controller Interface driver v2.2
nfs warning: mount version older than kernel
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
eth1: no IPv6 routers present
eth0: no IPv6 routers present

------=_Part_400_30355832.1092384942610--
