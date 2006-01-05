Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWAERft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWAERft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWAERft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:35:49 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:35509 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751322AbWAERfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:35:48 -0500
Date: Thu, 5 Jan 2006 18:32:03 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm1
Message-ID: <20060105173203.GA18970@ens-lyon.fr>
References: <20060105062249.4bc94697.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20060105062249.4bc94697.akpm@osdl.org>
X-Sieve: CMU Sieve 2.2
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 1/5/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm1/
>
>
> - ppc32 builds are broken
>
> - Fun new debug option CONFIG_DEBUG_SHIRQ will simulate a shared interrupt
>   arriving immediately after a driver does request_irq().  This broke one
>   driver for me and will probably break others.
>
>   Please try this option.  If it breaks anything, send the report and then
>   turn the option off.
>
>

No problem from DEBUG_SHIRQ, but:

I have things like: **** SET: Misaligned resource pointer: dfcf47c2 Type
07 Len 0
in my logs and a oops but X still started:

[   48.080000] [drm] Initialized drm 1.0.1 20051102
[   48.120000] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   48.120000] [drm] Initialized radeon 1.21.0 20051229 on minor 0
[   48.124000] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
[   48.124000] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[   48.124000] Unable to handle kernel NULL pointer dereference at virtual address 00000010
[   48.124000]  printing eip:
[   48.124000] c02628e4
[   48.124000] *pde = 1f3de067
[   48.124000] *pte = 00000000
[   48.124000] Oops: 0000 [#1]
[   48.124000] last sysfs file: /devices/pci0000:00/0000:00:1e.0/0000:02:03.0/rf_kill
[   48.124000] Modules linked in: radeon drm ipt_multiport ipt_state ipt_limit ipt_REJECT iptable_filter iptable_nat ip_nat ip_tables ip_conntrack_irc ip_conntrack_ftp ip_conntrack nfnetlink snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc speedstep_centrino cpufreq_stats freq_table cpufreq_conservative cpufreq_ondemand cpufreq_performance cpufreq_powersave fan button thermal processor battery ac uhci_hcd ehci_hcd usbcore tg3 ipw2200 ieee80211 ieee80211_crypt psmouse ide_cd cdrom
[   48.124000] CPU:    0
[   48.124000] EIP:    0060:[<c02628e4>]    Not tainted VLI
[   48.124000] EFLAGS: 00013202   (2.6.15-mm1-casaverde) 
[   48.124000] EIP is at agp_collect_device_status+0x14/0xd0
[   48.124000] eax: 00000058   ebx: df2a6ef0   ecx: 58000004   edx: df2a6e67
[   48.124000] esi: 1f000201   edi: dff248c0   ebp: df2a6ed4   esp: df2a6eb8
[   48.124000] ds: 007b   es: 007b   ss: 0068
[   48.124000] Process X (pid: 7051, threadinfo=df2a6000 task=de8b6a70)
[   48.124000] Stack: <0>00003246 1f000217 1f000201 1f000217 df2a6ef0 1f000201 dff248c0 df2a6f00 
[   48.124000]        <0>c0262b03 df2a6ef0 00000002 00000000 dff234ec df2a6efc 1f000217 df3c1800 
[   48.124000]        <0>00000032 def14b80 df2a6f08 c02631cd df2a6f14 e206ea80 df3c1800 df2a6f24 
[   48.124000] Call Trace:
[   48.124000]  [<c0103cfa>] show_stack+0x9a/0xc0
[   48.124000]  [<c0103e9d>] show_registers+0x15d/0x1e0
[   48.124000]  [<c01040a2>] die+0xe2/0x170
[   48.124000]  [<c011427d>] do_page_fault+0x25d/0x5ac
[   48.124000]  [<c01039b3>] error_code+0x4f/0x54
[   48.124000]  [<c0262b03>] agp_generic_enable+0x73/0x120
[   48.124000]  [<c02631cd>] agp_enable+0xd/0x10
[   48.124000]  [<e206ea80>] drm_agp_enable+0x30/0x50 [drm]
[   48.124000]  [<e206ead3>] drm_agp_enable_ioctl+0x33/0x40 [drm]
[   48.124000]  [<e206a677>] drm_ioctl+0x97/0x1f3 [drm]
[   48.124000]  [<c01656e7>] do_ioctl+0x67/0x70
[   48.124000]  [<c0165817>] vfs_ioctl+0x57/0x1b0
[   48.124000]  [<c01659a9>] sys_ioctl+0x39/0x60
[   48.124000]  [<c0102e9f>] sysenter_past_esp+0x54/0x75
[   48.124000] Code: c5 f9 ff 84 c0 88 45 fb 74 dd 0f b6 45 fb 59 5b 5d c3 90 8d 74 26 00 55 89 e5 57 56 53 83 ec 10 89 55 ec 89 4d e8 e8 ac ff ff ff <8b> 1d 10 00 00 00 8b 15 20 00 00 00 0f b6 c8 8d 45 f0 83 c1 04 
[   48.124000]  <3>[drm:drm_release] *ERROR* Device busy: 1 0

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.log"

[    0.000000] Linux version 2.6.15-mm1-casaverde (tonfa@casaverde) (gcc version 4.1.0-beta20051230 (prerelease)) #1 Thu Jan 5 16:34:41 CET 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001ffae000 (usable)
[    0.000000]  BIOS-e820: 000000001ffae000 - 0000000020000000 (reserved)
[    0.000000]  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] 511MB LOWMEM available.
[    0.000000] On node 0 totalpages: 130990
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 0 pages, LIFO batch:0
[    0.000000]   Normal zone: 126894 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:0
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 DELL                                  ) @ 0x000fdf00
[    0.000000] ACPI: RSDT (v001 DELL    CPi R   0x27d5011a ASL  0x00000061) @ 0x1fff0000
[    0.000000] ACPI: FADT (v001 DELL    CPi R   0x27d5011a ASL  0x00000061) @ 0x1fff0400
[    0.000000] ACPI: ASF! (v016 DELL    CPi R   0x27d5011a ASL  0x00000061) @ 0x1fff0800
[    0.000000] ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000:deda0000)
[    0.000000] Detected 1598.740 MHz processor.
[    9.987406] Built 1 zonelists
[    9.987410] Local APIC disabled by BIOS -- you can enable it with "lapic"
[    9.987417] mapped APIC to ffffd000 (01401000)
[    9.987421] Enabling fast FPU save and restore... done.
[    9.987423] Enabling unmasked SIMD FPU exception support... done.
[    9.987426] Initializing CPU#0
[    9.987434] Kernel command line: root=/dev/hda5 video=vesa:mtrr vga=0x317 resume=/dev/hda3
[    9.987701] CPU 0 irqstacks, hard=c03f3000 soft=c03f2000
[    9.987705] PID hash table entries: 2048 (order: 11, 32768 bytes)
[   10.380855] Console: colour dummy device 80x25
[   10.381515] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   10.382278] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   10.396504] Memory: 515232k/523960k available (2143k kernel code, 8204k reserved, 666k data, 180k init, 0k highmem)
[   10.396517] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   10.475320] Calibrating delay using timer specific routine.. 3199.32 BogoMIPS (lpj=6398651)
[   10.475361] Mount-cache hash table entries: 512
[   10.475458] CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
[   10.475466] CPU: After vendor identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
[   10.475474] CPU: L1 I cache: 32K, L1 D cache: 32K
[   10.475480] CPU: L2 cache: 2048K
[   10.475484] CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
[   10.475490] Intel machine check architecture supported.
[   10.475496] Intel machine check reporting enabled on CPU#0.
[   10.475506] mtrr: v2.0 (20020519)
[   10.475513] CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 06
[   10.475520] Checking 'hlt' instruction... OK.
[   10.499368] ACPI: setting ELCR to 0200 (from 0800)
[   10.501966] NET: Registered protocol family 16
[   10.501990] ACPI: bus type pci registered
[   10.501997] PCI: Using configuration type 1
[   10.502114] ACPI: Subsystem revision 20051216
[   10.512501] ACPI: Interpreter enabled
[   10.512506] ACPI: Using PIC for interrupt routing
[   10.513699] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   10.513826] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   10.524396] PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
[   10.524402] PCI quirk: region 0880-08bf claimed by ICH4 GPIO
[   10.524447] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   10.524556] Boot video device is 0000:01:00.0
[   10.524787] PCI: Transparent bridge - 0000:00:1e.0
[   10.524844] PCI: Bus #03 (-#06) may be hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
[   10.524881] PCI: Bus #07 (-#0a) may be hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
[   10.524900] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   10.545689] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
[   10.545933] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
[   10.546175] ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
[   10.546416] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
[   10.546644] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   10.546889] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   10.548103] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[   10.548801] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
[   10.549645] Linux Plug and Play Support v0.97 (c) Adam Belay
[   10.549654] pnp: PnP ACPI init
[   10.554658] pnp: PnPACPI: unknown resource type 7
[   10.554663] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c01
[   10.559547] pnp: PnPACPI: unknown resource type 7
[   10.559551] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0a03
[   10.559586] pnp: PnPACPI: unknown resource type 7
[   10.559590] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c01
[   10.559623] pnp: PnPACPI: unknown resource type 7
[   10.559627] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c01
[   10.559660] pnp: PnPACPI: unknown resource type 7
[   10.559663] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0f13
[   10.559695] pnp: PnPACPI: unknown resource type 7
[   10.559699] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0303
[   10.559730] pnp: PnPACPI: unknown resource type 7
[   10.559734] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0b00
[   10.559768] pnp: PnPACPI: unknown resource type 7
[   10.559771] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0800
[   10.559802] pnp: PnPACPI: unknown resource type 7
[   10.559806] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c01
[   10.559841] pnp: PnPACPI: unknown resource type 7
[   10.559844] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0200
[   10.559875] pnp: PnPACPI: unknown resource type 7
[   10.559879] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c04
[   10.570269] pnp: PnPACPI: unknown resource type 7
[   10.570273] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0401
[   10.572926] pnp: PnP ACPI: found 0 devices
[   10.572964] Generic PHY: Registered new driver
[   10.573059] SCSI subsystem initialized
[   10.573092] PCI: Using ACPI for IRQ routing
[   10.573097] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   10.578314] PCI: Bridge: 0000:00:01.0
[   10.578319]   IO window: c000-cfff
[   10.578324]   MEM window: fc000000-fdffffff
[   10.578329]   PREFETCH window: e8000000-efffffff
[   10.578342] PCI: Bus 3, cardbus bridge: 0000:02:01.0
[   10.578346]   IO window: 0000d000-0000d0ff
[   10.578351]   IO window: 0000d400-0000d4ff
[   10.578356]   PREFETCH window: 30000000-31ffffff
[   10.578362]   MEM window: f6000000-f7ffffff
[   10.578367] PCI: Bus 7, cardbus bridge: 0000:02:01.1
[   10.578371]   IO window: 0000d800-0000d8ff
[   10.578376]   IO window: 0000dc00-0000dcff
[   10.578381]   PREFETCH window: 32000000-33ffffff
[   10.578386]   MEM window: f8000000-f9ffffff
[   10.578391] PCI: Bridge: 0000:00:1e.0
[   10.578396]   IO window: d000-efff
[   10.578402]   MEM window: f6000000-fbffffff
[   10.578407]   PREFETCH window: 30000000-33ffffff
[   10.578423] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   10.578435] PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
[   10.578444] **** SET: Misaligned resource pointer: dfe57e82 Type 07 Len 0
[   10.578617] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[   10.578622] PCI: setting IRQ 11 as level-triggered
[   10.578625] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   10.578644] PCI: Enabling device 0000:02:01.1 (0000 -> 0003)
[   10.578649] ACPI: PCI Interrupt 0000:02:01.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   10.579210] Initializing Cryptographic API
[   10.579215] io scheduler noop registered
[   10.579222] io scheduler anticipatory registered
[   10.579227] io scheduler deadline registered
[   10.579268] io scheduler cfq registered
[   10.579389] **** SET: Misaligned resource pointer: dfe57dc2 Type 07 Len 0
[   10.579566] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[   10.579570] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   10.579610] radeonfb: Retrieved PLL infos from BIOS
[   10.579615] radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=220.00 Mhz, System=200.00 MHz
[   10.579620] radeonfb: PLL min 20000 max 35000
[   10.599223] Time: tsc clocksource has been installed.
[   11.514500] Non-DDC laptop panel detected
[   12.450756] radeonfb: Monitor 1 type LCD found
[   12.450760] radeonfb: Monitor 2 type no found
[   12.450765] radeonfb: panel ID string: 6J5644141XB
[   12.450766]             
[   12.450771] radeonfb: detected LVDS panel size from BIOS: 1024x768
[   12.450775] radeondb: BIOS provided dividers will be used
[   12.569662] radeonfb: Dynamic Clock Power Management enabled
[   12.599536] Console: switching to colour frame buffer device 128x48
[   12.600591] radeonfb (0000:01:00.0): ATI Radeon Lf 
[   12.600781] vesafb: cannot reserve video memory at 0xe8000000
[   12.600860] vesafb: framebuffer at 0xe8000000, mapped to 0xe1900000, using 3072k, total 32704k
[   12.600959] vesafb: mode is 1024x768x16, linelength=2048, pages=20
[   12.601036] vesafb: protected mode interface info at c000:57f3
[   12.601108] vesafb: scrolling: redraw
[   12.601159] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   12.601273] fb1: VESA VGA frame buffer device
[   12.614963] Real Time Clock Driver v1.12
[   12.615044] Linux agpgart interface v0.101 (c) Dave Jones
[   12.615145] agpgart: Detected an Intel 855PM Chipset.
[   12.623741] agpgart: AGP aperture is 128M @ 0xe0000000
[   12.623925] PNP: No PS/2 controller found. Probing ports directly.
[   12.627911] serio: i8042 AUX port at 0x60,0x64 irq 12
[   12.628238] serio: i8042 KBD port at 0x60,0x64 irq 1
[   15.639233] floppy0: no floppy controllers found
[   15.639579] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   15.639803] loop: loaded (max 8 devices)
[   15.643296] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   15.646704] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   15.650199] ICH4: IDE controller at PCI slot 0000:00:1f.1
[   15.653705] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   15.657254] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   15.660992] ICH4: chipset revision 1
[   15.664766] ICH4: not 100% native mode: will probe irqs later
[   15.668529]     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
[   15.672334]     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
[   15.676104] Probing IDE interface ide0...
[   15.963130] hda: TOSHIBA MK4026GAX, ATA DISK drive
[   16.634513] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   16.638214] Probing IDE interface ide1...
[   17.374013] hdc: SAMSUNG CDRW/DVD SN-324S, ATAPI CD/DVD-ROM drive
[   18.045878] ide1 at 0x170-0x177,0x376 on irq 15
[   18.049945] hda: max request size: 128KiB
[   18.101875] hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
[   18.105623] hda: cache flushes supported
[   18.109298]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
[   18.147966] mice: PS/2 mouse device common for all mice
[   18.151700] i2c /dev entries driver
[   18.156263] NET: Registered protocol family 2
[   18.165147] input: AT Translated Set 2 keyboard as /class/input/input0
[   18.197245] IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
[   18.201127] TCP established hash table entries: 32768 (order: 5, 131072 bytes)
[   18.205023] TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
[   18.208906] TCP: Hash tables configured (established 32768 bind 32768)
[   18.212640] TCP reno registered
[   18.216422] TCP bic registered
[   18.220053] NET: Registered protocol family 1
[   18.223638] NET: Registered protocol family 17
[   18.227186] Using IPI Shortcut mode
[   18.248681] ACPI wakeup devices: 
[   18.252199]  LID PBTN PCI0 USB0 USB1 USB2 USB3 MODM PCIE 
[   18.255941] ACPI: (supports S0 S1 S3 S4 S5)
[   18.270235] ReiserFS: hda5: found reiserfs format "3.6" with standard journal
[   19.133065] ReiserFS: hda5: using ordered data mode
[   19.150573] ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   19.158796] ReiserFS: hda5: checking transaction log (hda5)
[   19.215177] ReiserFS: hda5: Using r5 hash to sort names
[   19.219201] VFS: Mounted root (reiserfs filesystem) readonly.
[   19.223336] Freeing unused kernel memory: 180k freed
[   19.227296] Write protecting the kernel read-only data: 301k
[   23.179416] Adding 979956k swap on /dev/hda3.  Priority:-1 extents:1 across:979956k
[   27.355149] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   27.355158] Uniform CD-ROM driver Revision: 3.20
[   27.473492] ieee80211_crypt: registered algorithm 'NULL'
[   27.504276] ieee80211: 802.11 data/management/control stack, git-1.1.7
[   27.504280] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   27.583759] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
[   27.583764] ipw2200: Copyright(c) 2003-2005 Intel Corporation
[   27.583847] **** SET: Misaligned resource pointer: dfcf4dc2 Type 07 Len 0
[   27.584088] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
[   27.584091] PCI: setting IRQ 5 as level-triggered
[   27.584095] ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[   27.584567] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[   27.883534] tg3.c:v3.47 (Dec 28, 2005)
[   27.883568] **** SET: Misaligned resource pointer: dfcf4dc2 Type 07 Len 0
[   27.883809] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[   27.883813] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   27.913772] eth0: Tigon3 [partno(BCM95705A50) rev 3001 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0f:1f:ca:d7:a8
[   27.913779] eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[   27.913782] eth0: dma_rwctrl[763f0000]
[   28.061435] input: DualPoint Stick as /class/input/input1
[   28.084230] input: AlpsPS/2 ALPS DualPoint TouchPad as /class/input/input2
[   28.234541] usbcore: registered new driver usbfs
[   28.234565] usbcore: registered new driver hub
[   28.275293] **** SET: Misaligned resource pointer: dfcf47c2 Type 07 Len 0
[   28.275532] ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
[   28.275536] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
[   28.275551] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   28.275554] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   28.275585] ehci_hcd 0000:00:1d.7: debug port 1
[   28.275595] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   28.275823] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   28.275832] ehci_hcd 0000:00:1d.7: irq 11, io mem 0xf4fffc00
[   28.279712] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   28.279763] usb usb1: configuration #1 chosen from 1 choice
[   28.279785] hub 1-0:1.0: USB hub found
[   28.279791] hub 1-0:1.0: 6 ports detected
[   28.408672] USB Universal Host Controller Interface driver v3.0
[   28.408725] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   28.408738] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   28.408742] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   28.408780] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   28.408791] uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
[   28.408861] usb usb2: configuration #1 chosen from 1 choice
[   28.408881] hub 2-0:1.0: USB hub found
[   28.408887] hub 2-0:1.0: 2 ports detected
[   28.509116] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   28.509130] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   28.509134] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   28.509166] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   28.509175] uhci_hcd 0000:00:1d.1: irq 11, io base 0x0000bf40
[   28.509237] usb usb3: configuration #1 chosen from 1 choice
[   28.509261] hub 3-0:1.0: USB hub found
[   28.509267] hub 3-0:1.0: 2 ports detected
[   28.617761] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   28.617776] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   28.617780] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   28.617813] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   28.617824] uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
[   28.617892] usb usb4: configuration #1 chosen from 1 choice
[   28.617912] hub 4-0:1.0: USB hub found
[   28.617918] hub 4-0:1.0: 2 ports detected
[   28.988199] ACPI: AC Adapter [AC] (on-line)
[   29.340433] ACPI: Battery Slot [BAT0] (battery present)
[   29.340503] ACPI: Battery Slot [BAT1] (battery absent)
[   29.822404] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
[   29.822411] ACPI: Processor [CPU0] (supports 8 throttling states)
[   29.869819] ACPI: Thermal Zone [THM] (52 C)
[   29.909177] ACPI: Lid Switch [LID]
[   29.909186] ACPI: Power Button (CM) [PBTN]
[   29.909193] ACPI: Sleep Button (CM) [SBTN]
[   38.539257] kjournald starting.  Commit interval 5 seconds
[   38.539269] EXT3-fs: mounted filesystem with ordered data mode.
[   38.567512] ReiserFS: hda6: found reiserfs format "3.6" with standard journal
[   40.641987] ReiserFS: hda6: using ordered data mode
[   40.666928] ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   40.667364] ReiserFS: hda6: checking transaction log (hda6)
[   40.710345] ReiserFS: hda6: Using r5 hash to sort names
[   30.800000] Time: acpi_pm clocksource has been installed.
[   36.956000] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[   36.956000] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   37.776000] intel8x0_measure_ac97_clock: measured 55320 usecs
[   37.776000] intel8x0: clocking to 48000
[   39.524000] Netfilter messages via NETLINK v0.30.
[   39.608000] ip_conntrack version 2.4 (4093 buckets, 32744 max) - 216 bytes per conntrack
[   39.780000] ip_tables: (C) 2000-2002 Netfilter core team
[   40.596000] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   40.596000] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   40.596000] ide: failed opcode was: 0xec
[   40.604000] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   40.604000] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   40.604000] ide: failed opcode was: 0xec
[   40.612000] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   40.612000] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   40.612000] ide: failed opcode was: 0xec
[   48.080000] [drm] Initialized drm 1.0.1 20051102
[   48.120000] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   48.120000] [drm] Initialized radeon 1.21.0 20051229 on minor 0
[   48.124000] mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x2000000
[   48.124000] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[   48.124000] Unable to handle kernel NULL pointer dereference at virtual address 00000010
[   48.124000]  printing eip:
[   48.124000] c02628e4
[   48.124000] *pde = 1f3de067
[   48.124000] *pte = 00000000
[   48.124000] Oops: 0000 [#1]
[   48.124000] last sysfs file: /devices/pci0000:00/0000:00:1e.0/0000:02:03.0/rf_kill
[   48.124000] Modules linked in: radeon drm ipt_multiport ipt_state ipt_limit ipt_REJECT iptable_filter iptable_nat ip_nat ip_tables ip_conntrack_irc ip_conntrack_ftp ip_conntrack nfnetlink snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc speedstep_centrino cpufreq_stats freq_table cpufreq_conservative cpufreq_ondemand cpufreq_performance cpufreq_powersave fan button thermal processor battery ac uhci_hcd ehci_hcd usbcore tg3 ipw2200 ieee80211 ieee80211_crypt psmouse ide_cd cdrom
[   48.124000] CPU:    0
[   48.124000] EIP:    0060:[<c02628e4>]    Not tainted VLI
[   48.124000] EFLAGS: 00013202   (2.6.15-mm1-casaverde) 
[   48.124000] EIP is at agp_collect_device_status+0x14/0xd0
[   48.124000] eax: 00000058   ebx: df2a6ef0   ecx: 58000004   edx: df2a6e67
[   48.124000] esi: 1f000201   edi: dff248c0   ebp: df2a6ed4   esp: df2a6eb8
[   48.124000] ds: 007b   es: 007b   ss: 0068
[   48.124000] Process X (pid: 7051, threadinfo=df2a6000 task=de8b6a70)
[   48.124000] Stack: <0>00003246 1f000217 1f000201 1f000217 df2a6ef0 1f000201 dff248c0 df2a6f00 
[   48.124000]        <0>c0262b03 df2a6ef0 00000002 00000000 dff234ec df2a6efc 1f000217 df3c1800 
[   48.124000]        <0>00000032 def14b80 df2a6f08 c02631cd df2a6f14 e206ea80 df3c1800 df2a6f24 
[   48.124000] Call Trace:
[   48.124000]  [<c0103cfa>] show_stack+0x9a/0xc0
[   48.124000]  [<c0103e9d>] show_registers+0x15d/0x1e0
[   48.124000]  [<c01040a2>] die+0xe2/0x170
[   48.124000]  [<c011427d>] do_page_fault+0x25d/0x5ac
[   48.124000]  [<c01039b3>] error_code+0x4f/0x54
[   48.124000]  [<c0262b03>] agp_generic_enable+0x73/0x120
[   48.124000]  [<c02631cd>] agp_enable+0xd/0x10
[   48.124000]  [<e206ea80>] drm_agp_enable+0x30/0x50 [drm]
[   48.124000]  [<e206ead3>] drm_agp_enable_ioctl+0x33/0x40 [drm]
[   48.124000]  [<e206a677>] drm_ioctl+0x97/0x1f3 [drm]
[   48.124000]  [<c01656e7>] do_ioctl+0x67/0x70
[   48.124000]  [<c0165817>] vfs_ioctl+0x57/0x1b0
[   48.124000]  [<c01659a9>] sys_ioctl+0x39/0x60
[   48.124000]  [<c0102e9f>] sysenter_past_esp+0x54/0x75
[   48.124000] Code: c5 f9 ff 84 c0 88 45 fb 74 dd 0f b6 45 fb 59 5b 5d c3 90 8d 74 26 00 55 89 e5 57 56 53 83 ec 10 89 55 ec 89 4d e8 e8 ac ff ff ff <8b> 1d 10 00 00 00 8b 15 20 00 00 00 0f b6 c8 8d 45 f0 83 c1 04 
[   48.124000]  <3>[drm:drm_release] *ERROR* Device busy: 1 0
[ 1493.336000] ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40

--WIyZ46R2i8wDzkSu
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--WIyZ46R2i8wDzkSu--
