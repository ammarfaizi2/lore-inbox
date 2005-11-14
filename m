Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVKNVxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVKNVxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVKNVxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:53:55 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:26127 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1751276AbVKNVxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:53:53 -0500
Message-ID: <4379074D.5060308@tuxrocks.com>
Date: Mon, 14 Nov 2005 14:53:17 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>	 <4378FFFF.4010706@tuxrocks.com> <1132004327.4668.30.camel@leatherman>
In-Reply-To: <1132004327.4668.30.camel@leatherman>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/mixed;
 boundary="------------000002070400090801080109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000002070400090801080109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

john stultz wrote:
> Hmm... Not sure if this is mis-calibration or just bad-interaction w/
> kthrt. Mind sending a dmesg to me?

dmesg attached

>>and 'pit' seems to produce errors (system will not switch from pit to
>>another clocksource anymore):

Odd.  This time, I got the errors when I switched from acpi_pm (which it
had defaulted to at bootup) to jiffies.  System has not locked at one
clocksource yet, though.

> Do the TOD patches have this issue by themselves, or is this only with
> kthrt? I know I had some issues with non-continuous clocksources (pit,
> jiffies) with the kthrt patch, where it wouldn't fall back to
> non-high-res when the clocksource stopped supporting it.

I only tried with kthrt because I ran into lots of conflicts when
applying the patches to more recent kernels otherwise.  I can try again
with 2.6.14-mm2 in order to test it out.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDeQdNaI0dwg4A47wRAmPLAJsGeBvY/M7wc4UehisbcLDVxcYi7wCgoaZM
gEKYNqAsmtXrgKI7ePr8Whg=
=wjaI
-----END PGP SIGNATURE-----

--------------000002070400090801080109
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

[    0.000000] Linux version 2.6.15-rc1-kthrt2-fs2 (sorenson@moebius.cs.byu.edu) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #2 PREEMPT Sun Nov 13 18:41:34 MST 2005
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000005ffae000 (usable)
[    0.000000]  BIOS-e820: 000000005ffae000 - 0000000060000000 (reserved)
[    0.000000]  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] 639MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] On node 0 totalpages: 393134
[    0.000000]   DMA zone: 4096 pages, LIFO batch:2
[    0.000000]   Normal zone: 225280 pages, LIFO batch:64
[    0.000000]   HighMem zone: 163758 pages, LIFO batch:64
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 DELL                                  ) @ 0x000fdf00
[    0.000000] ACPI: RSDT (v001 DELL    CPi R   0x27d50201 ASL  0x00000061) @ 0x5fff0000
[    0.000000] ACPI: FADT (v001 DELL    CPi R   0x27d50201 ASL  0x00000061) @ 0x5fff0400
[    0.000000] ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] Allocating PCI resources starting at 70000000 (gap: 60000000:9eda0000)
[    0.000000] Detected 1993.647 MHz processor.
[   10.305106] Built 1 zonelists
[   10.305108] Kernel command line: ro root=LABEL=/1 vga=794 nmi_watchdog=1 apic=verbose lapic psmouse.proto=exps acpi_sleep=s3_bios init=/sbin/tuxinit console=tty0 console=ttyUSB0,9600
[   10.305320] Local APIC disabled by BIOS -- reenabling.
[   10.305322] Found and enabled local APIC!
[   10.305324] mapped APIC to ffffd000 (fee00000)
[   10.305328] Initializing CPU#0
[   10.305386] CPU 0 irqstacks, hard=c05e4000 soft=c05e3000
[   10.305389] PID hash table entries: 4096 (order: 12, 65536 bytes)
[   10.426439] Event source pit installed with caps set: 0f
[   10.426468] Console: colour dummy device 80x25
[   10.427104] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   10.427813] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   10.481089] Memory: 1550872k/1572536k available (3506k kernel code, 19564k reserved, 1260k data, 212k init, 655032k highmem)
[   10.481109] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   10.540282] Calibrating delay using timer specific routine.. 3988.30 BogoMIPS (lpj=1994153)
[   10.540327] Mount-cache hash table entries: 512
[   10.540452] CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
[   10.540461] CPU: After vendor identify, caps: afe9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
[   10.540470] CPU: L1 I cache: 32K, L1 D cache: 32K
[   10.540474] CPU: L2 cache: 2048K
[   10.540476] CPU: After all inits, caps: afe9fbbf 00000000 00000000 00000040 00000180 00000000 00000000
[   10.540482] Intel machine check architecture supported.
[   10.540487] Intel machine check reporting enabled on CPU#0.
[   10.540500] mtrr: v2.0 (20020519)
[   10.540505] CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 06
[   10.540510] Enabling fast FPU save and restore... done.
[   10.540513] Enabling unmasked SIMD FPU exception support... done.
[   10.540518] Checking 'hlt' instruction... OK.
[   10.551138]  tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
[   10.553386] Parsing all Control Methods:........................................................................................................................................................
[   10.558219] Table [DSDT](id 0005) - 364 Objects with 60 Devices 152 Methods 5 Regions
[   10.558225] ACPI Namespace successfully loaded at root c062e158
[   10.558232] ACPI: setting ELCR to 0200 (from 0800)
[   10.559935] evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
[   10.560003] enabled ExtINT on CPU#0
[   10.560008] Using local APIC timer interrupts.
[   10.560011] calibrating APIC timer ...
[   10.660108] ..... CPU clock speed is 1993.0218 MHz.
[   10.660110] ..... host bus clock speed is 99.0660 MHz.
[   10.660114] Event source pit new caps set: 05
[   10.660117] Event source lapic installed with caps set: 0a
[   10.660220] checking if image is initramfs... it is
[   10.726911] Freeing initrd memory: 985k freed
[   10.727021] DEV: registering device: ID = 'platform'
[   10.727026] PM: Adding info for No Bus:platform
[   10.727039] bus type 'platform' registered
[   10.727041] Registering sysdev class '<NULL>'
[   10.727215] NET: Registered protocol family 16
[   10.727228] device class 'pci_bus': registering
[   10.727234] bus type 'pci' registered
[   10.727236] device class 'tty': registering
[   10.727240] ACPI: bus type pci registered
[   10.744176] PCI: PCI BIOS revision 2.10 entry at 0xfcf9e, last bus=2
[   10.744184] PCI: Using configuration type 1
[   10.744189] Registering sys device 'cpu0'
[   10.744789] bus type 'usb' registered
[   10.744793] device class 'usb_host': registering
[   10.744800] device class 'usb': registering
[   10.744804] bus usb: add driver usbfs
[   10.745049] usbcore: registered new driver usbfs
[   10.745056] device class 'usb_device': registering
[   10.745064] bus usb: add driver hub
[   10.745254] usbcore: registered new driver hub
[   10.745264] bus usb: add driver usb
[   10.745445] device class 'graphics': registering
[   10.745450] ACPI: Subsystem revision 20050902
[   10.746619] evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
[   10.746628] evgpeblk-0996 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 2 Runtime GPEs in this block
[   10.753904] Completing Region/Field/Buffer/Package initialization:.............................................
[   10.755836] Initialized 3/5 Regions 6/7 Fields 20/21 Buffers 16/25 Packages (373 nodes)
[   10.755842] Executing all Device _STA and_INI methods:................................................................
[   10.759907] 64 Devices found containing: 64 _STA, 3 _INI methods
[   10.759919] ACPI: Interpreter enabled
[   10.759922] ACPI: Using PIC for interrupt routing
[   10.762706] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   10.762711] PCI: Probing PCI hardware (bus 00)
[   10.762716] DEV: registering device: ID = 'pci0000:00'
[   10.762721] PM: Adding info for No Bus:pci0000:00
[   10.762924] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   10.773298] CLASS: registering class device: ID = '0000:00'
[   10.773304] class_hotplug - name = 0000:00
[   10.773790] PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
[   10.773795] PCI quirk: region 0880-08bf claimed by ICH4 GPIO
[   10.773838] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   10.773929] CLASS: registering class device: ID = '0000:01'
[   10.773934] class_hotplug - name = 0000:01
[   10.774151] Boot video device is 0000:01:00.0
[   10.774184] CLASS: registering class device: ID = '0000:02'
[   10.774188] class_hotplug - name = 0000:02
[   10.774582] PCI: Transparent bridge - 0000:00:1e.0
[   10.774606] CLASS: registering class device: ID = '0000:03'
[   10.774611] class_hotplug - name = 0000:03
[   10.774811] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   10.775302] DEV: registering device: ID = '0000:00:00.0'
[   10.775479] PM: Adding info for pci:0000:00:00.0
[   10.775483] bus pci: add device 0000:00:00.0
[   10.776573] DEV: registering device: ID = '0000:00:01.0'
[   10.776768] PM: Adding info for pci:0000:00:01.0
[   10.776774] bus pci: add device 0000:00:01.0
[   10.777862] DEV: registering device: ID = '0000:00:1d.0'
[   10.777940] PM: Adding info for pci:0000:00:1d.0
[   10.777943] bus pci: add device 0000:00:1d.0
[   10.779027] DEV: registering device: ID = '0000:00:1d.1'
[   10.779242] PM: Adding info for pci:0000:00:1d.1
[   10.779249] bus pci: add device 0000:00:1d.1
[   10.780339] DEV: registering device: ID = '0000:00:1d.2'
[   10.780548] PM: Adding info for pci:0000:00:1d.2
[   10.780551] bus pci: add device 0000:00:1d.2
[   10.781646] DEV: registering device: ID = '0000:00:1d.7'
[   10.781854] PM: Adding info for pci:0000:00:1d.7
[   10.781857] bus pci: add device 0000:00:1d.7
[   10.782955] DEV: registering device: ID = '0000:00:1e.0'
[   10.783170] PM: Adding info for pci:0000:00:1e.0
[   10.783175] bus pci: add device 0000:00:1e.0
[   10.784268] DEV: registering device: ID = '0000:00:1f.0'
[   10.784489] PM: Adding info for pci:0000:00:1f.0
[   10.784494] bus pci: add device 0000:00:1f.0
[   10.785594] DEV: registering device: ID = '0000:00:1f.1'
[   10.785806] PM: Adding info for pci:0000:00:1f.1
[   10.785810] bus pci: add device 0000:00:1f.1
[   10.786898] DEV: registering device: ID = '0000:00:1f.5'
[   10.787123] PM: Adding info for pci:0000:00:1f.5
[   10.787131] bus pci: add device 0000:00:1f.5
[   10.788220] DEV: registering device: ID = '0000:00:1f.6'
[   10.788441] PM: Adding info for pci:0000:00:1f.6
[   10.788445] bus pci: add device 0000:00:1f.6
[   10.789541] DEV: registering device: ID = '0000:01:00.0'
[   10.789902] PM: Adding info for pci:0000:01:00.0
[   10.789906] bus pci: add device 0000:01:00.0
[   10.789965] DEV: registering device: ID = '0000:02:00.0'
[   10.790191] PM: Adding info for pci:0000:02:00.0
[   10.790197] bus pci: add device 0000:02:00.0
[   10.790284] DEV: registering device: ID = '0000:02:01.0'
[   10.790499] PM: Adding info for pci:0000:02:01.0
[   10.790505] bus pci: add device 0000:02:01.0
[   10.790600] DEV: registering device: ID = '0000:02:01.1'
[   10.790812] PM: Adding info for pci:0000:02:01.1
[   10.790816] bus pci: add device 0000:02:01.1
[   10.790900] DEV: registering device: ID = '0000:02:01.2'
[   10.791132] PM: Adding info for pci:0000:02:01.2
[   10.791142] bus pci: add device 0000:02:01.2
[   10.791227] DEV: registering device: ID = '0000:02:03.0'
[   10.791440] PM: Adding info for pci:0000:02:03.0
[   10.791444] bus pci: add device 0000:02:03.0
[   10.800686] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
[   10.801350] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
[   10.801993] ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
[   10.802628] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
[   10.803242] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   10.803878] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   10.805712] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[   10.808270] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
[   10.809598] Linux Plug and Play Support v0.97 (c) Adam Belay
[   10.809613] bus type 'pnp' registered
[   10.809614] pnp: PnP ACPI init
[   10.809619] DEV: registering device: ID = 'pnp0'
[   10.809622] PM: Adding info for No Bus:pnp0
[   10.818494] DEV: registering device: ID = '00:00'
[   10.818675] PM: Adding info for pnp:00:00
[   10.818678] bus pnp: add device 00:00
[   10.818753] DEV: registering device: ID = '00:01'
[   10.818964] PM: Adding info for pnp:00:01
[   10.818969] bus pnp: add device 00:01
[   10.819043] DEV: registering device: ID = '00:02'
[   10.819247] PM: Adding info for pnp:00:02
[   10.819250] bus pnp: add device 00:02
[   10.819330] DEV: registering device: ID = '00:03'
[   10.819536] PM: Adding info for pnp:00:03
[   10.819541] bus pnp: add device 00:03
[   10.819615] DEV: registering device: ID = '00:04'
[   10.819829] PM: Adding info for pnp:00:04
[   10.819837] bus pnp: add device 00:04
[   10.819920] DEV: registering device: ID = '00:05'
[   10.820136] PM: Adding info for pnp:00:05
[   10.820140] bus pnp: add device 00:05
[   10.820220] DEV: registering device: ID = '00:06'
[   10.820433] PM: Adding info for pnp:00:06
[   10.820436] bus pnp: add device 00:06
[   10.820506] DEV: registering device: ID = '00:07'
[   10.820722] PM: Adding info for pnp:00:07
[   10.820725] bus pnp: add device 00:07
[   10.820809] DEV: registering device: ID = '00:08'
[   10.821030] PM: Adding info for pnp:00:08
[   10.821035] bus pnp: add device 00:08
[   10.821109] DEV: registering device: ID = '00:09'
[   10.821328] PM: Adding info for pnp:00:09
[   10.821334] bus pnp: add device 00:09
[   10.822069] pnp: PnP ACPI: found 10 devices
[   10.822081] device class 'misc': registering
[   10.822090] device class 'pcmcia_socket': registering
[   10.822100] device class 'input': registering
[   10.822110] bus type 'i2c' registered
[   10.822112] bus i2c: add driver i2c_adapter
[   10.822354] device class 'i2c-adapter': registering
[   10.822362] bus type 'ac97' registered
[   10.822364] PCI: Using ACPI for IRQ routing
[   10.822369] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   10.829255] device class 'net': registering
[   10.838241] bus pnp: add driver system
[   10.838455] pnp: Matched Device 00:00 with Driver system
[   10.838458] bound device '00:00' to driver 'system'
[   10.838461] pnp: Bound Device 00:00 to Driver system
[   10.838463] pnp: Matched Device 00:01 with Driver system
[   10.838466] pnp: 00:01: ioport range 0x4d0-0x4d1 has been reserved
[   10.838471] pnp: 00:01: ioport range 0x800-0x805 could not be reserved
[   10.838475] pnp: 00:01: ioport range 0x808-0x80f could not be reserved
[   10.838478] bound device '00:01' to driver 'system'
[   10.838480] pnp: Bound Device 00:01 to Driver system
[   10.838482] pnp: Matched Device 00:02 with Driver system
[   10.838484] pnp: 00:02: ioport range 0xf400-0xf4fe has been reserved
[   10.838488] pnp: 00:02: ioport range 0x806-0x807 has been reserved
[   10.838491] pnp: 00:02: ioport range 0x810-0x85f could not be reserved
[   10.838495] pnp: 00:02: ioport range 0x860-0x87f has been reserved
[   10.838498] pnp: 00:02: ioport range 0x880-0x8bf has been reserved
[   10.838501] pnp: 00:02: ioport range 0x8c0-0x8df has been reserved
[   10.838504] bound device '00:02' to driver 'system'
[   10.838506] pnp: Bound Device 00:02 to Driver system
[   10.838510] pnp: Matched Device 00:07 with Driver system
[   10.838512] pnp: 00:07: ioport range 0x900-0x97f has been reserved
[   10.838515] bound device '00:07' to driver 'system'
[   10.838517] pnp: Bound Device 00:07 to Driver system
[   10.838522] device class 'mem': registering
[   10.838527] CLASS: registering class device: ID = 'mem'
[   10.838532] class_hotplug - name = mem
[   10.838535] class_device_create_hotplug called for mem
[   10.838709] CLASS: registering class device: ID = 'kmem'
[   10.838714] class_hotplug - name = kmem
[   10.838716] class_device_create_hotplug called for kmem
[   10.838936] CLASS: registering class device: ID = 'null'
[   10.838941] class_hotplug - name = null
[   10.838943] class_device_create_hotplug called for null
[   10.839147] CLASS: registering class device: ID = 'port'
[   10.839152] class_hotplug - name = port
[   10.839154] class_device_create_hotplug called for port
[   10.839360] CLASS: registering class device: ID = 'zero'
[   10.839367] class_hotplug - name = zero
[   10.839369] class_device_create_hotplug called for zero
[   10.839565] CLASS: registering class device: ID = 'full'
[   10.839571] class_hotplug - name = full
[   10.839573] class_device_create_hotplug called for full
[   10.839778] CLASS: registering class device: ID = 'random'
[   10.839784] class_hotplug - name = random
[   10.839786] class_device_create_hotplug called for random
[   10.840012] CLASS: registering class device: ID = 'urandom'
[   10.840019] class_hotplug - name = urandom
[   10.840021] class_device_create_hotplug called for urandom
[   10.840229] CLASS: registering class device: ID = 'kmsg'
[   10.840235] class_hotplug - name = kmsg
[   10.840237] class_device_create_hotplug called for kmsg
[   10.840464] bus type 'pcmcia' registered
[   10.840498] PCI: Bridge: 0000:00:01.0
[   10.840505]   IO window: c000-cfff
[   10.840509]   MEM window: fc000000-fdffffff
[   10.840513]   PREFETCH window: f0000000-f7ffffff
[   10.840521] PCI: Bus 3, cardbus bridge: 0000:02:01.0
[   10.840524]   IO window: 0000e000-0000e0ff
[   10.840528]   IO window: 0000e400-0000e4ff
[   10.840533]   PREFETCH window: 70000000-71ffffff
[   10.840537]   MEM window: 74000000-75ffffff
[   10.840541] PCI: Bridge: 0000:00:1e.0
[   10.840545]   IO window: e000-efff
[   10.840550]   MEM window: fa000000-fbffffff
[   10.840555]   PREFETCH window: 70000000-71ffffff
[   10.840572] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   10.840587] acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
[   10.840595] PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
[   10.841037] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[   10.841042] PCI: setting IRQ 11 as level-triggered
[   10.841046] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   10.841056] Registering sysdev class '<NULL>'
[   10.841061] Registering sys device 'i82590'
[   10.841297] Registering sysdev class '<NULL>'
[   10.841301] Registering sys device 'i82370'
[   10.841524] apm: BIOS not found.
[   10.841530] Registering sysdev class '<NULL>'
[   10.841534] Registering sys device 'lapic0'
[   10.841739] Registering sysdev class '<NULL>'
[   10.853124] Registering sysdev class '<NULL>'
[   10.853128] Registering sys device 'clocksource0'
[   10.853299] Registering sysdev class '<NULL>'
[   10.853307] Registering sys device 'global_clock_event0'
[   10.853506] Registering sysdev class '<NULL>'
[   10.853510] Registering sys device 'timeofday0'
[   10.853730] audit: initializing netlink socket (disabled)
[   10.853746] audit(1131979227.293:1): initialized
[   10.853803] highmem bounce pool size: 64 pages
[   10.853808] Total HugeTLB memory allocated, 0
[   10.853870] VFS: Disk quotas dquot_6.5.1
[   10.853891] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   10.853970] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   10.854108] fuse init (API version 7.3)
[   10.854122] CLASS: registering class device: ID = 'fuse'
[   10.854132] class_hotplug - name = fuse
[   10.854135] class_device_create_hotplug called for fuse
[   10.854413] Initializing Cryptographic API
[   10.854420] io scheduler noop registered
[   10.854427] io scheduler anticipatory registered
[   10.854432] io scheduler deadline registered
[   10.854439] io scheduler cfq registered
[   10.854535] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   10.854539] usbmon: debugfs is not available
[   10.854544] bus pci: add driver ehci_hcd
[   10.854784] pci: Matched Device 0000:00:1d.7 with Driver ehci_hcd
[   10.854803] acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
[   10.855248] ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
[   10.855253] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
[   10.855267] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   10.855270] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   10.855283] ehci_hcd 0000:00:1d.7: debug port 1
[   10.855297] CLASS: registering class device: ID = 'usb_host1'
[   10.855306] class_hotplug - name = usb_host1
[   10.855308] class_device_create_hotplug called for usb_host1
[   10.855540] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   10.855550] ehci_hcd 0000:00:1d.7: irq 11, io mem 0xf8fffc00
[   10.855562] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   10.859443] ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[   10.859472] DEV: registering device: ID = 'usb1'
[   10.859657] PM: Adding info for usb:usb1
[   10.859662] bus usb: add device usb1
[   10.859664] bound device 'usb1' to driver 'usb'
[   10.859684] DEV: registering device: ID = '1-0:1.0'
[   10.859891] PM: Adding info for usb:1-0:1.0
[   10.859895] bus usb: add device 1-0:1.0
[   10.859898] usb: Matched Device 1-0:1.0 with Driver hub
[   10.859901] hub 1-0:1.0: USB hub found
[   10.859911] hub 1-0:1.0: 6 ports detected
[   10.882789] Time: tsc clocksource has been installed.
[   10.883786] Ktimers: Switched to high resolution mode CPU 0
[   10.960680] bound device '1-0:1.0' to driver 'hub'
[   10.960682] usb: Bound Device 1-0:1.0 to Driver hub
[   10.960691] CLASS: registering class device: ID = 'usbdev1.1'
[   10.960697] class_hotplug - name = usbdev1.1
[   10.960700] class_device_create_hotplug called for usbdev1.1
[   10.960936] bound device '0000:00:1d.7' to driver 'ehci_hcd'
[   10.960939] pci: Bound Device 0000:00:1d.7 to Driver ehci_hcd
[   10.960946] USB Universal Host Controller Interface driver v2.3
[   10.960964] bus pci: add driver uhci_hcd
[   10.961178] pci: Matched Device 0000:00:1d.0 with Driver uhci_hcd
[   10.961571] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[   10.961577] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   10.961589] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   10.961592] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   10.961611] CLASS: registering class device: ID = 'usb_host2'
[   10.961622] class_hotplug - name = usb_host2
[   10.961624] class_device_create_hotplug called for usb_host2
[   10.961829] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   10.961838] uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
[   10.961880] DEV: registering device: ID = 'usb2'
[   10.962064] PM: Adding info for usb:usb2
[   10.962068] bus usb: add device usb2
[   10.962070] bound device 'usb2' to driver 'usb'
[   10.962085] DEV: registering device: ID = '2-0:1.0'
[   10.962294] PM: Adding info for usb:2-0:1.0
[   10.962297] bus usb: add device 2-0:1.0
[   10.962300] usb: Matched Device 2-0:1.0 with Driver hub
[   10.962302] hub 2-0:1.0: USB hub found
[   10.962311] hub 2-0:1.0: 2 ports detected
[   11.062530] bound device '2-0:1.0' to driver 'hub'
[   11.062533] usb: Bound Device 2-0:1.0 to Driver hub
[   11.062541] CLASS: registering class device: ID = 'usbdev2.1'
[   11.062547] class_hotplug - name = usbdev2.1
[   11.062551] class_device_create_hotplug called for usbdev2.1
[   11.062777] bound device '0000:00:1d.0' to driver 'uhci_hcd'
[   11.062780] pci: Bound Device 0000:00:1d.0 to Driver uhci_hcd
[   11.062782] pci: Matched Device 0000:00:1d.1 with Driver uhci_hcd
[   11.062791] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   11.062802] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   11.062804] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   11.062823] CLASS: registering class device: ID = 'usb_host3'
[   11.062829] class_hotplug - name = usb_host3
[   11.062831] class_device_create_hotplug called for usb_host3
[   11.063050] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   11.063059] uhci_hcd 0000:00:1d.1: irq 11, io base 0x0000bf40
[   11.063091] DEV: registering device: ID = 'usb3'
[   11.063278] PM: Adding info for usb:usb3
[   11.063281] bus usb: add device usb3
[   11.063283] bound device 'usb3' to driver 'usb'
[   11.063293] DEV: registering device: ID = '3-0:1.0'
[   11.063496] PM: Adding info for usb:3-0:1.0
[   11.063501] bus usb: add device 3-0:1.0
[   11.063503] usb: Matched Device 3-0:1.0 with Driver hub
[   11.063505] hub 3-0:1.0: USB hub found
[   11.063515] hub 3-0:1.0: 2 ports detected
[   11.163386] bound device '3-0:1.0' to driver 'hub'
[   11.163388] usb: Bound Device 3-0:1.0 to Driver hub
[   11.163397] CLASS: registering class device: ID = 'usbdev3.1'
[   11.163402] class_hotplug - name = usbdev3.1
[   11.163405] class_device_create_hotplug called for usbdev3.1
[   11.163637] bound device '0000:00:1d.1' to driver 'uhci_hcd'
[   11.163640] pci: Bound Device 0000:00:1d.1 to Driver uhci_hcd
[   11.163642] pci: Matched Device 0000:00:1d.2 with Driver uhci_hcd
[   11.164047] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[   11.164052] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   11.164063] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   11.164066] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   11.164087] CLASS: registering class device: ID = 'usb_host4'
[   11.164094] class_hotplug - name = usb_host4
[   11.164096] class_device_create_hotplug called for usb_host4
[   11.164336] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   11.164344] uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
[   11.164395] DEV: registering device: ID = 'usb4'
[   11.164579] PM: Adding info for usb:usb4
[   11.164583] bus usb: add device usb4
[   11.164585] bound device 'usb4' to driver 'usb'
[   11.164602] DEV: registering device: ID = '4-0:1.0'
[   11.164815] PM: Adding info for usb:4-0:1.0
[   11.164819] bus usb: add device 4-0:1.0
[   11.164822] usb: Matched Device 4-0:1.0 with Driver hub
[   11.164824] hub 4-0:1.0: USB hub found
[   11.164833] hub 4-0:1.0: 2 ports detected
[   11.265239] bound device '4-0:1.0' to driver 'hub'
[   11.265241] usb: Bound Device 4-0:1.0 to Driver hub
[   11.265250] CLASS: registering class device: ID = 'usbdev4.1'
[   11.265255] class_hotplug - name = usbdev4.1
[   11.265259] class_device_create_hotplug called for usbdev4.1
[   11.265493] bound device '0000:00:1d.2' to driver 'uhci_hcd'
[   11.265496] pci: Bound Device 0000:00:1d.2 to Driver uhci_hcd
[   11.265507] bus usb: add driver hiddev
[   11.265722] usbcore: registered new driver hiddev
[   11.265728] bus usb: add driver usbhid
[   11.265910] usbcore: registered new driver usbhid
[   11.265913] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   11.265923] bus type 'usb-serial' registered
[   11.265930] bus usb: add driver usbserial
[   11.266112] usbcore: registered new driver usbserial
[   11.266118] bus usb-serial: add driver generic
[   11.266310] drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
[   11.266317] bus usb: add driver usbserial_generic
[   11.266496] usbcore: registered new driver usbserial_generic
[   11.266500] drivers/usb/serial/usb-serial.c: USB Serial Driver core
[   11.266504] bus usb-serial: add driver pl2303
[   11.266526] drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
[   11.266531] bus usb: add driver pl2303
[   11.266871] usbcore: registered new driver pl2303
[   11.266875] drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
[   11.266882] bus pci: add driver radeonfb
[   11.266909] pci: Matched Device 0000:01:00.0 with Driver radeonfb
[   11.266911] radeonfb_pci_register BEGIN
[   11.266925] acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
[   11.266937] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   11.266956] radeonfb (0000:01:00.0): Found 131072k of DDR 128 bits wide videoram
[   11.266982] radeonfb (0000:01:00.0): mapped 16384k videoram
[   11.266988] radeonfb: Retreived PLL infos from BIOS
[   11.266992] radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=445.00 Mhz, System=263.00 MHz
[   11.266996] radeonfb: PLL min 20000 max 35000
[   11.267025] DEV: registering device: ID = 'i2c-0'
[   11.267032] PM: Adding info for No Bus:i2c-0
[   11.267036] CLASS: registering class device: ID = 'i2c-0'
[   11.267042] class_hotplug - name = i2c-0
[   11.267390] i2c_adapter i2c-0: adapter [monid] registered
[   11.267415] DEV: registering device: ID = 'i2c-1'
[   11.267419] PM: Adding info for No Bus:i2c-1
[   11.267422] CLASS: registering class device: ID = 'i2c-1'
[   11.267427] class_hotplug - name = i2c-1
[   11.267448] i2c_adapter i2c-1: adapter [dvi] registered
[   11.267472] DEV: registering device: ID = 'i2c-2'
[   11.267476] PM: Adding info for No Bus:i2c-2
[   11.267483] CLASS: registering class device: ID = 'i2c-2'
[   11.267488] class_hotplug - name = i2c-2
[   11.267826] i2c_adapter i2c-2: adapter [vga] registered
[   11.267851] DEV: registering device: ID = 'i2c-3'
[   11.267855] PM: Adding info for No Bus:i2c-3
[   11.267858] CLASS: registering class device: ID = 'i2c-3'
[   11.267863] class_hotplug - name = i2c-3
[   11.267884] i2c_adapter i2c-3: adapter [crt2] registered
[   11.267889] 1 chips in connector info
[   11.267893]  - chip 1 has 2 connectors
[   11.267896]   * connector 0 of type 3 (DVI-I) : 3201
[   11.267899]   * connector 1 of type 2 (CRT) : 2320
[   11.267902] Starting monitor auto detection...
[   11.340128] i2c_adapter i2c-0: master_xfer[0] W, addr=0x50, len=1
[   11.340131] i2c_adapter i2c-0: master_xfer[1] R, addr=0x50, len=128
[   11.460953] i2c_adapter i2c-0: master_xfer[0] W, addr=0x50, len=1
[   11.460955] i2c_adapter i2c-0: master_xfer[1] R, addr=0x50, len=128
[   11.581779] i2c_adapter i2c-0: master_xfer[0] W, addr=0x50, len=1
[   11.581781] i2c_adapter i2c-0: master_xfer[1] R, addr=0x50, len=128
[   11.629712] radeonfb: I2C (port 1) ... not found
[   11.702605] i2c_adapter i2c-1: master_xfer[0] W, addr=0x50, len=1
[   11.702607] i2c_adapter i2c-1: master_xfer[1] R, addr=0x50, len=128
[   11.823430] i2c_adapter i2c-1: master_xfer[0] W, addr=0x50, len=1
[   11.823432] i2c_adapter i2c-1: master_xfer[1] R, addr=0x50, len=128
[   11.944256] i2c_adapter i2c-1: master_xfer[0] W, addr=0x50, len=1
[   11.944258] i2c_adapter i2c-1: master_xfer[1] R, addr=0x50, len=128
[   11.992189] radeonfb: I2C (port 2) ... not found
[   12.065082] i2c_adapter i2c-2: master_xfer[0] W, addr=0x50, len=1
[   12.065084] i2c_adapter i2c-2: master_xfer[1] R, addr=0x50, len=128
[   12.185908] i2c_adapter i2c-2: master_xfer[0] W, addr=0x50, len=1
[   12.185910] i2c_adapter i2c-2: master_xfer[1] R, addr=0x50, len=128
[   12.306733] i2c_adapter i2c-2: master_xfer[0] W, addr=0x50, len=1
[   12.306735] i2c_adapter i2c-2: master_xfer[1] R, addr=0x50, len=128
[   12.354666] radeonfb: I2C (port 3) ... not found
[   12.561368] radeonfb: I2C (port 4) ... not found
[   12.634261] i2c_adapter i2c-1: master_xfer[0] W, addr=0x50, len=1
[   12.634263] i2c_adapter i2c-1: master_xfer[1] R, addr=0x50, len=128
[   12.755087] i2c_adapter i2c-1: master_xfer[0] W, addr=0x50, len=1
[   12.755089] i2c_adapter i2c-1: master_xfer[1] R, addr=0x50, len=128
[   12.875913] i2c_adapter i2c-1: master_xfer[0] W, addr=0x50, len=1
[   12.875915] i2c_adapter i2c-1: master_xfer[1] R, addr=0x50, len=128
[   12.923846] radeonfb: I2C (port 2) ... not found
[   13.130547] radeonfb: I2C (port 4) ... not found
[   13.130550] Non-DDC laptop panel detected
[   13.203441] i2c_adapter i2c-2: master_xfer[0] W, addr=0x50, len=1
[   13.203443] i2c_adapter i2c-2: master_xfer[1] R, addr=0x50, len=128
[   13.324266] i2c_adapter i2c-2: master_xfer[0] W, addr=0x50, len=1
[   13.324268] i2c_adapter i2c-2: master_xfer[1] R, addr=0x50, len=128
[   13.445092] i2c_adapter i2c-2: master_xfer[0] W, addr=0x50, len=1
[   13.445094] i2c_adapter i2c-2: master_xfer[1] R, addr=0x50, len=128
[   13.493025] radeonfb: I2C (port 3) ... not found
[   13.699726] radeonfb: I2C (port 4) ... not found
[   13.700734] radeonfb: Monitor 1 type LCD found
[   13.700737] radeonfb: Monitor 2 type no found
[   13.700740] radeonfb: panel ID string: W4554171WU1
[   13.700741]            
[   13.700745] radeonfb: detected LVDS panel size from BIOS: 1920x1200
[   13.700748] BIOS provided panel power delay: 1000
[   13.700751] radeondb: BIOS provided dividers will be used
[   13.700753] ref_divider = 9
[   13.700755] post_divider = 0
[   13.700757] fbk_divider = 36
[   13.700759] Scanning BIOS table ...
[   13.700762]  320 x 350
[   13.700764]  320 x 400
[   13.700766]  320 x 400
[   13.700768]  320 x 480
[   13.700769]  400 x 600
[   13.700771]  512 x 384
[   13.700773]  640 x 350
[   13.700775]  640 x 400
[   13.700777]  640 x 475
[   13.700779]  640 x 480
[   13.700781]  720 x 480
[   13.700783]  720 x 576
[   13.700785]  800 x 600
[   13.700787]  848 x 480
[   13.700789]  1024 x 768
[   13.700791]  1280 x 1024
[   13.700793]  1280 x 768
[   13.700796]  1280 x 800
[   13.700797]  1440 x 900
[   13.700800]  1600 x 1200
[   13.700802]  1680 x 1050
[   13.700803]  1920 x 1200
[   13.700806] Found panel in BIOS table:
[   13.700808]   hblank: 240
[   13.700810]   hOver_plus: 48
[   13.700812]   hSync_width: 32
[   13.700814]   vblank: 50
[   13.700816]   vOver_plus: 1
[   13.700817]   vSync_width: 3
[   13.700819]   clock: 16200
[   13.700822] Setting up default mode based on panel info
[   13.700854] radeonfb: Dynamic Clock Power Management enabled
[   13.700858] CLASS: registering class device: ID = 'fb0'
[   13.700865] class_hotplug - name = fb0
[   13.700868] class_device_create_hotplug called for fb0
[   13.701141] hStart = 1968, hEnd = 2000, hTotal = 2160
[   13.701143] vStart = 1201, vEnd = 1204, vTotal = 1250
[   13.701145] h_total_disp = 0xef010d	   hsync_strt_wid = 0x407aa
[   13.701147] v_total_disp = 0x4af04e1	   vsync_strt_wid = 0x304b0
[   13.701148] pixclock = 6172
[   13.701149] freq = 16202
[   13.788821] Console: switching to colour frame buffer device 240x75
[   13.791062] radeonfb (0000:01:00.0): ATI Radeon NP 
[   13.791140] radeonfb_pci_register END
[   13.791190] bound device '0000:01:00.0' to driver 'radeonfb'
[   13.791196] pci: Bound Device 0000:01:00.0 to Driver radeonfb
[   13.791207] bus platform: add driver vesafb
[   13.791555] Registering platform device 'vesafb.0'. Parent at platform
[   13.791557] DEV: registering device: ID = 'vesafb.0'
[   13.791743] PM: Adding info for platform:vesafb.0
[   13.791748] bus platform: add device vesafb.0
[   13.791749] platform: Matched Device vesafb.0 with Driver vesafb
[   13.791754] vesafb: cannot reserve video memory at 0xf0000000
[   13.791834] vesafb: framebuffer at 0xf0000000, mapped to 0xf9900000, using 5120k, total 131008k
[   13.791932] vesafb: mode is 1280x1024x16, linelength=2560, pages=50
[   13.792010] vesafb: protected mode interface info at c000:5aa2
[   13.792083] vesafb: scrolling: redraw
[   13.792133] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   13.792204] vesafb: Mode is VGA compatible
[   13.792265] CLASS: registering class device: ID = 'fb1'
[   13.792272] class_hotplug - name = fb1
[   13.792275] class_device_create_hotplug called for fb1
[   13.792481] fb1: VESA VGA frame buffer device
[   13.792538] bound device 'vesafb.0' to driver 'vesafb'
[   13.792541] platform: Bound Device vesafb.0 to Driver vesafb
[   13.793000] ACPI: AC Adapter [AC] (on-line)
[   14.074210] ACPI: Battery Slot [BAT0] (battery present)
[   14.074294] ACPI: Lid Switch [LID]
[   14.074350] ACPI: Power Button (CM) [PBTN]
[   14.074410] ACPI: Sleep Button (CM) [SBTN]
[   14.076230] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   14.076396] Using specific hotkey driver
[   14.076451] Registering sysdev class '<NULL>'
[   14.076456] Registering sys device 'irqrouter0'
[   14.077362] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
[   14.077544] ACPI: Processor [CPU0] (supports 8 throttling states)
[   14.081717] ACPI: Thermal Zone [THM] (49 C)
[   14.081794] CLASS: registering class device: ID = 'tty'
[   14.081803] class_hotplug - name = tty
[   14.081805] class_device_create_hotplug called for tty
[   14.081999] CLASS: registering class device: ID = 'console'
[   14.082004] class_hotplug - name = console
[   14.082006] class_device_create_hotplug called for console
[   14.082200] CLASS: registering class device: ID = 'ptmx'
[   14.082205] class_hotplug - name = ptmx
[   14.082206] class_device_create_hotplug called for ptmx
[   14.082391] CLASS: registering class device: ID = 'tty0'
[   14.082396] class_hotplug - name = tty0
[   14.082397] class_device_create_hotplug called for tty0
[   14.082581] device class 'vc': registering
[   14.082586] CLASS: registering class device: ID = 'vcs'
[   14.082590] class_hotplug - name = vcs
[   14.082592] class_device_create_hotplug called for vcs
[   14.082779] CLASS: registering class device: ID = 'vcsa'
[   14.082784] class_hotplug - name = vcsa
[   14.082785] class_device_create_hotplug called for vcsa
[   14.082972] CLASS: registering class device: ID = 'tty1'
[   14.082977] class_hotplug - name = tty1
[   14.082978] class_device_create_hotplug called for tty1
[   14.083156] CLASS: registering class device: ID = 'tty2'
[   14.083160] class_hotplug - name = tty2
[   14.083162] class_device_create_hotplug called for tty2
[   14.083354] CLASS: registering class device: ID = 'tty3'
[   14.083359] class_hotplug - name = tty3
[   14.083360] class_device_create_hotplug called for tty3
[   14.083543] CLASS: registering class device: ID = 'tty4'
[   14.083547] class_hotplug - name = tty4
[   14.083549] class_device_create_hotplug called for tty4
[   14.083734] CLASS: registering class device: ID = 'tty5'
[   14.083739] class_hotplug - name = tty5
[   14.083741] class_device_create_hotplug called for tty5
[   14.083931] CLASS: registering class device: ID = 'tty6'
[   14.083939] class_hotplug - name = tty6
[   14.083941] class_device_create_hotplug called for tty6
[   14.084136] CLASS: registering class device: ID = 'tty7'
[   14.084140] class_hotplug - name = tty7
[   14.084142] class_device_create_hotplug called for tty7
[   14.084331] CLASS: registering class device: ID = 'tty8'
[   14.084335] class_hotplug - name = tty8
[   14.084337] class_device_create_hotplug called for tty8
[   14.084525] CLASS: registering class device: ID = 'tty9'
[   14.084529] class_hotplug - name = tty9
[   14.084531] class_device_create_hotplug called for tty9
[   14.084713] CLASS: registering class device: ID = 'tty10'
[   14.084717] class_hotplug - name = tty10
[   14.084719] class_device_create_hotplug called for tty10
[   14.084909] CLASS: registering class device: ID = 'tty11'
[   14.084913] class_hotplug - name = tty11
[   14.084915] class_device_create_hotplug called for tty11
[   14.085132] CLASS: registering class device: ID = 'tty12'
[   14.085138] class_hotplug - name = tty12
[   14.085140] class_device_create_hotplug called for tty12
[   14.085337] CLASS: registering class device: ID = 'tty13'
[   14.085341] class_hotplug - name = tty13
[   14.085343] class_device_create_hotplug called for tty13
[   14.085530] CLASS: registering class device: ID = 'tty14'
[   14.085536] class_hotplug - name = tty14
[   14.085538] class_device_create_hotplug called for tty14
[   14.085733] CLASS: registering class device: ID = 'tty15'
[   14.085739] class_hotplug - name = tty15
[   14.085741] class_device_create_hotplug called for tty15
[   14.085929] CLASS: registering class device: ID = 'tty16'
[   14.085934] class_hotplug - name = tty16
[   14.085935] class_device_create_hotplug called for tty16
[   14.086152] CLASS: registering class device: ID = 'tty17'
[   14.086157] class_hotplug - name = tty17
[   14.086158] class_device_create_hotplug called for tty17
[   14.086368] CLASS: registering class device: ID = 'tty18'
[   14.086378] class_hotplug - name = tty18
[   14.086380] class_device_create_hotplug called for tty18
[   14.086573] CLASS: registering class device: ID = 'tty19'
[   14.086577] class_hotplug - name = tty19
[   14.086579] class_device_create_hotplug called for tty19
[   14.086773] CLASS: registering class device: ID = 'tty20'
[   14.086780] class_hotplug - name = tty20
[   14.086782] class_device_create_hotplug called for tty20
[   14.086984] CLASS: registering class device: ID = 'tty21'
[   14.086989] class_hotplug - name = tty21
[   14.086991] class_device_create_hotplug called for tty21
[   14.087233] CLASS: registering class device: ID = 'tty22'
[   14.087238] class_hotplug - name = tty22
[   14.087240] class_device_create_hotplug called for tty22
[   14.087437] CLASS: registering class device: ID = 'tty23'
[   14.087443] class_hotplug - name = tty23
[   14.087444] class_device_create_hotplug called for tty23
[   14.087654] CLASS: registering class device: ID = 'tty24'
[   14.087660] class_hotplug - name = tty24
[   14.087662] class_device_create_hotplug called for tty24
[   14.087879] CLASS: registering class device: ID = 'tty25'
[   14.087886] class_hotplug - name = tty25
[   14.087888] class_device_create_hotplug called for tty25
[   14.088117] CLASS: registering class device: ID = 'tty26'
[   14.088124] class_hotplug - name = tty26
[   14.088126] class_device_create_hotplug called for tty26
[   14.088351] CLASS: registering class device: ID = 'tty27'
[   14.088357] class_hotplug - name = tty27
[   14.088358] class_device_create_hotplug called for tty27
[   14.088571] CLASS: registering class device: ID = 'tty28'
[   14.088577] class_hotplug - name = tty28
[   14.088579] class_device_create_hotplug called for tty28
[   14.088774] CLASS: registering class device: ID = 'tty29'
[   14.088782] class_hotplug - name = tty29
[   14.088783] class_device_create_hotplug called for tty29
[   14.088994] CLASS: registering class device: ID = 'tty30'
[   14.089004] class_hotplug - name = tty30
[   14.089006] class_device_create_hotplug called for tty30
[   14.089244] CLASS: registering class device: ID = 'tty31'
[   14.089252] class_hotplug - name = tty31
[   14.089254] class_device_create_hotplug called for tty31
[   14.089474] CLASS: registering class device: ID = 'tty32'
[   14.089481] class_hotplug - name = tty32
[   14.089483] class_device_create_hotplug called for tty32
[   14.089693] CLASS: registering class device: ID = 'tty33'
[   14.089699] class_hotplug - name = tty33
[   14.089701] class_device_create_hotplug called for tty33
[   14.089928] CLASS: registering class device: ID = 'tty34'
[   14.089935] class_hotplug - name = tty34
[   14.089937] class_device_create_hotplug called for tty34
[   14.090180] CLASS: registering class device: ID = 'tty35'
[   14.090187] class_hotplug - name = tty35
[   14.090189] class_device_create_hotplug called for tty35
[   14.090406] CLASS: registering class device: ID = 'tty36'
[   14.090412] class_hotplug - name = tty36
[   14.090413] class_device_create_hotplug called for tty36
[   14.090649] CLASS: registering class device: ID = 'tty37'
[   14.090655] class_hotplug - name = tty37
[   14.090657] class_device_create_hotplug called for tty37
[   14.090884] CLASS: registering class device: ID = 'tty38'
[   14.090891] class_hotplug - name = tty38
[   14.090893] class_device_create_hotplug called for tty38
[   14.091116] CLASS: registering class device: ID = 'tty39'
[   14.091124] class_hotplug - name = tty39
[   14.091126] class_device_create_hotplug called for tty39
[   14.091367] CLASS: registering class device: ID = 'tty40'
[   14.091374] class_hotplug - name = tty40
[   14.091376] class_device_create_hotplug called for tty40
[   14.091615] CLASS: registering class device: ID = 'tty41'
[   14.091622] class_hotplug - name = tty41
[   14.091624] class_device_create_hotplug called for tty41
[   14.091846] CLASS: registering class device: ID = 'tty42'
[   14.091859] class_hotplug - name = tty42
[   14.091861] class_device_create_hotplug called for tty42
[   14.092115] CLASS: registering class device: ID = 'tty43'
[   14.092129] class_hotplug - name = tty43
[   14.092131] class_device_create_hotplug called for tty43
[   14.092366] CLASS: registering class device: ID = 'tty44'
[   14.092375] class_hotplug - name = tty44
[   14.092377] class_device_create_hotplug called for tty44
[   14.092606] CLASS: registering class device: ID = 'tty45'
[   14.092615] class_hotplug - name = tty45
[   14.092617] class_device_create_hotplug called for tty45
[   14.092845] CLASS: registering class device: ID = 'tty46'
[   14.092853] class_hotplug - name = tty46
[   14.092855] class_device_create_hotplug called for tty46
[   14.093085] CLASS: registering class device: ID = 'tty47'
[   14.093093] class_hotplug - name = tty47
[   14.093095] class_device_create_hotplug called for tty47
[   14.093331] CLASS: registering class device: ID = 'tty48'
[   14.093338] class_hotplug - name = tty48
[   14.093340] class_device_create_hotplug called for tty48
[   14.093564] CLASS: registering class device: ID = 'tty49'
[   14.093571] class_hotplug - name = tty49
[   14.093572] class_device_create_hotplug called for tty49
[   14.093809] CLASS: registering class device: ID = 'tty50'
[   14.093817] class_hotplug - name = tty50
[   14.093819] class_device_create_hotplug called for tty50
[   14.094050] CLASS: registering class device: ID = 'tty51'
[   14.094058] class_hotplug - name = tty51
[   14.094060] class_device_create_hotplug called for tty51
[   14.094306] CLASS: registering class device: ID = 'tty52'
[   14.094315] class_hotplug - name = tty52
[   14.094317] class_device_create_hotplug called for tty52
[   14.094547] CLASS: registering class device: ID = 'tty53'
[   14.094555] class_hotplug - name = tty53
[   14.094557] class_device_create_hotplug called for tty53
[   14.094788] CLASS: registering class device: ID = 'tty54'
[   14.094802] class_hotplug - name = tty54
[   14.094804] class_device_create_hotplug called for tty54
[   14.095045] CLASS: registering class device: ID = 'tty55'
[   14.095053] class_hotplug - name = tty55
[   14.095055] class_device_create_hotplug called for tty55
[   14.095303] CLASS: registering class device: ID = 'tty56'
[   14.095310] class_hotplug - name = tty56
[   14.095312] class_device_create_hotplug called for tty56
[   14.095534] CLASS: registering class device: ID = 'tty57'
[   14.095543] class_hotplug - name = tty57
[   14.095545] class_device_create_hotplug called for tty57
[   14.095783] CLASS: registering class device: ID = 'tty58'
[   14.095793] class_hotplug - name = tty58
[   14.095795] class_device_create_hotplug called for tty58
[   14.096016] CLASS: registering class device: ID = 'tty59'
[   14.096025] class_hotplug - name = tty59
[   14.096026] class_device_create_hotplug called for tty59
[   14.096279] CLASS: registering class device: ID = 'tty60'
[   14.096288] class_hotplug - name = tty60
[   14.096290] class_device_create_hotplug called for tty60
[   14.096511] CLASS: registering class device: ID = 'tty61'
[   14.096521] class_hotplug - name = tty61
[   14.096523] class_device_create_hotplug called for tty61
[   14.096757] CLASS: registering class device: ID = 'tty62'
[   14.096769] class_hotplug - name = tty62
[   14.096771] class_device_create_hotplug called for tty62
[   14.096998] CLASS: registering class device: ID = 'tty63'
[   14.097009] class_hotplug - name = tty63
[   14.097010] class_device_create_hotplug called for tty63
[   14.097262] device class 'printer': registering
[   14.097427] lp: driver loaded but no devices found
[   14.097516] CLASS: registering class device: ID = 'rtc'
[   14.097525] class_hotplug - name = rtc
[   14.097527] class_device_create_hotplug called for rtc
[   14.097737] Real Time Clock Driver v1.12
[   14.097796] CLASS: registering class device: ID = 'hpet'
[   14.097808] class_hotplug - name = hpet
[   14.097810] class_device_create_hotplug called for hpet
[   14.098048] CLASS: registering class device: ID = 'watchdog'
[   14.098055] class_hotplug - name = watchdog
[   14.098056] class_device_create_hotplug called for watchdog
[   14.098310] Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
[   14.098418] Linux agpgart interface v0.101 (c) Dave Jones
[   14.098489] bus pci: add driver agpgart-ati
[   14.098748] device class 'drm': registering
[   14.098762] [drm] Initialized drm 1.0.0 20040925
[   14.098826] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[   14.098932] Hangcheck: Using monotonic_clock().
[   14.099010] bus type 'serio' registered
[   14.099014] bus pnp: add driver i8042 kbd
[   14.099257] pnp: Matched Device 00:04 with Driver i8042 kbd
[   14.099261] bound device '00:04' to driver 'i8042 kbd'
[   14.099264] pnp: Bound Device 00:04 to Driver i8042 kbd
[   14.099271] bus pnp: add driver i8042 aux
[   14.099454] pnp: Matched Device 00:03 with Driver i8042 aux
[   14.099458] bound device '00:03' to driver 'i8042 aux'
[   14.099461] pnp: Bound Device 00:03 to Driver i8042 aux
[   14.099469] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   14.099937] bus platform: add driver i8042
[   14.100131] Registering platform device 'i8042'. Parent at platform
[   14.100133] DEV: registering device: ID = 'i8042'
[   14.100179] PM: Adding info for platform:i8042
[   14.100186] bus platform: add device i8042
[   14.100188] platform: Matched Device i8042 with Driver i8042
[   14.100190] bound device 'i8042' to driver 'i8042'
[   14.100192] platform: Bound Device i8042 to Driver i8042
[   14.103158] serio: i8042 AUX port at 0x60,0x64 irq 12
[   14.103224] DEV: registering device: ID = 'serio0'
[   14.103604] serio: i8042 KBD port at 0x60,0x64 irq 1
[   14.103673] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   14.103773] Registering platform device 'serial8250'. Parent at platform
[   14.103775] DEV: registering device: ID = 'serial8250'
[   14.103966] PM: Adding info for serio:serio0
[   14.103970] bus serio: add device serio0
[   14.103975] DEV: registering device: ID = 'serio1'
[   14.104202] PM: Adding info for platform:serial8250
[   14.104206] bus platform: add device serial8250
[   14.104223] CLASS: registering class device: ID = 'ttyS0'
[   14.104236] class_hotplug - name = ttyS0
[   14.104239] class_device_create_hotplug called for ttyS0
[   14.104435] PM: Adding info for serio:serio1
[   14.104439] bus serio: add device serio1
[   14.104651] CLASS: registering class device: ID = 'ttyS1'
[   14.104661] class_hotplug - name = ttyS1
[   14.104664] class_device_create_hotplug called for ttyS1
[   14.104902] CLASS: registering class device: ID = 'ttyS2'
[   14.104913] class_hotplug - name = ttyS2
[   14.104915] class_device_create_hotplug called for ttyS2
[   14.105165] CLASS: registering class device: ID = 'ttyS3'
[   14.105176] class_hotplug - name = ttyS3
[   14.105180] class_device_create_hotplug called for ttyS3
[   14.105411] bus platform: add driver serial8250
[   14.105640] platform: Matched Device serial8250 with Driver serial8250
[   14.105643] bound device 'serial8250' to driver 'serial8250'
[   14.105645] platform: Bound Device serial8250 to Driver serial8250
[   14.105649] bus pnp: add driver serial
[   14.106112] bus pci: add driver serial
[   14.106159] pci: Matched Device 0000:00:1f.6 with Driver serial
[   14.106179] acpi_bus-0200 [07] bus_set_power         : Device is not power manageable
[   14.106770] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
[   14.106850] PCI: setting IRQ 7 as level-triggered
[   14.106914] ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
[   14.107059] ACPI: PCI interrupt for device 0000:00:1f.6 disabled
[   14.107163] bus pnp: add driver parport_pc
[   14.107598] bus pci: add driver parport_pc
[   14.107625] device class 'firmware': registering
[   14.111111] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
[   14.111262] CLASS: registering class device: ID = 'lo'
[   14.111269] class_hotplug - name = lo
[   14.111526] bus pci: add driver b44
[   14.111753] pci: Matched Device 0000:02:00.0 with Driver b44
[   14.111756] b44.c:v0.96 (Nov 8, 2005)
[   14.111838] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   14.120362] CLASS: registering class device: ID = 'eth0'
[   14.120371] class_hotplug - name = eth0
[   14.120813] eth0: Broadcom 4400 10/100BaseT Ethernet 00:11:43:5e:b3:ef
[   14.126145] bound device '0000:02:00.0' to driver 'b44'
[   14.126149] pci: Bound Device 0000:02:00.0 to Driver b44
[   14.126155] netconsole: not configured, aborting
[   14.131438] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   14.136997] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   14.142621] bus type 'ide' registered
[   14.142647] ICH4: IDE controller at PCI slot 0000:00:1f.1
[   14.148242] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   14.153828] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   14.159691] ICH4: chipset revision 1
[   14.165567] ICH4: not 100% native mode: will probe irqs later
[   14.171525]     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
[   14.177573]     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
[   14.183639] Probing IDE interface ide0...
[   14.357130] Falling back to C3 safe TSC
[   14.424299] check_periodic_interval: Long interval! 190982348.
[   14.430431] 		Something may be blocking interrupts.
[   14.471403] hda: HTS726060M9AT00, ATA DISK drive
[   14.477582] DEV: registering device: ID = 'ide0'
[   14.477591] PM: Adding info for No Bus:ide0
[   15.116214] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   15.122429] DEV: registering device: ID = '0.0'
[   15.122735] PM: Adding info for ide:0.0
[   15.122739] bus ide: add device 0.0
[   15.122744] Probing IDE interface ide1...
[   15.825205] hdc: _NEC DVD+/-RW ND-6500A, ATAPI CD/DVD-ROM drive
[   15.831543] DEV: registering device: ID = 'ide1'
[   15.831548] PM: Adding info for No Bus:ide1
[   16.486315] ide1 at 0x170-0x177,0x376 on irq 15
[   16.492932] DEV: registering device: ID = '1.0'
[   16.493223] PM: Adding info for ide:1.0
[   16.493229] bus ide: add device 1.0
[   16.493250] bus pci: add driver PIIX_IDE
[   16.493450] pci: Matched Device 0000:00:1f.1 with Driver PIIX_IDE
[   16.493453] bound device '0000:00:1f.1' to driver 'PIIX_IDE'
[   16.493458] pci: Bound Device 0000:00:1f.1 to Driver PIIX_IDE
[   16.493463] bus pci: add driver PCI_IDE
[   16.493642] bus pnp: add driver ide
[   16.493832] bus ide: add driver ide-disk
[   16.494016] ide: Matched Device 0.0 with Driver ide-disk
[   16.494031] hda: max request size: 1024KiB
[   16.514499] hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
[   16.521373] hda: cache flushes supported
[   16.528108]  hda: hda1 hda2 hda3
[   16.543177] bound device '0.0' to driver 'ide-disk'
[   16.543180] ide: Bound Device 0.0 to Driver ide-disk
[   16.543182] ide: Matched Device 1.0 with Driver ide-disk
[   16.543185] bus ide: add driver ide-cdrom
[   16.543394] ide: Matched Device 1.0 with Driver ide-cdrom
[   16.561013] hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
[   16.567759] Uniform CD-ROM driver Revision: 3.20
[   16.600271] bound device '1.0' to driver 'ide-cdrom'
[   16.600274] ide: Bound Device 1.0 to Driver ide-cdrom
[   16.600288] bus type 'ieee1394' registered
[   16.600291] device class 'ieee1394_host': registering
[   16.600296] device class 'ieee1394_protocol': registering
[   16.600303] device class 'ieee1394_node': registering
[   16.600306] device class 'ieee1394': registering
[   16.600310] bus pci: add driver ohci1394
[   16.600513] pci: Matched Device 0000:02:01.1 with Driver ohci1394
[   16.600516] ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
[   16.607174] acpi_bus-0200 [07] bus_set_power         : Device is not power manageable
[   16.613933] ACPI: PCI Interrupt 0000:02:01.1[B] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   16.620759] DEV: registering device: ID = 'fw-host0'
[   16.620953] PM: Adding info for ieee1394:fw-host0
[   16.620957] bus ieee1394: add device fw-host0
[   16.620961] CLASS: registering class device: ID = 'fw-host0'
[   16.620966] class_hotplug - name = fw-host0
[   16.674249] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[faffd800-faffdfff]  Max Packet=[2048]
[   16.688155] bound device '0000:02:01.1' to driver 'ohci1394'
[   16.688158] pci: Bound Device 0000:02:01.1 to Driver ohci1394
[   16.688166] CLASS: registering class device: ID = 'video1394-0'
[   16.688174] class_hotplug - name = video1394-0
[   16.688176] class_device_create_hotplug called for video1394-0
[   16.688383] bus ieee1394: add driver video1394
[   16.688586] video1394: Installed video1394 module
[   16.695770] bus pci: add driver yenta_cardbus
[   16.695964] pci: Matched Device 0000:02:01.0 with Driver yenta_cardbus
[   16.695978] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   16.703004] Yenta: CardBus bridge found at 0000:02:01.0 [1028:01a2]
[   16.835509] Yenta: ISA IRQ mask 0x0438, PCI irq 11
[   16.842535] Socket status: 30000006
[   16.849551] pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
[   16.856572] pcmcia: parent PCI bridge Memory window: 0xfa000000 - 0xfbffffff
[   16.863817] pcmcia: parent PCI bridge Memory window: 0x70000000 - 0x71ffffff
[   16.870841] CLASS: registering class device: ID = 'pcmcia_socket0'
[   16.870849] class_hotplug - name = pcmcia_socket0
[   17.132060] bound device '0000:02:01.0' to driver 'yenta_cardbus'
[   17.132062] pci: Bound Device 0000:02:01.0 to Driver yenta_cardbus
[   17.132068] CLASS: registering class device: ID = 'mice'
[   17.132075] class_hotplug - name = mice
[   17.132077] class_device_create_hotplug called for mice
[   17.132246] mice: PS/2 mouse device common for all mice
[   17.139212] bus serio: add driver atkbd
[   17.139238] serio: Matched Device serio0 with Driver atkbd
[   17.140008] input: PC Speaker as /class/input/input0
[   17.146986] CLASS: registering class device: ID = 'input0'
[   17.146991] class_hotplug - name = input0
[   17.147179] CLASS: registering class device: ID = 'event0'
[   17.147188] class_hotplug - name = event0
[   17.147190] class_device_create_hotplug called for event0
[   17.147455] serio: Matched Device serio1 with Driver atkbd
[   17.147986] I2O subsystem v1.288
[   17.154929] device class 'i2o_controller': registering
[   17.154935] i2o: max drivers = 8
[   17.161877] bus type 'i2o' registered
[   17.161895] bus i2o: add driver exec-osm
[   17.162108] bus pci: add driver PCI_I2O
[   17.162291] I2O ProcFS OSM v1.145
[   17.169234] bus i2o: add driver proc-osm
[   17.169413] i2c /dev entries driver
[   17.176346] device class 'i2c-dev': registering
[   17.176351] bus i2c: add driver dev_driver
[   17.176530] i2c-core: driver [dev_driver] registered
[   17.176533] i2c-dev: adapter [monid] registered as minor 0
[   17.176535] CLASS: registering class device: ID = 'i2c-0'
[   17.176544] class_hotplug - name = i2c-0
[   17.176725] i2c-dev: adapter [dvi] registered as minor 1
[   17.176727] CLASS: registering class device: ID = 'i2c-1'
[   17.176732] class_hotplug - name = i2c-1
[   17.176948] i2c-dev: adapter [vga] registered as minor 2
[   17.176951] CLASS: registering class device: ID = 'i2c-2'
[   17.176961] class_hotplug - name = i2c-2
[   17.177172] i2c-dev: adapter [crt2] registered as minor 3
[   17.177174] CLASS: registering class device: ID = 'i2c-3'
[   17.177180] class_hotplug - name = i2c-3
[   17.177369] device class 'hwmon': registering
[   17.177852] input: AT Translated Set 2 keyboard as /class/input/input1
[   17.184861] CLASS: registering class device: ID = 'input1'
[   17.184866] class_hotplug - name = input1
[   17.185242] CLASS: registering class device: ID = 'event1'
[   17.185248] class_hotplug - name = event1
[   17.185251] class_device_create_hotplug called for event1
[   17.185472] bound device 'serio1' to driver 'atkbd'
[   17.185476] serio: Bound Device serio1 to Driver atkbd
[   17.185481] bus serio: add driver psmouse
[   17.185681] serio: Matched Device serio0 with Driver psmouse
[   17.207354] device class 'sound': registering
[   17.207372] bus platform: add driver snd_generic
[   17.207558] Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 13:30:21 2005 UTC).
[   17.214819] CLASS: registering class device: ID = 'timer'
[   17.214823] class_hotplug - name = timer
[   17.214825] class_device_create_hotplug called for timer
[   17.215004] CLASS: registering class device: ID = 'sequencer'
[   17.215009] class_hotplug - name = sequencer
[   17.215011] class_device_create_hotplug called for sequencer
[   17.215331] CLASS: registering class device: ID = 'sequencer2'
[   17.215341] class_hotplug - name = sequencer2
[   17.215343] class_device_create_hotplug called for sequencer2
[   17.215767] CLASS: registering class device: ID = 'seq'
[   17.215773] class_hotplug - name = seq
[   17.215775] class_device_create_hotplug called for seq
[   17.215806] bus pci: add driver Intel ICH
[   17.215995] pci: Matched Device 0000:00:1f.5 with Driver Intel ICH
[   17.216018] acpi_bus-0200 [07] bus_set_power         : Device is not power manageable
[   17.223439] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
[   17.230884] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   17.353923] input: PS/2 Generic Mouse as /class/input/input2
[   17.361137] CLASS: registering class device: ID = 'input2'
[   17.361147] class_hotplug - name = input2
[   17.361369] CLASS: registering class device: ID = 'mouse0'
[   17.361375] class_hotplug - name = mouse0
[   17.361378] class_device_create_hotplug called for mouse0
[   17.361580] CLASS: registering class device: ID = 'event2'
[   17.361586] class_hotplug - name = event2
[   17.361589] class_device_create_hotplug called for event2
[   17.364899] bound device 'serio0' to driver 'psmouse'
[   17.364902] serio: Bound Device serio0 to Driver psmouse
[   18.076835] intel8x0_measure_ac97_clock: measured 50274 usecs
[   18.084049] intel8x0: clocking to 48000
[   18.091244] CLASS: registering class device: ID = 'pcmC0D4p'
[   18.091255] class_hotplug - name = pcmC0D4p
[   18.091259] class_device_create_hotplug called for pcmC0D4p
[   18.091544] CLASS: registering class device: ID = 'pcmC0D3c'
[   18.091551] class_hotplug - name = pcmC0D3c
[   18.091554] class_device_create_hotplug called for pcmC0D3c
[   18.091765] CLASS: registering class device: ID = 'pcmC0D2c'
[   18.091774] class_hotplug - name = pcmC0D2c
[   18.091777] class_device_create_hotplug called for pcmC0D2c
[   18.091979] CLASS: registering class device: ID = 'pcmC0D1c'
[   18.091985] class_hotplug - name = pcmC0D1c
[   18.091988] class_device_create_hotplug called for pcmC0D1c
[   18.092189] CLASS: registering class device: ID = 'adsp'
[   18.092200] class_hotplug - name = adsp
[   18.092203] class_device_create_hotplug called for adsp
[   18.092400] CLASS: registering class device: ID = 'pcmC0D0p'
[   18.092406] class_hotplug - name = pcmC0D0p
[   18.092409] class_device_create_hotplug called for pcmC0D0p
[   18.092614] CLASS: registering class device: ID = 'pcmC0D0c'
[   18.092620] class_hotplug - name = pcmC0D0c
[   18.092623] class_device_create_hotplug called for pcmC0D0c
[   18.092837] CLASS: registering class device: ID = 'dsp'
[   18.092843] class_hotplug - name = dsp
[   18.092846] class_device_create_hotplug called for dsp
[   18.093050] CLASS: registering class device: ID = 'audio'
[   18.093058] class_hotplug - name = audio
[   18.093061] class_device_create_hotplug called for audio
[   18.093269] DEV: registering device: ID = 'card0-0'
[   18.093484] PM: Adding info for ac97:card0-0
[   18.093491] bus ac97: add device card0-0
[   18.093499] CLASS: registering class device: ID = 'controlC0'
[   18.093504] class_hotplug - name = controlC0
[   18.093508] class_device_create_hotplug called for controlC0
[   18.093725] CLASS: registering class device: ID = 'mixer'
[   18.093734] class_hotplug - name = mixer
[   18.093737] class_device_create_hotplug called for mixer
[   18.094209] bound device '0000:00:1f.5' to driver 'Intel ICH'
[   18.094213] pci: Bound Device 0000:00:1f.5 to Driver Intel ICH
[   18.094223] bus pci: add driver Intel ICH Modem
[   18.094455] pci: Matched Device 0000:00:1f.6 with Driver Intel ICH Modem
[   18.094480] ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
[   18.101895] PCI: Setting latency timer of device 0000:00:1f.6 to 64
[   18.119930] DEV: registering device: ID = '444fc000221b90c1'
[   18.120211] PM: Adding info for ieee1394:444fc000221b90c1
[   18.120218] bus ieee1394: add device 444fc000221b90c1
[   18.120223] CLASS: registering class device: ID = '444fc000221b90c1'
[   18.120235] class_hotplug - name = 444fc000221b90c1
[   18.120454] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[444fc000221b90c1]
[   18.205718] MC'97 1 converters and GPIO not ready (0xff00)
[   18.213242] CLASS: registering class device: ID = 'pcmC1D0p'
[   18.213252] class_hotplug - name = pcmC1D0p
[   18.213255] class_device_create_hotplug called for pcmC1D0p
[   18.213851] CLASS: registering class device: ID = 'pcmC1D0c'
[   18.213857] class_hotplug - name = pcmC1D0c
[   18.213861] class_device_create_hotplug called for pcmC1D0c
[   18.214063] CLASS: registering class device: ID = 'dsp1'
[   18.214071] class_hotplug - name = dsp1
[   18.214074] class_device_create_hotplug called for dsp1
[   18.214277] CLASS: registering class device: ID = 'audio1'
[   18.214283] class_hotplug - name = audio1
[   18.214286] class_device_create_hotplug called for audio1
[   18.214493] DEV: registering device: ID = 'card1-1'
[   18.214698] PM: Adding info for ac97:card1-1
[   18.214703] bus ac97: add device card1-1
[   18.214709] CLASS: registering class device: ID = 'controlC1'
[   18.214714] class_hotplug - name = controlC1
[   18.214718] class_device_create_hotplug called for controlC1
[   18.214934] CLASS: registering class device: ID = 'mixer1'
[   18.214942] class_hotplug - name = mixer1
[   18.214945] class_device_create_hotplug called for mixer1
[   18.215242] bound device '0000:00:1f.6' to driver 'Intel ICH Modem'
[   18.215246] pci: Bound Device 0000:00:1f.6 to Driver Intel ICH Modem
[   18.215254] ALSA device list:
[   18.222616]   #0: Intel 82801DB-ICH4 with STAC9750,51 at 0xf8fff800, irq 7
[   18.229994]   #1: Intel 82801DB-ICH4 Modem at 0xd400, irq 7
[   18.237315] Registering sysdev class '<NULL>'
[   18.237321] Registering sys device 'oprofile0'
[   18.237543] oprofile: using NMI interrupt.
[   18.244888] NET: Registered protocol family 2
[   18.262485] IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
[   18.270401] TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
[   18.278825] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[   18.286398] TCP: Hash tables configured (established 262144 bind 65536)
[   18.293735] TCP reno registered
[   18.300988] IPv4 over IPv4 tunneling driver
[   18.308274] CLASS: registering class device: ID = 'tunl0'
[   18.308295] class_hotplug - name = tunl0
[   18.308736] GRE over IPv4 tunneling driver
[   18.315831] CLASS: registering class device: ID = 'gre0'
[   18.315837] class_hotplug - name = gre0
[   18.316130] TCP bic registered
[   18.323838] Initializing IPsec netlink socket
[   18.330844] NET: Registered protocol family 1
[   18.337753] NET: Registered protocol family 17
[   18.403492] Testing NMI watchdog ... OK.
[   18.420236] Registering sysdev class '<NULL>'
[   18.420242] Registering sys device 'lapic_nmi0'
[   18.420442] Using IPI Shortcut mode
[   18.427511] swsusp: Resume From Partition /dev/hda2
[   18.427513] PM: Checking swsusp image.
[   18.455914] swsusp: Error -22 check for resume file
[   18.455916] PM: Resume from disk failed.
[   18.455942] Registering sysdev class '<NULL>'
[   18.455947] Registering sys device 'acpi0'
[   18.456177] ACPI wakeup devices: 
[   18.462755]  LID PBTN PCI0 USB0 USB1 USB2 USB3 MODM PCIE 
[   18.469475] ACPI: (supports S0 S1 S3 S4 S5)
[   18.476321] Freeing unused kernel memory: 212k freed
[   18.483263] CLASS: registering class device: ID = 'vcs1'
[   18.483272] class_hotplug - name = vcs1
[   18.483275] class_device_create_hotplug called for vcs1
[   18.483525] CLASS: registering class device: ID = 'vcsa1'
[   18.483535] class_hotplug - name = vcsa1
[   18.483536] class_device_create_hotplug called for vcsa1
[   18.637618] EXT3-fs: mounted filesystem with ordered data mode.
[   18.649869] kjournald starting.  Commit interval 5 seconds
[   20.601927] CLASS: registering class device: ID = 'vcs2'
[   20.601942] class_hotplug - name = vcs2
[   20.601944] class_device_create_hotplug called for vcs2
[   20.622898] CLASS: registering class device: ID = 'vcsa2'
[   20.622905] class_hotplug - name = vcsa2
[   20.622907] class_device_create_hotplug called for vcsa2
[   20.623902] CLASS: Unregistering class device. ID = 'vcs2'
[   20.623907] class_hotplug - name = vcs2
[   20.623909] class_device_create_hotplug called for vcs2
[   20.624156] device class 'vcs2': release.
[   20.624159] class_device_create_release called for vcs2
[   20.624161] CLASS: Unregistering class device. ID = 'vcsa2'
[   20.624164] class_hotplug - name = vcsa2
[   20.624166] class_device_create_hotplug called for vcsa2
[   20.624396] device class 'vcsa2': release.
[   20.624397] class_device_create_release called for vcsa2
[   20.626032] CLASS: registering class device: ID = 'vcs3'
[   20.626039] class_hotplug - name = vcs3
[   20.626041] class_device_create_hotplug called for vcs3
[   20.626304] CLASS: registering class device: ID = 'vcsa3'
[   20.626311] class_hotplug - name = vcsa3
[   20.626312] class_device_create_hotplug called for vcsa3
[   20.628274] CLASS: Unregistering class device. ID = 'vcs3'
[   20.628280] class_hotplug - name = vcs3
[   20.628282] class_device_create_hotplug called for vcs3
[   20.628568] device class 'vcs3': release.
[   20.628570] class_device_create_release called for vcs3
[   20.628572] CLASS: Unregistering class device. ID = 'vcsa3'
[   20.628575] class_hotplug - name = vcsa3
[   20.628577] class_device_create_hotplug called for vcsa3
[   20.628816] device class 'vcsa3': release.
[   20.628817] class_device_create_release called for vcsa3
[   20.631495] CLASS: registering class device: ID = 'vcs4'
[   20.631506] class_hotplug - name = vcs4
[   20.631509] class_device_create_hotplug called for vcs4
[   20.631844] CLASS: registering class device: ID = 'vcsa4'
[   20.631851] class_hotplug - name = vcsa4
[   20.631852] class_device_create_hotplug called for vcsa4
[   20.633807] CLASS: Unregistering class device. ID = 'vcs4'
[   20.633814] class_hotplug - name = vcs4
[   20.633816] class_device_create_hotplug called for vcs4
[   20.634123] device class 'vcs4': release.
[   20.634125] class_device_create_release called for vcs4
[   20.634127] CLASS: Unregistering class device. ID = 'vcsa4'
[   20.634131] class_hotplug - name = vcsa4
[   20.634132] class_device_create_hotplug called for vcsa4
[   20.634381] device class 'vcsa4': release.
[   20.634383] class_device_create_release called for vcsa4
[   20.636152] CLASS: registering class device: ID = 'vcs5'
[   20.636164] class_hotplug - name = vcs5
[   20.636166] class_device_create_hotplug called for vcs5
[   20.636948] CLASS: registering class device: ID = 'vcsa5'
[   20.636956] class_hotplug - name = vcsa5
[   20.636958] class_device_create_hotplug called for vcsa5
[   20.638984] CLASS: Unregistering class device. ID = 'vcs5'
[   20.638998] class_hotplug - name = vcs5
[   20.639000] class_device_create_hotplug called for vcs5
[   20.639311] device class 'vcs5': release.
[   20.639314] class_device_create_release called for vcs5
[   20.639316] CLASS: Unregistering class device. ID = 'vcsa5'
[   20.639320] class_hotplug - name = vcsa5
[   20.639322] class_device_create_hotplug called for vcsa5
[   20.639573] device class 'vcsa5': release.
[   20.639575] class_device_create_release called for vcsa5
[   20.641413] CLASS: registering class device: ID = 'vcs6'
[   20.641426] class_hotplug - name = vcs6
[   20.641428] class_device_create_hotplug called for vcs6
[   20.641749] CLASS: registering class device: ID = 'vcsa6'
[   20.641755] class_hotplug - name = vcsa6
[   20.641757] class_device_create_hotplug called for vcsa6
[   20.643759] CLASS: Unregistering class device. ID = 'vcs6'
[   20.643767] class_hotplug - name = vcs6
[   20.643769] class_device_create_hotplug called for vcs6
[   20.644130] device class 'vcs6': release.
[   20.644132] class_device_create_release called for vcs6
[   20.644134] CLASS: Unregistering class device. ID = 'vcsa6'
[   20.644138] class_hotplug - name = vcsa6
[   20.644140] class_device_create_hotplug called for vcsa6
[   20.644391] device class 'vcsa6': release.
[   20.644393] class_device_create_release called for vcsa6
[   20.647803] CLASS: registering class device: ID = 'vcs7'
[   20.647816] class_hotplug - name = vcs7
[   20.647818] class_device_create_hotplug called for vcs7
[   20.648177] CLASS: registering class device: ID = 'vcsa7'
[   20.648183] class_hotplug - name = vcsa7
[   20.648185] class_device_create_hotplug called for vcsa7
[   20.650276] CLASS: Unregistering class device. ID = 'vcs7'
[   20.650283] class_hotplug - name = vcs7
[   20.650285] class_device_create_hotplug called for vcs7
[   20.650587] device class 'vcs7': release.
[   20.650589] class_device_create_release called for vcs7
[   20.650591] CLASS: Unregistering class device. ID = 'vcsa7'
[   20.650595] class_hotplug - name = vcsa7
[   20.650596] class_device_create_hotplug called for vcsa7
[   20.650852] device class 'vcsa7': release.
[   20.650854] class_device_create_release called for vcsa7
[   20.652806] CLASS: registering class device: ID = 'vcs8'
[   20.652819] class_hotplug - name = vcs8
[   20.652822] class_device_create_hotplug called for vcs8
[   20.653165] CLASS: registering class device: ID = 'vcsa8'
[   20.653172] class_hotplug - name = vcsa8
[   20.653174] class_device_create_hotplug called for vcsa8
[   20.655301] CLASS: Unregistering class device. ID = 'vcs8'
[   20.655308] class_hotplug - name = vcs8
[   20.655310] class_device_create_hotplug called for vcs8
[   20.655632] device class 'vcs8': release.
[   20.655635] class_device_create_release called for vcs8
[   20.655637] CLASS: Unregistering class device. ID = 'vcsa8'
[   20.655640] class_hotplug - name = vcsa8
[   20.655642] class_device_create_hotplug called for vcsa8
[   20.655904] device class 'vcsa8': release.
[   20.655906] class_device_create_release called for vcsa8
[   25.849523] floppy0: no floppy controllers found
[   26.068672] ieee80211_crypt: registered algorithm 'NULL'
[   26.102338] ieee80211: 802.11 data/management/control stack, git-1.1.7
[   26.102341] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   26.147929] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
[   26.147933] ipw2200: Copyright(c) 2003-2005 Intel Corporation
[   26.147936] bus pci: add driver ipw2200
[   26.152270] pci: Matched Device 0000:02:03.0 with Driver ipw2200
[   26.152326] ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
[   26.152358] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[   26.152380] CLASS: registering class device: ID = '0000:02:03.0'
[   26.152391] class_hotplug - name = 0000:02:03.0
[   26.152395] class->hotplug() returned -19
[   26.152399] class_hotplug - name = 0000:02:03.0
[   26.231890] CLASS: Unregistering class device. ID = '0000:02:03.0'
[   26.231902] class_hotplug - name = 0000:02:03.0
[   26.232402] device class '0000:02:03.0': release.
[   26.232407] CLASS: registering class device: ID = '0000:02:03.0'
[   26.232415] class_hotplug - name = 0000:02:03.0
[   26.232418] class->hotplug() returned -19
[   26.232421] class_hotplug - name = 0000:02:03.0
[   26.250722] CLASS: Unregistering class device. ID = '0000:02:03.0'
[   26.250735] class_hotplug - name = 0000:02:03.0
[   26.251266] CLASS: registering class device: ID = '0000:02:03.0'
[   26.251275] class_hotplug - name = 0000:02:03.0
[   26.251278] class->hotplug() returned -19
[   26.251282] class_hotplug - name = 0000:02:03.0
[   26.258937] device class '0000:02:03.0': release.
[   26.276321] CLASS: Unregistering class device. ID = '0000:02:03.0'
[   26.276334] class_hotplug - name = 0000:02:03.0
[   26.397597] device class '0000:02:03.0': release.
[   26.398354] CLASS: registering class device: ID = 'eth1'
[   26.398368] class_hotplug - name = eth1
[   26.398867] bound device '0000:02:03.0' to driver 'ipw2200'
[   26.398872] pci: Bound Device 0000:02:03.0 to Driver ipw2200
[   27.305152] EXT3 FS on hda3, internal journal
[   27.413602] kjournald starting.  Commit interval 5 seconds
[   27.413802] EXT3 FS on hda1, internal journal
[   27.413806] EXT3-fs: mounted filesystem with ordered data mode.
[   28.120587] Adding 2008116k swap on /dev/hda2.  Priority:-1 extents:1 across:2008116k
[   28.266219] CLASS: registering class device: ID = 'vcs2'
[   28.266233] class_hotplug - name = vcs2
[   28.266236] class_device_create_hotplug called for vcs2
[   28.266529] CLASS: registering class device: ID = 'vcsa2'
[   28.266538] class_hotplug - name = vcsa2
[   28.266540] class_device_create_hotplug called for vcsa2
[   28.267084] CLASS: Unregistering class device. ID = 'vcs2'
[   28.267089] class_hotplug - name = vcs2
[   28.267091] class_device_create_hotplug called for vcs2
[   28.267339] device class 'vcs2': release.
[   28.267341] class_device_create_release called for vcs2
[   28.267343] CLASS: Unregistering class device. ID = 'vcsa2'
[   28.267346] class_hotplug - name = vcsa2
[   28.267348] class_device_create_hotplug called for vcsa2
[   28.267582] device class 'vcsa2': release.
[   28.267583] class_device_create_release called for vcsa2
[   28.267801] CLASS: registering class device: ID = 'vcs2'
[   28.267806] class_hotplug - name = vcs2
[   28.267808] class_device_create_hotplug called for vcs2
[   28.268052] CLASS: registering class device: ID = 'vcsa2'
[   28.268057] class_hotplug - name = vcsa2
[   28.268059] class_device_create_hotplug called for vcsa2
[   28.313694] CLASS: registering class device: ID = 'vcs3'
[   28.313706] class_hotplug - name = vcs3
[   28.313708] class_device_create_hotplug called for vcs3
[   28.314016] CLASS: registering class device: ID = 'vcsa3'
[   28.314022] class_hotplug - name = vcsa3
[   28.314024] class_device_create_hotplug called for vcsa3
[   28.314548] CLASS: Unregistering class device. ID = 'vcs3'
[   28.314553] class_hotplug - name = vcs3
[   28.314554] class_device_create_hotplug called for vcs3
[   28.314795] device class 'vcs3': release.
[   28.314797] class_device_create_release called for vcs3
[   28.314799] CLASS: Unregistering class device. ID = 'vcsa3'
[   28.314802] class_hotplug - name = vcsa3
[   28.314804] class_device_create_hotplug called for vcsa3
[   28.315043] device class 'vcsa3': release.
[   28.315045] class_device_create_release called for vcsa3
[   28.315262] CLASS: registering class device: ID = 'vcs3'
[   28.315268] class_hotplug - name = vcs3
[   28.315269] class_device_create_hotplug called for vcs3
[   28.315506] CLASS: registering class device: ID = 'vcsa3'
[   28.315511] class_hotplug - name = vcsa3
[   28.315513] class_device_create_hotplug called for vcsa3
[   28.873990] pcmcia: Detected deprecated PCMCIA ioctl usage.
[   28.873993] pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
[   28.873996] pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
[   19.084000] Time: acpi_pm clocksource has been installed.
[   19.085000] Ktimers: Switched to high resolution mode CPU 0
[   21.128000] b44: eth0: Link is up at 100 Mbps, full duplex.
[   21.128000] b44: eth0: Flow control is on for TX and on for RX.
[   62.376000] CLASS: registering class device: ID = 'vcs4'
[   62.376000] class_hotplug - name = vcs4
[   62.376000] class_device_create_hotplug called for vcs4
[   62.377000] CLASS: registering class device: ID = 'vcsa4'
[   62.377000] class_hotplug - name = vcsa4
[   62.377000] class_device_create_hotplug called for vcsa4
[   62.379000] CLASS: Unregistering class device. ID = 'vcs4'
[   62.379000] class_hotplug - name = vcs4
[   62.379000] class_device_create_hotplug called for vcs4
[   62.380000] device class 'vcs4': release.
[   62.380000] class_device_create_release called for vcs4
[   62.380000] CLASS: Unregistering class device. ID = 'vcsa4'
[   62.380000] class_hotplug - name = vcsa4
[   62.380000] class_device_create_hotplug called for vcsa4
[   62.381000] device class 'vcsa4': release.
[   62.381000] class_device_create_release called for vcsa4
[   62.382000] CLASS: registering class device: ID = 'vcs4'
[   62.382000] class_hotplug - name = vcs4
[   62.382000] class_device_create_hotplug called for vcs4
[   62.383000] CLASS: registering class device: ID = 'vcsa4'
[   62.383000] class_hotplug - name = vcsa4
[   62.383000] class_device_create_hotplug called for vcsa4
[   62.387000] CLASS: registering class device: ID = 'vcs5'
[   62.387000] class_hotplug - name = vcs5
[   62.387000] class_device_create_hotplug called for vcs5
[   62.388000] CLASS: registering class device: ID = 'vcsa5'
[   62.388000] class_hotplug - name = vcsa5
[   62.388000] class_device_create_hotplug called for vcsa5
[   62.390000] CLASS: Unregistering class device. ID = 'vcs5'
[   62.390000] class_hotplug - name = vcs5
[   62.390000] class_device_create_hotplug called for vcs5
[   62.391000] device class 'vcs5': release.
[   62.391000] class_device_create_release called for vcs5
[   62.391000] CLASS: Unregistering class device. ID = 'vcsa5'
[   62.391000] class_hotplug - name = vcsa5
[   62.391000] class_device_create_hotplug called for vcsa5
[   62.392000] device class 'vcsa5': release.
[   62.392000] class_device_create_release called for vcsa5
[   62.394000] CLASS: registering class device: ID = 'vcs5'
[   62.394000] class_hotplug - name = vcs5
[   62.394000] class_device_create_hotplug called for vcs5
[   62.396000] CLASS: registering class device: ID = 'vcs6'
[   62.396000] class_hotplug - name = vcs6
[   62.396000] class_device_create_hotplug called for vcs6
[   62.626000] CLASS: registering class device: ID = 'vcsa5'
[   62.626000] class_hotplug - name = vcsa5
[   62.626000] class_device_create_hotplug called for vcsa5
[   62.628000] CLASS: registering class device: ID = 'vcsa6'
[   62.628000] class_hotplug - name = vcsa6
[   62.628000] class_device_create_hotplug called for vcsa6
[   62.709000] CLASS: Unregistering class device. ID = 'vcs6'
[   62.709000] class_hotplug - name = vcs6
[   62.709000] class_device_create_hotplug called for vcs6
[   62.710000] device class 'vcs6': release.
[   62.710000] class_device_create_release called for vcs6
[   62.711000] CLASS: Unregistering class device. ID = 'vcsa6'
[   62.711000] class_hotplug - name = vcsa6
[   62.711000] class_device_create_hotplug called for vcsa6
[   62.712000] device class 'vcsa6': release.
[   62.713000] class_device_create_release called for vcsa6
[   62.733000] CLASS: registering class device: ID = 'vcs6'
[   62.733000] class_hotplug - name = vcs6
[   62.733000] class_device_create_hotplug called for vcs6
[   62.734000] CLASS: registering class device: ID = 'vcsa6'
[   62.734000] class_hotplug - name = vcsa6
[   62.734000] class_device_create_hotplug called for vcsa6
[   71.188000] CLASS: registering class device: ID = 'vcs7'
[   71.188000] class_hotplug - name = vcs7
[   71.188000] class_device_create_hotplug called for vcs7
[   71.189000] CLASS: registering class device: ID = 'vcsa7'
[   71.189000] class_hotplug - name = vcsa7
[   71.189000] class_device_create_hotplug called for vcsa7
[   71.313000] CLASS: Unregistering class device. ID = 'vcs7'
[   71.313000] class_hotplug - name = vcs7
[   71.313000] class_device_create_hotplug called for vcs7
[   71.314000] device class 'vcs7': release.
[   71.314000] class_device_create_release called for vcs7
[   71.314000] CLASS: Unregistering class device. ID = 'vcsa7'
[   71.314000] class_hotplug - name = vcsa7
[   71.314000] class_device_create_hotplug called for vcsa7
[   71.315000] device class 'vcsa7': release.
[   71.315000] class_device_create_release called for vcsa7
[   71.819000] CLASS: registering class device: ID = 'vcs7'
[   71.819000] class_hotplug - name = vcs7
[   71.819000] class_device_create_hotplug called for vcs7
[   71.820000] CLASS: registering class device: ID = 'vcsa7'
[   71.820000] class_hotplug - name = vcsa7
[   71.820000] class_device_create_hotplug called for vcsa7
[  189.109000] Time: jiffies clocksource has been installed.
[  189.364000] check_monotonic_clock: monotonic inconsistency detected!
[  189.364000] 	from       2c4111daf6 (190070250230) to       2c4111daf5 (190070250229).
[  189.364000] Badness in check_monotonic_clock at kernel/time/timeofday.c:156
[  189.364000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[  189.364000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[  189.364000]  [<c0136aac>] enqueue_ktimer+0x2c/0x350
[  189.364000]  [<c0136ed1>] internal_restart_ktimer+0x51/0xb0
[  189.364000]  [<c013962a>] timeofday_periodic_hook+0x67a/0x8f0
[  189.364000]  [<f98891f7>] ipw_handle_mgmt_packet+0x37/0x2d0 [ipw2200]
[  189.364000]  [<c01365e2>] ktimer_interrupt+0x1e2/0x2e0
[  189.364000]  [<c0137258>] ktimer_run_queues+0x18/0x110
[  189.364000]  [<c025d24d>] __rb_erase_color+0xcd/0x190
[  189.364000]  [<c0138fb0>] timeofday_periodic_hook+0x0/0x8f0
[  189.364000]  [<c01371f8>] run_ktimer_softirq+0x68/0xb0
[  189.364000]  [<c0124772>] __do_softirq+0x42/0xa0
[  189.364000]  [<c010531e>] do_softirq+0x4e/0x60
[  189.364000]  =======================
[  189.364000]  [<c0124895>] irq_exit+0x35/0x40
[  189.364000]  [<c01051da>] do_IRQ+0x5a/0xa0
[  189.364000]  [<c0103ace>] common_interrupt+0x1a/0x20
[  189.364000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[  189.364000]  [<c01010f2>] cpu_idle+0x42/0x60
[  189.364000]  [<c05a9855>] start_kernel+0x175/0x1e0
[  189.364000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[  189.619000] check_monotonic_clock: monotonic inconsistency detected!
[  189.619000] 	from       2c5044782f (190325225519) to       2c5044782e (190325225518).
[  189.619000] Badness in check_monotonic_clock at kernel/time/timeofday.c:156
[  189.619000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[  189.619000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[  189.619000]  [<c0136aac>] enqueue_ktimer+0x2c/0x350
[  189.619000]  [<c0136ed1>] internal_restart_ktimer+0x51/0xb0
[  189.619000]  [<c013962a>] timeofday_periodic_hook+0x67a/0x8f0
[  189.619000]  [<f98891f7>] ipw_handle_mgmt_packet+0x37/0x2d0 [ipw2200]
[  189.619000]  [<c01365e2>] ktimer_interrupt+0x1e2/0x2e0
[  189.619000]  [<c0137258>] ktimer_run_queues+0x18/0x110
[  189.619000]  [<c0138fb0>] timeofday_periodic_hook+0x0/0x8f0
[  189.619000]  [<c01371f8>] run_ktimer_softirq+0x68/0xb0
[  189.619000]  [<c0124772>] __do_softirq+0x42/0xa0
[  189.619000]  [<c010531e>] do_softirq+0x4e/0x60
[  189.619000]  =======================
[  189.619000]  [<c0124895>] irq_exit+0x35/0x40
[  189.619000]  [<c01051da>] do_IRQ+0x5a/0xa0
[  189.619000]  [<c0103ace>] common_interrupt+0x1a/0x20
[  189.619000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[  189.619000]  [<c01010f2>] cpu_idle+0x42/0x60
[  189.619000]  [<c05a9855>] start_kernel+0x175/0x1e0
[  189.619000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[  189.874000] check_monotonic_clock: monotonic inconsistency detected!
[  189.874000] 	from       2c5f771568 (190580200808) to       2c5f771567 (190580200807).
[  189.874000] Badness in check_monotonic_clock at kernel/time/timeofday.c:156
[  189.874000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[  189.874000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[  189.874000]  [<c0136aac>] enqueue_ktimer+0x2c/0x350
[  189.874000]  [<c0136ed1>] internal_restart_ktimer+0x51/0xb0
[  189.874000]  [<c013962a>] timeofday_periodic_hook+0x67a/0x8f0
[  189.874000]  [<c032a210>] i8042_timer_func+0x0/0x10
[  189.874000]  [<c0137258>] ktimer_run_queues+0x18/0x110
[  189.874000]  [<c0138fb0>] timeofday_periodic_hook+0x0/0x8f0
[  189.874000]  [<c01371f8>] run_ktimer_softirq+0x68/0xb0
[  189.874000]  [<c0124772>] __do_softirq+0x42/0xa0
[  189.874000]  [<c010531e>] do_softirq+0x4e/0x60
[  189.874000]  =======================
[  189.874000]  [<c0124895>] irq_exit+0x35/0x40
[  189.874000]  [<c01051da>] do_IRQ+0x5a/0xa0
[  189.874000]  [<c0103ace>] common_interrupt+0x1a/0x20
[  189.874000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[  189.874000]  [<c01010f2>] cpu_idle+0x42/0x60
[  189.874000]  [<c05a9855>] start_kernel+0x175/0x1e0
[  189.874000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[  190.130000] check_monotonic_clock: monotonic inconsistency detected!
[  190.130000] 	from       2c6eb8f480 (190836176000) to       2c6eb8f47f (190836175999).
[  190.130000] Badness in check_monotonic_clock at kernel/time/timeofday.c:156
[  190.130000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[  190.130000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[  190.130000]  [<c0136aac>] enqueue_ktimer+0x2c/0x350
[  190.130000]  [<c0136ed1>] internal_restart_ktimer+0x51/0xb0
[  190.130000]  [<c013962a>] timeofday_periodic_hook+0x67a/0x8f0
[  190.130000]  [<f98891f7>] ipw_handle_mgmt_packet+0x37/0x2d0 [ipw2200]
[  190.130000]  [<c01365e2>] ktimer_interrupt+0x1e2/0x2e0
[  190.130000]  [<c0137258>] ktimer_run_queues+0x18/0x110
[  190.130000]  [<c0138fb0>] timeofday_periodic_hook+0x0/0x8f0
[  190.130000]  [<c01371f8>] run_ktimer_softirq+0x68/0xb0
[  190.130000]  [<c0124772>] __do_softirq+0x42/0xa0
[  190.130000]  [<c010531e>] do_softirq+0x4e/0x60
[  190.130000]  =======================
[  190.130000]  [<c0124895>] irq_exit+0x35/0x40
[  190.130000]  [<c01051da>] do_IRQ+0x5a/0xa0
[  190.130000]  [<c0103ace>] common_interrupt+0x1a/0x20
[  190.130000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[  190.130000]  [<c01010f2>] cpu_idle+0x42/0x60
[  190.130000]  [<c05a9855>] start_kernel+0x175/0x1e0
[  190.130000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[  190.589000] check_monotonic_clock: monotonic inconsistency detected!
[  190.589000] 	from       2c8a140f80 (191295131520) to       2c8a140f7f (191295131519).
[  190.589000] Badness in check_monotonic_clock at kernel/time/timeofday.c:156
[  190.589000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[  190.589000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[  190.589000]  [<c0136aac>] enqueue_ktimer+0x2c/0x350
[  190.589000]  [<c0136ed1>] internal_restart_ktimer+0x51/0xb0
[  190.589000]  [<c013962a>] timeofday_periodic_hook+0x67a/0x8f0
[  190.589000]  [<c01365e2>] ktimer_interrupt+0x1e2/0x2e0
[  190.589000]  [<c0137258>] ktimer_run_queues+0x18/0x110
[  190.589000]  [<c0138fb0>] timeofday_periodic_hook+0x0/0x8f0
[  190.589000]  [<c01371f8>] run_ktimer_softirq+0x68/0xb0
[  190.589000]  [<c0124772>] __do_softirq+0x42/0xa0
[  190.589000]  [<c010531e>] do_softirq+0x4e/0x60
[  190.589000]  =======================
[  190.589000]  [<c0124895>] irq_exit+0x35/0x40
[  190.589000]  [<c01051da>] do_IRQ+0x5a/0xa0
[  190.589000]  [<c0103ace>] common_interrupt+0x1a/0x20
[  190.589000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[  190.589000]  [<c01010f2>] cpu_idle+0x42/0x60
[  190.589000]  [<c05a9855>] start_kernel+0x175/0x1e0
[  190.589000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[  190.694000] check_monotonic_clock: monotonic inconsistency detected!
[  190.694000] 	from       2c90561401 (191400121345) to       2c90561400 (191400121344).
[  190.694000] Badness in check_monotonic_clock at kernel/time/timeofday.c:156
[  190.694000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[  190.694000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[  190.694000]  [<c0136aac>] enqueue_ktimer+0x2c/0x350
[  190.694000]  [<c0136ed1>] internal_restart_ktimer+0x51/0xb0
[  190.694000]  [<c013962a>] timeofday_periodic_hook+0x67a/0x8f0
[  190.694000]  [<c0116adb>] smp_apic_timer_interrupt+0x2b/0x30
[  190.694000]  [<c0103af0>] apic_timer_interrupt+0x1c/0x24
[  190.694000]  [<c0138fb0>] timeofday_periodic_hook+0x0/0x8f0
[  190.694000]  [<c01371f8>] run_ktimer_softirq+0x68/0xb0
[  190.694000]  [<c0124772>] __do_softirq+0x42/0xa0
[  190.694000]  [<c010531e>] do_softirq+0x4e/0x60
[  190.694000]  =======================
[  190.694000]  [<c0124895>] irq_exit+0x35/0x40
[  190.694000]  [<c01051da>] do_IRQ+0x5a/0xa0
[  190.694000]  [<c0103ace>] common_interrupt+0x1a/0x20
[  190.694000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[  190.694000]  [<c01010f2>] cpu_idle+0x42/0x60
[  190.694000]  [<c05a9855>] start_kernel+0x175/0x1e0
[  190.694000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[  190.796000] check_monotonic_clock: monotonic inconsistency detected!
[  190.796000] 	from       2c966a52e4 (191502111460) to       2c966a52e3 (191502111459).
[  190.796000] Badness in check_monotonic_clock at kernel/time/timeofday.c:156
[  190.796000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[  190.796000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[  190.796000]  [<c0136aac>] enqueue_ktimer+0x2c/0x350
[  190.796000]  [<c0136ed1>] internal_restart_ktimer+0x51/0xb0
[  190.796000]  [<c013962a>] timeofday_periodic_hook+0x67a/0x8f0
[  190.796000]  [<f98891f7>] ipw_handle_mgmt_packet+0x37/0x2d0 [ipw2200]
[  190.796000]  [<c01365e2>] ktimer_interrupt+0x1e2/0x2e0
[  190.796000]  [<c0137258>] ktimer_run_queues+0x18/0x110
[  190.796000]  [<c0138fb0>] timeofday_periodic_hook+0x0/0x8f0
[  190.796000]  [<c01371f8>] run_ktimer_softirq+0x68/0xb0
[  190.796000]  [<c0124772>] __do_softirq+0x42/0xa0
[  190.796000]  [<c010531e>] do_softirq+0x4e/0x60
[  190.796000]  =======================
[  190.796000]  [<c0124895>] irq_exit+0x35/0x40
[  190.796000]  [<c01051da>] do_IRQ+0x5a/0xa0
[  190.796000]  [<c0103ace>] common_interrupt+0x1a/0x20
[  190.796000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[  190.796000]  [<c01010f2>] cpu_idle+0x42/0x60
[  190.796000]  [<c05a9855>] start_kernel+0x175/0x1e0
[  190.796000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[  190.949000] check_monotonic_clock: monotonic inconsistency detected!
[  190.949000] 	from       2c9f88b13a (191655096634) to       2c9f88b139 (191655096633).
[  190.949000] Badness in check_monotonic_clock at kernel/time/timeofday.c:156
[  190.949000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[  190.949000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[  190.949000]  [<c0136aac>] enqueue_ktimer+0x2c/0x350
[  190.949000]  [<c0136ed1>] internal_restart_ktimer+0x51/0xb0
[  190.949000]  [<c013962a>] timeofday_periodic_hook+0x67a/0x8f0
[  190.949000]  [<c01365e2>] ktimer_interrupt+0x1e2/0x2e0
[  190.949000]  [<c0137258>] ktimer_run_queues+0x18/0x110
[  190.949000]  [<c0138fb0>] timeofday_periodic_hook+0x0/0x8f0
[  190.949000]  [<c01371f8>] run_ktimer_softirq+0x68/0xb0
[  190.949000]  [<c0124772>] __do_softirq+0x42/0xa0
[  190.949000]  [<c010531e>] do_softirq+0x4e/0x60
[  190.949000]  =======================
[  190.949000]  [<c0124895>] irq_exit+0x35/0x40
[  190.949000]  [<c01051da>] do_IRQ+0x5a/0xa0
[  190.949000]  [<c0103ace>] common_interrupt+0x1a/0x20
[  190.949000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[  190.949000]  [<c01010f2>] cpu_idle+0x42/0x60
[  190.949000]  [<c05a9855>] start_kernel+0x175/0x1e0
[  190.949000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[  191.051000] check_monotonic_clock: monotonic inconsistency detected!
[  191.051000] 	from       2ca59cf01d (191757086749) to       2ca59cf01c (191757086748).
[  191.051000] Badness in check_monotonic_clock at kernel/time/timeofday.c:156
[  191.051000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[  191.051000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[  191.051000]  [<c0136aac>] enqueue_ktimer+0x2c/0x350
[  191.051000]  [<c0136ed1>] internal_restart_ktimer+0x51/0xb0
[  191.051000]  [<c013962a>] timeofday_periodic_hook+0x67a/0x8f0
[  191.051000]  [<f98891f7>] ipw_handle_mgmt_packet+0x37/0x2d0 [ipw2200]
[  191.051000]  [<c01365e2>] ktimer_interrupt+0x1e2/0x2e0
[  191.051000]  [<c0137258>] ktimer_run_queues+0x18/0x110
[  191.051000]  [<c0138fb0>] timeofday_periodic_hook+0x0/0x8f0
[  191.051000]  [<c01371f8>] run_ktimer_softirq+0x68/0xb0
[  191.051000]  [<c0124772>] __do_softirq+0x42/0xa0
[  191.051000]  [<c010531e>] do_softirq+0x4e/0x60
[  191.051000]  =======================
[  191.051000]  [<c0124895>] irq_exit+0x35/0x40
[  191.051000]  [<c01051da>] do_IRQ+0x5a/0xa0
[  191.051000]  [<c0103ace>] common_interrupt+0x1a/0x20
[  191.051000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[  191.051000]  [<c01010f2>] cpu_idle+0x42/0x60
[  191.051000]  [<c05a9855>] start_kernel+0x175/0x1e0
[  191.051000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[  191.204000] check_monotonic_clock: monotonic inconsistency detected!
[  191.204000] 	from       2caebb4e73 (191910071923) to       2caebb4e72 (191910071922).
[  191.204000] Badness in check_monotonic_clock at kernel/time/timeofday.c:156
[  191.204000]  [<c01381cc>] check_monotonic_clock+0x9c/0x110
[  191.204000]  [<c013858e>] get_monotonic_clock+0xae/0xd0
[  191.204000]  [<c0136aac>] enqueue_ktimer+0x2c/0x350
[  191.204000]  [<c0136ed1>] internal_restart_ktimer+0x51/0xb0
[  191.204000]  [<c013962a>] timeofday_periodic_hook+0x67a/0x8f0
[  191.204000]  [<f98891f7>] ipw_handle_mgmt_packet+0x37/0x2d0 [ipw2200]
[  191.204000]  [<c01365e2>] ktimer_interrupt+0x1e2/0x2e0
[  191.204000]  [<c0137258>] ktimer_run_queues+0x18/0x110
[  191.204000]  [<c0138fb0>] timeofday_periodic_hook+0x0/0x8f0
[  191.204000]  [<c01371f8>] run_ktimer_softirq+0x68/0xb0
[  191.204000]  [<c0124772>] __do_softirq+0x42/0xa0
[  191.204000]  [<c010531e>] do_softirq+0x4e/0x60
[  191.204000]  =======================
[  191.204000]  [<c0124895>] irq_exit+0x35/0x40
[  191.204000]  [<c01051da>] do_IRQ+0x5a/0xa0
[  191.204000]  [<c0103ace>] common_interrupt+0x1a/0x20
[  191.204000]  [<c02f6000>] acpi_processor_idle+0x127/0x2bd
[  191.204000]  [<c01010f2>] cpu_idle+0x42/0x60
[  191.204000]  [<c05a9855>] start_kernel+0x175/0x1e0
[  191.204000]  [<c05a93a0>] unknown_bootoption+0x0/0x1e0
[  207.856000] Time: c3tsc clocksource has been installed.
[  207.857000] Ktimers: Switched to high resolution mode CPU 0
[  214.135000] Time: pit clocksource has been installed.
[  219.565000] Time: jiffies clocksource has been installed.
[  227.340000] Time: acpi_pm clocksource has been installed.
[  227.341000] Ktimers: Switched to high resolution mode CPU 0
[  236.159000] Time: c3tsc clocksource has been installed.
[  236.159000] Ktimers: Switched to high resolution mode CPU 0

--------------000002070400090801080109--
