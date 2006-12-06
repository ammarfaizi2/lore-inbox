Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937577AbWLFTuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937577AbWLFTuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937579AbWLFTuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:50:50 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:1602 "EHLO tuxrocks.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937577AbWLFTus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:50:48 -0500
Message-ID: <45771F0B.8090708@tuxrocks.com>
Date: Wed, 06 Dec 2006 13:50:35 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>
Subject: Kernel panic at boot with recent pci quirks patch
Content-Type: multipart/mixed;
 boundary="------------010607040101080205050209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010607040101080205050209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The latest -git tree panics at boot for me.  git-bisect traced the offending commit to:

368c73d4f689dae0807d0a2aa74c61fd2b9b075f is first bad commit
commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Wed Oct 4 00:41:26 2006 +0100

    PCI: quirks: fix the festering mess that claims to handle IDE quirks

Hardware is a Dell Inspiron E1705 laptop running FC6 x86_64.

I've attached a netcconsole dump of the panic, as well as lspci output.

Is there any additional information I can provide?

Thanks,
Frank

--------------010607040101080205050209
Content-Type: text/plain;
 name="netconsole-panic.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netconsole-panic.txt"

[    0.000000] Linux version 2.6.19-bs1 (sorenson@george.sorensonfamily.com) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #11 SMP PREEMPT Wed Dec 6 09:43:25 CST 2006
[    0.000000] Command line: ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose nmi_watchdog=1 netconsole=@172.31.0.101/,@64.62.190.123/00:0F:66:99:97:4F loglevel=8 console=tty0 console=ttyUSB0,9600n8
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fed3400 (usable)
[    0.000000]  BIOS-e820: 000000007fed3400 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 523987) 1 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP (v000 DELL                                  ) @ 0x00000000000fc1b0
[    0.000000] ACPI: RSDT (v001 DELL    M07     0x27d6071d ASL  0x00000061) @ 0x000000007fed39cd
[    0.000000] ACPI: FADT (v001 DELL    M07     0x27d6071d ASL  0x00000061) @ 0x000000007fed4800
[    0.000000] ACPI: MADT (v001 DELL    M07     0x27d6071d ASL  0x00000047) @ 0x000000007fed5000
[    0.000000] ACPI: MCFG (v016 DELL    M07     0x27d6071d ASL  0x00000061) @ 0x000000007fed4fc0
[    0.000000] ACPI: BOOT (v001 DELL    M07     0x27d6071d ASL  0x00000061) @ 0x000000007fed4bc0
[    0.000000] ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x000000007fed3a05
[    0.000000] ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 INTL 0x20050624) @ 0x0000000000000000
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 523987) 1 entries of 256 used
[    0.000000] No mptable found.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   523987
[    0.000000] On node 0 totalpages: 523890
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 8 pages reserved
[    0.000000]   DMA zone: 3935 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7107 pages used for memmap
[    0.000000]   DMA32 zone: 512784 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to physical flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 32768 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 516719
[    0.000000] Kernel command line: ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose nmi_watchdog=1 netconsole=@172.31.0.101/,@64.62.190.123/00:0F:66:99:97:4F loglevel=8 console=tty0 console=ttyUSB0,9600n8
[    0.000000] netconsole: local port 6665
[    0.000000] netconsole: local IP 172.31.0.101
[    0.000000] netconsole: interface eth0
[    0.000000] netconsole: remote port 6666
[    0.000000] netconsole: remote IP 64.62.190.123
[    0.000000] netconsole: remote ethernet address 00:0f:66:99:97:4f
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    8.787732] Console: colour dummy device 80x25
[    8.788920] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    8.790147] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    8.790288] Checking aperture...
[    8.816100] Memory: 2055256k/2095948k available (2931k kernel code, 39948k reserved, 1857k data, 236k init)
[    8.875615] Calibrating delay using timer specific routine.. 4330.48 BogoMIPS (lpj=2165241)
[    8.875656] Security Framework v1.0.0 initialized
[    8.875663] Capability LSM initialized
[    8.875680] Mount-cache hash table entries: 256
[    8.875803] CPU: L1 I cache: 32K, L1 D cache: 32K
[    8.875807] CPU: L2 cache: 4096K
[    8.875810] using mwait in idle threads.
[    8.875812] CPU: Physical Processor ID: 0
[    8.875814] CPU: Processor Core ID: 0
[    8.875821] CPU0: Thermal monitoring enabled (TM2)
[    8.875836] SMP alternatives: switching to UP code
[    8.876040] ACPI: Core revision 20060707
[    8.894846] enabled ExtINT on CPU#0
[    8.894850] ESR value after enabling vector: 00000000, after 00000040
[    8.895043] ENABLING IO-APIC IRQs
[    8.895045] init IO_APIC IRQs
[    8.895048]  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
[    8.895245] ..TIMER: vector=0x20 apic1=0 pin1=2 apic2=-1 pin2=-1
[    8.905251] activating NMI Watchdog ... done.
[    8.905260] Using local APIC timer interrupts.
[    8.951454] result 10403193
[    8.951456] Detected 10.403 MHz APIC timer.
[    8.951662] SMP alternatives: switching to SMP code
[    8.951688] Booting processor 1/2 APIC 0x1
[   10.748763] Initializing CPU#1
[   10.748949] masked ExtINT on CPU#1
[   10.808359] Calibrating delay using timer specific routine.. 4326.94 BogoMIPS (lpj=2163470)
[   10.808366] CPU: L1 I cache: 32K, L1 D cache: 32K
[   10.808367] CPU: L2 cache: 4096K
[   10.808370] CPU: Physical Processor ID: 0
[   10.808371] CPU: Processor Core ID: 1
[   10.808376] CPU1: Thermal monitoring enabled (TM2)
[   10.808847] Intel(R) Core(TM)2 CPU         T7400  @ 2.16GHz stepping 06
[   10.809378] CPU 1: Syncing TSC to CPU 0.
[    9.023702] CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 1027 cycles)
[    9.023717] Brought up 2 CPUs
[    9.023779] testing NMI watchdog ... OK.
[    9.033783] Disabling vsyscall due to use of PM timer
[    9.033786] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[    9.033789] time.c: Detected 2163.866 MHz processor.
[    9.084196] migration_cost=25
[    9.084298] checking if image is initramfs... it is
[    9.236700] Freeing initrd memory: 2085k freed
[    9.237501] PM: Adding info for No Bus:platform
[    9.237702] NET: Registered protocol family 16
[    9.237776] ACPI: bus type pci registered
[    9.241096] PCI: Using MMCONFIG at e0000000
[    9.268354] ACPI: Interpreter enabled
[    9.268359] ACPI: Using IOAPIC for interrupt routing
[    9.268454] PM: Adding info for acpi:acpi
[    9.268933] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    9.268941] PCI: Probing PCI hardware (bus 00)
[    9.269018] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[    9.280771] PM: Adding info for No Bus:pci0000:00
[    9.280807] PCI: Scanning bus 0000:00
[    9.280815] PCI: Found 0000:00:00.0 [8086/27a0] 000600 00
[    9.280818] PCI: Calling quirk ffffffff81157720 for 0000:00:00.0
[    9.280828] PCI: Calling quirk ffffffff81263e90 for 0000:00:00.0
[    9.280831] PCI: Calling quirk ffffffff81263968 for 0000:00:00.0
[    9.280839] PCI: Found 0000:00:01.0 [8086/27a1] 000604 01
[    9.280842] PCI: Calling quirk ffffffff81157720 for 0000:00:01.0
[    9.280848] PCI: Calling quirk ffffffff81263e90 for 0000:00:01.0
[    9.280851] PCI: Calling quirk ffffffff81263968 for 0000:00:01.0
[    9.280892] PCI: Found 0000:00:1b.0 [8086/27d8] 000403 00
[    9.280895] PCI: Calling quirk ffffffff81157720 for 0000:00:1b.0
[    9.280931] PCI: Calling quirk ffffffff81263e90 for 0000:00:1b.0
[    9.280934] PCI: Calling quirk ffffffff81263968 for 0000:00:1b.0
[    9.280945] PCI: Found 0000:00:1c.0 [8086/27d0] 000604 01
[    9.280948] PCI: Calling quirk ffffffff81157720 for 0000:00:1c.0
[    9.280966] PCI: Calling quirk ffffffff81263e90 for 0000:00:1c.0
[    9.280969] PCI: Calling quirk ffffffff81263968 for 0000:00:1c.0
[    9.280980] PCI: Found 0000:00:1c.1 [8086/27d2] 000604 01
[    9.280983] PCI: Calling quirk ffffffff81157720 for 0000:00:1c.1
[    9.281000] PCI: Calling quirk ffffffff81263e90 for 0000:00:1c.1
[    9.281003] PCI: Calling quirk ffffffff81263968 for 0000:00:1c.1
[    9.281016] PCI: Found 0000:00:1c.3 [8086/27d6] 000604 01
[    9.281019] PCI: Calling quirk ffffffff81157720 for 0000:00:1c.3
[    9.281036] PCI: Calling quirk ffffffff81263e90 for 0000:00:1c.3
[    9.281039] PCI: Calling quirk ffffffff81263968 for 0000:00:1c.3
[    9.281052] PCI: Found 0000:00:1d.0 [8086/27c8] 000c03 00
[    9.281055] PCI: Calling quirk ffffffff81157720 for 0000:00:1d.0
[    9.281090] PCI: Calling quirk ffffffff81263e90 for 0000:00:1d.0
[    9.281093] PCI: Calling quirk ffffffff81263968 for 0000:00:1d.0
[    9.281103] PCI: Found 0000:00:1d.1 [8086/27c9] 000c03 00
[    9.281106] PCI: Calling quirk ffffffff81157720 for 0000:00:1d.1
[    9.281141] PCI: Calling quirk ffffffff81263e90 for 0000:00:1d.1
[    9.281144] PCI: Calling quirk ffffffff81263968 for 0000:00:1d.1
[    9.281153] PCI: Found 0000:00:1d.2 [8086/27ca] 000c03 00
[    9.281156] PCI: Calling quirk ffffffff81157720 for 0000:00:1d.2
[    9.281191] PCI: Calling quirk ffffffff81263e90 for 0000:00:1d.2
[    9.281194] PCI: Calling quirk ffffffff81263968 for 0000:00:1d.2
[    9.281204] PCI: Found 0000:00:1d.3 [8086/27cb] 000c03 00
[    9.281207] PCI: Calling quirk ffffffff81157720 for 0000:00:1d.3
[    9.281242] PCI: Calling quirk ffffffff81263e90 for 0000:00:1d.3
[    9.281245] PCI: Calling quirk ffffffff81263968 for 0000:00:1d.3
[    9.281268] PCI: Found 0000:00:1d.7 [8086/27cc] 000c03 00
[    9.281271] PCI: Calling quirk ffffffff81157720 for 0000:00:1d.7
[    9.281308] PCI: Calling quirk ffffffff81263e90 for 0000:00:1d.7
[    9.281310] PCI: Calling quirk ffffffff81263968 for 0000:00:1d.7
[    9.281326] PCI: Found 0000:00:1e.0 [8086/2448] 000604 01
[    9.281329] PCI: Calling quirk ffffffff81157720 for 0000:00:1e.0
[    9.281348] PCI: Calling quirk ffffffff81263e90 for 0000:00:1e.0
[    9.281351] PCI: Calling quirk ffffffff81263968 for 0000:00:1e.0
[    9.281372] PCI: Found 0000:00:1f.0 [8086/27b9] 000601 00
[    9.281375] PCI: Calling quirk ffffffff81157720 for 0000:00:1f.0
[    9.281425] PCI: Calling quirk ffffffff81157a68 for 0000:00:1f.0
[    9.281431] PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    9.281436] PCI quirk: region 1080-10bf claimed by ICH6 GPIO
[    9.281439] PCI: Calling quirk ffffffff81263e90 for 0000:00:1f.0
[    9.281442] PCI: Calling quirk ffffffff81263968 for 0000:00:1f.0
[    9.281459] PCI: Found 0000:00:1f.2 [8086/27c4] 000101 00
[    9.281462] PCI: Calling quirk ffffffff81157720 for 0000:00:1f.2
[    9.281498] PCI: Calling quirk ffffffff81263e90 for 0000:00:1f.2
[    9.281501] PCI: Calling quirk ffffffff81263968 for 0000:00:1f.2
[    9.281513] PCI: Found 0000:00:1f.3 [8086/27da] 000c05 00
[    9.281516] PCI: Calling quirk ffffffff81157720 for 0000:00:1f.3
[    9.281566] PCI: Calling quirk ffffffff81263e90 for 0000:00:1f.3
[    9.281568] PCI: Calling quirk ffffffff81263968 for 0000:00:1f.3
[    9.281575] PCI: Fixups for bus 0000:00
[    9.281578] PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
[    9.281610] PCI: Scanning bus 0000:01
[    9.281621] PCI: Found 0000:01:00.0 [10de/0298] 000300 00
[    9.281638] PCI: Calling quirk ffffffff81263e90 for 0000:01:00.0
[    9.281641] Boot video device is 0000:01:00.0
[    9.281676] PCI: Fixups for bus 0000:01
[    9.281680] PCI: Bus scan for 0000:01 returning with max=01
[    9.281684] PCI: Scanning behind PCI bridge 0000:00:1c.0, config 0b0b00, pass 0
[    9.281720] PCI: Scanning bus 0000:0b
[    9.281755] PCI: Fixups for bus 0000:0b
[    9.281766] PCI: Bus scan for 0000:0b returning with max=0b
[    9.281771] PCI: Scanning behind PCI bridge 0000:00:1c.1, config 0c0c00, pass 0
[    9.281805] PCI: Scanning bus 0000:0c
[    9.281828] PCI: Found 0000:0c:00.0 [14e4/4328] 000280 00
[    9.281884] PCI: Calling quirk ffffffff81263e90 for 0000:0c:00.0
[    9.281919] PCI: Fixups for bus 0000:0c
[    9.281930] PCI: Bus scan for 0000:0c returning with max=0c
[    9.281935] PCI: Scanning behind PCI bridge 0000:00:1c.3, config 0e0d00, pass 0
[    9.281970] PCI: Scanning bus 0000:0d
[    9.282006] PCI: Fixups for bus 0000:0d
[    9.282016] PCI: Bus scan for 0000:0d returning with max=0d
[    9.282021] PCI: Scanning behind PCI bridge 0000:00:1e.0, config 030300, pass 0
[    9.282057] PCI: Scanning bus 0000:03
[    9.282073] PCI: Found 0000:03:00.0 [14e4/170c] 000200 00
[    9.282108] PCI: Calling quirk ffffffff81263e90 for 0000:03:00.0
[    9.282125] PCI: Found 0000:03:01.0 [1180/0832] 000c00 00
[    9.282163] PCI: Calling quirk ffffffff81263e90 for 0000:03:01.0
[    9.282181] PCI: Found 0000:03:01.1 [1180/0822] 000805 00
[    9.282221] PCI: Calling quirk ffffffff81263e90 for 0000:03:01.1
[    9.282237] PCI: Found 0000:03:01.2 [1180/0843] 000880 00
[    9.282274] PCI: Calling quirk ffffffff81263e90 for 0000:03:01.2
[    9.282291] PCI: Found 0000:03:01.3 [1180/0592] 000880 00
[    9.282329] PCI: Calling quirk ffffffff81263e90 for 0000:03:01.3
[    9.282347] PCI: Found 0000:03:01.4 [1180/0852] 000880 00
[    9.282386] PCI: Calling quirk ffffffff81263e90 for 0000:03:01.4
[    9.282435] PCI: Fixups for bus 0000:03
[    9.282437] PCI: Transparent bridge - 0000:00:1e.0
[    9.282448] PCI: Bus scan for 0000:03 returning with max=03
[    9.282452] PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
[    9.282460] PCI: Scanning behind PCI bridge 0000:00:1c.0, config 0b0b00, pass 1
[    9.282473] PCI: Scanning behind PCI bridge 0000:00:1c.1, config 0c0c00, pass 1
[    9.282487] PCI: Scanning behind PCI bridge 0000:00:1c.3, config 0e0d00, pass 1
[    9.282500] PCI: Scanning behind PCI bridge 0000:00:1e.0, config 030300, pass 1
[    9.282511] PCI: Bus scan for 0000:00 returning with max=0e
[    9.282517] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    9.283281] PM: Adding info for pci:0000:00:00.0
[    9.283744] PM: Adding info for pci:0000:00:01.0
[    9.284200] PM: Adding info for pci:0000:00:1b.0
[    9.284662] PM: Adding info for pci:0000:00:1c.0
[    9.285118] PM: Adding info for pci:0000:00:1c.1
[    9.285579] PM: Adding info for pci:0000:00:1c.3
[    9.286041] PM: Adding info for pci:0000:00:1d.0
[    9.286503] PM: Adding info for pci:0000:00:1d.1
[    9.286960] PM: Adding info for pci:0000:00:1d.2
[    9.287423] PM: Adding info for pci:0000:00:1d.3
[    9.287881] PM: Adding info for pci:0000:00:1d.7
[    9.288341] PM: Adding info for pci:0000:00:1e.0
[    9.288802] PM: Adding info for pci:0000:00:1f.0
[    9.289262] PM: Adding info for pci:0000:00:1f.2
[    9.289721] PM: Adding info for pci:0000:00:1f.3
[    9.289767] PM: Adding info for pci:0000:01:00.0
[    9.289810] PM: Adding info for pci:0000:0c:00.0
[    9.289855] PM: Adding info for pci:0000:03:00.0
[    9.289903] PM: Adding info for pci:0000:03:01.0
[    9.289948] PM: Adding info for pci:0000:03:01.1
[    9.289994] PM: Adding info for pci:0000:03:01.2
[    9.290042] PM: Adding info for pci:0000:03:01.3
[    9.290087] PM: Adding info for pci:0000:03:01.4
[    9.300664] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 11) *4
[    9.300882] ACPI: PCI Interrupt Link [LNKB] (IRQs *5 7)
[    9.301095] ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
[    9.301310] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 11) *3
[    9.301528] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    9.301745] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    9.301961] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    9.302181] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
[    9.302538] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[    9.303552] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
[    9.303776] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    9.303979] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    9.304252] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    9.304638] Linux Plug and Play Support v0.97 (c) Adam Belay
[    9.304650] pnp: PnP ACPI init
[    9.304655] PM: Adding info for No Bus:pnp0
[    9.320258] PM: Adding info for pnp:00:00
[    9.331496] PM: Adding info for pnp:00:01
[    9.331565] PM: Adding info for pnp:00:02
[    9.331629] PM: Adding info for pnp:00:03
[    9.331690] IOAPIC[0]: Set PCI routing entry (2-12 -> 0x2c -> IRQ 12 Mode:0 Active:0)
[    9.331701] PM: Adding info for pnp:00:04
[    9.331761] IOAPIC[0]: Set PCI routing entry (2-1 -> 0x21 -> IRQ 1 Mode:0 Active:0)
[    9.331772] PM: Adding info for pnp:00:05
[    9.331828] IOAPIC[0]: Set PCI routing entry (2-8 -> 0x28 -> IRQ 8 Mode:0 Active:0)
[    9.331839] PM: Adding info for pnp:00:06
[    9.331901] PM: Adding info for pnp:00:07
[    9.331964] PM: Adding info for pnp:00:08
[    9.332028] PM: Adding info for pnp:00:09
[    9.332084] IOAPIC[0]: Set PCI routing entry (2-13 -> 0x2d -> IRQ 13 Mode:0 Active:0)
[    9.332095] PM: Adding info for pnp:00:0a
[    9.332565] pnp: PnP ACPI: found 11 devices
[    9.334136] intel_rng: FWH not detected
[    9.334307] SCSI subsystem initialized
[    9.334374] libata version 2.00 loaded.
[    9.334416] PCI: Using ACPI for IRQ routing
[    9.334420] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    9.334424] number of MP IRQ sources: 15.
[    9.334426] number of IO-APIC #2 registers: 24.
[    9.334428] testing the IO APIC.......................
[    9.334436] 
[    9.334437] IO APIC #2......
[    9.334440] .... register #00: 00000000
[    9.334442] .......    : physical APIC id: 00
[    9.334444] .... register #01: 00170020
[    9.334446] .......     : max redirection entries: 0017
[    9.334448] .......     : PRQ implemented: 0
[    9.334451] .......     : IO APIC version: 0020
[    9.334453] .... register #02: 00170020
[    9.334455] .......     : arbitration: 00
[    9.334457] .... IRQ redirection table:
[    9.334459]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
[    9.334465]  00 000 00  1    0    0   0   0    0    0    00
[    9.334472]  01 000 00  1    0    0   0   0    0    0    21
[    9.334479]  02 000 00  0    0    0   0   0    0    0    20
[    9.334486]  03 000 00  0    0    0   0   0    0    0    23
[    9.334493]  04 000 00  0    0    0   0   0    0    0    24
[    9.334499]  05 000 00  0    0    0   0   0    0    0    25
[    9.334506]  06 000 00  0    0    0   0   0    0    0    26
[    9.334512]  07 000 00  0    0    0   0   0    0    0    27
[    9.334519]  08 000 00  1    0    0   0   0    0    0    28
[    9.334526]  09 000 00  0    1    0   0   0    0    0    29
[    9.334532]  0a 000 00  0    0    0   0   0    0    0    2A
[    9.334539]  0b 000 00  0    0    0   0   0    0    0    2B
[    9.334546]  0c 000 00  1    0    0   0   0    0    0    2C
[    9.334552]  0d 000 00  1    0    0   0   0    0    0    2D
[    9.334559]  0e 000 00  0    0    0   0   0    0    0    2E
[    9.334565]  0f 000 00  0    0    0   0   0    0    0    2F
[    9.334572]  10 000 00  1    0    0   0   0    0    0    00
[    9.334579]  11 000 00  1    0    0   0   0    0    0    00
[    9.334585]  12 000 00  1    0    0   0   0    0    0    00
[    9.334592]  13 000 00  1    0    0   0   0    0    0    00
[    9.334599]  14 000 00  1    0    0   0   0    0    0    00
[    9.334605]  15 000 00  1    0    0   0   0    0    0    00
[    9.334612]  16 000 00  1    0    0   0   0    0    0    00
[    9.334619]  17 000 00  1    0    0   0   0    0    0    00
[    9.334622] IRQ to pin mappings:
[    9.334624] IRQ0 -> 0:2
[    9.334626] IRQ1 -> 0:1
[    9.334629] IRQ3 -> 0:3
[    9.334632] IRQ4 -> 0:4
[    9.334634] IRQ5 -> 0:5
[    9.334636] IRQ6 -> 0:6
[    9.334639] IRQ7 -> 0:7
[    9.334641] IRQ8 -> 0:8
[    9.334644] IRQ9 -> 0:9
[    9.334646] IRQ10 -> 0:10
[    9.334649] IRQ11 -> 0:11
[    9.334651] IRQ12 -> 0:12
[    9.334654] IRQ13 -> 0:13
[    9.334656] IRQ14 -> 0:14
[    9.334659] IRQ15 -> 0:15
[    9.334662] .................................... done.
[    9.334756] Bluetooth: Core ver 2.11
[    9.334767] PM: Adding info for platform:bluetooth
[    9.334827] NET: Registered protocol family 31
[    9.334829] Bluetooth: HCI device and connection manager initialized
[    9.334833] Bluetooth: HCI socket layer initialized
[    9.334845] PCI-GART: No AMD northbridge found.
[    9.350570] pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
[    9.350574] pnp: 00:02: ioport range 0x1000-0x1005 could not be reserved
[    9.350578] pnp: 00:02: ioport range 0x1008-0x100f could not be reserved
[    9.350585] pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
[    9.350588] pnp: 00:03: ioport range 0x1006-0x1007 has been reserved
[    9.350592] pnp: 00:03: ioport range 0x100a-0x1059 could not be reserved
[    9.350595] pnp: 00:03: ioport range 0x1060-0x107f has been reserved
[    9.350598] pnp: 00:03: ioport range 0x1080-0x10bf has been reserved
[    9.350602] pnp: 00:03: ioport range 0x10c0-0x10df has been reserved
[    9.350611] pnp: 00:08: ioport range 0xc80-0xcff could not be reserved
[    9.350614] pnp: 00:08: ioport range 0x910-0x91f has been reserved
[    9.350619] pnp: 00:08: ioport range 0x920-0x92f has been reserved
[    9.350622] pnp: 00:08: ioport range 0xcb0-0xcbf has been reserved
[    9.350625] pnp: 00:08: ioport range 0x930-0x97f has been reserved
[    9.350901] PCI: Bridge: 0000:00:01.0
[    9.350904]   IO window: e000-efff
[    9.350908]   MEM window: dd000000-dfefffff
[    9.350911]   PREFETCH window: c0000000-cfffffff
[    9.350914] PCI: Bridge: 0000:00:1c.0
[    9.350916]   IO window: disabled.
[    9.350920]   MEM window: disabled.
[    9.350924]   PREFETCH window: disabled.
[    9.350929] PCI: Bridge: 0000:00:1c.1
[    9.350931]   IO window: disabled.
[    9.350936]   MEM window: dcf00000-dcffffff
[    9.350940]   PREFETCH window: d0000000-d00fffff
[    9.350946] PCI: Bridge: 0000:00:1c.3
[    9.350949]   IO window: d000-dfff
[    9.350954]   MEM window: dcc00000-dcefffff
[    9.350958]   PREFETCH window: d0100000-d03fffff
[    9.350964] PCI: Bridge: 0000:00:1e.0
[    9.350966]   IO window: disabled.
[    9.350971]   MEM window: dcb00000-dcbfffff
[    9.350975]   PREFETCH window: disabled.
[    9.350987] IOAPIC[0]: Set PCI routing entry (2-16 -> 0x39 -> IRQ 16 Mode:1 Active:1)
[    9.350992] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[    9.350998] PCI: Setting latency timer of device 0000:00:01.0 to 64
[    9.351015] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[    9.351021] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    9.351039] IOAPIC[0]: Set PCI routing entry (2-17 -> 0x41 -> IRQ 17 Mode:1 Active:1)
[    9.351043] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
[    9.351049] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    9.351067] IOAPIC[0]: Set PCI routing entry (2-19 -> 0x49 -> IRQ 19 Mode:1 Active:1)
[    9.351071] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[    9.351077] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    9.351088] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    9.351110] NET: Registered protocol family 2
[    9.360389] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    9.360550] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    9.362534] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    9.363048] TCP: Hash tables configured (established 262144 bind 65536)
[    9.363052] TCP reno registered
[    9.363273] Simple Boot Flag at 0x79 set to 0x80
[    9.363924] audit: initializing netlink socket (disabled)
[    9.363935] audit(1165420802.530:1): initialized
[    9.363996] Total HugeTLB memory allocated, 0
[    9.364100] VFS: Disk quotas dquot_6.5.1
[    9.364118] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    9.364180] fuse init (API version 7.7)
[    9.364271] io scheduler noop registered
[    9.364274] io scheduler anticipatory registered
[    9.364278] io scheduler deadline registered
[    9.364289] io scheduler cfq registered (default)
[    9.364296] PCI: Calling quirk ffffffff81157060 for 0000:00:00.0
[    9.364300] PCI: Calling quirk ffffffff81157b6d for 0000:00:00.0
[    9.364303] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:00.0
[    9.364307] PCI: Calling quirk ffffffff81157060 for 0000:00:01.0
[    9.364310] PCI: Calling quirk ffffffff81157b6d for 0000:00:01.0
[    9.364313] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:01.0
[    9.364317] PCI: Calling quirk ffffffff81157060 for 0000:00:1b.0
[    9.364319] PCI: Calling quirk ffffffff81157b6d for 0000:00:1b.0
[    9.364322] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1b.0
[    9.364326] PCI: Calling quirk ffffffff81157060 for 0000:00:1c.0
[    9.364329] PCI: Calling quirk ffffffff81157b6d for 0000:00:1c.0
[    9.364332] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1c.0
[    9.364335] PCI: Calling quirk ffffffff81157060 for 0000:00:1c.1
[    9.364338] PCI: Calling quirk ffffffff81157b6d for 0000:00:1c.1
[    9.364341] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1c.1
[    9.364345] PCI: Calling quirk ffffffff81157060 for 0000:00:1c.3
[    9.364348] PCI: Calling quirk ffffffff81157b6d for 0000:00:1c.3
[    9.364353] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1c.3
[    9.364356] PCI: Calling quirk ffffffff81157060 for 0000:00:1d.0
[    9.364359] PCI: Calling quirk ffffffff81157b6d for 0000:00:1d.0
[    9.364362] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1d.0
[    9.364383] PCI: Calling quirk ffffffff81157060 for 0000:00:1d.1
[    9.364385] PCI: Calling quirk ffffffff81157b6d for 0000:00:1d.1
[    9.364388] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1d.1
[    9.364406] PCI: Calling quirk ffffffff81157060 for 0000:00:1d.2
[    9.364409] PCI: Calling quirk ffffffff81157b6d for 0000:00:1d.2
[    9.364412] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1d.2
[    9.364430] PCI: Calling quirk ffffffff81157060 for 0000:00:1d.3
[    9.364433] PCI: Calling quirk ffffffff81157b6d for 0000:00:1d.3
[    9.364436] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1d.3
[    9.364454] PCI: Calling quirk ffffffff81157060 for 0000:00:1d.7
[    9.364457] PCI: Calling quirk ffffffff81157b6d for 0000:00:1d.7
[    9.364460] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1d.7
[    9.366613] PCI: Calling quirk ffffffff81157060 for 0000:00:1e.0
[    9.366620] PCI: Calling quirk ffffffff81157b6d for 0000:00:1e.0
[    9.366623] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1e.0
[    9.366627] PCI: Calling quirk ffffffff81157060 for 0000:00:1f.0
[    9.366629] PCI: Calling quirk ffffffff81157b6d for 0000:00:1f.0
[    9.366632] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1f.0
[    9.366636] PCI: Calling quirk ffffffff81157060 for 0000:00:1f.2
[    9.366644] PCI: Calling quirk ffffffff81157b6d for 0000:00:1f.2
[    9.366647] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1f.2
[    9.366650] PCI: Calling quirk ffffffff81157060 for 0000:00:1f.3
[    9.366653] PCI: Calling quirk ffffffff81157b6d for 0000:00:1f.3
[    9.366656] PCI: Calling quirk ffffffff811fe2f0 for 0000:00:1f.3
[    9.366660] PCI: Calling quirk ffffffff81157b6d for 0000:01:00.0
[    9.366663] PCI: Calling quirk ffffffff811fe2f0 for 0000:01:00.0
[    9.366666] PCI: Calling quirk ffffffff81157b6d for 0000:0c:00.0
[    9.366669] PCI: Calling quirk ffffffff811fe2f0 for 0000:0c:00.0
[    9.366672] PCI: Calling quirk ffffffff81157b6d for 0000:03:00.0
[    9.366675] PCI: Calling quirk ffffffff811fe2f0 for 0000:03:00.0
[    9.366678] PCI: Calling quirk ffffffff81157b6d for 0000:03:01.0
[    9.366681] PCI: Calling quirk ffffffff811fe2f0 for 0000:03:01.0
[    9.366685] PCI: Calling quirk ffffffff81157b6d for 0000:03:01.1
[    9.366688] PCI: Calling quirk ffffffff811fe2f0 for 0000:03:01.1
[    9.366691] PCI: Calling quirk ffffffff81157b6d for 0000:03:01.2
[    9.366694] PCI: Calling quirk ffffffff811fe2f0 for 0000:03:01.2
[    9.366697] PCI: Calling quirk ffffffff81157b6d for 0000:03:01.3
[    9.366700] PCI: Calling quirk ffffffff811fe2f0 for 0000:03:01.3
[    9.366703] PCI: Calling quirk ffffffff81157b6d for 0000:03:01.4
[    9.366706] PCI: Calling quirk ffffffff811fe2f0 for 0000:03:01.4
[    9.366876] PCI: Setting latency timer of device 0000:00:01.0 to 64
[    9.366891] assign_interrupt_mode Found MSI capability
[    9.366920] Allocate Port Service[0000:00:01.0:pcie00]
[    9.366928] PM: Adding info for pci_express:0000:00:01.0:pcie00
[    9.366960] Allocate Port Service[0000:00:01.0:pcie03]
[    9.366968] PM: Adding info for pci_express:0000:00:01.0:pcie03
[    9.367018] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    9.367062] assign_interrupt_mode Found MSI capability
[    9.367097] Allocate Port Service[0000:00:1c.0:pcie00]
[    9.367103] PM: Adding info for pci_express:0000:00:1c.0:pcie00
[    9.367130] Allocate Port Service[0000:00:1c.0:pcie02]
[    9.367135] PM: Adding info for pci_express:0000:00:1c.0:pcie02
[    9.367161] Allocate Port Service[0000:00:1c.0:pcie03]
[    9.367169] PM: Adding info for pci_express:0000:00:1c.0:pcie03
[    9.367264] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    9.367311] assign_interrupt_mode Found MSI capability
[    9.367345] Allocate Port Service[0000:00:1c.1:pcie00]
[    9.367354] PM: Adding info for pci_express:0000:00:1c.1:pcie00
[    9.367390] Allocate Port Service[0000:00:1c.1:pcie02]
[    9.367396] PM: Adding info for pci_express:0000:00:1c.1:pcie02
[    9.367423] Allocate Port Service[0000:00:1c.1:pcie03]
[    9.367430] PM: Adding info for pci_express:0000:00:1c.1:pcie03
[    9.367523] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    9.367567] assign_interrupt_mode Found MSI capability
[    9.367602] Allocate Port Service[0000:00:1c.3:pcie00]
[    9.367607] PM: Adding info for pci_express:0000:00:1c.3:pcie00
[    9.367635] Allocate Port Service[0000:00:1c.3:pcie02]
[    9.367640] PM: Adding info for pci_express:0000:00:1c.3:pcie02
[    9.367668] Allocate Port Service[0000:00:1c.3:pcie03]
[    9.367676] PM: Adding info for pci_express:0000:00:1c.3:pcie03
[    9.367800] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    9.367853] pciehp: HPC vendor_id 8086 device_id 27d0 ss_vid 0 ss_did 0
[    9.367879] Evaluate _OSC Set fails. Status = 0x0005
[    9.367894] Evaluate _OSC Set fails. Status = 0x0005
[    9.367903] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.0
[    9.367920] pciehp: HPC vendor_id 8086 device_id 27d2 ss_vid 0 ss_did 0
[    9.367936] Evaluate _OSC Set fails. Status = 0x0005
[    9.367945] Evaluate _OSC Set fails. Status = 0x0005
[    9.367954] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.1
[    9.367969] pciehp: HPC vendor_id 8086 device_id 27d6 ss_vid 0 ss_did 0
[    9.367984] Evaluate _OSC Set fails. Status = 0x0005
[    9.367994] Evaluate _OSC Set fails. Status = 0x0005
[    9.368002] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.3
[    9.368010] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    9.368074] PM: Adding info for platform:vesafb.0
[    9.368113] vesafb: framebuffer at 0xc0000000, mapped to 0xffffc20010100000, using 5120k, total 262144k
[    9.368118] vesafb: mode is 1280x1024x16, linelength=2560, pages=1
[    9.368120] vesafb: scrolling: redraw
[    9.368123] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    9.408266] Console: switching to colour frame buffer device 160x64
[    9.445852] fb0: VESA VGA frame buffer device
[    9.446474] ACPI: AC Adapter [AC] (on-line)
[    9.466630] ACPI: Battery Slot [BAT0] (battery present)
[    9.466886] ACPI: Lid Switch [LID]
[    9.467050] ACPI: Power Button (CM) [PBTN]
[    9.467242] ACPI: Sleep Button (CM) [SBTN]
[    9.468351] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[    9.468995] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[    9.469362] ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
[    9.470093] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
[    9.470671] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
[    9.471271] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    9.471563] ACPI: Processor [CPU0] (supports 8 throttling states)
[    9.472194] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
[    9.472761] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
[    9.473398] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[    9.473688] ACPI: Processor [CPU1] (supports 8 throttling states)
[    9.479346] ACPI: Thermal Zone [THM] (52 C)
[    9.483064] Real Time Clock Driver v1.12ac
[    9.483330] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.00 (08-Oct-2006)
[    9.483697] PM: Adding info for platform:iTCO_wdt
[    9.483986] iTCO_wdt: Found a ICH7-M TCO device (Version=2, TCOBASE=0x1060)
[    9.484386] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    9.484661] Linux agpgart interface v0.101 (c) Dave Jones
[    9.484961] agpgart: Detected an Intel 945GM Chipset.
[    9.501909] agpgart: AGP aperture is 256M @ 0x0
[    9.502143] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    9.502526] PM: Adding info for platform:serial8250
[    9.504341] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
[    9.504855] b44.c:v1.01 (Jun 16, 2006)
[    9.505039] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[    9.508961] eth0: Broadcom 4400 10/100BaseT Ethernet 00:15:c5:4b:5e:8f
[    9.509332] netconsole: device eth0 not up yet, forcing it
[   12.509322] b44: eth0: Link is up at 100 Mbps, full duplex.
[   12.516854] b44: eth0: Flow control is off for TX and off for RX.
[   17.104490] netconsole: network logging started
[   17.116576] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   17.128779] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   17.141348] ide0: I/O resource 0x1F0-0x1F7 not free.
[   17.153636] ide0: ports already in use, skipping probe
[   17.165879] Probing IDE interface ide1...
[   17.225551] hdc: TSSTcorp DVD+/-RW TS-L632D, ATAPI CD/DVD-ROM drive
[   17.238096] PM: Adding info for No Bus:ide1
[   17.279811] ide1 at 0x170-0x177,0x376 on irq 15
[   17.292176] PM: Adding info for ide:1.0
[   17.309006] hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
[   17.321664] Uniform CD-ROM driver Revision: 3.20
[   17.338814] ide-floppy driver 0.99.newide
[   17.351233] ata_piix 0000:00:1f.2: version 2.00ac6
[   17.363461] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[   17.375879] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
[   17.388335] PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
[   17.400778] ata_piix: probe of 0000:00:1f.2 failed with error -16
[   17.413356] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   17.425848] PM: Adding info for platform:i8042
[   17.441079] serio: i8042 KBD port at 0x60,0x64 irq 1
[   17.453358] PM: Adding info for serio:serio0
[   17.465624] serio: i8042 AUX port at 0x60,0x64 irq 12
[   17.477882] PM: Adding info for serio:serio1
[   17.490071] mice: PS/2 mouse device common for all mice
[   17.502375] md: multipath personality registered for level -4
[   17.514844] input: AT Translated Set 2 keyboard as /class/input/input0
[   17.514870] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[   17.539754] device-mapper: multipath: version 1.0.5 loaded
[   17.552702] device-mapper: multipath round-robin: version 1.0.0 loaded
[   17.565692] device-mapper: multipath emc: version 0.0.3 loaded
[   17.578764] Advanced Linux Sound Architecture Driver Version 1.0.13 (Tue Nov 28 14:07:24 2006 UTC).
[   17.593098] IOAPIC[0]: Set PCI routing entry (2-21 -> 0x71 -> IRQ 21 Mode:1 Active:1)
[   17.606417] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
[   17.620921] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   17.685904] ALSA device list:
[   17.699148]   #0: HDA Intel at 0xdfffc000 irq 21
[   17.712301] TCP cubic registered
[   17.725479] Initializing XFRM netlink socket
[   17.738523] NET: Registered protocol family 1
[   17.751523] NET: Registered protocol family 17
[   17.764358] Bluetooth: L2CAP ver 2.8
[   17.777160] Bluetooth: L2CAP socket layer initialized
[   17.789908] Bluetooth: SCO (Voice Link) ver 0.5
[   17.802524] Bluetooth: SCO socket layer initialized
[   17.815032] Bluetooth: RFCOMM socket layer initialized
[   17.827474] Bluetooth: RFCOMM TTY layer initialized
[   17.839816] Bluetooth: RFCOMM ver 1.8
[   17.852007] Bluetooth: BNEP (Ethernet Emulation) ver 1.2
[   17.864269] Bluetooth: BNEP filters: protocol multicast
[   17.876383] Bluetooth: HIDP (Human Interface Emulation) ver 1.1
[   17.888410] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   17.900445] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   17.912572] ieee80211_crypt: registered algorithm 'NULL'
[   17.924608] ieee80211_crypt: registered algorithm 'WEP'
[   17.937109] ACPI: (supports S0 S3 S4 S5)
[   17.948931] Freeing unused kernel memory: 236k freed
[   18.060056] Synaptics Touchpad, model: 1, fw: 6.2, id: 0xfa0b1, caps: 0xa04713/0x200000
[   18.084930] input: SynPS/2 Synaptics TouchPad as /class/input/input1
[   18.128636] usbcore: registered new interface driver usbfs
[   18.140001] usbcore: registered new interface driver hub
[   18.151125] Losing some ticks... checking if CPU frequency changed.
[   18.162371] usbcore: registered new device driver usb
[   18.185517] USB Universal Host Controller Interface driver v3.0
[   18.197012] IOAPIC[0]: Set PCI routing entry (2-20 -> 0x79 -> IRQ 20 Mode:1 Active:1)
[   18.208539] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
[   18.220139] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   18.231654] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   18.243103] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[   18.254534] uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000bf80
[   18.265922] PM: Adding info for usb:usb1
[   18.277255] PM: Adding info for No Bus:usbdev1.1_ep00
[   18.288549] usb usb1: configuration #1 chosen from 1 choice
[   18.299896] PM: Adding info for usb:1-0:1.0
[   18.311202] hub 1-0:1.0: USB hub found
[   18.322387] hub 1-0:1.0: 2 ports detected
[   18.338699] PM: Adding info for No Bus:usbdev1.1_ep81
[   18.349775] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 21 (level, low) -> IRQ 21
[   18.360857] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   18.371972] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   18.383174] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[   18.394317] uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000bf60
[   18.405226] PM: Adding info for usb:usb2
[   18.415946] PM: Adding info for No Bus:usbdev2.1_ep00
[   18.426510] usb usb2: configuration #1 chosen from 1 choice
[   18.437082] PM: Adding info for usb:2-0:1.0
[   18.447647] hub 2-0:1.0: USB hub found
[   18.458119] hub 2-0:1.0: 2 ports detected
[   18.476337] PM: Adding info for No Bus:usbdev2.1_ep81
[   18.486939] usb 1-1: new full speed USB device using uhci_hcd and address 2
[   18.486980] IOAPIC[0]: Set PCI routing entry (2-22 -> 0x81 -> IRQ 22 Mode:1 Active:1)
[   18.486983] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 22 (level, low) -> IRQ 22
[   18.486988] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   18.486991] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   18.487008] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[   18.487036] uhci_hcd 0000:00:1d.2: irq 22, io base 0x0000bf40
[   18.487069] PM: Adding info for usb:usb3
[   18.487094] PM: Adding info for No Bus:usbdev3.1_ep00
[   18.487106] usb usb3: configuration #1 chosen from 1 choice
[   18.487112] PM: Adding info for usb:3-0:1.0
[   18.487124] hub 3-0:1.0: USB hub found
[   18.487128] hub 3-0:1.0: 2 ports detected
[   18.587183] PM: Adding info for No Bus:usbdev3.1_ep81
[   18.587251] IOAPIC[0]: Set PCI routing entry (2-23 -> 0x89 -> IRQ 23 Mode:1 Active:1)
[   18.587253] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 23
[   18.587259] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[   18.587261] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[   18.587288] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[   18.587315] uhci_hcd 0000:00:1d.3: irq 23, io base 0x0000bf20
[   18.587350] PM: Adding info for usb:usb4
[   18.587387] PM: Adding info for No Bus:usbdev4.1_ep00
[   18.587410] usb usb4: configuration #1 chosen from 1 choice
[   18.587416] PM: Adding info for usb:4-0:1.0
[   18.587439] hub 4-0:1.0: USB hub found
[   18.587443] hub 4-0:1.0: 2 ports detected
[   18.688115] PM: Adding info for No Bus:usbdev4.1_ep81
[   18.807387] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[   18.831535] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
[   18.844449] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   18.856402] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   18.868352] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[   18.880229] ehci_hcd 0000:00:1d.7: debug port 1
[   18.891807] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   18.903517] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xffa80000
[   18.919094] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   18.930410] usb 1-1: device descriptor read/all, error -71
[   18.942686] PM: Adding info for usb:usb5
[   18.954423] PM: Adding info for No Bus:usbdev5.1_ep00
[   18.966156] usb usb5: configuration #1 chosen from 1 choice
[   18.977887] PM: Adding info for usb:5-0:1.0
[   18.989672] hub 5-0:1.0: USB hub found
[   19.001332] hub 5-0:1.0: 8 ports detected
[   19.021318] PM: Adding info for No Bus:usbdev5.1_ep81
[   19.226818] usb 5-1: new high speed USB device using ehci_hcd and address 2
[   19.332017] Kernel panic - not syncing: Attempted to kill init!
[   19.341158] PM: Adding info for usb:5-1
[   19.341199] PM: Adding info for No Bus:usbdev5.2_ep00
[   19.341211] usb 5-1: configuration #1 chosen from 1 choice
[   19.341274] PM: Adding info for usb:5-1:1.0
[   19.341288] hub 5-1:1.0: USB hub found
[   19.341397] hub 5-1:1.0: 4 ports detected
[   19.341536] PM: Adding info for No Bus:usbdev5.2_ep81
[   19.419600]  
--------------010607040101080205050209
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express PCI Express Root Port (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 01)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controller IDE (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation GeForce Go 7900 GS (rev a1)
03:00.0 Ethernet controller: Broadcom Corporation BCM4401-B0 100Base-TX (rev 02)
03:01.0 FireWire (IEEE 1394): Ricoh Co Ltd Unknown device 0832
03:01.1 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 19)
03:01.2 System peripheral: Ricoh Co Ltd Unknown device 0843 (rev 01)
03:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adapter (rev 0a)
03:01.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev 05)
0c:00.0 Network controller: Broadcom Corporation Unknown device 4328 (rev 01)

--------------010607040101080205050209--
