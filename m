Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWAYSMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWAYSMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWAYSMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:12:25 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:63946 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750782AbWAYSMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:12:24 -0500
Date: Wed, 25 Jan 2006 19:12:59 +0100
From: Mattia Dongili <malattia@linux.it>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)]
Message-ID: <20060125181258.GB4110@inferi.kami.home>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060116204057.GC3639@inferi.kami.home> <1137458964.27699.65.camel@cog.beaverton.ibm.com> <20060117174953.GA3529@inferi.kami.home> <1137525090.27699.92.camel@cog.beaverton.ibm.com> <20060117224951.GA3320@inferi.kami.home> <16839.83.103.117.254.1137581235.squirrel@picard.linux.it> <1138141635.15682.92.camel@cog.beaverton.ibm.com> <20060124230453.GA6174@inferi.kami.home> <1138146498.15682.99.camel@cog.beaverton.ibm.com> <1138147929.15682.114.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <1138147929.15682.114.camel@cog.beaverton.ibm.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc1-mm2-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2006 at 04:12:09PM -0800, john stultz wrote:
> On Tue, 2006-01-24 at 15:48 -0800, john stultz wrote:
[...]
> > Well, it isn't do_gettimeofday that needs to be called, but we need a
> > way to decide if we should call tsc_mark_unstable(). Currently we do
> > that when we get a cpufreq transition notification if the cpu's TSC is
> > not constant.  The problem being: on your system, that notification
> > isn't called until after the cpufreq driver module loads. This is of
> > course, after we've started to use the TSC.

Ah!! the driver doesn't notify the transitions happening at
initialization as it doesn't use the cpufreq interfaces to do so and
booting with the performance governor just keep the frequency at it
highest limit.
The first cpufreq_set_policy call (and subsequent notification) in my
case is performed by the ondemand governor pretty late (when the
cpufrequtils script is run).

[...]
> 	Just to verify I'm not barking up the wrong tree here, could you try
> building w/ CONFIG_X86_SPEEDSTEP_ICH=y instead of as a module?

done, as expected things remain the same and tsc is marked unstable only
when cpufreutils loads the ondemand that immediately switches to the
lowest available frequency.

Dmesg is attached (CONFIG_PARANOID_GENERIC_TIME=y), as always I had
stalls at the known places (the 2 sleep calls done by init-scripts) at
20.88 and 22.09

thanks!
-- 
mattia
:wq!

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=tsc_cpufreq_y

[    0.000000] Linux version 2.6.16-rc1-mm2-4 (mattia@inferi) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #11 PREEMPT Wed Jan 25 16:14:11 CET 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
[    0.000000]  BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000000ff00000 - 000000000ff80000 (usable)
[    0.000000]  BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
[    0.000000] 255MB LOWMEM available.
[    0.000000] On node 0 totalpages: 65408
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 0 pages, LIFO batch:0
[    0.000000]   Normal zone: 61312 pages, LIFO batch:15
[    0.000000]   HighMem zone: 0 pages, LIFO batch:0
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6cd0
[    0.000000] ACPI: RSDT (v001 SONY   C0       0x20010809 PTL  0x00000000) @ 0x0fefa88f
[    0.000000] ACPI: FADT (v001   SONY       C0 0x20010809 PTL  0x01000000) @ 0x0fefef64
[    0.000000] ACPI: BOOT (v001   SONY       C0 0x20010809 PTL  0x00000001) @ 0x0fefefd8
[    0.000000] ACPI: DSDT (v001   SONY       C0 0x20010809 PTL  0x0100000d) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] Allocating PCI resources starting at 20000000 (gap: 10000000:ef800000)
[    0.000000] Detected 994.266 MHz processor.
[   12.410522] Built 1 zonelists
[   12.410527] Local APIC disabled by BIOS -- reenabling.
[   12.410532] Found and enabled local APIC!
[   12.410538] mapped APIC to ffffd000 (fee00000)
[   12.410544] Enabling fast FPU save and restore... done.
[   12.410549] Enabling unmasked SIMD FPU exception support... done.
[   12.410555] Initializing CPU#0
[   12.410568] Kernel command line: root=/dev/hda1 ro vga=extended video=radeonfb:800x600-32@60 fbcon=font:Acorn8x8 lapic resume=/dev/hda2
[   12.411135] CPU 0 irqstacks, hard=c0418000 soft=c0419000
[   12.411143] PID hash table entries: 1024 (order: 10, 16384 bytes)
[   12.817018] Console: colour VGA+ 80x50
[   12.818471] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   12.819128] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   12.833814] Memory: 255104k/261632k available (2073k kernel code, 5908k reserved, 916k data, 152k init, 0k highmem)
[   12.833862] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   12.910722] Calibrating delay using timer specific routine.. 1989.93 BogoMIPS (lpj=3979867)
[   12.910873] Mount-cache hash table entries: 512
[   12.911086] CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
[   12.911100] CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
[   12.911116] CPU: L1 I cache: 16K, L1 D cache: 16K
[   12.911189] CPU: L2 cache: 512K
[   12.911230] CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
[   12.911241] Intel machine check architecture supported.
[   12.911286] Intel machine check reporting enabled on CPU#0.
[   12.911340] mtrr: v2.0 (20020519)
[   12.911386] CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
[   12.911492] Checking 'hlt' instruction... OK.
[   12.929066]  tbxface-0111 [02] load_tables           : ACPI Tables successfully acquired
[   12.941047] Parsing all Control Methods:
[   12.941593] Table [DSDT](id 0005) - 555 Objects with 54 Devices 191 Methods 21 Regions
[   12.941685] ACPI Namespace successfully loaded at root c044b278
[   12.975432] evxfevnt-0090 [03] enable                : Transition to ACPI mode successful
[   13.083137] NET: Registered protocol family 16
[   13.083210] ACPI: bus type pci registered
[   13.086771] PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
[   13.086822] PCI: Using configuration type 1
[   13.087094] ACPI: Subsystem revision 20060113
[   13.089056] evgpeblk-0933 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
[   13.089201] evgpeblk-0933 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on int 0x9
[   13.090767] evgpeblk-1029 [05] ev_initialize_gpe_bloc: Found 6 Wake, Enabled 0 Runtime GPEs in this block
[   13.091647] evgpeblk-1029 [05] ev_initialize_gpe_bloc: Found 1 Wake, Enabled 0 Runtime GPEs in this block
[   13.097051] Completing Region/Field/Buffer/Package initialization:..............................................................
[   13.104249] Initialized 20/21 Regions 0/0 Fields 25/25 Buffers 17/27 Packages (564 nodes)
[   13.104338] Executing all Device _STA and_INI methods:..........................................................
[   13.114485] 58 Devices found containing: 3 _STA, 3 _INI methods
[   13.114606] ACPI: Interpreter enabled
[   13.114648] ACPI: Using PIC for interrupt routing
[   13.116505] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   13.116551] PCI: Probing PCI hardware (bus 00)
[   13.154760] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
[   13.154809] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
[   13.154895] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   13.155139] Boot video device is 0000:01:00.0
[   13.155380] PCI: Transparent bridge - 0000:00:1e.0
[   13.155500] PCI: Bus #03 (-#06) may be hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
[   13.155609] PCI: Bus #07 (-#0a) may be hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
[   13.155696] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   13.173776] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[   13.176781] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
[   13.184021] ACPI: Embedded Controller [EC0] (gpe 28) interrupt mode.
[   13.228438] ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
[   13.229860] pci_link-0238 [09] pci_link_check_current: Resource isn't an IRQ
[   13.229968] ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
[   13.231454] pci_link-0238 [09] pci_link_check_current: Resource isn't an IRQ
[   13.231561] ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
[   13.233238] ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
[   13.234884] ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
[   13.236503] pci_link-0238 [09] pci_link_check_current: Resource isn't an IRQ
[   13.236610] ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0
[   13.238057] pci_link-0238 [09] pci_link_check_current: Resource isn't an IRQ
[   13.238165] ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
[   13.239663] pci_link-0238 [09] pci_link_check_current: Resource isn't an IRQ
[   13.239771] ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.
[   13.240543] Linux Plug and Play Support v0.97 (c) Adam Belay
[   13.240684] PCI: Using ACPI for IRQ routing
[   13.240728] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   13.245914] PCI: Bridge: 0000:00:01.0
[   13.245959]   IO window: 3000-3fff
[   13.246003]   MEM window: d0100000-d01fffff
[   13.246046]   PREFETCH window: d8000000-dfffffff
[   13.246108] PCI: Bus 3, cardbus bridge: 0000:02:05.0
[   13.246151]   IO window: 00004400-000044ff
[   13.246195]   IO window: 00004800-000048ff
[   13.246238]   PREFETCH window: 20000000-21ffffff
[   13.246283]   MEM window: 24000000-25ffffff
[   13.246326] PCI: Bus 7, cardbus bridge: 0000:02:05.1
[   13.246369]   IO window: 00004c00-00004cff
[   13.246413]   IO window: 00001400-000014ff
[   13.246473]   PREFETCH window: 22000000-23ffffff
[   13.246517]   MEM window: 26000000-27ffffff
[   13.246560] PCI: Bridge: 0000:00:1e.0
[   13.246602]   IO window: 4000-4fff
[   13.246647]   MEM window: d0200000-d02fffff
[   13.246690]   PREFETCH window: 20000000-23ffffff
[   13.246748] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   13.248087] ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
[   13.248135] PCI: setting IRQ 9 as level-triggered
[   13.248140] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKF] -> GSI 9 (level, low) -> IRQ 9
[   13.248255] PCI: Setting latency timer of device 0000:02:05.0 to 64
[   13.249554] ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
[   13.249599] ACPI: PCI Interrupt 0000:02:05.1[B] -> Link [LNKG] -> GSI 9 (level, low) -> IRQ 9
[   13.249714] PCI: Setting latency timer of device 0000:02:05.1 to 64
[   13.249807] Simple Boot Flag at 0x36 set to 0x1
[   13.249919] speedstep: frequency transition measured seems out of range (0 nSec), falling back to a safe one of 500000 nSec.
[   13.251300] Initializing Cryptographic API
[   13.251350] io scheduler noop registered
[   13.251427] io scheduler anticipatory registered
[   13.251503] io scheduler deadline registered
[   13.251591] io scheduler cfq registered
[   13.251880] acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
[   13.253411] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
[   13.253458] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[   13.262095] radeonfb: Retrieved PLL infos from BIOS
[   13.262142] radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=166.00 Mhz, System=166.00 MHz
[   13.262195] radeonfb: PLL min 12000 max 35000
[   14.197262] Non-DDC laptop panel detected
[   15.192430] radeonfb: Monitor 1 type LCD found
[   15.192473] radeonfb: Monitor 2 type no found
[   15.192521] radeonfb: panel ID string: Samsung LTN150P1-L02    
[   15.192566] radeonfb: detected LVDS panel size from BIOS: 1400x1050
[   15.192611] radeondb: BIOS provided dividers will be used
[   15.428232] radeonfb: Dynamic Clock Power Management enabled
[   15.700014] Console: switching to colour frame buffer device 100x75
[   15.700876] radeonfb (0000:01:00.0): ATI Radeon LY 
[   15.703422] ACPI: AC Adapter [ACAD] (on-line)
[   15.712433] ACPI: Battery Slot [BAT1] (battery present)
[   15.714762] ACPI: Battery Slot [BAT2] (battery absent)
[   15.714885] ACPI: Lid Switch [LID]
[   15.714972] ACPI: Power Button (CM) [PWRB]
[   15.715318] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   15.722466] ACPI: Thermal Zone [ATF0] (32 C)
[   15.722599] isapnp: Scanning for PnP cards...
[   16.076144] isapnp: No Plug & Play device found
[   16.112827] PNP: No PS/2 controller found. Probing ports directly.
[   16.114760] serio: i8042 AUX port at 0x60,0x64 irq 12
[   16.114951] serio: i8042 KBD port at 0x60,0x64 irq 1
[   16.115213] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   16.115378] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   16.115615] ICH3M: IDE controller at PCI slot 0000:00:1f.1
[   16.115730] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   16.115850]  pci_irq-0384 [02] pci_irq_derive        : Unable to derive IRQ for device 0000:00:1f.1
[   16.116049] ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI
[   16.116171] ICH3M: chipset revision 1
[   16.116246] ICH3M: not 100% native mode: will probe irqs later
[   16.116366]     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
[   16.116542]     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
[   16.116712] Probing IDE interface ide0...
[   16.126748] hda: FUJITSU MHV2080AH, ATA DISK drive
[   16.138085] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   16.144008] Probing IDE interface ide1...
[   16.154339] Probing IDE interface ide1...
[   16.164642] hda: max request size: 128KiB
[   16.170849] hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
[   16.176942] hda: cache flushes supported
[   16.182989]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
[   16.190007] mice: PS/2 mouse device common for all mice
[   16.196091] NET: Registered protocol family 2
[   16.203089] input: AT Translated Set 2 keyboard as /class/input/input0
[   16.209339] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   16.215706] TCP established hash table entries: 16384 (order: 4, 65536 bytes)
[   16.222074] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[   16.228457] TCP: Hash tables configured (established 16384 bind 16384)
[   16.234774] TCP reno registered
[   16.241210] TCP bic registered
[   16.247513] NET: Registered protocol family 1
[   16.253823] NET: Registered protocol family 17
[   16.260092] Using IPI Shortcut mode
[   16.295333] ACPI wakeup devices: 
[   16.301587] PWRB USB1 USB2 USB3 CRD0 CRD1  LAN  EC0 COMA MODE 
[   16.308019] ACPI: (supports S0 S3 S4 S5)
[   16.315008] ReiserFS: hda1: found reiserfs format "3.6" with standard journal
[   16.321676] Time: tsc clocksource has been installed.
[   16.327942] TSC clocksource: 994266 khz, rating=300 mult=4218493 shift=22
[   16.335692] check_periodic_interval: short interval! 751599 ns.
[   16.341946] 		bad calibration or timers may be broken.
[   16.348804] check_periodic_interval: short interval! 13123774 ns.
[   16.355035] 		bad calibration or timers may be broken.
[   16.361340] ReiserFS: hda1: using ordered data mode
[   16.367772] ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   16.383013] ReiserFS: hda1: checking transaction log (hda1)
[   16.390031] check_periodic_interval: short interval! 41260308 ns.
[   16.396555] 		bad calibration or timers may be broken.
[   16.403377] ReiserFS: hda1: Using r5 hash to sort names
[   16.409877] VFS: Mounted root (reiserfs filesystem) readonly.
[   16.416543] Freeing unused kernel memory: 152k freed
[   16.423208] check_periodic_interval: short interval! 33206471 ns.
[   16.429595] 		bad calibration or timers may be broken.
[   16.437094] check_periodic_interval: short interval! 13897048 ns.
[   16.443497] 		bad calibration or timers may be broken.
[   16.450426] check_periodic_interval: short interval! 13346943 ns.
[   16.456807] 		bad calibration or timers may be broken.
[   16.464487] check_periodic_interval: short interval! 14072404 ns.
[   16.470921] 		bad calibration or timers may be broken.
[   16.478931] check_periodic_interval: short interval! 14457901 ns.
[   16.485454] 		bad calibration or timers may be broken.
[   16.492877] check_periodic_interval: short interval! 13959022 ns.
[   16.499432] 		bad calibration or timers may be broken.
[   16.508801] check_periodic_interval: short interval! 15935332 ns.
[   16.515424] 		bad calibration or timers may be broken.
[   18.094914] Linux agpgart interface v0.101 (c) Dave Jones
[   18.111366] agpgart: Detected an Intel 830M Chipset.
[   18.133361] agpgart: AGP aperture is 256M @ 0xe0000000
[   18.150469] usbcore: registered new driver usbfs
[   18.157395] usbcore: registered new driver hub
[   18.177002] USB Universal Host Controller Interface driver v3.0
[   18.183960] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[   18.191260] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   18.191268] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   18.198506] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[   18.205596] uhci_hcd 0000:00:1d.0: irq 9, io base 0x00001800
[   18.212709] usb usb1: configuration #1 chosen from 1 choice
[   18.221127] hub 1-0:1.0: USB hub found
[   18.228084] hub 1-0:1.0: 2 ports detected
[   18.348201] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
[   18.355094] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
[   18.362024] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   18.362031] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   18.368958] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[   18.375987] uhci_hcd 0000:00:1d.1: irq 9, io base 0x00001820
[   18.382972] usb usb2: configuration #1 chosen from 1 choice
[   18.389918] hub 2-0:1.0: USB hub found
[   18.396769] hub 2-0:1.0: 2 ports detected
[   18.508091] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
[   18.514993] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
[   18.522196] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   18.522204] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   18.529129] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[   18.536053] uhci_hcd 0000:00:1d.2: irq 9, io base 0x00001840
[   18.543061] usb usb3: configuration #1 chosen from 1 choice
[   18.549987] hub 3-0:1.0: USB hub found
[   18.556835] hub 3-0:1.0: 2 ports detected
[   18.669785] PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
[   18.678203] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
[   18.684999] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
[   18.691910] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   18.782185] usb 2-1: new low speed USB device using uhci_hcd and address 2
[   18.967436] usb 2-1: configuration #1 chosen from 1 choice
[   19.061656] hw_random hardware driver 1.0.0 loaded
[   19.217866] usb 3-1: new full speed USB device using uhci_hcd and address 2
[   19.265818] intel8x0_measure_ac97_clock: measured 55491 usecs
[   19.272935] intel8x0: clocking to 48000
[   19.402275] usb 3-1: configuration #1 chosen from 1 choice
[   19.644085] e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
[   19.721917] input: Logitech USB Mouse as /class/input/input1
[   19.729407] input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1d.1-1
[   19.736752] usbcore: registered new driver usbhid
[   19.743975] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   20.150646] e100: Copyright(c) 1999-2005 Intel Corporation
[   20.158073] acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
[   20.167022] ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
[   20.174308] ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [LNKE] -> GSI 9 (level, low) -> IRQ 9
[   20.203916] e100: eth0: e100_probe: addr 0xd0204000, irq 9, MAC addr 08:00:46:26:50:59
[   20.318740] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKF] -> GSI 9 (level, low) -> IRQ 9
[   20.326185] Yenta: CardBus bridge found at 0000:02:05.0 [104d:80e7]
[   20.366384] SCSI subsystem initialized
[   20.386600] Initializing USB Mass Storage driver...
[   20.395040] scsi0 : SCSI emulation for USB Mass Storage devices
[   20.402616] usb-storage: device found at 2
[   20.402620] usb-storage: waiting for device to settle before scanning
[   20.402638] usbcore: registered new driver usb-storage
[   20.410002] USB Mass Storage support registered.
[   20.442816] Yenta: ISA IRQ mask 0x0cb8, PCI irq 9
[   20.450162] Socket status: 30000006
[   20.457470] pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
[   20.464947] cs: IO port probe 0x4000-0x4fff: clean.
[   20.472668] pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
[   20.480039] pcmcia: parent PCI bridge Memory window: 0x20000000 - 0x23ffffff
[   20.491777] ACPI: PCI Interrupt 0000:02:05.1[B] -> Link [LNKG] -> GSI 9 (level, low) -> IRQ 9
[   20.499356] Yenta: CardBus bridge found at 0000:02:05.1 [104d:80e7]
[   20.591299] Yenta: ISA IRQ mask 0x0cb8, PCI irq 9
[   20.598762] Socket status: 30000006
[   20.606081] pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
[   20.613455] cs: IO port probe 0x4000-0x4fff: clean.
[   20.621547] pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
[   20.628965] pcmcia: parent PCI bridge Memory window: 0x20000000 - 0x23ffffff
[   20.734449]   Vendor: Sony      Model: MSC-U02           Rev: 1.00
[   20.742514]   Type:   Direct-Access                      ANSI SCSI revision: 00
[   20.756973] usb-storage: device scan complete
[   20.782320] SCSI device sda: 7904 512-byte hdwr sectors (4 MB)
[   20.790561] sda: Write Protect is off
[   20.800389] sda: Mode Sense: 00 6a 10 00
[   20.800396] sda: assuming drive cache: write through
[   20.816778] SCSI device sda: 7904 512-byte hdwr sectors (4 MB)
[   20.853999] sda: Write Protect is off
[   20.861556] sda: Mode Sense: 00 6a 10 00
[   20.861561] sda: assuming drive cache: write through
[   20.869093]  sda: sda1
[   20.882927] sd 0:0:0:0: Attached scsi removable disk sda
[   21.162635] Adding 248996k swap on /dev/hda2.  Priority:-1 extents:1 across:248996k
[   21.389737] input: PC Speaker as /class/input/input2
[   21.490267] sonypi: Sony Programmable I/O Controller Driver v1.26.
[   21.502423] sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
[   21.515559] sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
[   21.522146] sonypi: device allocated minor is 63
[   21.543452] input: Sony Vaio Jogdial as /class/input/input3
[   21.583406] input: Sony Vaio Keys as /class/input/input4
[   21.639976] tun: Universal TUN/TAP device driver, 1.6
[   21.646600] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   21.674601] ACPI Sony Notebook Control Driver v0.2 successfully installed
[   21.700436] Real Time Clock Driver v1.12ac
[   21.746219] Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2548b1, caps: 0x804753/0x0
[   21.761542] input: SynPS/2 Synaptics TouchPad as /class/input/input5
[   21.788856] do_settimeofday() was called!
[   21.807042] do_settimeofday() was called!
[   21.983237] ReiserFS: hda3: found reiserfs format "3.6" with standard journal
[   22.003447] ReiserFS: hda3: using ordered data mode
[   22.009893] ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   22.024781] ReiserFS: hda3: checking transaction log (hda3)
[   22.031922] ReiserFS: hda3: Using r5 hash to sort names
[   22.061283] SGI XFS with ACLs, security attributes, no debug enabled
[   22.086044] XFS mounting filesystem hda6
[   22.096956] Ending clean XFS mount for filesystem: hda6
[   22.767135] do_settimeofday() was called!
[   32.135988] TSC: Marked unstable
[   32.142337]  <c0103c43> show_trace+0x13/0x20   <c0103c6e> dump_stack+0x1e/0x20
[   32.148756]  <c0108c17> mark_tsc_unstable+0x27/0x40   <c010908b> time_cpufreq_notifier+0x19b/0x1b0
[   32.161524]  <c01290fd> notifier_call_chain+0x2d/0x50   <c029d35c> cpufreq_notify_transition+0x13c/0x170
[   32.174549]  <c010d940> speedstep_target+0xd0/0xe0   <c029cf57> __cpufreq_driver_target+0x77/0x80
[   32.181252]  <d12035ee> do_dbs_timer+0x13e/0x200 [cpufreq_ondemand]   <c012c49a> run_workqueue+0x9a/0x140
[   32.194713]  <c012c737> worker_thread+0x107/0x140   <c012fd89> kthread+0xd9/0xe0
[   32.201583]  <c0101005> kernel_thread_helper+0x5/0x10  
[   43.612000] Time: acpi_pm clocksource has been installed.
[   45.876000] ip_tables: (C) 2000-2006 Netfilter Core Team
[   46.128000] ip_conntrack version 2.4 (2044 buckets, 16352 max) - 232 bytes per conntrack
[   46.504000] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   48.336000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

--sm4nu43k4a2Rpi4c--
