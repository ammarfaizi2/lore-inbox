Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWADXlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWADXlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWADXlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:41:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:41634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750734AbWADXlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:41:36 -0500
Date: Wed, 4 Jan 2006 15:39:19 -0800
From: Greg KH <gregkh@suse.de>
To: ak@suse.de
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Clock going way too fast on 2.6.15 for amd64 processor
Message-ID: <20060104233919.GA15724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried digging through the mess in
	http://bugzilla.kernel.org/show_bug.cgi?id=3927
but got lost in a see of conflicting patches.

I too have a amd64 box that is showing that the clock is running way too
fast (feels about double speed, haven't checked for sure.)  I'm running
it in 32bit mode for now, and the boot dmesg is below.

Any hints on patches that I should test out to try to track this down?
I haven't run any real old kernels on it to see if it is something new
(shows up on a 2.6.13 and 2.6.14 kernel too.)

thanks,

greg k-h


[4294667.296000] Linux version 2.6.15 (greg@blue) (gcc version 3.4.5 (Gentoo 3.4.5, ssp-3.4.5-1.0, pie-8.7.9)) #4 Wed Jan 4 17:55:00 PST 2006
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[4294667.296000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000001bf40000 (usable)
[4294667.296000]  BIOS-e820: 000000001bf40000 - 000000001bf50000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000001bf50000 - 000000001c000000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 000000001c000000 - 0000000020000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[4294667.296000] 447MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 114496
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:0
[4294667.296000]   DMA32 zone: 0 pages, LIFO batch:0
[4294667.296000]   Normal zone: 110400 pages, LIFO batch:31
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:0
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: RSDP (v000 MSI                                   ) @ 0x000f8400
[4294667.296000] ACPI: RSDT (v001 MSI    1013     0x10262005 MSFT 0x00000097) @ 0x1bf40000
[4294667.296000] ACPI: FADT (v002 MSI    1013     0x10262005 MSFT 0x00000097) @ 0x1bf40200
[4294667.296000] ACPI: MADT (v001 MSI    OEMAPIC  0x10262005 MSFT 0x00000097) @ 0x1bf40300
[4294667.296000] ACPI: WDRT (v001 MSI    MSI_OEM  0x10262005 MSFT 0x00000097) @ 0x1bf40360
[4294667.296000] ACPI: MCFG (v001 MSI    OEMMCFG  0x10262005 MSFT 0x00000097) @ 0x1bf403b0
[4294667.296000] ACPI: SSDT (v001 OEM_ID OEMTBLID 0x00000001 INTL 0x02002026) @ 0x1bf43700
[4294667.296000] ACPI: OEMB (v001 MSI    MSI_OEM  0x10262005 MSFT 0x00000097) @ 0x1bf50040
[4294667.296000] ACPI: DSDT (v001    MSI     1013 0x10262005 INTL 0x02002026) @ 0x00000000
[4294667.296000] ACPI: Local APIC address 0xfee00000
[4294667.296000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 15:4 APIC version 16
[4294667.296000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[4294667.296000] IOAPIC[0]: apic_id 1, version 33, address 0xfec00000, GSI 0-23
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
[4294667.296000] ACPI: IRQ0 used by override.
[4294667.296000] ACPI: IRQ2 used by override.
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Using ACPI (MADT) for SMP configuration information
[4294667.296000] Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/hda2 resume=dev/hda3 vga=0x0305
[4294667.296000] mapped APIC to ffffd000 (fee00000)
[4294667.296000] mapped IOAPIC to ffffc000 (fec00000)
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 1593.023 MHz processor.
[   38.370159] Using tsc for high-res timesource
[   38.370185] Console: colour dummy device 80x25
[   38.370545] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   38.370860] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   38.379581] Memory: 450412k/457984k available (1926k kernel code, 7096k reserved, 715k data, 172k init, 0k highmem)
[   38.379590] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   38.439379] Calibrating delay using timer specific routine.. 3188.30 BogoMIPS (lpj=1594152)
[   38.439419] Mount-cache hash table entries: 512
[   38.439495] CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
[   38.439501] CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
[   38.439508] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   38.439513] CPU: L2 Cache: 512K (64 bytes/line)
[   38.439516] CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000010 00000001 00000000 00000001
[   38.439530] mtrr: v2.0 (20020519)
[   38.439535] CPU: AMD Turion(tm) 64 Mobile Technology MT-28 stepping 02
[   38.439541] Enabling fast FPU save and restore... done.
[   38.439545] Enabling unmasked SIMD FPU exception support... done.
[   38.439550] Checking 'hlt' instruction... OK.
[   38.450674] ENABLING IO-APIC IRQs
[   38.450861] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   38.562406] NET: Registered protocol family 16
[   38.562426] ACPI: bus type pci registered
[   38.562818] PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
[   38.562824] PCI: Using MMCONFIG
[   38.563232] ACPI: Subsystem revision 20050902
[   38.567625] ACPI: Interpreter enabled
[   38.567630] ACPI: Using IOAPIC for interrupt routing
[   38.567888] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   38.567894] PCI: Probing PCI hardware (bus 00)
[   38.568710] PCI: Scanning bus 0000:00
[   38.568719] PCI: Found 0000:00:00.0 [1002/5950] 000600 00
[   38.568730] PCI: Calling quirk c01e3800 for 0000:00:00.0
[   38.568733] PCI: Calling quirk c026d830 for 0000:00:00.0
[   38.568736] PCI: Calling quirk c026dc40 for 0000:00:00.0
[   38.568745] PCI: Found 0000:00:01.0 [1002/5a3f] 000604 01
[   38.568750] PCI: Calling quirk c01e3800 for 0000:00:01.0
[   38.568753] PCI: Calling quirk c026d830 for 0000:00:01.0
[   38.568755] PCI: Calling quirk c026dc40 for 0000:00:01.0
[   38.568809] PCI: Found 0000:00:13.0 [1002/4374] 000c03 00
[   38.568853] PCI: Calling quirk c01e3800 for 0000:00:13.0
[   38.568855] PCI: Calling quirk c026d830 for 0000:00:13.0
[   38.568857] PCI: Calling quirk c026dc40 for 0000:00:13.0
[   38.568878] PCI: Found 0000:00:13.1 [1002/4375] 000c03 00
[   38.568921] PCI: Calling quirk c01e3800 for 0000:00:13.1
[   38.568924] PCI: Calling quirk c026d830 for 0000:00:13.1
[   38.568926] PCI: Calling quirk c026dc40 for 0000:00:13.1
[   38.568953] PCI: Found 0000:00:13.2 [1002/4373] 000c03 00
[   38.568997] PCI: Calling quirk c01e3800 for 0000:00:13.2
[   38.568999] PCI: Calling quirk c026d830 for 0000:00:13.2
[   38.569002] PCI: Calling quirk c026dc40 for 0000:00:13.2
[   38.569033] PCI: Found 0000:00:14.0 [1002/4372] 000c05 00
[   38.569074] PCI: Calling quirk c01e3800 for 0000:00:14.0
[   38.569076] PCI: Calling quirk c026d830 for 0000:00:14.0
[   38.569078] PCI: Calling quirk c026dc40 for 0000:00:14.0
[   38.569126] PCI: Found 0000:00:14.1 [1002/4376] 000101 00
[   38.569168] PCI: Calling quirk c01e3800 for 0000:00:14.1
[   38.569171] PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
[   38.569176] PCI: Calling quirk c026d830 for 0000:00:14.1
[   38.569178] PCI: Calling quirk c026dc40 for 0000:00:14.1
[   38.569192] PCI: Found 0000:00:14.3 [1002/4377] 000601 00
[   38.569233] PCI: Calling quirk c01e3800 for 0000:00:14.3
[   38.569236] PCI: Calling quirk c026d830 for 0000:00:14.3
[   38.569238] PCI: Calling quirk c026dc40 for 0000:00:14.3
[   38.569251] PCI: Found 0000:00:14.4 [1002/4371] 000604 01
[   38.569267] PCI: Calling quirk c01e3800 for 0000:00:14.4
[   38.569270] PCI: Calling quirk c026d830 for 0000:00:14.4
[   38.569272] PCI: Calling quirk c026dc40 for 0000:00:14.4
[   38.569294] PCI: Found 0000:00:14.5 [1002/4370] 000401 00
[   38.569336] PCI: Calling quirk c01e3800 for 0000:00:14.5
[   38.569339] PCI: Calling quirk c026d830 for 0000:00:14.5
[   38.569341] PCI: Calling quirk c026dc40 for 0000:00:14.5
[   38.569362] PCI: Found 0000:00:14.6 [1002/4378] 000703 00
[   38.569405] PCI: Calling quirk c01e3800 for 0000:00:14.6
[   38.569407] PCI: Calling quirk c026d830 for 0000:00:14.6
[   38.569410] PCI: Calling quirk c026dc40 for 0000:00:14.6
[   38.569425] PCI: Found 0000:00:18.0 [1022/1100] 000600 00
[   38.569437] PCI: Calling quirk c01e3800 for 0000:00:18.0
[   38.569440] PCI: Calling quirk c026d830 for 0000:00:18.0
[   38.569442] PCI: Calling quirk c026dc40 for 0000:00:18.0
[   38.569448] PCI: Found 0000:00:18.1 [1022/1101] 000600 00
[   38.569460] PCI: Calling quirk c01e3800 for 0000:00:18.1
[   38.569462] PCI: Calling quirk c026d830 for 0000:00:18.1
[   38.569465] PCI: Calling quirk c026dc40 for 0000:00:18.1
[   38.569471] PCI: Found 0000:00:18.2 [1022/1102] 000600 00
[   38.569482] PCI: Calling quirk c01e3800 for 0000:00:18.2
[   38.569485] PCI: Calling quirk c026d830 for 0000:00:18.2
[   38.569487] PCI: Calling quirk c026dc40 for 0000:00:18.2
[   38.569493] PCI: Found 0000:00:18.3 [1022/1103] 000600 00
[   38.569505] PCI: Calling quirk c01e3800 for 0000:00:18.3
[   38.569507] PCI: Calling quirk c026d830 for 0000:00:18.3
[   38.569510] PCI: Calling quirk c026dc40 for 0000:00:18.3
[   38.569527] PCI: Fixups for bus 0000:00
[   38.569531] PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
[   38.569553] PCI: Scanning bus 0000:01
[   38.569565] PCI: Found 0000:01:05.0 [1002/5955] 000300 00
[   38.569575] PCI: Calling quirk c01e3800 for 0000:01:05.0
[   38.569578] PCI: Calling quirk c026d830 for 0000:01:05.0
[   38.569580] PCI: Calling quirk c026dc40 for 0000:01:05.0
[   38.569584] Boot video device is 0000:01:05.0
[   38.569605] PCI: Fixups for bus 0000:01
[   38.569611] PCI: Bus scan for 0000:01 returning with max=01
[   38.569617] PCI: Scanning behind PCI bridge 0000:00:14.4, config 030200, pass 0
[   38.569637] PCI: Scanning bus 0000:02
[   38.569669] PCI: Found 0000:02:03.0 [10ec/8139] 000200 00
[   38.569725] PCI: Calling quirk c01e3800 for 0000:02:03.0
[   38.569728] PCI: Calling quirk c026d830 for 0000:02:03.0
[   38.569730] PCI: Calling quirk c026dc40 for 0000:02:03.0
[   38.569760] PCI: Found 0000:02:05.0 [1217/7134] 000607 02
[   38.569777] PCI: Calling quirk c01e3800 for 0000:02:05.0
[   38.569779] PCI: Calling quirk c026d830 for 0000:02:05.0
[   38.569782] PCI: Calling quirk c026dc40 for 0000:02:05.0
[   38.569810] PCI: Found 0000:02:05.2 [1217/7120] 000805 00
[   38.569867] PCI: Calling quirk c01e3800 for 0000:02:05.2
[   38.569869] PCI: Calling quirk c026d830 for 0000:02:05.2
[   38.569872] PCI: Calling quirk c026dc40 for 0000:02:05.2
[   38.569898] PCI: Found 0000:02:05.3 [1217/7130] 000680 00
[   38.569955] PCI: Calling quirk c01e3800 for 0000:02:05.3
[   38.569958] PCI: Calling quirk c026d830 for 0000:02:05.3
[   38.569960] PCI: Calling quirk c026dc40 for 0000:02:05.3
[   38.569985] PCI: Found 0000:02:05.4 [1217/00f7] 000c00 00
[   38.570040] PCI: Calling quirk c01e3800 for 0000:02:05.4
[   38.570042] PCI: Calling quirk c026d830 for 0000:02:05.4
[   38.570045] PCI: Calling quirk c026dc40 for 0000:02:05.4
[   38.570112] PCI: Found 0000:02:09.0 [1814/0302] 000280 00
[   38.570168] PCI: Calling quirk c01e3800 for 0000:02:09.0
[   38.570170] PCI: Calling quirk c026d830 for 0000:02:09.0
[   38.570173] PCI: Calling quirk c026dc40 for 0000:02:09.0
[   38.570225] PCI: Fixups for bus 0000:02
[   38.570227] PCI: Transparent bridge - 0000:00:14.4
[   38.570247] PCI: Scanning behind PCI bridge 0000:02:05.0, config 030302, pass 0
[   38.570263] PCI: Scanning behind PCI bridge 0000:02:05.0, config 030302, pass 1
[   38.570294] PCI: Bus scan for 0000:02 returning with max=06
[   38.570299] PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
[   38.570307] PCI: Scanning behind PCI bridge 0000:00:14.4, config 030200, pass 1
[   38.570314] PCI: Bus scan for 0000:00 returning with max=06
[   38.570321] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   38.577689] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[   38.578407] ACPI: Embedded Controller [EC] (gpe 6)
[   38.585036] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.POP2._PRT]
[   38.587138] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
[   38.587351] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 6 7 *10 11 12 14 15)
[   38.587558] ACPI: PCI Interrupt Link [LNKC] (IRQs *5 6 7 10 11 12 14 15)
[   38.587768] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 6 7 10 *11 12 14 15)
[   38.587975] ACPI: PCI Interrupt Link [LNKE] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
[   38.588215] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
[   38.588426] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 6 *7 10 11 12 14 15)
[   38.588633] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
[   38.588763] PCI: Using ACPI for IRQ routing
[   38.588769] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   38.592595] PCI: Device 0000:02:03.0 not found by BIOS
[   38.592730] PCI: Device 0000:02:05.0 not found by BIOS
[   38.592864] PCI: Device 0000:02:05.2 not found by BIOS
[   38.592998] PCI: Device 0000:02:05.3 not found by BIOS
[   38.593158] PCI: Device 0000:02:05.4 not found by BIOS
[   38.593292] PCI: Device 0000:02:09.0 not found by BIOS
[   38.593973] PCI: Bridge: 0000:00:01.0
[   38.593979]   IO window: d000-dfff
[   38.593983]   MEM window: fbe00000-fbefffff
[   38.593987]   PREFETCH window: f0000000-faffffff
[   38.593995]   got res [32000000:3200ffff] bus [32000000:3200ffff] flags 7200 for BAR 6 of 0000:02:03.0
[   38.594001]   got res [fbf00000:fbf00fff] bus [fbf00000:fbf00fff] flags 200 for BAR 0 of 0000:02:05.0
[   38.594008] PCI: moved device 0000:02:05.0 resource 0 (200) to fbf00000
[   38.594011] PCI: Bus 3, cardbus bridge: 0000:02:05.0
[   38.594015]   IO window: 0000e000-0000e0ff
[   38.594019]   IO window: 0000e400-0000e4ff
[   38.594023]   PREFETCH window: 30000000-31ffffff
[   38.594027]   MEM window: 34000000-35ffffff
[   38.594030] PCI: Bridge: 0000:00:14.4
[   38.594063]   IO window: e000-efff
[   38.594067]   MEM window: fbf00000-fbffffff
[   38.594071]   PREFETCH window: 30000000-32ffffff
[   38.594108] ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 19 (level, low) -> IRQ 16
[   38.594593] Initializing Cryptographic API
[   38.594600] io scheduler noop registered
[   38.594608] io scheduler anticipatory registered
[   38.594616] io scheduler deadline registered
[   38.594632] io scheduler cfq registered
[   38.594636] PCI: Calling quirk c01e36d0 for 0000:00:00.0
[   38.594639] PCI: Calling quirk c0255f20 for 0000:00:00.0
[   38.594642] PCI: Calling quirk c01e36d0 for 0000:00:01.0
[   38.594645] PCI: Calling quirk c0255f20 for 0000:00:01.0
[   38.594647] PCI: Calling quirk c01e36d0 for 0000:00:13.0
[   38.594650] PCI: Calling quirk c0255f20 for 0000:00:13.0
[   38.622002] PCI: Calling quirk c01e36d0 for 0000:00:13.1
[   38.622005] PCI: Calling quirk c0255f20 for 0000:00:13.1
[   38.637966] PCI: Calling quirk c01e36d0 for 0000:00:13.2
[   38.637969] PCI: Calling quirk c0255f20 for 0000:00:13.2
[   38.637982] PCI: Calling quirk c01e36d0 for 0000:00:14.0
[   38.637985] PCI: Calling quirk c0255f20 for 0000:00:14.0
[   38.637987] PCI: Calling quirk c01e36d0 for 0000:00:14.1
[   38.637990] PCI: Calling quirk c0255f20 for 0000:00:14.1
[   38.637993] PCI: Calling quirk c01e36d0 for 0000:00:14.3
[   38.637995] PCI: Calling quirk c0255f20 for 0000:00:14.3
[   38.637998] PCI: Calling quirk c01e36d0 for 0000:00:14.4
[   38.638000] PCI: Calling quirk c0255f20 for 0000:00:14.4
[   38.638003] PCI: Calling quirk c01e36d0 for 0000:00:14.5
[   38.638005] PCI: Calling quirk c0255f20 for 0000:00:14.5
[   38.638008] PCI: Calling quirk c01e36d0 for 0000:00:14.6
[   38.638010] PCI: Calling quirk c0255f20 for 0000:00:14.6
[   38.638013] PCI: Calling quirk c01e36d0 for 0000:00:18.0
[   38.638015] PCI: Calling quirk c0255f20 for 0000:00:18.0
[   38.638018] PCI: Calling quirk c01e36d0 for 0000:00:18.1
[   38.638020] PCI: Calling quirk c0255f20 for 0000:00:18.1
[   38.638023] PCI: Calling quirk c01e36d0 for 0000:00:18.2
[   38.638025] PCI: Calling quirk c0255f20 for 0000:00:18.2
[   38.638028] PCI: Calling quirk c01e36d0 for 0000:00:18.3
[   38.638030] PCI: Calling quirk c0255f20 for 0000:00:18.3
[   38.638033] PCI: Calling quirk c01e36d0 for 0000:01:05.0
[   38.638035] PCI: Calling quirk c0255f20 for 0000:01:05.0
[   38.638038] PCI: Calling quirk c01e36d0 for 0000:02:03.0
[   38.638040] PCI: Calling quirk c0255f20 for 0000:02:03.0
[   38.638043] PCI: Calling quirk c01e36d0 for 0000:02:05.0
[   38.638046] PCI: Calling quirk c0255f20 for 0000:02:05.0
[   38.638049] PCI: Calling quirk c01e36d0 for 0000:02:05.2
[   38.638052] PCI: Calling quirk c0255f20 for 0000:02:05.2
[   38.638054] PCI: Calling quirk c01e36d0 for 0000:02:05.3
[   38.638057] PCI: Calling quirk c0255f20 for 0000:02:05.3
[   38.638059] PCI: Calling quirk c01e36d0 for 0000:02:05.4
[   38.638062] PCI: Calling quirk c0255f20 for 0000:02:05.4
[   38.638064] PCI: Calling quirk c01e36d0 for 0000:02:09.0
[   38.638067] PCI: Calling quirk c0255f20 for 0000:02:09.0
[   38.638190] vesafb: framebuffer at 0xf0000000, mapped to 0xdc880000, using 1536k, total 65536k
[   38.638198] vesafb: mode is 1024x768x8, linelength=1024, pages=84
[   38.638202] vesafb: protected mode interface info at c000:52f9
[   38.638206] vesafb: scrolling: redraw
[   38.638210] vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
[   38.638214] vesafb: Mode is VGA compatible
[   38.696032] Console: switching to colour frame buffer device 128x48
[   38.696368] fb0: VESA VGA frame buffer device
[   38.696663] ACPI: AC Adapter [ADP1] (on-line)
[   38.708993] ACPI: Battery Slot [BAT1] (battery present)
[   38.709293] ACPI: Power Button (FF) [PWRF]
[   38.709526] ACPI: Lid Switch [LID0]
[   38.709718] ACPI: Sleep Button (CM) [SLPB]
[   38.709967] ACPI: Power Button (CM) [PWRB]
[   38.710256] Using specific hotkey driver
[   38.710594] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   38.714910] ACPI: Thermal Zone [THRM] (56 C)
[   38.716160] Real Time Clock Driver v1.12
[   38.716559] i8042.c: Detected active multiplexing controller, rev 1.1.
[   38.716989] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   38.717279] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   38.717566] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   38.717878] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   38.718165] serio: i8042 KBD port at 0x60,0x64 irq 1
[   38.718434] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   38.727054] ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 17
[   38.735493] ACPI: PCI interrupt for device 0000:00:14.6 disabled
[   38.743918] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   38.752583] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   38.761578] ATIIXP: IDE controller at PCI slot 0000:00:14.1
[   38.770636] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 18
[   38.779987] ATIIXP: chipset revision 0
[   38.789297] ATIIXP: not 100% native mode: will probe irqs later
[   38.798777]     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
[   38.808522]     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
[   38.818071] Probing IDE interface ide0...
[   38.956719] hda: WDC WD800VE-00HDT0, ATA DISK drive
[   39.276717] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   39.286101] Probing IDE interface ide1...
[   39.632271] hdc: HL-DT-ST DVD-RW GWA-4082N, ATAPI CD/DVD-ROM drive
[   39.798389] ide1 at 0x170-0x177,0x376 on irq 15
[   39.808122] hda: max request size: 128KiB
[   39.817771] hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
[   40.093036] hda: cache flushes supported
[   40.102987]  hda: hda1 hda2 hda3 hda4
[   40.119459] mice: PS/2 mouse device common for all mice
[   40.129169] ts: Compaq touchscreen protocol output
[   40.138854] input: PC Speaker as /class/input/input0
[   40.148665] NET: Registered protocol family 2
[   40.167731] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   40.177777] TCP established hash table entries: 16384 (order: 4, 65536 bytes)
[   40.187790] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[   40.197793] TCP: Hash tables configured (established 16384 bind 16384)
[   40.207816] TCP reno registered
[   40.217744] TCP bic registered
[   40.227581] Initializing IPsec netlink socket
[   40.237540] NET: Registered protocol family 1
[   40.247535] NET: Registered protocol family 17
[   40.257501] NET: Registered protocol family 15
[   40.267335] NET: Registered protocol family 8
[   40.276973] NET: Registered protocol family 20
[   40.286456] powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.4)
[   40.304425] powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x14 (1050 mV)
[   40.314211] powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0xa (1300 mV)
[   40.323841] cpu_init done, current fid 0x8, vid 0x8
[   40.333766] powernow-k8: ph2 null fid transition 0x8
[   40.343750] Using IPI Shortcut mode
[   40.353853] swsusp: Resume From Partition dev/hda3
[   40.353855] PM: Checking swsusp image.
[   40.353862] swsusp: Error -6 check for resume file
[   40.353864] PM: Resume from disk failed.
[   40.353940] ACPI wakeup devices: 
[   40.363965] POP2  RTL USB1 USB2 EUSB AC97 MC97 
[   40.373998] ACPI: (supports S0 S1 S3 S4 S5)
[   40.383841] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[   40.411188] kjournald starting.  Commit interval 5 seconds
[   40.420954] EXT3-fs: mounted filesystem with ordered data mode.
[   40.430655] VFS: Mounted root (ext3 filesystem) readonly.
[   40.440365] Freeing unused kernel memory: 172k freed
[   40.635743] input: AT Translated Set 2 keyboard as /class/input/input1
[   40.792065] logips2pp: Detected unknown logitech mouse model 99
[   40.875046] input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
[   41.139612] logips2pp: Detected unknown logitech mouse model 99
[   41.222576] input: ImPS/2 Logitech Wheel Mouse as /class/input/input3
[   43.564568] Adding 1953496k swap on /dev/hda3.  Priority:-1 extents:1 across:1953496k
[   43.805920] EXT3 FS on hda2, internal journal
[   44.424324] kjournald starting.  Commit interval 5 seconds
[   44.424577] EXT3 FS on hda4, internal journal
[   44.424581] EXT3-fs: mounted filesystem with ordered data mode.
[   44.499518] usbcore: registered new driver usbfs
[   44.499538] usbcore: registered new driver hub
