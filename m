Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVCaAGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVCaAGX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVCaAGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:06:23 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:4830 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262604AbVCaAFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:05:22 -0500
Message-ID: <424B3EBB.6090407@tiscali.de>
Date: Thu, 31 Mar 2005 02:05:15 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Philip Lawatsch <philip@lawatsch.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
References: <424B228B.8000807@lawatsch.at>
In-Reply-To: <424B228B.8000807@lawatsch.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Lawatsch schrieb:

>Hi,
>
>
>I do have a very strange problem:
>
>If I memset a ~1meg buffer some thousand times (in the userspace) it
>will hardlock my machine.
>
>I've been using 2.6.12-rc1 and also a lot of other kernels (2.6.9,
>2.6.11). I've tried it both using a 32 bit kernel and a 64 bit kernel.
>When running on the 32 bit kernel the machine hardlocks after about
>15000 iterations, on a 64 bit kernel the machine hardlocks after about
>5000 (the 64 bit system has nearly no background jobs running).
>
>I've been running memcheck for several hours now but nothing did show up.
>
>
>I've got an Asus A8N-SLI board with 2 gigs of memory and an AMD 3500+ CPU.
>
>The 64 bit kernel was compiled using gcc 3.4.3 and the 32 bit kernel
>using 3.3.5.
>
>
>This simple programm will kill my machine:
>
>#include <stdlib.h>
>#include <stdio.h>
>int main(int argc, char *argv[])
>{
>        char buf[1024*1024];
>        int i;
>        for (i=0;i<1024*16;++i)
>        {
>                printf("%d\n",i);
>                memset(buf,0,1024*1024);
>        }
>        printf("Done\n");
>	return 0;
>}
>
>If I usleep for 1ms after each memset the whole thing will happily run
>forever without any problems.
>
>Also if I start it twice (without sleeping in the loop) the machine wont
>hardlock either (tested with a 32 bit kernel).
>
>I'd really appreciate any pointers as to what might be wrong here.
>
>I've tried both kernels with and without preemption.
>
>kind regards Philip
>
>
>  
>
>------------------------------------------------------------------------
>
>  
>
>>Bootdata ok (command line is BOOT_IMAGE=test ro root=809)
>>    
>>
>Linux version 2.6.12-rc1 (root@localhost) (gcc version 3.4.3 20041125 (Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #1 Wed Mar 30 23:30:20 CEST 2005
>BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
> BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
> BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
> BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
> BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
>ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f78c0
>ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff3040
>ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff30c0
>ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9540
>ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9480
>ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
>On node 0 totalpages: 524272
>  DMA zone: 4096 pages, LIFO batch:1
>  Normal zone: 520176 pages, LIFO batch:16
>  HighMem zone: 0 pages, LIFO batch:1
>Nvidia board detected. Ignoring ACPI timer override.
>ACPI: Local APIC address 0xfee00000
>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>Processor #0 15:15 APIC version 16
>ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
>ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
>IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>ACPI: BIOS IRQ0 pin2 override ignored.
>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
>ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
>ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
>ACPI: IRQ9 used by override.
>ACPI: IRQ14 used by override.
>ACPI: IRQ15 used by override.
>Setting APIC routing to flat
>Using ACPI (MADT) for SMP configuration information
>Built 1 zonelists
>Kernel command line: BOOT_IMAGE=test ro root=809 console=tty0
>Initializing CPU#0
>PID hash table entries: 4096 (order: 12, 131072 bytes)
>time.c: Using 1.193182 MHz PIT timer.
>time.c: Detected 2211.376 MHz processor.
>Console: colour VGA+ 80x25
>Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
>Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
>Memory: 2056168k/2097088k available (3281k kernel code, 40236k reserved, 1386k data, 188k init)
>Calibrating delay loop... 4374.52 BogoMIPS (lpj=2187264)
>Mount-cache hash table entries: 256
>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
>CPU: L2 Cache: 512K (64 bytes/line)
>CPU: AMD Athlon(tm) 64 Processor 3500+ stepping 00
>Using local APIC NMI watchdog using perfctr0
>Using local APIC timer interrupts.
>Detected 12.564 MHz APIC timer.
>NET: Registered protocol family 16
>PCI: Using configuration type 1
>mtrr: v2.0 (20020519)
>ACPI: Subsystem revision 20050211
>ACPI: Interpreter enabled
>ACPI: Using IOAPIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (00:00)
>PCI: Probing PCI hardware (bus 00)
>PCI: Transparent bridge - 0000:00:09.0
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
>ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 11 *12 14 15)
>ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
>ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 9 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
>ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
>ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 7 9 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
>ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LACI] (IRQs *3 4 5 7 9 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
>ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LUB2] (IRQs *3 4 5 7 9 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
>ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 7 9 10 11 *12 14 15)
>ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
>ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
>ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
>ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
>ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
>ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
>ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
>ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
>ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
>ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
>ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
>ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
>ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
>ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
>ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
>ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
>ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
>SCSI subsystem initialized
>usbcore: registered new driver usbfs
>usbcore: registered new driver hub
>PCI: Using ACPI for IRQ routing
>PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
>TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
>IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
>Total HugeTLB memory allocated, 0
>devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
>devfs: boot_options: 0x0
>JFS: nTxBlock = 8192, nTxLock = 65536
>SGI XFS with ACLs, large block/inode numbers, no debug enabled
>Initializing Cryptographic API
>pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
>ACPI: Power Button (FF) [PWRF]
>ACPI: Fan [FAN] (on)
>ACPI: Processor [CPU0] (supports 8 throttling states)
>ACPI: Thermal Zone [THRM] (40 C)
>Real Time Clock Driver v1.12
>Non-volatile memory driver v1.2
>[drm] Initialized drm 1.0.0 20040925
>serio: i8042 AUX port at 0x60,0x64 irq 12
>serio: i8042 KBD port at 0x60,0x64 irq 1
>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>io scheduler noop registered
>io scheduler anticipatory registered
>io scheduler deadline registered
>io scheduler cfq registered
>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
>loop: loaded (max 8 devices)
>forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.31.
>ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
>ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 23 (level, low) -> IRQ 23
>PCI: Setting latency timer of device 0000:00:0a.0 to 64
>eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
>NFORCE-CK804: chipset revision 162
>NFORCE-CK804: not 100% native mode: will probe irqs later
>NFORCE-CK804: BIOS didn't set cable bits correctly. Enabling workaround.
>NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
>Probing IDE interface ide0...
>hda: PIONEER DVD-RW DVR-109, ATAPI CD/DVD-ROM drive
>hdb: PHILIPS DROM5016L, ATAPI CD/DVD-ROM drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>Probing IDE interface ide1...
>Probing IDE interface ide1...
>Probing IDE interface ide2...
>Probing IDE interface ide3...
>Probing IDE interface ide4...
>Probing IDE interface ide5...
>hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
>Uniform CD-ROM driver Revision: 3.20
>hdb: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
>libata version 1.10 loaded.
>sata_nv version 0.6
>ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
>ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 22 (level, low) -> IRQ 22
>PCI: Setting latency timer of device 0000:00:07.0 to 64
>ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 22
>ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 22
>ata1: no device found (phy stat 00000000)
>scsi0 : sata_nv
>ata2: no device found (phy stat 00000000)
>scsi1 : sata_nv
>ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
>ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 21 (level, low) -> IRQ 21
>PCI: Setting latency timer of device 0000:00:08.0 to 64
>ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 21
>ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
>ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c68 86:3e01 87:4063 88:407f
>ata3: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
>nv_sata: Primary device added
>nv_sata: Primary device removed
>nv_sata: Secondary device added
>nv_sata: Secondary device removed
>ata3: dev 0 configured for UDMA/133
>scsi2 : sata_nv
>ata4: no device found (phy stat 00000000)
>scsi3 : sata_nv
>  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
>  Type:   Direct-Access                      ANSI SCSI revision: 05
>SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
>SCSI device sda: drive cache: write back
>SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
>SCSI device sda: drive cache: write back
> /dev/scsi/host2/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
>Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
>Attached scsi generic sg0 at scsi2, channel 0, id 0, lun 0,  type 0
>usbmon: debugs is not available
>mice: PS/2 mouse device common for all mice
>md: linear personality registered as nr 1
>md: raid0 personality registered as nr 2
>md: raid1 personality registered as nr 3
>md: raid5 personality registered as nr 4
>raid5: automatically using best checksumming function: generic_sse
>   generic_sse:  6776.000 MB/sec
>raid5: using function: generic_sse (6776.000 MB/sec)
>raid6: int64x1   2042 MB/s
>raid6: int64x2   2949 MB/s
>raid6: int64x4   2886 MB/s
>raid6: int64x8   1921 MB/s
>raid6: sse2x1     906 MB/s
>raid6: sse2x2    1773 MB/s
>raid6: sse2x4    3062 MB/s
>raid6: using algorithm sse2x4 (3062 MB/s)
>md: raid6 personality registered as nr 8
>md: multipath personality registered as nr 7
>md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
>device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
>Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
>ALSA device list:
>  No soundcards found.
>NET: Registered protocol family 2
>IP: routing cache hash table of 16384 buckets, 128Kbytes
>TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
>TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
>TCP: Hash tables configured (established 524288 bind 65536)
>NET: Registered protocol family 1
>NET: Registered protocol family 10
>Disabled Privacy Extensions on device ffffffff80538620(lo)
>IPv6 over IPv4 tunneling driver
>NET: Registered protocol family 17
>NET: Registered protocol family 15
>powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
>powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x6 (1400 mV)
>powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x8 (1350 mV)
>powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
>powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
>cpu_init done, current fid 0xe, vid 0x6
>ACPI wakeup devices: 
>HUB0 XVR0 XVR1 XVR2 XVR3 USB0 USB2 MMAC MMCI UAR1 
>ACPI: (supports S0 S1 S3 S4 S5)
>BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
>devfs_mk_dev: could not append to parent for md/0
>md: Autodetecting RAID arrays.
>md: autorun ...
>md: ... autorun DONE.
>kjournald starting.  Commit interval 5 seconds
>EXT3-fs: mounted filesystem with ordered data mode.
>VFS: Mounted root (ext3 filesystem) readonly.
>Freeing unused kernel memory: 188k freed
>input: AT Translated Set 2 keyboard on isa0060/serio0
>Adding 1959888k swap on /dev/sda6.  Priority:-1 extents:1
>EXT3 FS on sda9, internal journal
>kjournald starting.  Commit interval 5 seconds
>EXT3 FS on sda8, internal journal
>EXT3-fs: mounted filesystem with ordered data mode.
>i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
>i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
>ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
>ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
>ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 20 (level, low) -> IRQ 20
>PCI: Setting latency timer of device 0000:00:02.0 to 64
>ohci_hcd 0000:00:02.0: nVidia Corporation CK804 USB Controller
>ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
>ohci_hcd 0000:00:02.0: irq 20, io mem 0xd0104000
>hub 1-0:1.0: USB hub found
>hub 1-0:1.0: 10 ports detected
>ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
>ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 23 (level, low) -> IRQ 23
>PCI: Setting latency timer of device 0000:00:02.1 to 64
>ehci_hcd 0000:00:02.1: nVidia Corporation CK804 USB Controller
>ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
>ehci_hcd 0000:00:02.1: irq 23, io mem 0xd0105000
>PCI: cache line size of 64 is not supported by device 0000:00:02.1
>ehci_hcd 0000:00:02.1: park 0
>ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
>hub 2-0:1.0: USB hub found
>hub 2-0:1.0: 10 ports detected
>ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
>ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, low) -> IRQ 22
>PCI: Setting latency timer of device 0000:00:04.0 to 64
>intel8x0_measure_ac97_clock: measured 49642 usecs
>intel8x0: clocking to 46875
>usb 1-1: new full speed USB device using ohci_hcd and address 3
>usb 1-2: new low speed USB device using ohci_hcd and address 4
>usb 1-10: new full speed USB device using ohci_hcd and address 5
>cdc_acm 1-1:1.0: ttyACM0: USB ACM device
>usbcore: registered new driver cdc_acm
>drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB modems and ISDN adapters
>usbcore: registered new driver hiddev
>input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:02.0-2
>usbcore: registered new driver usbhid
>drivers/usb/input/hid-core.c: v2.01:USB HID core driver
>Bluetooth: Core ver 2.7
>NET: Registered protocol family 31
>Bluetooth: HCI device and connection manager initialized
>Bluetooth: HCI socket layer initialized
>Bluetooth: HCI USB driver ver 2.8
>usbcore: registered new driver hci_usb
>ieee1394: Initialized config rom entry `ip1394'
>ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
>ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
>ACPI: PCI interrupt 0000:05:0b.0[A] -> GSI 16 (level, low) -> IRQ 16
>ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[d0004000-d00047ff]  Max Packet=[2048]
>USB Universal Host Controller Interface driver v2.2
>ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d800000a00cc]
>eth1394: $Rev: 1247 $ Ben Collins <bcollins@debian.org>
>eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
>  
>
You want to allocate a lot of memory (16 GB), you don't have that much 
space, so the Kernel hangs.

Matthias-Christian Ott
