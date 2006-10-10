Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWJJSzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWJJSzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWJJSzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:55:44 -0400
Received: from gw.goop.org ([64.81.55.164]:30594 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750804AbWJJSzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:55:42 -0400
Message-ID: <452BECAE.2070001@goop.org>
Date: Tue, 10 Oct 2006 11:55:42 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: linux-thinkpad@linux-thinkpad.org
CC: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       acpi-devel@kernel.org, Pavel Machek <pavel@suse.cz>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: X60s w/t kern 2.6.19-rc1-git: two BUG warnings
References: <20061010062826.GC9895@gimli>
In-Reply-To: <20061010062826.GC9895@gimli>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Lorenz wrote:
> Dear kernel gurus,
>   

(CC:s added to various interested parties.)

> whatever I do and whic problem I seem to get fixed new ones arise:
>
> now I loose ACPI events after suspend/resume. not every time, but roughly 
> 3 out of 4 times.
>   

Yes, I'm seeing this as well.  It used to be a 100% failure, so there 
has been some improvement.  On the other hand, before that it used to 
work perfectly...  Unfortunately I don't have a good feeling for when 
these changes happened.

> the only errornous things I see in the logs are those: 
>
> [ 6727.089000] BUG: warning at drivers/pci/msi.c:680/pci_enable_msi()
> [ 6727.089000]  [<c0103bd9>] dump_trace+0x69/0x1af
> [ 6727.089000]  [<c0103d37>] show_trace_log_lvl+0x18/0x2c
> [ 6727.089000]  [<c01043d6>] show_trace+0xf/0x11
> [ 6727.089000]  [<c01044d9>] dump_stack+0x15/0x17
> [ 6727.089000]  [<c0208cd6>] pci_enable_msi+0x78/0x22e
> [ 6727.090000]  [<c0257fe5>] e1000_open+0x64/0x176
> [ 6727.091000]  [<c029b121>] dev_open+0x2b/0x62
> [ 6727.092000]  [<c0299c2f>] dev_change_flags+0x47/0xe4
> [ 6727.093000]  [<c02cdceb>] devinet_ioctl+0x252/0x556
> [ 6727.094000]  [<c0290e9a>] sock_ioctl+0x19e/0x1c2
> [ 6727.095000]  [<c016979b>] do_ioctl+0x1f/0x62
> [ 6727.095000]  [<c0169a23>] vfs_ioctl+0x245/0x257
> [ 6727.096000]  [<c0169a81>] sys_ioctl+0x4c/0x67
> [ 6727.096000]  [<c0102dc3>] syscall_call+0x7/0xb
> [ 6727.096000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> [ 6727.096000]
> [ 6727.096000] Leftover inexact backtrace:
> [ 6727.096000]
> [ 6727.096000]  [<c02e007b>] unix_stream_connect+0x15b/0x367
> [ 6727.096000]  =======================
>
> which occurs in variations but very often
>   

This just seems to be something thinking the IRQ isn't MSI-capable.  It 
doesn't seem to have any negative effect - the e1000 works fine anyway.

> and this one, which I noticed for the first time with the kernel I built
> from tha git yesterday:
>
> [19139.940000] BUG: warning at kernel/cpu.c:56/unlock_cpu_hotplug()
> [19139.940000]  [<c0103bd9>] dump_trace+0x69/0x1af
> [19139.940000]  [<c0103d37>] show_trace_log_lvl+0x18/0x2c
> [19139.940000]  [<c01043d6>] show_trace+0xf/0x11
> [19139.940000]  [<c01044d9>] dump_stack+0x15/0x17
> [19139.940000]  [<c0135c47>] unlock_cpu_hotplug+0x3d/0x66
> [19139.941000]  [<f92927f3>] do_dbs_timer+0x1c2/0x229 [cpufreq_ondemand]
> [19139.941000]  [<c012cb21>] run_workqueue+0x83/0xc5
> [19139.941000]  [<c012d445>] worker_thread+0xd9/0x10c
> [19139.941000]  [<c012f9a6>] kthread+0xc2/0xf0
> [19139.942000]  [<c0103987>] kernel_thread_helper+0x7/0x10
> [19139.942000] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
> [19139.942000]
> [19139.942000] Leftover inexact backtrace:
> [19139.942000]
> [19139.942000]  =======================
>   

I haven't seen this one.

> dmesg log of latest startup is attached
>
> gruss
>   mlo
> --
> Dipl.-Ing. Martin Lorenz
>
>             They that can give up essential liberty 
> 	    to obtain a little temporary safety 
> 	    deserve neither liberty nor safety.
>                                    Benjamin Franklin
>
> please encrypt your mail to me
> GnuPG key-ID: F1AAD37D
> get it here:
> http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D
>
> ICQ UIN: 33588107
>   
> ------------------------------------------------------------------------
>
> 0.000000]     0:        0 ->   521952
> [    0.000000] On node 0 totalpages: 521952
> [    0.000000]   DMA zone: 32 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 4064 pages, LIFO batch:0
> [    0.000000]   Normal zone: 1760 pages used for memmap
> [    0.000000]   Normal zone: 223520 pages, LIFO batch:31
> [    0.000000]   HighMem zone: 2285 pages used for memmap
> [    0.000000]   HighMem zone: 290291 pages, LIFO batch:31
> [    0.000000] DMI present.
> [    0.000000] ACPI: RSDP (v002 LENOVO                                ) @ 0x000f6870
> [    0.000000] ACPI: XSDT (v001 LENOVO TP-7B    0x00001100  LTP 0x00000000) @ 0x7f6e6526
> [    0.000000] ACPI: FADT (v003 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6e6600
> [    0.000000] ACPI: SSDT (v001 LENOVO TP-7B    0x00001100 MSFT 0x0100000e) @ 0x7f6e67b4
> [    0.000000] ACPI: ECDT (v001 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6f2d45
> [    0.000000] ACPI: TCPA (v002 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6f2d97
> [    0.000000] ACPI: MADT (v001 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6f2dc9
> [    0.000000] ACPI: MCFG (v001 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6f2e31
> [    0.000000] ACPI: HPET (v001 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6f2e6f
> [    0.000000] ACPI: BOOT (v001 LENOVO TP-7B    0x00001100  LTP 0x00000001) @ 0x7f6f2fd8
> [    0.000000] ACPI: SSDT (v001 LENOVO TP-7B    0x00001100 INTL 0x20050513) @ 0x7f6e5ae1
> [    0.000000] ACPI: SSDT (v001 LENOVO TP-7B    0x00001100 INTL 0x20050513) @ 0x7f6e5909
> [    0.000000] ACPI: DSDT (v001 LENOVO TP-7B    0x00001100 MSFT 0x0100000e) @ 0x00000000
> [    0.000000] ACPI: PM-Timer IO Port: 0x1008
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> [    0.000000] Processor #0 6:14 APIC version 20
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> [    0.000000] Processor #1 6:14 APIC version 20
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ2 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
> [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
> [    0.000000] Detected 1662.676 MHz processor.
> [   10.988176] Built 1 zonelists.  Total pages: 517875
> [   10.988180] Kernel command line: root=/dev/sda5 ro resume
> [   10.988475] mapped APIC to ffffd000 (fee00000)
> [   10.988479] mapped IOAPIC to ffffc000 (fec00000)
> [   10.988484] Enabling fast FPU save and restore... done.
> [   10.988488] Enabling unmasked SIMD FPU exception support... done.
> [   10.988493] Initializing CPU#0
> [   10.988575] PID hash table entries: 4096 (order: 12, 16384 bytes)
> [   10.990333] Console: colour VGA+ 80x25
> [   10.994766] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [   10.995375] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [   11.137588] Memory: 2065764k/2087808k available (1941k kernel code, 20796k reserved, 775k data, 176k init, 1170304k highmem)
> [   11.137746] virtual kernel memory layout:
> [   11.137748]     fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
> [   11.137750]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
> [   11.137752]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
> [   11.137754]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
> [   11.137757]       .init : 0xc0406000 - 0xc0432000   ( 176 kB)
> [   11.137759]       .data : 0xc02e5485 - 0xc03a7414   ( 775 kB)
> [   11.137761]       .text : 0xc0100000 - 0xc02e5485   (1941 kB)
> [   11.138489] Checking if this processor honours the WP bit even in supervisor mode... Ok.
> [   11.138868] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [   11.139143] hpet0: 3 64-bit timers, 14318180 Hz
> [   11.140237] Using HPET for base-timer
> [   11.199778] Calibrating delay using timer specific routine.. 3328.31 BogoMIPS (lpj=1664157)
> [   11.200009] Security Framework v1.0.0 initialized
> [   11.200106] Capability LSM initialized
> [   11.200217] Mount-cache hash table entries: 512
> [   11.200447] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
> [   11.200458] monitor/mwait feature present.
> [   11.200549] using mwait in idle threads.
> [   11.200641] CPU: L1 I cache: 32K, L1 D cache: 32K
> [   11.200790] CPU: L2 cache: 2048K
> [   11.200880] CPU: Physical Processor ID: 0
> [   11.200970] CPU: Processor Core ID: 0
> [   11.201061] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
> [   11.201072] Intel machine check architecture supported.
> [   11.201172] Intel machine check reporting enabled on CPU#0.
> [   11.201269] Compat vDSO mapped to ffffe000.
> [   11.201373] Checking 'hlt' instruction... OK.
> [   11.204941] SMP alternatives: switching to UP code
> [   11.205258] ACPI: Core revision 20060707
> [   11.229264] CPU0: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
> [   11.229543] SMP alternatives: switching to SMP code
> [   11.229703] Booting processor 1/1 eip 3000
> [   11.240934] Initializing CPU#1
> [   11.300963] Calibrating delay using timer specific routine.. 3325.07 BogoMIPS (lpj=1662537)
> [   11.300972] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
> [   11.300981] monitor/mwait feature present.
> [   11.300986] CPU: L1 I cache: 32K, L1 D cache: 32K
> [   11.300989] CPU: L2 cache: 2048K
> [   11.300993] CPU: Physical Processor ID: 0
> [   11.300995] CPU: Processor Core ID: 1
> [   11.300998] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
> [   11.301006] Intel machine check architecture supported.
> [   11.301015] Intel machine check reporting enabled on CPU#1.
> [   11.301240] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
> [   11.302362] Total of 2 processors activated (6653.38 BogoMIPS).
> [   11.302665] ENABLING IO-APIC IRQs
> [   11.302970] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> [   11.414447] checking TSC synchronization across 2 CPUs: 
> [    0.000082] CPU#0 had -172 usecs TSC skew, fixed it up.
> [    0.000175] CPU#1 had 172 usecs TSC skew, fixed it up.
> [    0.000944] Brought up 2 CPUs
> [    0.121364] migration_cost=102
> [    0.122165] NET: Registered protocol family 16
> [    0.122358] ACPI: bus type pci registered
> [    0.122456] PCI: Using MMCONFIG
> [    0.123378] Setting up standard PCI resources
> [    0.127583] ACPI: Found ECDT
> [    0.142088] ACPI: Interpreter enabled
> [    0.142179] ACPI: Using IOAPIC for interrupt routing
> [    0.143679] ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11)
> [    0.145271] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 7 9 10 11)
> [    0.146865] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11)
> [    0.148442] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 9 10 11)
> [    0.150040] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
> [    0.151627] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
> [    0.153220] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 *10 11)
> [    0.154813] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
> [    0.156017] ACPI: PCI Root Bridge [PCI0] (0000:00)
> [    0.156113] PCI: Probing PCI hardware (bus 00)
> [    0.161185] Boot video device is 0000:00:02.0
> [    0.161829] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> [    0.163158] PCI: Transparent bridge - 0000:00:1e.0
> [    0.163401] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> [    0.170804] ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
> [    0.171493] ACPI: Power Resource [PUBS] (on)
> [    0.173984] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
> [    0.174296] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
> [    0.174605] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
> [    0.174985] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
> [    0.175354] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
> [    0.178116] Linux Plug and Play Support v0.97 (c) Adam Belay
> [    0.178222] pnp: PnP ACPI init
> [    0.184979] pnp: PnP ACPI: found 12 devices
> [    0.185103] intel_rng: FWH not detected
> [    0.185373] SCSI subsystem initialized
> [    0.185551] PCI: Using ACPI for IRQ routing
> [    0.185668] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> [    0.187308] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
> [    0.187407] PCI: Bridge: 0000:00:1c.0
> [    0.187498]   IO window: 2000-2fff
> [    0.187591]   MEM window: ee000000-ee0fffff
> [    0.187693]   PREFETCH window: disabled.
> [    0.187786] PCI: Bridge: 0000:00:1c.1
> [    0.187877]   IO window: 3000-4fff
> [    0.187970]   MEM window: ec000000-edffffff
> [    0.188063]   PREFETCH window: e4000000-e40fffff
> [    0.188157] PCI: Bridge: 0000:00:1c.2
> [    0.188247]   IO window: 5000-6fff
> [    0.188340]   MEM window: e8000000-e9ffffff
> [    0.188433]   PREFETCH window: e4100000-e41fffff
> [    0.188527] PCI: Bridge: 0000:00:1c.3
> [    0.188618]   IO window: 7000-8fff
> [    0.188721]   MEM window: ea000000-ebffffff
> [    0.188814]   PREFETCH window: e4200000-e42fffff
> [    0.188914] PCI: Bus 22, cardbus bridge: 0000:15:00.0
> [    0.189006]   IO window: 00009000-000090ff
> [    0.189100]   IO window: 00009400-000094ff
> [    0.189194]   PREFETCH window: e0000000-e1ffffff
> [    0.189288]   MEM window: e6000000-e7ffffff
> [    0.189381] PCI: Bridge: 0000:00:1e.0
> [    0.189472]   IO window: 9000-cfff
> [    0.189566]   MEM window: e4300000-e7ffffff
> [    0.189667]   PREFETCH window: e0000000-e3ffffff
> [    0.189786] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 16
> [    0.189971] PCI: Setting latency timer of device 0000:00:1c.0 to 64
> [    0.189994] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 17
> [    0.190178] PCI: Setting latency timer of device 0000:00:1c.1 to 64
> [    0.190200] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 18
> [    0.190384] PCI: Setting latency timer of device 0000:00:1c.2 to 64
> [    0.190406] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 19
> [    0.190589] PCI: Setting latency timer of device 0000:00:1c.3 to 64
> [    0.190601] PCI: Enabling device 0000:00:1e.0 (0005 -> 0007)
> [    0.190707] PCI: Setting latency timer of device 0000:00:1e.0 to 64
> [    0.190726] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
> [    0.190911] PCI: Setting latency timer of device 0000:15:00.0 to 64
> [    0.190946] NET: Registered protocol family 2
> [    0.203671] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.203915] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.206843] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
> [    0.207649] TCP: Hash tables configured (established 262144 bind 65536)
> [    0.207745] TCP reno registered
> [    0.208057] Simple Boot Flag at 0x35 set to 0x1
> [    0.208793] audit: initializing netlink socket (disabled)
> [    0.208902] audit(1160409368.666:1): initialized
> [    0.209086] highmem bounce pool size: 64 pages
> [    0.209438] io scheduler noop registered
> [    0.209575] io scheduler anticipatory registered
> [    0.209719] io scheduler deadline registered
> [    0.209872] io scheduler cfq registered (default)
> [    0.210366] PCI: Setting latency timer of device 0000:00:1c.0 to 64
> [    0.210419] assign_interrupt_mode Found MSI capability
> [    0.210568] Allocate Port Service[0000:00:1c.0:pcie00]
> [    0.210632] Allocate Port Service[0000:00:1c.0:pcie02]
> [    0.210689] Allocate Port Service[0000:00:1c.0:pcie03]
> [    0.210810] PCI: Setting latency timer of device 0000:00:1c.1 to 64
> [    0.210863] assign_interrupt_mode Found MSI capability
> [    0.211822] Allocate Port Service[0000:00:1c.1:pcie00]
> [    0.211872] Allocate Port Service[0000:00:1c.1:pcie02]
> [    0.211920] Allocate Port Service[0000:00:1c.1:pcie03]
> [    0.212036] PCI: Setting latency timer of device 0000:00:1c.2 to 64
> [    0.212089] assign_interrupt_mode Found MSI capability
> [    0.212222] Allocate Port Service[0000:00:1c.2:pcie00]
> [    0.212270] Allocate Port Service[0000:00:1c.2:pcie02]
> [    0.212324] Allocate Port Service[0000:00:1c.2:pcie03]
> [    0.212438] PCI: Setting latency timer of device 0000:00:1c.3 to 64
> [    0.212490] assign_interrupt_mode Found MSI capability
> [    0.212629] Allocate Port Service[0000:00:1c.3:pcie00]
> [    0.212679] Allocate Port Service[0000:00:1c.3:pcie02]
> [    0.212727] Allocate Port Service[0000:00:1c.3:pcie03]
> [    0.246180] Real Time Clock Driver v1.12ac
> [    0.246337] hpet_resources: 0xfed00000 is busy
> [    0.246366] Linux agpgart interface v0.101 (c) Dave Jones
> [    0.246504] agpgart: Detected an Intel 945GM Chipset.
> [    0.248482] agpgart: Detected 7932K stolen memory.
> [    0.266093] agpgart: AGP aperture is 256M @ 0xd0000000
> [    0.266235] [drm] Initialized drm 1.0.1 20051102
> [    0.266742] loop: loaded (max 8 devices)
> [    0.266833] Intel(R) PRO/1000 Network Driver - version 7.2.9-k2-NAPI
> [    0.266927] Copyright (c) 1999-2006 Intel Corporation.
> [    0.267094] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
> [    0.267287] PCI: Setting latency timer of device 0000:02:00.0 to 64
> [    0.311969] e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 00:16:d3:22:9b:82
> [    0.357365] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> [    0.357603] netconsole: not configured, aborting
> [    0.357812] libata version 2.00 loaded.
> [    0.357864] ahci 0000:00:1f.2: version 2.0
> [    0.357883] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
> [    1.359804] PCI: Setting latency timer of device 0000:00:1f.2 to 64
> [    1.359814] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
> [    1.359958] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
> [    1.360145] ata1: SATA max UDMA/133 cmd 0xF8824500 ctl 0x0 bmdma 0x0 irq 219
> [    1.360316] ata2: SATA max UDMA/133 cmd 0xF8824580 ctl 0x0 bmdma 0x0 irq 219
> [    1.360483] ata3: SATA max UDMA/133 cmd 0xF8824600 ctl 0x0 bmdma 0x0 irq 219
> [    1.360652] ata4: SATA max UDMA/133 cmd 0xF8824680 ctl 0x0 bmdma 0x0 irq 219
> [    1.360757] scsi0 : ahci
> [    1.819063] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.819518] ata1.00: ATA-7, max UDMA/100, 156301488 sectors: LBA48 NCQ (depth 31/32)
> [    1.819656] ata1.00: ata1: dev 0 multi count 16
> [    1.822069] ata1.00: configured for UDMA/100
> [    1.822171] scsi1 : ahci
> [    2.125563] ata2: SATA link down (SStatus 0 SControl 0)
> [    2.125671] scsi2 : ahci
> [    2.429081] ata3: SATA link down (SStatus 0 SControl 0)
> [    2.429184] scsi3 : ahci
> [    2.732599] ata4: SATA link down (SStatus 0 SControl 0)
> [    2.732827] scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2080B 0084 PQ: 0 ANSI: 5
> [    2.733101] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> [    2.733212] sda: Write Protect is off
> [    2.733304] sda: Mode Sense: 00 3a 00 00
> [    2.733330] SCSI device sda: drive cache: write back
> [    2.733483] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> [    2.733594] sda: Write Protect is off
> [    2.733685] sda: Mode Sense: 00 3a 00 00
> [    2.733711] SCSI device sda: drive cache: write back
> [    2.733807]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
> [    2.901379] sd 0:0:0:0: Attached scsi disk sda
> [    2.901674] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> [    2.914016] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    2.914114] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    2.914374] mice: PS/2 mouse device common for all mice
> [    2.914474] i2c /dev entries driver
> [    2.914717] ACPI: PCI Interrupt 0000:00:1f.3[A] -> GSI 23 (level, low) -> IRQ 19
> [    2.915009] EDAC MC: Ver: 2.0.1 Oct  9 2006
> [    2.915740] TCP bic registered
> [    2.915839] NET: Registered protocol family 1
> [    2.915937] NET: Registered protocol family 17
> [    2.916081] Starting balanced_irq
> [    2.916186] Using IPI No-Shortcut mode
> [    2.916441] Time: tsc clocksource has been installed.
> [    2.916812] ACPI: (supports S0 S3 S4 S5)
> [    2.917210] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
> [    2.920441] input: AT Translated Set 2 keyboard as /class/input/input0
> [    3.020737] VFS: Mounted root (ext2 filesystem) readonly.
> [    3.020973] Freeing unused kernel memory: 176k freed
> [    6.202832] input: PC Speaker as /class/input/input1
> [    6.607441] sdhci: Secure Digital Host Controller Interface driver, 0.12
> [    6.607546] sdhci: Copyright(c) Pierre Ossman
> [    6.607682] sdhci: SDHCI controller found at 0000:15:00.2 [1180:0822] (rev 18)
> [    6.607846] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 21
> [    6.608047] PCI: Setting latency timer of device 0000:15:00.2 to 64
> [    6.608103] mmc0: SDHCI at 0xe4301800 irq 21 DMA
> [    6.646130] usbcore: registered new interface driver usbfs
> [    6.646259] usbcore: registered new interface driver hub
> [    6.646388] usbcore: registered new device driver usb
> [    6.650159] USB Universal Host Controller Interface driver v3.0
> [    6.650315] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
> [    6.650513] PCI: Setting latency timer of device 0000:00:1d.0 to 64
> [    6.650519] uhci_hcd 0000:00:1d.0: UHCI Host Controller
> [    6.650807] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
> [    6.650981] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001820
> [    6.651217] usb usb1: configuration #1 chosen from 1 choice
> [    6.651352] hub 1-0:1.0: USB hub found
> [    6.651452] hub 1-0:1.0: 2 ports detected
> [    6.676620] ieee1394: Initialized config rom entry `ip1394'
> [    6.738535] irda_init()
> [    6.738560] NET: Registered protocol family 23
> [    6.752380] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 22
> [    6.752576] PCI: Setting latency timer of device 0000:00:1d.1 to 64
> [    6.752582] uhci_hcd 0000:00:1d.1: UHCI Host Controller
> [    6.752712] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
> [    6.753217] uhci_hcd 0000:00:1d.1: irq 22, io base 0x00001840
> [    6.753441] usb usb2: configuration #1 chosen from 1 choice
> [    6.753575] hub 2-0:1.0: USB hub found
> [    6.753671] hub 2-0:1.0: 2 ports detected
> [    6.768283] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> [    6.768384] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> [    6.855215] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 21
> [    6.855414] PCI: Setting latency timer of device 0000:00:1d.2 to 64
> [    6.855420] uhci_hcd 0000:00:1d.2: UHCI Host Controller
> [    6.855548] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
> [    6.855719] uhci_hcd 0000:00:1d.2: irq 21, io base 0x00001860
> [    6.855945] usb usb3: configuration #1 chosen from 1 choice
> [    6.856307] hub 3-0:1.0: USB hub found
> [    6.856409] hub 3-0:1.0: 2 ports detected
> [    6.958045] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
> [    6.958244] PCI: Setting latency timer of device 0000:00:1d.3 to 64
> [    6.958250] uhci_hcd 0000:00:1d.3: UHCI Host Controller
> [    6.958376] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
> [    6.958546] uhci_hcd 0000:00:1d.3: irq 23, io base 0x00001880
> [    6.958766] usb usb4: configuration #1 chosen from 1 choice
> [    6.958902] hub 4-0:1.0: USB hub found
> [    6.958998] hub 4-0:1.0: 2 ports detected
> [    7.059898] ACPI: PCI Interrupt 0000:15:00.1[B] -> GSI 17 (level, low) -> IRQ 22
> [    7.060091] PCI: Setting latency timer of device 0000:15:00.1 to 64
> [    7.113620] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[22]  MMIO=[e4301000-e43017ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
> [    7.121654] Yenta: CardBus bridge found at 0000:15:00.0 [17aa:201c]
> [    7.121936] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 22
> [    7.122188] PCI: Setting latency timer of device 0000:00:1b.0 to 64
> [    7.216762] IBM TrackPoint firmware: 0x0e, buttons: 3/3
> [    7.238439] input: TPPS/2 IBM TrackPoint as /class/input/input2
> [    7.243432] pnp: Device 00:0a activated.
> [    7.243537] nsc_ircc_pnp_probe() : From PnP, found firbase 0x3F8 ; irq 4 ; dma 1.
> [    7.243564] nsc-ircc, chip->init
> [    7.243673] nsc-ircc, Found chip at base=0x164e
> [    7.243820] nsc-ircc, driver loaded (Dag Brattli)
> [    7.244005] IrDA: Registered device irda0
> [    7.244166] nsc-ircc, Found dongle: No dongle connected
> [    7.244177] Yenta: ISA IRQ mask 0x0ca8, PCI irq 20
> [    7.244182] Socket status: 30000006
> [    7.244187] pcmcia: parent PCI bridge I/O window: 0x9000 - 0xcfff
> [    7.244193] pcmcia: parent PCI bridge Memory window: 0xe4300000 - 0xe7ffffff
> [    7.244197] pcmcia: parent PCI bridge Memory window: 0xe0000000 - 0xe3ffffff
> [    7.244831] nsc_ircc_init_dongle_interface(), No dongle connected
> [    7.266405] usb 4-1: new full speed USB device using uhci_hcd and address 2
> [    7.378225] ohci1394: fw-host0: Running dma failed because Node ID is not valid
> [    7.419070] usb 4-1: configuration #1 chosen from 1 choice
> [    7.471389] Bluetooth: Core ver 2.10
> [    7.471953] NET: Registered protocol family 31
> [    7.472045] Bluetooth: HCI device and connection manager initialized
> [    7.472145] Bluetooth: HCI socket layer initialized
> [    7.475867] Bluetooth: HCI USB driver ver 2.9
> [    7.627824] usb 4-2: new full speed USB device using uhci_hcd and address 3
> [    7.793503] usb 4-2: configuration #1 chosen from 1 choice
> [    7.799610] usbcore: registered new interface driver hci_usb
> [    8.121070] ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
> [    8.122066] ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> [    8.166961] hda_intel: azx_get_response timeout, switching to polling mode...
> [    8.379809] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae40600192017]
> [    8.434607] eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> [    9.166374] hda_intel: azx_get_response timeout, switching to single_cmd mode...
> [   19.928134] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
> [   19.928348] PCI: Setting latency timer of device 0000:00:1d.7 to 64
> [   19.928354] ehci_hcd 0000:00:1d.7: EHCI Host Controller
> [   19.928503] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
> [   19.928680] ehci_hcd 0000:00:1d.7: debug port 1
> [   19.928777] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
> [   19.928787] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xee444000
> [   19.932775] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> [   19.933033] usb usb5: configuration #1 chosen from 1 choice
> [   19.933165] hub 5-0:1.0: USB hub found
> [   19.933265] hub 5-0:1.0: 8 ports detected
> [   20.343831] usb 4-1: USB disconnect, address 2
> [   20.549302] usb 4-1: new full speed USB device using uhci_hcd and address 4
> [   20.708779] usb 4-1: configuration #1 chosen from 1 choice
> [   20.714155] usb 4-2: USB disconnect, address 3
> [   20.764281] Adding 1951856k swap on /dev/sda12.  Priority:-1 extents:1 across:1951856k
> [   20.765499] Adding 2931820k swap on /dev/sda13.  Priority:-2 extents:1 across:2931820k
> [   20.919710] usb 4-2: new full speed USB device using uhci_hcd and address 5
> [   21.083203] usb 4-2: configuration #1 chosen from 1 choice
> [   23.087999] Non-volatile memory driver v1.2
> [   23.126995] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
> [   23.127095] ieee1394: sbp2: Try serialize_io=0 for better performance
> [   23.144110] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
> [   23.144212] ibm_acpi: http://ibm-acpi.sf.net/
> [   23.184177] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
> [   23.184941] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
> [   23.186278] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> [   23.186556] ACPI: Processor [CPU0] (supports 8 throttling states)
> [   23.187723] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
> [   23.188422] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
> [   23.189798] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
> [   23.190075] ACPI: Processor [CPU1] (supports 8 throttling states)
> [   23.412000] Time: hpet clocksource has been installed.
> [   43.524000] ReiserFS: sda14: found reiserfs format "3.6" with standard journal
> [   43.524000] ReiserFS: sda14: warning: CONFIG_REISERFS_CHECK is set ON
> [   43.524000] ReiserFS: sda14: warning: - it is slow mode for debugging.
> [   43.524000] ReiserFS: sda14: using ordered data mode
> [   43.548000] ReiserFS: sda14: journal params: device sda14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   43.548000] ReiserFS: sda14: checking transaction log (sda14)
> [   43.548000] ReiserFS: sda14: journal-1153: found in header: first_unflushed_offset 2438, last_flushed_trans_id 16379
> [   43.559000] ReiserFS: sda14: journal-1006: found valid transaction start offset 4294969734, len 14195 id 4096
> [   43.559000] ReiserFS: sda14: journal-1206: Starting replay from offset 70351564310918, trans_id 3223276320
> [   43.559000] ReiserFS: sda14: journal-1037: journal_read_transaction, offset 4294969734, len 116 mount_id -140174536
> [   43.559000] ReiserFS: sda14: journal-1039: journal_read_trans skipping because 2438 is too old
> [   43.559000] ReiserFS: sda14: journal-1299: Setting newest_mount_id to 140
> [   43.603000] ReiserFS: sda14: Using r5 hash to sort names
> [   43.644000] ReiserFS: sda8: found reiserfs format "3.6" with standard journal
> [   43.644000] ReiserFS: sda8: warning: CONFIG_REISERFS_CHECK is set ON
> [   43.644000] ReiserFS: sda8: warning: - it is slow mode for debugging.
> [   43.645000] ReiserFS: sda8: using ordered data mode
> [   43.652000] ReiserFS: sda8: journal params: device sda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   43.652000] ReiserFS: sda8: checking transaction log (sda8)
> [   43.652000] ReiserFS: sda8: journal-1153: found in header: first_unflushed_offset 5636, last_flushed_trans_id 467806
> [   43.665000] ReiserFS: sda8: journal-1206: Starting replay from offset 2009215765845508, trans_id 3223276320
> [   43.665000] ReiserFS: sda8: journal-1299: Setting newest_mount_id to 140
> [   43.681000] ReiserFS: sda8: Using r5 hash to sort names
> [   43.729000] ReiserFS: sda11: found reiserfs format "3.6" with standard journal
> [   43.729000] ReiserFS: sda11: warning: CONFIG_REISERFS_CHECK is set ON
> [   43.729000] ReiserFS: sda11: warning: - it is slow mode for debugging.
> [   43.730000] ReiserFS: sda11: using ordered data mode
> [   43.735000] ReiserFS: sda11: journal params: device sda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   43.735000] ReiserFS: sda11: checking transaction log (sda11)
> [   43.735000] ReiserFS: sda11: journal-1153: found in header: first_unflushed_offset 5526, last_flushed_trans_id 7312
> [   43.750000] ReiserFS: sda11: journal-1206: Starting replay from offset 31409095841174, trans_id 3223276320
> [   43.750000] ReiserFS: sda11: journal-1299: Setting newest_mount_id to 140
> [   43.757000] ReiserFS: sda11: Using r5 hash to sort names
> [   43.774000] ReiserFS: sda10: found reiserfs format "3.6" with standard journal
> [   43.774000] ReiserFS: sda10: warning: CONFIG_REISERFS_CHECK is set ON
> [   43.774000] ReiserFS: sda10: warning: - it is slow mode for debugging.
> [   43.774000] ReiserFS: sda10: using ordered data mode
> [   43.784000] ReiserFS: sda10: journal params: device sda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   43.785000] ReiserFS: sda10: checking transaction log (sda10)
> [   43.785000] ReiserFS: sda10: journal-1153: found in header: first_unflushed_offset 5535, last_flushed_trans_id 7315
> [   43.794000] ReiserFS: sda10: journal-1206: Starting replay from offset 31421980743071, trans_id 3223276320
> [   43.794000] ReiserFS: sda10: journal-1299: Setting newest_mount_id to 140
> [   43.829000] ReiserFS: sda10: Using r5 hash to sort names
> [   43.846000] ReiserFS: sda9: found reiserfs format "3.6" with standard journal
> [   43.846000] ReiserFS: sda9: warning: CONFIG_REISERFS_CHECK is set ON
> [   43.846000] ReiserFS: sda9: warning: - it is slow mode for debugging.
> [   43.846000] ReiserFS: sda9: using ordered data mode
> [   43.852000] ReiserFS: sda9: journal params: device sda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   43.853000] ReiserFS: sda9: checking transaction log (sda9)
> [   43.853000] ReiserFS: sda9: journal-1153: found in header: first_unflushed_offset 180, last_flushed_trans_id 57906
> [   43.859000] ReiserFS: sda9: journal-1206: Starting replay from offset 248708671209652, trans_id 3223276320
> [   43.859000] ReiserFS: sda9: journal-1299: Setting newest_mount_id to 140
> [   43.868000] ReiserFS: sda9: Using r5 hash to sort names
> [   43.895000] ReiserFS: sda7: found reiserfs format "3.6" with standard journal
> [   43.895000] ReiserFS: sda7: warning: CONFIG_REISERFS_CHECK is set ON
> [   43.895000] ReiserFS: sda7: warning: - it is slow mode for debugging.
> [   43.895000] ReiserFS: sda7: using ordered data mode
> [   43.900000] ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   43.901000] ReiserFS: sda7: checking transaction log (sda7)
> [   43.901000] ReiserFS: sda7: journal-1153: found in header: first_unflushed_offset 2520, last_flushed_trans_id 490625
> [   43.912000] ReiserFS: sda7: journal-1206: Starting replay from offset 2107222624569816, trans_id 4043657240
> [   43.912000] ReiserFS: sda7: journal-1299: Setting newest_mount_id to 140
> [   43.961000] ReiserFS: sda7: Using r5 hash to sort names
> [   44.023000] ReiserFS: sda6: found reiserfs format "3.6" with standard journal
> [   44.023000] ReiserFS: sda6: warning: CONFIG_REISERFS_CHECK is set ON
> [   44.023000] ReiserFS: sda6: warning: - it is slow mode for debugging.
> [   44.023000] ReiserFS: sda6: using ordered data mode
> [   44.027000] ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   44.027000] ReiserFS: sda6: checking transaction log (sda6)
> [   44.027000] ReiserFS: sda6: journal-1153: found in header: first_unflushed_offset 4938, last_flushed_trans_id 629512
> [   44.035000] ReiserFS: sda6: journal-1206: Starting replay from offset 2703737747411786, trans_id 10000000
> [   44.035000] ReiserFS: sda6: journal-1299: Setting newest_mount_id to 140
> [   44.075000] ReiserFS: sda6: Using r5 hash to sort names
>   
> ------------------------------------------------------------------------
>
> 4-1 still 2
> [ 6689.254000]  usbdev4.7_ep83: PM: resume from 0, parent 4-1:1.1 still 2
> [ 6689.254000]  usbdev4.7_ep03: PM: resume from 0, parent 4-1:1.1 still 2
> [ 6689.254000] usb 4-1:1.2: PM: resume from 2, parent 4-1 still 2
> [ 6689.254000]  usbdev4.7_ep84: PM: resume from 0, parent 4-1:1.2 still 2
> [ 6689.254000]  usbdev4.7_ep04: PM: resume from 0, parent 4-1:1.2 still 2
> [ 6689.254000] usb 4-1:1.3: PM: resume from 2, parent 4-1 still 2
> [ 6689.255000] Restarting tasks...<6>usb 4-1: USB disconnect, address 7
> [ 6689.304000]  done
> [ 6689.304000] Enabling non-boot CPUs ...
> [ 6689.312000] SMP alternatives: switching to SMP code
> [ 6689.312000] Booting processor 1/1 eip 3000
> [ 6689.323000] Initializing CPU#1
> [ 6689.384000] Calibrating delay using timer specific routine.. 3325.08 BogoMIPS (lpj=1662541)
> [ 6689.384000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
> [ 6689.384000] monitor/mwait feature present.
> [ 6689.384000] CPU: L1 I cache: 32K, L1 D cache: 32K
> [ 6689.384000] CPU: L2 cache: 2048K
> [ 6689.384000] CPU: Physical Processor ID: 0
> [ 6689.384000] CPU: Processor Core ID: 1
> [ 6689.384000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
> [ 6689.384000] Intel machine check architecture supported.
> [ 6689.384000] Intel machine check reporting enabled on CPU#1.
> [ 6689.384000] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
> [ 6689.411000] usb 4-2: USB disconnect, address 6
> [ 6689.416000] CPU1 is up
> [ 6689.617000] usb 4-2: new full speed USB device using uhci_hcd and address 8
> [ 6689.782000] usb 4-2: configuration #1 chosen from 1 choice
> [ 6690.199000] usb 4-1: new full speed USB device using uhci_hcd and address 9
> [ 6690.235000] ata1: waiting for device to spin up (7 secs)
> [ 6690.410000] usb 4-1: configuration #1 chosen from 1 choice
> [ 6697.814000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [ 6697.818000] ata1.00: configured for UDMA/100
> [ 6697.818000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> [ 6697.818000] sda: Write Protect is off
> [ 6697.818000] sda: Mode Sense: 00 3a 00 00
> [ 6697.819000] SCSI device sda: drive cache: write back
> [ 6708.389000] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> [ 6708.389000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
> [ 6727.082000] Trying to free already-free IRQ 20
> [ 6727.089000] BUG: warning at drivers/pci/msi.c:680/pci_enable_msi()
> [ 6727.089000]  [<c0103bd9>] dump_trace+0x69/0x1af
> [ 6727.089000]  [<c0103d37>] show_trace_log_lvl+0x18/0x2c
> [ 6727.089000]  [<c01043d6>] show_trace+0xf/0x11
> [ 6727.089000]  [<c01044d9>] dump_stack+0x15/0x17
> [ 6727.089000]  [<c0208cd6>] pci_enable_msi+0x78/0x22e
> [ 6727.090000]  [<c0257fe5>] e1000_open+0x64/0x176
> [ 6727.091000]  [<c029b121>] dev_open+0x2b/0x62
> [ 6727.092000]  [<c0299c2f>] dev_change_flags+0x47/0xe4
> [ 6727.093000]  [<c02cdceb>] devinet_ioctl+0x252/0x556
> [ 6727.094000]  [<c0290e9a>] sock_ioctl+0x19e/0x1c2
> [ 6727.095000]  [<c016979b>] do_ioctl+0x1f/0x62
> [ 6727.095000]  [<c0169a23>] vfs_ioctl+0x245/0x257
> [ 6727.096000]  [<c0169a81>] sys_ioctl+0x4c/0x67
> [ 6727.096000]  [<c0102dc3>] syscall_call+0x7/0xb
> [ 6727.096000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> [ 6727.096000] 
> [ 6727.096000] Leftover inexact backtrace:
> [ 6727.096000] 
> [ 6727.096000]  [<c02e007b>] unix_stream_connect+0x15b/0x367
> [ 6727.096000]  =======================
> [ 6728.719000] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> [ 6728.719000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
> [ 7203.710000] usb 5-5: new high speed USB device using ehci_hcd and address 10
> [ 7203.824000] usb 5-5: configuration #1 chosen from 1 choice
> [ 7203.825000] scsi5 : SCSI emulation for USB Mass Storage devices
> [ 7203.825000] usb-storage: device found at 10
> [ 7203.825000] usb-storage: waiting for device to settle before scanning
> [ 7208.827000] scsi 5:0:0:0: Direct-Access     USB 2.0  memory           0.00 PQ: 0 ANSI: 2
> [ 7208.828000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
> [ 7208.829000] sdb: Write Protect is off
> [ 7208.829000] sdb: Mode Sense: 00 00 00 00
> [ 7208.829000] sdb: assuming drive cache: write through
> [ 7208.830000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
> [ 7208.831000] sdb: Write Protect is off
> [ 7208.831000] sdb: Mode Sense: 00 00 00 00
> [ 7208.831000] sdb: assuming drive cache: write through
> [ 7208.831000]  sdb: sdb1
> [ 7209.019000] sd 5:0:0:0: Attached scsi removable disk sdb
> [ 7209.020000] usb-storage: device scan complete
> [10312.504000] usb 5-5: USB disconnect, address 10
> [16177.817000] e1000: eth0: e1000_watchdog: NIC Link is Down
> [16246.617000] ieee80211_crypt: registered algorithm 'NULL'
> [16246.622000] ieee80211: 802.11 data/management/control stack, git-1.1.13
> [16246.622000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
> [16246.644000] ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.1.0d
> [16246.644000] ipw3945: Copyright(c) 2003-2006 Intel Corporation
> [16246.644000] PCI: Enabling device 0000:03:00.0 (0100 -> 0102)
> [16246.644000] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 22
> [16246.644000] PCI: Setting latency timer of device 0000:03:00.0 to 64
> [16246.645000] ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
> [16249.005000] ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
> [16289.360000] ACPI: PCI interrupt for device 0000:03:00.0 disabled
> [16289.370000] ieee80211_crypt: unregistered algorithm 'NULL'
> [16290.440000] ieee80211_crypt: registered algorithm 'NULL'
> [16290.445000] ieee80211: 802.11 data/management/control stack, git-1.1.13
> [16290.446000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
> [16290.472000] ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.1.0d
> [16290.472000] ipw3945: Copyright(c) 2003-2006 Intel Corporation
> [16290.473000] PCI: Enabling device 0000:03:00.0 (0100 -> 0102)
> [16290.473000] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 22
> [16290.473000] PCI: Setting latency timer of device 0000:03:00.0 to 64
> [16290.473000] ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
> [16292.463000] ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
> [17693.710000] usb 5-5: new high speed USB device using ehci_hcd and address 11
> [17693.825000] usb 5-5: configuration #1 chosen from 1 choice
> [17693.825000] scsi6 : SCSI emulation for USB Mass Storage devices
> [17693.826000] usb-storage: device found at 11
> [17693.826000] usb-storage: waiting for device to settle before scanning
> [17698.828000] scsi 6:0:0:0: Direct-Access     USB 2.0  memory           0.00 PQ: 0 ANSI: 2
> [17698.830000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
> [17698.831000] sdb: Write Protect is off
> [17698.831000] sdb: Mode Sense: 00 00 00 00
> [17698.831000] sdb: assuming drive cache: write through
> [17698.833000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
> [17698.833000] sdb: Write Protect is off
> [17698.833000] sdb: Mode Sense: 00 00 00 00
> [17698.833000] sdb: assuming drive cache: write through
> [17698.833000]  sdb: sdb1
> [17699.021000] sd 6:0:0:0: Attached scsi removable disk sdb
> [17699.023000] usb-storage: device scan complete
> [19139.940000] BUG: warning at kernel/cpu.c:56/unlock_cpu_hotplug()
> [19139.940000]  [<c0103bd9>] dump_trace+0x69/0x1af
> [19139.940000]  [<c0103d37>] show_trace_log_lvl+0x18/0x2c
> [19139.940000]  [<c01043d6>] show_trace+0xf/0x11
> [19139.940000]  [<c01044d9>] dump_stack+0x15/0x17
> [19139.940000]  [<c0135c47>] unlock_cpu_hotplug+0x3d/0x66
> [19139.941000]  [<f92927f3>] do_dbs_timer+0x1c2/0x229 [cpufreq_ondemand]
> [19139.941000]  [<c012cb21>] run_workqueue+0x83/0xc5
> [19139.941000]  [<c012d445>] worker_thread+0xd9/0x10c
> [19139.941000]  [<c012f9a6>] kthread+0xc2/0xf0
> [19139.942000]  [<c0103987>] kernel_thread_helper+0x7/0x10
> [19139.942000] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
> [19139.942000] 
> [19139.942000] Leftover inexact backtrace:
> [19139.942000] 
> [19139.942000]  =======================
> [19461.079000] usb 5-5: USB disconnect, address 11
> [19461.081000] scsi 6:0:0:0: rejecting I/O to dead device
> [19461.081000] scsi 6:0:0:0: rejecting I/O to dead device
> [19461.081000] scsi 6:0:0:0: rejecting I/O to dead device
> [19461.081000] scsi 6:0:0:0: rejecting I/O to dead device
> [19461.081000] sdb : READ CAPACITY failed.
> [19461.081000] sdb : status=0, message=00, host=1, driver=00 
> [19461.081000] sdb : sense not available. 
> [19461.081000] scsi 6:0:0:0: rejecting I/O to dead device
> [19461.081000] sdb: Write Protect is off
> [19461.081000] sdb: Mode Sense: 00 00 00 00
> [19461.081000] sdb: assuming drive cache: write through
> [19461.081000] scsi 6:0:0:0: rejecting I/O to dead device
> [19461.081000] scsi 6:0:0:0: rejecting I/O to dead device
> [19461.081000] scsi 6:0:0:0: rejecting I/O to dead device
> [19461.081000] scsi 6:0:0:0: rejecting I/O to dead device
> [19461.081000] sdb : READ CAPACITY failed.
> [19461.081000] sdb : status=0, message=00, host=1, driver=00 
> [19461.081000] sdb : sense not available. 
> [19461.081000] scsi 6:0:0:0: rejecting I/O to dead device
> [19461.081000] sdb: Write Protect is off
> [19461.081000] sdb: Mode Sense: 00 00 00 00
> [19461.081000] sdb: assuming drive cache: write through
> [19930.960000] usb 5-5: new high speed USB device using ehci_hcd and address 12
> [19931.075000] usb 5-5: configuration #1 chosen from 1 choice
> [19931.076000] scsi7 : SCSI emulation for USB Mass Storage devices
> [19931.076000] usb-storage: device found at 12
> [19931.076000] usb-storage: waiting for device to settle before scanning
> [19936.078000] scsi 7:0:0:0: Direct-Access     USB 2.0  memory           0.00 PQ: 0 ANSI: 2
> [19936.081000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
> [19936.082000] sdb: Write Protect is off
> [19936.082000] sdb: Mode Sense: 00 00 00 00
> [19936.082000] sdb: assuming drive cache: write through
> [19936.084000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
> [19936.085000] sdb: Write Protect is off
> [19936.085000] sdb: Mode Sense: 00 00 00 00
> [19936.085000] sdb: assuming drive cache: write through
> [19936.085000]  sdb: sdb1
> [19936.273000] sd 7:0:0:0: Attached scsi removable disk sdb
> [19936.275000] usb-storage: device scan complete
> [21893.004000] usb 5-5: USB disconnect, address 12
> [22383.460000] usb 5-5: new high speed USB device using ehci_hcd and address 13
> [22383.574000] usb 5-5: configuration #1 chosen from 1 choice
> [22383.575000] scsi8 : SCSI emulation for USB Mass Storage devices
> [22383.575000] usb-storage: device found at 13
> [22383.575000] usb-storage: waiting for device to settle before scanning
> [22388.577000] scsi 8:0:0:0: Direct-Access     USB 2.0  memory           0.00 PQ: 0 ANSI: 2
> [22388.578000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
> [22388.579000] sdb: Write Protect is off
> [22388.579000] sdb: Mode Sense: 00 00 00 00
> [22388.579000] sdb: assuming drive cache: write through
> [22388.581000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
> [22388.582000] sdb: Write Protect is off
> [22388.582000] sdb: Mode Sense: 00 00 00 00
> [22388.582000] sdb: assuming drive cache: write through
> [22388.582000]  sdb: sdb1
> [22388.769000] sd 8:0:0:0: Attached scsi removable disk sdb
> [22388.770000] usb-storage: device scan complete
> [22435.504000] usb 5-5: USB disconnect, address 13
> [22692.710000] usb 5-5: new high speed USB device using ehci_hcd and address 14
> [22692.824000] usb 5-5: configuration #1 chosen from 1 choice
> [22692.825000] scsi9 : SCSI emulation for USB Mass Storage devices
> [22692.825000] usb-storage: device found at 14
> [22692.825000] usb-storage: waiting for device to settle before scanning
> [22697.826000] scsi 9:0:0:0: Direct-Access     USB 2.0  memory           0.00 PQ: 0 ANSI: 2
> [22697.828000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
> [22697.828000] sdb: Write Protect is off
> [22697.828000] sdb: Mode Sense: 00 00 00 00
> [22697.828000] sdb: assuming drive cache: write through
> [22697.830000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
> [22697.831000] sdb: Write Protect is off
> [22697.831000] sdb: Mode Sense: 00 00 00 00
> [22697.831000] sdb: assuming drive cache: write through
> [22697.831000]  sdb: sdb1
> [22698.019000] sd 9:0:0:0: Attached scsi removable disk sdb
> [22698.019000] usb-storage: device scan complete
> [22980.504000] usb 5-5: USB disconnect, address 14
> [56763.356000] ACPI: PCI interrupt for device 0000:03:00.0 disabled
> [56763.357000] ieee80211_crypt: unregistered algorithm 'NULL'
> [56767.070000] Disabling non-boot CPUs ...
> [56767.178000] CPU 1 is now offline
> [56767.178000] SMP alternatives: switching to UP code
> [56767.182000] CPU1 is down
> [56767.182000] Stopping tasks: =======================================================================================================================================================================================================================================================================|
> [56767.441000] Suspending console(s)
> [56767.453000]  usbdev4.8_ep83: PM: suspend 0->2, parent 4-2:1.0 already 2
> [56767.453000]  usbdev4.8_ep02: PM: suspend 0->2, parent 4-2:1.0 already 2
> [56767.453000]  usbdev4.8_ep81: PM: suspend 0->2, parent 4-2:1.0 already 2
> [56767.453000] usb 4-2:1.0: PM: suspend 2->2, parent 4-2 already 2
> [56767.453000]  usbdev4.8_ep00: PM: suspend 0->2, parent 4-2 already 2
> [56769.134000] pnp: Device 00:0a disabled.
> [56769.134000] ACPI: PCI interrupt for device 0000:15:00.2 disabled
> [56769.156000] ACPI: PCI interrupt for device 0000:15:00.0 disabled
> [56769.200000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
> [56769.213000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
> [56769.224000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
> [56769.335000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
> [56769.335000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
> [56769.335000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
> [56769.335000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
> [56769.337000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> [56769.337000] Intel machine check architecture supported.
> [56769.337000] Intel machine check reporting enabled on CPU#0.
> [56769.337000] Back to C!
> [57422.955000] PM: Writing back config space on device 0000:00:02.1 at offset 1 (was 900000, writing 900003)
> [57422.955000] PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100106, writing 100100)
> [57422.955000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
> [57422.955000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 22
> [57422.955000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
> [57422.974000] PM: Writing back config space on device 0000:00:1c.0 at offset 1 (was 100107, writing 100507)
> [57422.974000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
> [57422.974000] PM: Writing back config space on device 0000:00:1c.1 at offset 1 (was 100107, writing 100507)
> [57422.974000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
> [57422.974000] PM: Writing back config space on device 0000:00:1c.2 at offset 1 (was 100107, writing 100507)
> [57422.974000] PCI: Setting latency timer of device 0000:00:1c.2 to 64
> [57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset f (was 40400, writing 4040b)
> [57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset 9 (was 10001, writing e421e421)
> [57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset 8 (was 0, writing ebf0ea00)
> [57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset 7 (was 20000000, writing 8070)
> [57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset 3 (was 810000, writing 810010)
> [57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset 1 (was 100000, writing 100507)
> [57422.974000] PCI: Setting latency timer of device 0000:00:1c.3 to 64
> [57422.974000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
> [57422.974000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
> [57422.974000] usb usb1: root hub lost power or was reset
> [57422.974000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 22
> [57422.974000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
> [57422.974000] usb usb2: root hub lost power or was reset
> [57422.974000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 21
> [57422.974000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
> [57422.974000] usb usb3: root hub lost power or was reset
> [57422.974000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
> [57422.974000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
> [57422.974000] usb usb4: root hub lost power or was reset
> [57423.285000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
> [57423.285000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
> [57423.285000] PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was 100005, writing 100007)
> [57423.285000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
> [57423.296000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
> [57423.296000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
> [57424.308000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
> [57424.308000] PCI: Setting latency timer of device 0000:02:00.0 to 64
> [57424.351000] PM: Writing back config space on device 0000:03:00.0 at offset 1 (was 100106, writing 100100)
> [57424.351000] PM: Writing back config space on device 0000:15:00.0 at offset 1 (was 2100000, writing 2100007)
> [57424.351000] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
> [57424.393000] PM: Writing back config space on device 0000:15:00.1 at offset 4 (was 0, writing e4301000)
> [57424.393000] PM: Writing back config space on device 0000:15:00.1 at offset 3 (was 800000, writing 804000)
> [57424.393000] PM: Writing back config space on device 0000:15:00.1 at offset 1 (was 2100000, writing 2100006)
> [57424.404000] PM: Writing back config space on device 0000:15:00.2 at offset 4 (was 0, writing e4301800)
> [57424.404000] PM: Writing back config space on device 0000:15:00.2 at offset 3 (was 800000, writing 804000)
> [57424.404000] PM: Writing back config space on device 0000:15:00.2 at offset 1 (was 2100000, writing 2100006)
> [57424.404000] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 21
> [57424.415000] pnp: Device 00:08 does not support activation.
> [57424.415000] pnp: Device 00:09 does not support activation.
> [57424.416000] pnp: Device 00:0a activated.
> [57424.600000] ata2: SATA link down (SStatus 0 SControl 0)
> [57424.600000] ata3: SATA link down (SStatus 0 SControl 0)
> [57424.600000] ata4: SATA link down (SStatus 0 SControl 0)
> [57424.830000] nsc_ircc_init_dongle_interface(), No dongle connected
> [57424.830000] nsc_ircc_change_dongle_speed(), No dongle connected is not for IrDA mode
> [57424.842000]  usbdev4.8_ep00: PM: resume from 0, parent 4-2 still 2
> [57424.842000]  usbdev4.8_ep81: PM: resume from 0, parent 4-2:1.0 still 2
> [57424.842000]  usbdev4.8_ep02: PM: resume from 0, parent 4-2:1.0 still 2
> [57424.842000]  usbdev4.8_ep83: PM: resume from 0, parent 4-2:1.0 still 2
> [57424.842000]  usbdev4.9_ep00: PM: resume from 0, parent 4-1 still 2
> [57424.842000] hci_usb 4-1:1.0: PM: resume from 2, parent 4-1 still 2
> [57424.842000]  hci0: PM: resume from 0, parent 4-1:1.0 still 2
> [57424.842000]  usbdev4.9_ep81: PM: resume from 0, parent 4-1:1.0 still 2
> [57424.842000]  usbdev4.9_ep82: PM: resume from 0, parent 4-1:1.0 still 2
> [57424.842000]  usbdev4.9_ep02: PM: resume from 0, parent 4-1:1.0 still 2
> [57424.842000] hci_usb 4-1:1.1: PM: resume from 2, parent 4-1 still 2
> [57424.842000]  usbdev4.9_ep83: PM: resume from 0, parent 4-1:1.1 still 2
> [57424.842000]  usbdev4.9_ep03: PM: resume from 0, parent 4-1:1.1 still 2
> [57424.842000] usb 4-1:1.2: PM: resume from 2, parent 4-1 still 2
> [57424.842000]  usbdev4.9_ep84: PM: resume from 0, parent 4-1:1.2 still 2
> [57424.842000]  usbdev4.9_ep04: PM: resume from 0, parent 4-1:1.2 still 2
> [57424.842000] usb 4-1:1.3: PM: resume from 2, parent 4-1 still 2
> [57424.843000] Restarting tasks...<6>usb 4-1: USB disconnect, address 9
> [57424.868000]  done
> [57424.868000] Enabling non-boot CPUs ...
> [57424.900000] SMP alternatives: switching to SMP code
> [57424.901000] Booting processor 1/1 eip 3000
> [57424.911000] Initializing CPU#1
> [57424.972000] Calibrating delay using timer specific routine.. 3325.04 BogoMIPS (lpj=1662520)
> [57424.972000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
> [57424.972000] monitor/mwait feature present.
> [57424.972000] CPU: L1 I cache: 32K, L1 D cache: 32K
> [57424.972000] CPU: L2 cache: 2048K
> [57424.972000] CPU: Physical Processor ID: 0
> [57424.972000] CPU: Processor Core ID: 1
> [57424.972000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
> [57424.972000] Intel machine check architecture supported.
> [57424.972000] Intel machine check reporting enabled on CPU#1.
> [57424.972000] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
> [57424.999000] usb 4-2: USB disconnect, address 8
> [57425.205000] usb 4-2: new full speed USB device using uhci_hcd and address 10
> [57425.369000] usb 4-2: configuration #1 chosen from 1 choice
> [57425.624000] CPU1 is up
> [57425.787000] usb 4-1: new full speed USB device using uhci_hcd and address 11
> [57425.823000] ata1: waiting for device to spin up (7 secs)
> [57425.998000] usb 4-1: configuration #1 chosen from 1 choice
> [57433.805000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [57433.809000] ata1.00: configured for UDMA/100
> [57433.810000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> [57433.810000] sda: Write Protect is off
> [57433.810000] sda: Mode Sense: 00 3a 00 00
> [57433.810000] SCSI device sda: drive cache: write back
> [58268.899000] Disabling non-boot CPUs ...
> [58269.008000] CPU 1 is now offline
> [58269.008000] SMP alternatives: switching to UP code
> [58269.013000] CPU1 is down
> [58269.013000] Stopping tasks: ===============================================================================================================|
> [58270.649000] Suspending console(s)
> [58270.661000]  usbdev4.10_ep83: PM: suspend 0->2, parent 4-2:1.0 already 2
> [58270.661000]  usbdev4.10_ep02: PM: suspend 0->2, parent 4-2:1.0 already 2
> [58270.661000]  usbdev4.10_ep81: PM: suspend 0->2, parent 4-2:1.0 already 2
> [58270.661000] usb 4-2:1.0: PM: suspend 2->2, parent 4-2 already 2
> [58270.661000]  usbdev4.10_ep00: PM: suspend 0->2, parent 4-2 already 2
> [58272.370000] pnp: Device 00:0a disabled.
> [58272.371000] ACPI: PCI interrupt for device 0000:15:00.2 disabled
> [58272.393000] ACPI: PCI interrupt for device 0000:15:00.0 disabled
> [58272.437000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
> [58272.450000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
> [58272.461000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
> [58272.872000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
> [58272.872000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
> [58272.872000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
> [58272.872000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
> [58272.873000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> [58272.873000] Intel machine check architecture supported.
> [58272.873000] Intel machine check reporting enabled on CPU#0.
> [58272.873000] Back to C!
> [58806.491000] PM: Writing back config space on device 0000:00:02.1 at offset 1 (was 900000, writing 900003)
> [58806.491000] PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100106, writing 100100)
> [58806.491000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
> [58806.492000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 22
> [58806.492000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
> [58806.510000] PM: Writing back config space on device 0000:00:1c.0 at offset 1 (was 100107, writing 100507)
> [58806.510000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
> [58806.510000] PM: Writing back config space on device 0000:00:1c.1 at offset 1 (was 100107, writing 100507)
> [58806.510000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
> [58806.510000] PM: Writing back config space on device 0000:00:1c.2 at offset 1 (was 100107, writing 100507)
> [58806.510000] PCI: Setting latency timer of device 0000:00:1c.2 to 64
> [58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset f (was 40400, writing 4040b)
> [58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset 9 (was 10001, writing e421e421)
> [58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset 8 (was 0, writing ebf0ea00)
> [58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset 7 (was 20000000, writing 20008070)
> [58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset 3 (was 810000, writing 810010)
> [58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset 1 (was 100000, writing 100507)
> [58806.510000] PCI: Setting latency timer of device 0000:00:1c.3 to 64
> [58806.510000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
> [58806.510000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
> [58806.510000] usb usb1: root hub lost power or was reset
> [58806.510000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 22
> [58806.510000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
> [58806.510000] usb usb2: root hub lost power or was reset
> [58806.510000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 21
> [58806.510000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
> [58806.510000] usb usb3: root hub lost power or was reset
> [58806.510000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
> [58806.510000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
> [58806.510000] usb usb4: root hub lost power or was reset
> [58806.821000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
> [58806.821000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
> [58806.821000] PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was 100005, writing 100007)
> [58806.821000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
> [58806.832000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
> [58806.832000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
> [58807.844000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
> [58807.844000] PCI: Setting latency timer of device 0000:02:00.0 to 64
> [58807.887000] PM: Writing back config space on device 0000:03:00.0 at offset 1 (was 100106, writing 100100)
> [58807.887000] PM: Writing back config space on device 0000:15:00.0 at offset 1 (was 2100000, writing 2100007)
> [58807.887000] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
> [58807.929000] PM: Writing back config space on device 0000:15:00.1 at offset 4 (was 0, writing e4301000)
> [58807.929000] PM: Writing back config space on device 0000:15:00.1 at offset 3 (was 800000, writing 804000)
> [58807.929000] PM: Writing back config space on device 0000:15:00.1 at offset 1 (was 2100000, writing 2100006)
> [58807.940000] PM: Writing back config space on device 0000:15:00.2 at offset 4 (was 0, writing e4301800)
> [58807.940000] PM: Writing back config space on device 0000:15:00.2 at offset 3 (was 800000, writing 804000)
> [58807.940000] PM: Writing back config space on device 0000:15:00.2 at offset 1 (was 2100000, writing 2100006)
> [58807.940000] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 21
> [58807.951000] pnp: Device 00:08 does not support activation.
> [58807.951000] pnp: Device 00:09 does not support activation.
> [58807.952000] pnp: Device 00:0a activated.
> [58808.136000] ata2: SATA link down (SStatus 0 SControl 0)
> [58808.136000] ata3: SATA link down (SStatus 0 SControl 0)
> [58808.136000] ata4: SATA link down (SStatus 0 SControl 0)
> [58808.359000] nsc_ircc_init_dongle_interface(), No dongle connected
> [58808.359000] nsc_ircc_change_dongle_speed(), No dongle connected is not for IrDA mode
> [58808.371000]  usbdev4.10_ep00: PM: resume from 0, parent 4-2 still 2
> [58808.371000]  usbdev4.10_ep81: PM: resume from 0, parent 4-2:1.0 still 2
> [58808.371000]  usbdev4.10_ep02: PM: resume from 0, parent 4-2:1.0 still 2
> [58808.371000]  usbdev4.10_ep83: PM: resume from 0, parent 4-2:1.0 still 2
> [58808.371000]  usbdev4.11_ep00: PM: resume from 0, parent 4-1 still 2
> [58808.371000] hci_usb 4-1:1.0: PM: resume from 2, parent 4-1 still 2
> [58808.371000]  hci0: PM: resume from 0, parent 4-1:1.0 still 2
> [58808.371000]  usbdev4.11_ep81: PM: resume from 0, parent 4-1:1.0 still 2
> [58808.371000]  usbdev4.11_ep82: PM: resume from 0, parent 4-1:1.0 still 2
> [58808.371000]  usbdev4.11_ep02: PM: resume from 0, parent 4-1:1.0 still 2
> [58808.371000] hci_usb 4-1:1.1: PM: resume from 2, parent 4-1 still 2
> [58808.371000]  usbdev4.11_ep83: PM: resume from 0, parent 4-1:1.1 still 2
> [58808.371000]  usbdev4.11_ep03: PM: resume from 0, parent 4-1:1.1 still 2
> [58808.371000] usb 4-1:1.2: PM: resume from 2, parent 4-1 still 2
> [58808.371000]  usbdev4.11_ep84: PM: resume from 0, parent 4-1:1.2 still 2
> [58808.371000]  usbdev4.11_ep04: PM: resume from 0, parent 4-1:1.2 still 2
> [58808.371000] usb 4-1:1.3: PM: resume from 2, parent 4-1 still 2
> [58808.372000] Restarting tasks...<6>usb 4-1: USB disconnect, address 11
> [58808.439000]  done
> [58808.439000] Enabling non-boot CPUs ...
> [58808.451000] SMP alternatives: switching to SMP code
> [58808.452000] Booting processor 1/1 eip 3000
> [58808.463000] Initializing CPU#1
> [58808.523000] Calibrating delay using timer specific routine.. 3325.03 BogoMIPS (lpj=1662517)
> [58808.523000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
> [58808.523000] monitor/mwait feature present.
> [58808.523000] CPU: L1 I cache: 32K, L1 D cache: 32K
> [58808.523000] CPU: L2 cache: 2048K
> [58808.523000] CPU: Physical Processor ID: 0
> [58808.523000] CPU: Processor Core ID: 1
> [58808.523000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
> [58808.523000] Intel machine check architecture supported.
> [58808.523000] Intel machine check reporting enabled on CPU#1.
> [58808.523000] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
> [58808.524000] usb 4-2: USB disconnect, address 10
> [58808.730000] usb 4-2: new full speed USB device using uhci_hcd and address 12
> [58808.893000] usb 4-2: configuration #1 chosen from 1 choice
> [58809.316000] usb 4-1: new full speed USB device using uhci_hcd and address 13
> [58809.363000] ata1: waiting for device to spin up (7 secs)
> [58809.476000] usb 4-1: configuration #1 chosen from 1 choice
> [58809.829000] CPU1 is up
> [58817.341000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [58817.345000] ata1.00: configured for UDMA/100
> [58817.346000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> [58817.346000] sda: Write Protect is off
> [58817.347000] sda: Mode Sense: 00 3a 00 00
> [58817.347000] SCSI device sda: drive cache: write back
>   

