Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268047AbUHTMVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268047AbUHTMVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268098AbUHTMUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:20:52 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.72]:34975 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S266643AbUHTMTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:19:22 -0400
Date: Fri, 20 Aug 2004 08:18:20 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
In-reply-to: <200408201250.55025.stefandoesinger@gmx.at>
To: stefandoesinger@gmx.at
Cc: acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>
Message-id: <4125EC0C.5090006@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
References: <41103F22.4090303@optonline.net>
 <200408192224.08271.stefandoesinger@gmx.at> <41251385.9040907@optonline.net>
 <200408201250.55025.stefandoesinger@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stefan -

Can you please attach 'cat /proc/interrupts' from a system that has all 
possible drivers for your hardware loaded. From before suspend.

Also - did suspend/resume for the ipw2100 ever work under any kernel 
version?

Thanks.
Nathan

Stefan Dösinger wrote:

>>I can't find anything named "ipw2100" in my kernel source tree...
>>    
>>
>The driver for the Intel wlan card. See ipw2100.sf.net
>  
>
>>>*In single user mode with ipw2100 loaded while S3, IRQ 11 is disabled on
>>>resume, IRQ is not disabled
>>>      
>>>
>>Huh? IRQ(what) is not disabled?
>>    
>>
>Ooops, I forgot the number.
>IRQ 10 is not disabled any more. I verified that it works fine.
>  
>
>>Please attach dmesg.
>>
>>    
>>
>>>*When the system is fully booted up, everything seems to work fine.
>>>      
>>>
>>What do you mean by this? If you suspend when more drivers are loaded,
>>things work fine, but don't work when less drivers are loaded?
>>    
>>
>Yes, I meant this. But it looks like another once-and-never-again success. I 
>recompiled my kernel and now the ipw2100 resume also fails when all drivers 
>are loaded.
>
>Is it possible that the IRQ routing is restored too late? ipw2100 reports a 
>lot of unhandled irqs.
>
>A dmesg is attached.
>
>Stefan
>  
>
>------------------------------------------------------------------------
>
>Linux version 2.6.8.1 (root@laptop) (gcc version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #4 Fri Aug 20 12:08:26 CEST 2004
>BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
> BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
> BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
> BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
> BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
> BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
>511MB LOWMEM available.
>On node 0 totalpages: 130928
>  DMA zone: 4096 pages, LIFO batch:1
>  Normal zone: 126832 pages, LIFO batch:16
>  HighMem zone: 0 pages, LIFO batch:1
>DMI present.
>ACPI: RSDP (v000 ACER                                      ) @ 0x000f60c0
>ACPI: RSDT (v001 ACER   Cardinal 0x20020302  LTP 0x00000000) @ 0x1ff74c20
>ACPI: FADT (v001 ACER   Cardinal 0x20020302 PTL  0x0000001e) @ 0x1ff7af64
>ACPI: BOOT (v001 ACER   Cardinal 0x20020302  LTP 0x00000001) @ 0x1ff7afd8
>ACPI: DSDT (v001 ACER   Cardinal 0x20020302 MSFT 0x0100000d) @ 0x00000000
>ACPI: PM-Timer IO Port: 0x1008
>Built 1 zonelists
>Kernel command line: root=/dev/hda8 rootfstype=ext3 resume=/dev/hda5 s
>Local APIC disabled by BIOS -- reenabling.
>Found and enabled local APIC!
>Initializing CPU#0
>PID hash table entries: 2048 (order 11: 16384 bytes)
>Detected 1598.835 MHz processor.
>Using pmtmr for high-res timesource
>Console: colour VGA+ 80x25
>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>Memory: 515504k/523712k available (1522k kernel code, 7464k reserved, 671k data, 140k init, 0k highmem)
>Checking if this processor honours the WP bit even in supervisor mode... Ok.
>Calibrating delay loop... 3170.30 BogoMIPS
>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
>CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
>CPU: After vendor identify, caps:  a7e9fbbf 00000000 00000000 00000000
>CPU: L1 I cache: 32K, L1 D cache: 32K
>CPU: L2 cache: 1024K
>CPU: After all inits, caps:        a7e9fbbf 00000000 00000000 00000040
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>ACPI: IRQ9 SCI: Edge set to Level Trigger.
>enabled ExtINT on CPU#0
>ESR value before enabling vector: 00000000
>ESR value after enabling vector: 00000000
>Using local APIC timer interrupts.
>calibrating APIC timer ...
>..... CPU clock speed is 1598.0418 MHz.
>..... host bus clock speed is 99.0901 MHz.
>checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
>ACPI: Looking for DSDT in initrd ... found (at offset 20)!
> found customized DSDT with 23378 bytes!
>Freeing initrd memory: 22k freed
>NET: Registered protocol family 16
>PCI: PCI BIOS revision 2.10 entry at 0xfd732, last bus=2
>PCI: Using configuration type 1
>mtrr: v2.0 (20020519)
>ACPI: Subsystem revision 20040715
>ACPI: Interpreter enabled
>ACPI: Using PIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (00:00)
>PCI: Probing PCI hardware (bus 00)
>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
>PCI: Transparent bridge - 0000:00:1e.0
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
>ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
>ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
>ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
>ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12) *10
>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 11 12) *0, disabled.
>ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
>ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
>ACPI: Embedded Controller [EC0] (gpe 29)
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
>ACPI: Power Resource [PFN0] (off)
>ACPI: Power Resource [PFN1] (off)
>PCI: Using ACPI for IRQ routing
>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
>ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
>ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
>ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
>ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
>ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
>ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
>ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
>ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI interrupt 0000:02:06.1[A] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
>ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
>Simple Boot Flag at 0x37 set to 0x1
>Machine check exception polling timer started.
>devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
>devfs: boot_options: 0x0
>Initializing Cryptographic API
>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>ICH4: IDE controller at PCI slot 0000:00:1f.1
>PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
>ICH4: chipset revision 3
>ICH4: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
>hda: IC25N040ATCS04-0, ATA DISK drive
>Using anticipatory io scheduler
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>hdc: UJDA740 DVD/CDRW, ATAPI CD/DVD-ROM drive
>ide1 at 0x170-0x177,0x376 on irq 15
>hda: max request size: 128KiB
>hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
> /dev/ide/host0/bus0/target0/lun0: p1 p3 < p5 p6 p7 p8 p9 >
>mice: PS/2 mouse device common for all mice
>serio: i8042 AUX port at 0x60,0x64 irq 12
>serio: i8042 KBD port at 0x60,0x64 irq 1
>input: AT Translated Set 2 keyboard on isa0060/serio0
>NET: Registered protocol family 2
>IP: routing cache hash table of 4096 buckets, 32Kbytes
>TCP: Hash tables configured (established 32768 bind 65536)
>speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
>Resume Machine: resuming from /dev/hda5
>Resuming from device unknown-block(3,5)
>Resume Machine: This is normal swap space
>ACPI: (supports S0 S3 S4 S5)
>ACPI wakeup devices: 
>MDM0 GLAN USB1 USB2 USB3 
>RAMDISK: Couldn't find valid RAM disk image starting at 0.
>kjournald starting.  Commit interval 5 seconds
>EXT3-fs: mounted filesystem with ordered data mode.
>VFS: Mounted root (ext3 filesystem) readonly.
>Freeing unused kernel memory: 140k freed
>NET: Registered protocol family 1
>Adding 1052216k swap on /dev/hda5.  Priority:-1 extents:1
>EXT3 FS on hda8, internal journal
>SCSI subsystem initialized
>hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
>Uniform CD-ROM driver Revision: 3.20
>Linux agpgart interface v0.100 (c) Dave Jones
>agpgart: Detected an Intel 855PM Chipset.
>agpgart: Maximum main memory to use for agp memory: 439M
>agpgart: AGP aperture is 256M @ 0xe0000000
>Synaptics Touchpad, model: 1
> Firmware: 5.8
> 180 degree mounted touchpad
> Sensor: 29
> new absolute packet format
> Touchpad has extended capability bits
> -> 4 multi-buttons, i.e. besides standard buttons
> -> multifinger detection
> -> palm detection
>input: SynPS/2 Synaptics TouchPad on isa0060/serio1
>kjournald starting.  Commit interval 5 seconds
>EXT3 FS on hda9, internal journal
>EXT3-fs: mounted filesystem with ordered data mode.
>kjournald starting.  Commit interval 5 seconds
>EXT3 FS on hda6, internal journal
>EXT3-fs: mounted filesystem with ordered data mode.
>kjournald starting.  Commit interval 5 seconds
>EXT3 FS on hda7, internal journal
>EXT3-fs: mounted filesystem with ordered data mode.
>usbcore: registered new driver usbfs
>usbcore: registered new driver hub
>ieee80211_crypt: registered algorithm 'NULL'
>ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.53
>ipw2100: Copyright(c) 2003-2004 Intel Corporation
>ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
>ipw2100: 0000:02:04.0: Detected at mem: 0xD0206000-0xD0206FFF -> e0931000, irq: 11
>wlan0: Using hotplug firmware load.
>wlan0: Bound to 0000:02:04.0
>NET: Registered protocol family 17
>PM: Preparing system for suspend
>Stopping tasks: ==========|
>wlan0: Going into suspend...
>PM: Entering state.
>Back to C!
>
>--Here is a uncountable number of "IRQ ignored" messages from the ipw2100 driver--
>--I removed the debug line from the driver because it would have overwritten the--
>--lines above--
>
>irq 11: nobody cared!
> [<c010851a>] __report_bad_irq+0x2a/0x90
> [<c0108610>] note_interrupt+0x70/0xb0
> [<c01088f0>] do_IRQ+0x120/0x130
> [<c0106b40>] common_interrupt+0x18/0x20
> [<c012119e>] __do_softirq+0x2e/0x80
> [<c0121217>] do_softirq+0x27/0x30
> [<c01088cb>] do_IRQ+0xfb/0x130
> [<c010c8e0>] time_resume+0x0/0x50
> [<c0106b40>] common_interrupt+0x18/0x20
> [<c010c8e0>] time_resume+0x0/0x50
> [<c010c91d>] time_resume+0x3d/0x50
> [<c01f8493>] sysdev_resume+0x103/0x108
> [<c01fbf85>] device_power_up+0x5/0xa
> [<c01352f6>] suspend_enter+0x36/0x50
> [<c01353d9>] enter_state+0x69/0xb0
> [<c01dc085>] acpi_suspend+0x3e/0x4d
> [<c01dc434>] acpi_system_write_sleep+0x60/0x8b
> [<c01dc449>] acpi_system_write_sleep+0x75/0x8b
> [<c0156298>] vfs_write+0xb8/0x130
> [<c0155839>] filp_close+0x59/0x90
> [<c01563e1>] sys_write+0x51/0x80
> [<c010615b>] syscall_call+0x7/0xb
>handlers:
>[<e095b340>] (ipw2100_interrupt+0x0/0xe0 [ipw2100])
>Disabling IRQ #11
>MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
>Bank 1: f200000000000135
>PM: Finishing up.
>psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
>    ACPI-0286: *** Error: No installed handler for fixed event [00000002]
>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
>wlan0: Coming out of suspend...
>wlan0: Using hotplug firmware load.
>wlan0: ipw2100_hw_send_command timed out.
>wlan0: Failed to start the card.
>Restarting tasks... done
>wlan0: Hardware fatal error detected.
>wlan0: Scheduling firmware restart (0s).
>ipw2100: wlan0: Restarting adapter.
>wlan0: Using hotplug firmware load.
>wlan0: ipw2100_hw_send_command timed out.
>wlan0: Failed to start the card.
>wlan0: Hardware fatal error detected.
>wlan0: Scheduling firmware restart (0s).
>ipw2100: wlan0: Restarting adapter.
>wlan0: Using hotplug firmware load.
>wlan0: ipw2100_hw_send_command timed out.
>wlan0: Failed to start the card.
>wlan0: Hardware fatal error detected.
>wlan0: Scheduling firmware restart (0s).
>ipw2100: wlan0: Restarting adapter.
>wlan0: Using hotplug firmware load.
>  
>

