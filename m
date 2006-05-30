Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWE3Un7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWE3Un7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWE3Un7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:43:59 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:31068 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932407AbWE3Un4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:43:56 -0400
X-IronPort-AV: i="4.05,190,1146466800"; 
   d="txt'?scan'208"; a="1815640852:sNHT6152774774"
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] lock validator: fix RT_HASH_LOCK_SZ
X-Message-Flag: Warning: May contain useful information
References: <20060530022925.8a67b613.akpm@osdl.org>
	<adaac8z70yc.fsf@cisco.com> <20060530202654.GA25720@elte.hu>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 30 May 2006 13:43:40 -0700
In-Reply-To: <20060530202654.GA25720@elte.hu> (Ingo Molnar's message of "Tue, 30 May 2006 22:26:54 +0200")
Message-ID: <ada1wub6y6b.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-OriginalArrivalTime: 30 May 2006 20:43:41.0459 (UTC) FILETIME=[BC510630:01C68429]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	11 extraneous bytes; sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

 > on lockdep we have a quite big spinlock_t, so keep the size down.

Yes, that builds fine.

However the kernel won't boot for me... it oopses early on in
save_stack_trace().  I'm attaching a bootlog, plus another try booting
with nmi_watchdog=0, plus my config.

Thanks,
  Roland


--=-=-=
Content-Disposition: inline; filename=lockdep-boot.txt

[    0.000000] Bootdata ok (command line is root=/dev/sda3 ro console=ttyS0,38400 )  *
[    0.000000] Linux version 2.6.17-rc5-mm1 (root@roland-microway-1) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #4 SMP Tue May 30 12:43:27 PDT 2006  *
[    0.000000] BIOS-provided physical RAM map:                             *
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)    *
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)  *
[    0.000000]  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)  *
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000dfff0000 (usable)*****
[    0.000000]  BIOS-e820: 00000000dfff0000 - 00000000dfffe000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000dfffe000 - 00000000e0000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff700000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000220000000 (usable)
[    0.000000] DMI 2.3 present.
[    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 1 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 2 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 3 -> Node 1
[    0.000000] SRAT: PXM 2 -> APIC 4 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 5 -> Node 2
[    0.000000] SRAT: PXM 3 -> APIC 6 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 7 -> Node 3
[    0.000000] SRAT: Node 0 PXM 0 100000-80000000
[    0.000000] SRAT: Node 1 PXM 1 80000000-e0000000
[    0.000000] SRAT: Node 2 PXM 2 120000000-1a0000000
[    0.000000] SRAT: Node 3 PXM 3 1a0000000-220000000
[    0.000000] SRAT: Node 1 PXM 1 80000000-120000000
[    0.000000] SRAT: Node 0 PXM 0 0-80000000
[    0.000000] Bootmem setup node 0 0000000000000000-0000000080000000
[    0.000000] Bootmem setup node 1 0000000080000000-0000000120000000
[    0.000000] Bootmem setup node 2 0000000120000000-00000001a0000000
[    0.000000] Bootmem setup node 3 00000001a0000000-0000000220000000
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] Processor #2 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] Processor #3 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] enabled)
[    0.000000] Processor #4 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] enabled)
[    0.000000] Processor #5 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x06] enabled)
[    0.000000] Processor #6 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] Processor #7 15:1 APIC version 16
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x0d] address[0xfeafe000] gsi_base[40])
[    0.000000] IOAPIC[1]: apic_id 13, version 17, address 0xfeafe000, GSI 40-46
[    0.000000] ACPI: IOAPIC (id[0x0e] address[0xfeaff000] gsi_base[47])
[    0.000000] IOAPIC[2]: apic_id 14, version 17, address 0xfeaff000, GSI 47-53
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
[    0.000000] Built 4 zonelists
[    0.000000] Kernel command line: root=/dev/sda3 ro console=ttyS0,38400
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   56.029324] Console: colour VGA+ 80x25
[   57.128874] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   57.152019] ... MAX_LOCKDEP_SUBTYPES:    8
[   57.164264] ... MAX_LOCK_DEPTH:          30
[   57.176769] ... MAX_LOCKDEP_KEYS:        2048
[   57.189794] ... TYPEHASH_SIZE:           1024
[   57.202817] ... MAX_LOCKDEP_ENTRIES:     8192
[   57.215842] ... MAX_LOCKDEP_CHAINS:      8192
[   57.228865] ... CHAINHASH_SIZE:          4096
[   57.241890]  memory used by lock dependency info: 1120 kB
[   57.258026]  per task-struct memory footprint: 1440 bytes
[   57.274164] ------------------------
[   57.284852] | Locking API testsuite:
[   57.295542] ----------------------------------------------------------------------------
[   57.319722]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[   57.343903]   --------------------------------------------------------------------------
[   57.368088]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   57.393240]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   57.418380]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   57.443526]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   57.468692]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   57.493903]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   57.519043]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   57.544190]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   57.569355]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   57.594522]   --------------------------------------------------------------------------
[   57.618703]               recursive read-lock:             |  ok  |             |  ok  |
[   57.643348]   --------------------------------------------------------------------------
[   57.667529]                 non-nested unlock:  ok  |  ok  |  ok  |  ok  |
[   57.688743]   ------------------------------------------------------------
[   57.709274]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   57.728516]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   57.747747]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   57.766997]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   57.786242]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[   57.805466]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[   57.824698]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   57.843948]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   57.863192]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   57.882424]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   57.901674]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   57.920918]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   57.940142]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   57.959374]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   57.978624]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   57.997869]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   58.017100]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   58.036350]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   58.055593]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   58.074819]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   58.094049]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   58.113300]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   58.132544]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   58.151776]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   58.171026]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   58.190270]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   58.209494]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   58.228726]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   58.247976]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   58.267221]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   58.286451]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   58.305702]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   58.324945]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   58.344171]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   58.363401]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   58.382652]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   58.401897]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   58.421121]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   58.440353]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   58.459603]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   58.478846]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   58.498078]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   58.517328]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   58.536572]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   58.555797]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   58.575028]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   58.594279]       hard-irq read-recursion/123:  ok  |
[   58.609579]       soft-irq read-recursion/123:  ok  |
[   58.624867]       hard-irq read-recursion/132:  ok  |
[   58.640174]       soft-irq read-recursion/132:  ok  |
[   58.655474]       hard-irq read-recursion/213:  ok  |
[   58.670762]       soft-irq read-recursion/213:  ok  |
[   58.686190]       hard-irq read-recursion/231:  ok  |
[   58.701473]       soft-irq read-recursion/231:  ok  |
[   58.716761]       hard-irq read-recursion/312:  ok  |
[   58.732061]       soft-irq read-recursion/312:  ok  |
[   58.747343]       hard-irq read-recursion/321:  ok  |
[   58.762631]       soft-irq read-recursion/321:  ok  |
[   58.777930] -------------------------------------------------------
[   58.796645] Good, all 210 testcases passed! |
[   58.809668] ---------------------------------
[   58.828152] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[   58.857504] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[   58.880979] Checking aperture...
[   58.890646] CPU 0: aperture @ 4000000 size 32 MB
[   58.904442] Aperture too small (32 MB)
[   58.920442] No AGP bridge found
[   58.929815] Your BIOS doesn't leave a aperture memory hole
[   58.946212] Please enable the IOMMU option in the BIOS setup
[   58.963128] This costs you 64 MB of RAM
[   59.019026] Mapping aperture over 65536 KB of RAM @ 4000000
[   59.189225] Memory: 7987980k/8912896k available (2295k kernel code, 400176k reserved, 1237k data, 240k init)
[   59.279159] Calibrating delay using timer specific routine.. 5202.67 BogoMIPS (lpj=2601335)
[   59.304560] Security Framework v1.0.0 initialized
[   59.318618] SELinux:  Disabled at boot.
[   59.330083] Capability LSM initialized
[   59.341481] Mount-cache hash table entries: 256
[   59.355549] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   59.376861] CPU: L2 Cache: 1024K (64 bytes/line)
[   59.390661] CPU 0/0(2) -> Node 0 -> Core 0
[   59.402918] Freeing SMP alternatives: 24k freed
[   59.437194] Using local APIC timer interrupts.
[   59.488839] result 12500042
[   59.497183] Detected 12.500 MHz APIC timer.
[   59.511667] lockdep: not fixing up alternatives.
[   59.525490] Booting processor 1/8 APIC 0x1
[   59.548003] Initializing CPU#1
[   59.608395] Calibrating delay using timer specific routine.. 5199.26 BogoMIPS (lpj=2599631)
[   59.608402] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   59.608404] CPU: L2 Cache: 1024K (64 bytes/line)
[   59.608407] CPU 1/1(2) -> Node 0 -> Core 1
[   59.608528] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   59.609404] CPU 1: Syncing TSC to CPU 0.
[   59.609554] CPU 1: synchronized TSC with CPU 0 (last diff 22 cycles, maxerr 944 cycles)
[   59.610418] lockdep: not fixing up alternatives.
[   59.758943] Booting processor 2/8 APIC 0x2
[   59.781534] Initializing CPU#2
[   59.841857] Calibrating delay using timer specific routine.. 5199.32 BogoMIPS (lpj=2599663)
[   59.841865] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   59.841867] CPU: L2 Cache: 1024K (64 bytes/line)
[   59.841870] CPU 2/2(2) -> Node 1 -> Core 0
[   59.841986] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   59.842874] CPU 2: Syncing TSC to CPU 0.
[   59.843019] CPU 2: synchronized TSC with CPU 0 (last diff 155 cycles, maxerr 730 cycles)
[   59.843862] lockdep: not fixing up alternatives.
[   59.992620] Booting processor 3/8 APIC 0x3
[   60.015131] Initializing CPU#3
[   60.075319] Calibrating delay using timer specific routine.. 5199.33 BogoMIPS (lpj=2599665)
[   60.075326] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   60.075329] CPU: L2 Cache: 1024K (64 bytes/line)
[   60.075331] CPU 3/3(2) -> Node 1 -> Core 1
[   60.075449] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   60.076336] CPU 3: Syncing TSC to CPU 0.
[   60.076482] CPU 3: synchronized TSC with CPU 0 (last diff -166 cycles, maxerr 1004 cycles)
[   60.077496] lockdep: not fixing up alternatives.
[   60.226736] Booting processor 4/8 APIC 0x4
[   60.249256] Initializing CPU#4
[   60.309778] Calibrating delay using timer specific routine.. 5199.32 BogoMIPS (lpj=2599663)
[   60.309786] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   60.309788] CPU: L2 Cache: 1024K (64 bytes/line)
[   60.309791] CPU 4/4(2) -> Node 2 -> Core 0
[   60.309907] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   60.310793] CPU 4: Syncing TSC to CPU 0.
[   60.310940] CPU 4: synchronized TSC with CPU 0 (last diff 16 cycles, maxerr 1001 cycles)
[   60.311951] lockdep: not fixing up alternatives.
[   60.460683] Booting processor 5/8 APIC 0x5
[   60.483272] Initializing CPU#5
[   60.543240] Calibrating delay using timer specific routine.. 5199.32 BogoMIPS (lpj=2599663)
[   60.543248] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   60.543250] CPU: L2 Cache: 1024K (64 bytes/line)
[   60.543252] CPU 5/5(2) -> Node 2 -> Core 1
[   60.543366] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   60.544255] CPU 5: Syncing TSC to CPU 0.
[   60.544400] CPU 5: synchronized TSC with CPU 0 (last diff 14 cycles, maxerr 1000 cycles)
[   60.545438] lockdep: not fixing up alternatives.
[   60.694228] Booting processor 6/8 APIC 0x6
[   60.716743] Initializing CPU#6
[   60.777700] Calibrating delay using timer specific routine.. 5199.34 BogoMIPS (lpj=2599670)
[   60.777708] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   60.777711] CPU: L2 Cache: 1024K (64 bytes/line)
[   60.777713] CPU 6/6(2) -> Node 3 -> Core 0
[   60.777871] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   60.778711] CPU 6: Syncing TSC to CPU 0.
[   60.778953] CPU 6: synchronized TSC with CPU 0 (last diff -2 cycles, maxerr 1731 cycles)
[   60.779972] lockdep: not fixing up alternatives.
[   60.928707] Booting processor 7/8 APIC 0x7
[   60.951227] Initializing CPU#7
[   61.012159] Calibrating delay using timer specific routine.. 5199.32 BogoMIPS (lpj=2599663)
[   61.012168] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   61.012170] CPU: L2 Cache: 1024K (64 bytes/line)
[   61.012172] CPU 7/7(2) -> Node 3 -> Core 1
[   61.012326] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   61.013175] CPU 7: Syncing TSC to CPU 0.
[   61.013417] CPU 7: synchronized TSC with CPU 0 (last diff 3 cycles, maxerr 1744 cycles)
[   61.013431] Brought up 8 CPUs
[   61.157095] lockdep: disabled NMI watchdog.
[   61.158090] Uhhuh. NMI received for unknown reason 3d.
[   61.158093] Do you have a strange power saving mode enabled?
[   61.158094] Dazed and confused, but trying to continue
[   61.162927] Uhhuh. NMI received for unknown reason 00.
[   61.162931] Do you have a strange power saving mode enabled?
[   61.162932] Dazed and confused, but trying to continue
[   61.169946] Uhhuh. NMI received for unknown reason 00.
[   61.169950] Do you have a strange power saving mode enabled?
[   61.169951] Dazed and confused, but trying to continue
[   61.176804] Uhhuh. NMI received for unknown reason 00.
[   61.176807] Do you have a strange power saving mode enabled?
[   61.176809] Dazed and confused, but trying to continue
[   61.176827] Uhhuh. NMI received for unknown reason 00.
[   61.176831] Do you have a strange power saving mode enabled?
[   61.176833] Dazed and confused, but trying to continue
[   61.227863] Uhhuh. NMI received for unknown reason 00.
[   61.227866] Do you have a strange power saving mode enabled?
[   61.227868] Dazed and confused, but trying to continue
[   61.240686] Uhhuh. NMI received for unknown reason 00.
[   61.240689] Do you have a strange power saving mode enabled?
[   61.240691] Dazed and confused, but trying to continue
[   61.259831] Uhhuh. NMI received for unknown reason 00.
[   61.259834] Do you have a strange power saving mode enabled?
[   61.259836] Dazed and confused, but trying to continue
[   61.550383] Disabling vsyscall due to use of PM timer
[   61.565483] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[   61.582653] time.c: Detected 2600.005 MHz processor.
[   61.767031] migration_cost=368,399
[   61.781565] NET: Registered protocol family 16
[   61.794960] ACPI: bus type pci registered
[   61.806947] PCI: Using configuration type 1
[   61.819557] Unable to handle kernel paging request at 0000000100000007 RIP:
[   61.833350]  [<ffffffff8020c82b>] save_stack_trace+0x187/0x234
[   61.858177] PGD 0
[   61.864248] Oops: 0000 [1] SMP
[   61.873744] last sysfs file:
[   61.882617] CPU 2
[   61.888688] Modules linked in:
[   61.897873] Pid: 34, comm: khelper Not tainted 2.6.17-rc5-mm1 #4
[   61.915825] RIP: 0010:[<ffffffff8020c82b>]  [<ffffffff8020c82b>] save_stack_trace+0x187/0x234
[   61.940837] RSP: 0000:ffff81019b51da48  EFLAGS: 00010046
[   61.957259] RAX: 0000000000000001 RBX: ffff81019b51dab8 RCX: ffffffff805c85e8
[   61.978585] RDX: 0000000000000001 RSI: 0000000000000009 RDI: ffff81019b51e000
[   61.999911] RBP: ffff81019b51dab8 R08: 00000000ffffffff R09: 0000000000000000
[   62.021238] R10: ffffffffffffffff R11: ffffffff805a4d18 R12: ffffffff807723f8
[   62.042563] R13: ffff81011a295080 R14: ffff81011a295080 R15: 0000000000000000
[   62.063890] FS:  0000000000000000(0000) GS:ffff81011a4d9e40(0000) knlGS:0000000000000000
[   62.088068] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[   62.105243] CR2: 0000000100000007 CR3: 0000000000201000 CR4: 00000000000006e0
[   62.126571] Process khelper (pid: 34, threadinfo ffff81019b51c000, task ffff81011a295080)
[   62.151008] Stack: 0000000000000003 ffff81019b51da58 ffff81019b51e000 ffffffff80248484
[   62.174617]        0000000000000000 0000000000000001 ffffffff804bc5c8 ffff81019b51dab8
[   62.198770]        0000000000000000 ffffffff807723f8
[   62.214001] Call Trace:
[   62.221866]  [<ffffffff80248484>] __lockdep_acquire+0xa98/0xad2
[   62.239612]  [<ffffffff80246cab>] save_trace+0x3e/0xe6
[   62.255020]  [<ffffffff80246e43>] add_lock_to_list+0x79/0xa0
[   62.271988]  [<ffffffff8024837d>] __lockdep_acquire+0x991/0xad2
[   62.289735]  [<ffffffff8022bec4>] copy_process+0x1314/0x1816
[   62.306676]  [<ffffffff802488a5>] lockdep_acquire+0x82/0xa3
[   62.323384]  [<ffffffff8043af82>] _spin_lock+0x1c/0x28
[   62.338794]  [<ffffffff8022bec4>] copy_process+0x1314/0x1816
[   62.355763]  [<ffffffff8043b33f>] _spin_unlock_irq+0x28/0x2e
[   62.372729]  [<ffffffff8023f3cc>] alloc_pid+0x2b1/0x2d9
[   62.388399]  [<ffffffff8022c4c8>] do_fork+0x102/0x236
[   62.403525]  [<ffffffff8023f35e>] alloc_pid+0x243/0x2d9
[   62.419170]  [<ffffffff80247268>] mark_lock+0x3b/0x4fc
[   62.434580]  [<ffffffff80247268>] mark_lock+0x3b/0x4fc
[   62.449993]  [<ffffffff8020a51d>] kernel_thread+0x81/0xde
[   62.466180]  [<ffffffff8023e38b>] run_workqueue+0x17/0x10f
[   62.482629]  [<ffffffff8023df29>] ____call_usermodehelper+0x0/0x10e
[   62.501386]  [<ffffffff8020a57a>] child_rip+0x0/0x12
[   62.516277]  [<ffffffff8023ddc5>] __call_usermodehelper+0x32/0x4d
[   62.534543]  [<ffffffff8023e42d>] run_workqueue+0xb9/0x10f
[   62.550990]  [<ffffffff8023dd93>] __call_usermodehelper+0x0/0x4d
[   62.568996]  [<ffffffff8023e539>] worker_thread+0x0/0x128
[   62.585185]  [<ffffffff8023e62e>] worker_thread+0xf5/0x128
[   62.601635]  [<ffffffff802276bf>] default_wake_function+0x0/0xf
[   62.619381]  [<ffffffff8023e539>] worker_thread+0x0/0x128
[   62.635569]  [<ffffffff80241cba>] kthread+0xd1/0xfb
[   62.650201]  [<ffffffff8023e539>] worker_thread+0x0/0x128
[   62.666389]  [<ffffffff8020a582>] child_rip+0x8/0x12
[   62.681282]  [<ffffffff8043b33f>] _spin_unlock_irq+0x28/0x2e
[   62.698224]  [<ffffffff80209bcf>] restore_args+0x0/0x30
[   62.713896]  [<ffffffff80241be9>] kthread+0x0/0xfb
[   62.728267]  [<ffffffff8020a57a>] child_rip+0x0/0x12
[   62.743132]
[   62.747595]
[   62.747595] Code: 4d 8b 50 08 75 1b 41 8b 14 24 49 8b 4c 24 08 49 8d 42 ff 89
[   62.774758] RIP  [<ffffffff8020c82b>] save_stack_trace+0x187/0x234 RSP <ffff81019b51da48>
[   62.799301] CR2: 0000000100000007

--=-=-=
Content-Disposition: inline; filename=lockdep-boot-nonmi.txt

[    0.000000] Bootdata ok (command line is root=/dev/sda3 ro console=ttyS0,38400  nmi_watchdog=0)
[    0.000000] Linux version 2.6.17-rc5-mm1 (root@roland-microway-1) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #4 SMP Tue May 30 12:43:27 PDT 2006  *
[    0.000000] BIOS-provided physical RAM map:                             *
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)    *
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)  *
[    0.000000]  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)  *
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000dfff0000 (usable)*****
[    0.000000]  BIOS-e820: 00000000dfff0000 - 00000000dfffe000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000dfffe000 - 00000000e0000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff700000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000220000000 (usable)
[    0.000000] DMI 2.3 present.
[    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 1 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 2 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 3 -> Node 1
[    0.000000] SRAT: PXM 2 -> APIC 4 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 5 -> Node 2
[    0.000000] SRAT: PXM 3 -> APIC 6 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 7 -> Node 3
[    0.000000] SRAT: Node 0 PXM 0 100000-80000000
[    0.000000] SRAT: Node 1 PXM 1 80000000-e0000000
[    0.000000] SRAT: Node 2 PXM 2 120000000-1a0000000
[    0.000000] SRAT: Node 3 PXM 3 1a0000000-220000000
[    0.000000] SRAT: Node 1 PXM 1 80000000-120000000
[    0.000000] SRAT: Node 0 PXM 0 0-80000000
[    0.000000] Bootmem setup node 0 0000000000000000-0000000080000000
[    0.000000] Bootmem setup node 1 0000000080000000-0000000120000000
[    0.000000] Bootmem setup node 2 0000000120000000-00000001a0000000
[    0.000000] Bootmem setup node 3 00000001a0000000-0000000220000000
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] Processor #2 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] Processor #3 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] enabled)
[    0.000000] Processor #4 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] enabled)
[    0.000000] Processor #5 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x06] enabled)
[    0.000000] Processor #6 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] Processor #7 15:1 APIC version 16
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x0d] address[0xfeafe000] gsi_base[40])
[    0.000000] IOAPIC[1]: apic_id 13, version 17, address 0xfeafe000, GSI 40-46
[    0.000000] ACPI: IOAPIC (id[0x0e] address[0xfeaff000] gsi_base[47])
[    0.000000] IOAPIC[2]: apic_id 14, version 17, address 0xfeaff000, GSI 47-53
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
[    0.000000] Built 4 zonelists
[    0.000000] Kernel command line: root=/dev/sda3 ro console=ttyS0,38400  nmi_watchdog=0
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   63.998993] Console: colour VGA+ 80x25
[   65.106316] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   65.129462] ... MAX_LOCKDEP_SUBTYPES:    8
[   65.141707] ... MAX_LOCK_DEPTH:          30
[   65.154212] ... MAX_LOCKDEP_KEYS:        2048
[   65.167237] ... TYPEHASH_SIZE:           1024
[   65.180261] ... MAX_LOCKDEP_ENTRIES:     8192
[   65.193284] ... MAX_LOCKDEP_CHAINS:      8192
[   65.206308] ... CHAINHASH_SIZE:          4096
[   65.219332]  memory used by lock dependency info: 1120 kB
[   65.235537]  per task-struct memory footprint: 1440 bytes
[   65.251659] ------------------------
[   65.262348] | Locking API testsuite:
[   65.273036] ----------------------------------------------------------------------------
[   65.297217]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[   65.321397]   --------------------------------------------------------------------------
[   65.345583]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   65.370735]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   65.395874]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   65.421014]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   65.446161]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   65.471326]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   65.496538]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   65.521677]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   65.546825]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[   65.571990]   --------------------------------------------------------------------------
[   65.596172]               recursive read-lock:             |  ok  |             |  ok  |
[   65.620818]   --------------------------------------------------------------------------
[   65.644999]                 non-nested unlock:  ok  |  ok  |  ok  |  ok  |
[   65.666213]   ------------------------------------------------------------
[   65.686742]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   65.705985]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   65.725209]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   65.744441]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   65.763692]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[   65.782935]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[   65.802159]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   65.821391]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   65.840641]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   65.859885]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   65.879117]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   65.898368]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   65.917611]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   65.936836]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   65.956067]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   65.975318]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   65.994561]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   66.013792]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   66.033043]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   66.052288]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   66.071512]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   66.090744]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   66.109994]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   66.129237]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   66.148468]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   66.167720]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   66.186963]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   66.206188]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   66.225419]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   66.244670]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   66.263914]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   66.283145]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   66.302396]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   66.321873]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   66.341104]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   66.360355]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   66.379598]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   66.398830]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   66.418081]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   66.437324]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   66.456549]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   66.475780]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   66.495030]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   66.514275]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   66.533506]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   66.552756]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   66.572000]       hard-irq read-recursion/123:  ok  |
[   66.587282]       soft-irq read-recursion/123:  ok  |
[   66.602569]       hard-irq read-recursion/132:  ok  |
[   66.617870]       soft-irq read-recursion/132:  ok  |
[   66.633151]       hard-irq read-recursion/213:  ok  |
[   66.648438]       soft-irq read-recursion/213:  ok  |
[   66.663745]       hard-irq read-recursion/231:  ok  |
[   66.679046]       soft-irq read-recursion/231:  ok  |
[   66.694333]       hard-irq read-recursion/312:  ok  |
[   66.709641]       soft-irq read-recursion/312:  ok  |
[   66.724941]       hard-irq read-recursion/321:  ok  |
[   66.740229]       soft-irq read-recursion/321:  ok  |
[   66.755536] -------------------------------------------------------
[   66.774269] Good, all 210 testcases passed! |
[   66.787292] ---------------------------------
[   66.805780] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[   66.835368] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[   66.858851] Checking aperture...
[   66.868500] CPU 0: aperture @ 8016000000 size 32 MB
[   66.883078] Aperture too small (32 MB)
[   66.899307] No AGP bridge found
[   66.908685] Your BIOS doesn't leave a aperture memory hole
[   66.925081] Please enable the IOMMU option in the BIOS setup
[   66.941997] This costs you 64 MB of RAM
[   66.997926] Mapping aperture over 65536 KB of RAM @ 4000000
[   67.168352] Memory: 7987980k/8912896k available (2295k kernel code, 400176k reserved, 1237k data, 240k init)
[   67.257820] Calibrating delay using timer specific routine.. 5202.67 BogoMIPS (lpj=2601339)
[   67.283222] Security Framework v1.0.0 initialized
[   67.297280] SELinux:  Disabled at boot.
[   67.308744] Capability LSM initialized
[   67.320144] Mount-cache hash table entries: 256
[   67.334212] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   67.355523] CPU: L2 Cache: 1024K (64 bytes/line)
[   67.369324] CPU 0/0(2) -> Node 0 -> Core 0
[   67.381581] Freeing SMP alternatives: 24k freed
[   67.415858] Using local APIC timer interrupts.
[   67.467501] result 12500031
[   67.475844] Detected 12.500 MHz APIC timer.
[   67.490346] lockdep: not fixing up alternatives.
[   67.504180] Booting processor 1/8 APIC 0x1
[   67.526690] Initializing CPU#1
[   67.587056] Calibrating delay using timer specific routine.. 5199.33 BogoMIPS (lpj=2599668)
[   67.587063] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   67.587065] CPU: L2 Cache: 1024K (64 bytes/line)
[   67.587068] CPU 1/1(2) -> Node 0 -> Core 1
[   67.587188] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   67.588070] CPU 1: Syncing TSC to CPU 0.
[   67.588218] CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 985 cycles)
[   67.589100] lockdep: not fixing up alternatives.
[   67.737528] Booting processor 2/8 APIC 0x2
[   67.760036] Initializing CPU#2
[   67.820518] Calibrating delay using timer specific routine.. 5199.25 BogoMIPS (lpj=2599628)
[   67.820525] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   67.820527] CPU: L2 Cache: 1024K (64 bytes/line)
[   67.820530] CPU 2/2(2) -> Node 1 -> Core 0
[   67.820646] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   67.821530] CPU 2: Syncing TSC to CPU 0.
[   67.821674] CPU 2: synchronized TSC with CPU 0 (last diff 159 cycles, maxerr 732 cycles)
[   67.822534] lockdep: not fixing up alternatives.
[   67.971260] Booting processor 3/8 APIC 0x3
[   67.993768] Initializing CPU#3
[   68.053980] Calibrating delay using timer specific routine.. 5199.33 BogoMIPS (lpj=2599665)
[   68.053987] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   68.053989] CPU: L2 Cache: 1024K (64 bytes/line)
[   68.053992] CPU 3/3(2) -> Node 1 -> Core 1
[   68.054109] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   68.054992] CPU 3: Syncing TSC to CPU 0.
[   68.055138] CPU 3: synchronized TSC with CPU 0 (last diff 17 cycles, maxerr 1019 cycles)
[   68.056166] lockdep: not fixing up alternatives.
[   68.204907] Booting processor 4/8 APIC 0x4
[   68.227421] Initializing CPU#4
[   68.287441] Calibrating delay using timer specific routine.. 5199.25 BogoMIPS (lpj=2599628)
[   68.287449] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   68.287451] CPU: L2 Cache: 1024K (64 bytes/line)
[   68.287454] CPU 4/4(2) -> Node 2 -> Core 0
[   68.287570] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   68.288454] CPU 4: Syncing TSC to CPU 0.
[   68.288599] CPU 4: synchronized TSC with CPU 0 (last diff 156 cycles, maxerr 728 cycles)
[   68.289627] lockdep: not fixing up alternatives.
[   68.438361] Booting processor 5/8 APIC 0x5
[   68.460866] Initializing CPU#5
[   68.520903] Calibrating delay using timer specific routine.. 5199.33 BogoMIPS (lpj=2599666)
[   68.520911] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   68.520913] CPU: L2 Cache: 1024K (64 bytes/line)
[   68.520915] CPU 5/5(2) -> Node 2 -> Core 1
[   68.521030] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   68.521913] CPU 5: Syncing TSC to CPU 0.
[   68.522059] CPU 5: synchronized TSC with CPU 0 (last diff -157 cycles, maxerr 1002 cycles)
[   68.523119] lockdep: not fixing up alternatives.
[   68.672370] Booting processor 6/8 APIC 0x6
[   68.694888] Initializing CPU#6
[   68.755363] Calibrating delay using timer specific routine.. 5199.26 BogoMIPS (lpj=2599632)
[   68.755372] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   68.755373] CPU: L2 Cache: 1024K (64 bytes/line)
[   68.755376] CPU 6/6(2) -> Node 3 -> Core 0
[   68.755505] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   68.756372] CPU 6: Syncing TSC to CPU 0.
[   68.756607] CPU 6: synchronized TSC with CPU 0 (last diff -2 cycles, maxerr 1731 cycles)
[   68.757636] lockdep: not fixing up alternatives.
[   68.906332] Booting processor 7/8 APIC 0x7
[   68.928851] Initializing CPU#7
[   68.989822] Calibrating delay using timer specific routine.. 5199.26 BogoMIPS (lpj=2599631)
[   68.989831] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   68.989833] CPU: L2 Cache: 1024K (64 bytes/line)
[   68.989836] CPU 7/7(2) -> Node 3 -> Core 1
[   68.989963] Dual Core AMD Opteron(tm) Processor 885 stepping 02
[   68.990839] CPU 7: Syncing TSC to CPU 0.
[   68.991078] CPU 7: synchronized TSC with CPU 0 (last diff 3 cycles, maxerr 1731 cycles)
[   68.991091] Brought up 8 CPUs
[   69.134637] lockdep: disabled NMI watchdog.
[   69.147145] Disabling vsyscall due to use of PM timer
[   69.162245] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[   69.179418] time.c: Detected 2600.003 MHz processor.
[   70.126641] migration_cost=394,475
[   70.141165] NET: Registered protocol family 16
[   70.154564] ACPI: bus type pci registered
[   70.166550] PCI: Using configuration type 1
[   70.179152] Unable to handle kernel paging request at 0000000100000007 RIP:
[   70.192949]  [<ffffffff8020c82b>] save_stack_trace+0x187/0x234
[   70.217778] PGD 0
[   70.223849] Oops: 0000 [1] SMP
[   70.233344] last sysfs file:
[   70.242217] CPU 2
[   70.248288] Modules linked in:
[   70.257474] Pid: 34, comm: khelper Not tainted 2.6.17-rc5-mm1 #4
[   70.275425] RIP: 0010:[<ffffffff8020c82b>]  [<ffffffff8020c82b>] save_stack_trace+0x187/0x234
[   70.300435] RSP: 0000:ffff81019b51da48  EFLAGS: 00010046
[   70.316884] RAX: 0000000000000001 RBX: ffff81019b51dab8 RCX: ffffffff805c86b8
[   70.338210] RDX: 0000000000000001 RSI: 0000000000000009 RDI: ffff81019b51e000
[   70.359537] RBP: ffff81019b51dab8 R08: 00000000ffffffff R09: 0000000000000000
[   70.380862] R10: ffffffffffffffff R11: ffffffff805a4d18 R12: ffffffff807723f8
[   70.402190] R13: ffff81011a295080 R14: ffff81011a295080 R15: 0000000000000000
[   70.423514] FS:  0000000000000000(0000) GS:ffff81011a4d9e40(0000) knlGS:0000000000000000
[   70.447694] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[   70.464869] CR2: 0000000100000007 CR3: 0000000000201000 CR4: 00000000000006e0
[   70.486196] Process khelper (pid: 34, threadinfo ffff81019b51c000, task ffff81011a295080)
[   70.510635] Stack: 0000000000000003 ffff81019b51da58 ffff81019b51e000 ffffffff80248484
[   70.534243]        0000000000000000 0000000000000001 ffffffff804bc5c8 ffff81019b51dab8
[   70.558422]        0000000000000000 ffffffff807723f8
[   70.573652] Call Trace:
[   70.581545]  [<ffffffff80248484>] __lockdep_acquire+0xa98/0xad2
[   70.599289]  [<ffffffff80246cab>] save_trace+0x3e/0xe6
[   70.614698]  [<ffffffff80246e43>] add_lock_to_list+0x79/0xa0
[   70.631666]  [<ffffffff8024837d>] __lockdep_acquire+0x991/0xad2
[   70.649413]  [<ffffffff8022bec4>] copy_process+0x1314/0x1816
[   70.666380]  [<ffffffff802488a5>] lockdep_acquire+0x82/0xa3
[   70.683063]  [<ffffffff8043af82>] _spin_lock+0x1c/0x28
[   70.698471]  [<ffffffff8022bec4>] copy_process+0x1314/0x1816
[   70.715441]  [<ffffffff8043b33f>] _spin_unlock_irq+0x28/0x2e
[   70.732407]  [<ffffffff8023f3cc>] alloc_pid+0x2b1/0x2d9
[   70.748052]  [<ffffffff8022c4c8>] do_fork+0x102/0x236
[   70.763201]  [<ffffffff8023f35e>] alloc_pid+0x243/0x2d9
[   70.778874]  [<ffffffff80247268>] mark_lock+0x3b/0x4fc
[   70.794284]  [<ffffffff80247268>] mark_lock+0x3b/0x4fc
[   70.809670]  [<ffffffff8020a51d>] kernel_thread+0x81/0xde
[   70.825859]  [<ffffffff8023e38b>] run_workqueue+0x17/0x10f
[   70.842306]  [<ffffffff8023df29>] ____call_usermodehelper+0x0/0x10e
[   70.861088]  [<ffffffff8020a57a>] child_rip+0x0/0x12
[   70.875983]  [<ffffffff8023ddc5>] __call_usermodehelper+0x32/0x4d
[   70.894246]  [<ffffffff8023e42d>] run_workqueue+0xb9/0x10f
[   70.910694]  [<ffffffff8023dd93>] __call_usermodehelper+0x0/0x4d
[   70.928701]  [<ffffffff8023e539>] worker_thread+0x0/0x128
[   70.944889]  [<ffffffff8023e62e>] worker_thread+0xf5/0x128
[   70.961314]  [<ffffffff802276bf>] default_wake_function+0x0/0xf
[   70.979058]  [<ffffffff8023e539>] worker_thread+0x0/0x128
[   70.995247]  [<ffffffff80241cba>] kthread+0xd1/0xfb
[   71.009880]  [<ffffffff8023e539>] worker_thread+0x0/0x128
[   71.026068]  [<ffffffff8020a582>] child_rip+0x8/0x12
[   71.040959]  [<ffffffff8043b33f>] _spin_unlock_irq+0x28/0x2e
[   71.057929]  [<ffffffff80209bcf>] restore_args+0x0/0x30
[   71.073599]  [<ffffffff80241be9>] kthread+0x0/0xfb
[   71.087970]  [<ffffffff8020a57a>] child_rip+0x0/0x12
[   71.102861]
[   71.107324]
[   71.107324] Code: 4d 8b 50 08 75 1b 41 8b 14 24 49 8b 4c 24 08 49 8d 42 ff 89
[   71.134383] RIP  [<ffffffff8020c82b>] save_stack_trace+0x187/0x234 RSP <ffff81019b51da48>
[   71.158926] CR2: 0000000100000007

--=-=-=
Content-Disposition: inline; filename=lockdep-config.txt

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.17-rc5-mm1
# Tue May 30 13:37:32 2006
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
# CONFIG_SWAP_PREFETCH is not set
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_SYSCTL=y
# CONFIG_UTS_NS is not set
CONFIG_AUDIT=y
# CONFIG_AUDITSYSCALL is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CPUSETS=y
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_KLIBC_ERRLIST=y
CONFIG_KLIBC_ZLIB=y
CONFIG_UID16=y
CONFIG_VM86=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_RT_MUTEXES=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_LBD=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VSMP is not set
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTERNODE_CACHE_BYTES=64
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_BKL is not set
CONFIG_NUMA=y
CONFIG_K8_NUMA=y
CONFIG_NODES_SHIFT=6
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_DISCONTIGMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
# CONFIG_UNALIGNED_ZONE_BOUNDARIES is not set
# CONFIG_ADAPTIVE_READAHEAD is not set
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_OUT_OF_LINE_PFN_TO_PAGE=y
CONFIG_NR_CPUS=32
# CONFIG_HOTPLUG_CPU is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x200000
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_REORDER is not set
CONFIG_K8_NB=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=m
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_ASUS=m
# CONFIG_ACPI_ATLAS is not set
CONFIG_ACPI_IBM=m
# CONFIG_ACPI_IBM_DOCK is not set
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_SONY is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=m

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=m
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
CONFIG_PCI_MSI=y
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
CONFIG_HOTPLUG_PCI_ACPI=m
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_TCP_CONG_ADVANCED=y

#
# TCP congestion control
#
CONFIG_TCP_CONG_BIC=y
# CONFIG_TCP_CONG_CUBIC is not set
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_SCALABLE=m

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
CONFIG_IPV6_TUNNEL=m
CONFIG_NETWORK_SECMARK=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
# CONFIG_IP_NF_CONNTRACK_SECMARK is not set
CONFIG_IP_NF_CONNTRACK_EVENTS=y
CONFIG_IP_NF_CONNTRACK_NETLINK=m
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_NETBIOS_NS=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_PPTP=m
# CONFIG_IP_NF_H323 is not set
CONFIG_IP_NF_QUEUE=m

#
# IPv6: Netfilter Configuration (EXPERIMENTAL)
#
CONFIG_IP6_NF_QUEUE=m

#
# DCCP Configuration (EXPERIMENTAL)
#
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP_CCID2 is not set
CONFIG_IP_DCCP_CCID3=m
CONFIG_IP_DCCP_TFRC_LIB=m

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=y
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
CONFIG_6PACK=m
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_YAM=m
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
CONFIG_BLK_DEV_INITRD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=m
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=m
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
# CONFIG_SCSI_TGT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
# CONFIG_SCSI_SAS_DOMAIN_ATTRS is not set

#
# SCSI low-level drivers
#
CONFIG_ISCSI_TCP=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_AHCI=m
# CONFIG_SCSI_PATA_ALI is not set
# CONFIG_SCSI_PATA_AMD is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_PATA_TRIFLEX is not set
# CONFIG_SCSI_PATA_MPIIX is not set
# CONFIG_SCSI_PATA_OLDPIIX is not set
CONFIG_SCSI_ATA_PIIX=m
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_PATA_NETCELL is not set
CONFIG_SCSI_SATA_NV=y
# CONFIG_SCSI_PATA_OPTI is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_PATA_PDC2027X is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_PATA_SIL680 is not set
# CONFIG_SCSI_PATA_SIS is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_PATA_VIA is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set
CONFIG_SCSI_SRP=m

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
# CONFIG_MD_RAID456 is not set
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_EMC=m

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
# CONFIG_I2O_LCT_NOTIFY_ON_CHANGES is not set
CONFIG_I2O_EXT_ADAPTEC=y
CONFIG_I2O_EXT_ADAPTEC_DMA64=y
CONFIG_I2O_CONFIG=m
CONFIG_I2O_CONFIG_OLD_IOCTL=y
CONFIG_I2O_BUS=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_LXT_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_SMSC_PHY is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_CASSINI=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_HP100=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
# CONFIG_AMD8111E_NAPI is not set
CONFIG_ADAPTEC_STARFIRE=m
# CONFIG_ADAPTEC_STARFIRE_NAPI is not set
CONFIG_B44=m
CONFIG_FORCEDETH=m
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
CONFIG_E100=m
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
CONFIG_DL2K=m
CONFIG_E1000=m
# CONFIG_E1000_NAPI is not set
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
CONFIG_NS83820=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_R8169=m
# CONFIG_R8169_NAPI is not set
# CONFIG_R8169_VLAN is not set
CONFIG_SIS190=m
CONFIG_SKGE=m
# CONFIG_SKY2 is not set
CONFIG_SK98LIN=m
CONFIG_VIA_VELOCITY=m
CONFIG_TIGON3=m
CONFIG_BNX2=m

#
# Ethernet (10000 Mbit)
#
CONFIG_CHELSIO_T1=m
CONFIG_IXGB=m
# CONFIG_IXGB_NAPI is not set
CONFIG_S2IO=m
# CONFIG_S2IO_NAPI is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
CONFIG_WAN=y
CONFIG_DSCC4=m
CONFIG_DSCC4_PCISYNC=y
CONFIG_DSCC4_PCI_RST=y
CONFIG_LANMEDIA=m
CONFIG_HDLC=m
CONFIG_HDLC_RAW=y
CONFIG_HDLC_RAW_ETH=y
CONFIG_HDLC_CISCO=y
CONFIG_HDLC_FR=y
CONFIG_HDLC_PPP=y

#
# X.25/LAPB support is disabled
#
CONFIG_PCI200SYN=m
CONFIG_WANXL=m
CONFIG_PC300=m
CONFIG_PC300_MLPPP=y
CONFIG_FARSYNC=m
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_SBNI=m
# CONFIG_SBNI_MULTILINE is not set
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
CONFIG_HIPPI=y
CONFIG_ROADRUNNER=m
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_MPPE=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_NET_FC=y
CONFIG_SHAPER=m
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_VSXXXAA=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=m
CONFIG_I6300ESB_WDT=m
CONFIG_I8XX_TCO=m
# CONFIG_ITCO_WDT is not set
CONFIG_SC1200_WDT=m
CONFIG_60XX_WDT=m
CONFIG_SBC8360_WDT=m
CONFIG_CPU5_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m
CONFIG_WDT_501_PCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=m
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=m
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_I2C_OCORES is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L1 is not set
# CONFIG_VIDEO_V4L1_COMPAT is not set
CONFIG_VIDEO_V4L2=y

#
# Video Capture Adapters
#

#
# Video Capture Adapters
#
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_VIVI is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_CPIA2 is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_CX88 is not set

#
# Encoders and Decoders
#
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_CX25840 is not set
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set

#
# V4L USB devices
#
# CONFIG_USB_QUICKCAM_MESSENGER is not set

#
# Radio Adapters
#

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_ARC=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_FB_HGA=m
# CONFIG_FB_HGA_ACCEL is not set
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_INTEL is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_SAVAGE=m
# CONFIG_FB_SAVAGE_I2C is not set
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_TRIDENT=m
# CONFIG_FB_TRIDENT_ACCEL is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_VIRTUAL=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
# CONFIG_LOGO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_STORAGE_ALAUDA=y
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_AIRPRIME=m
CONFIG_USB_SERIAL_ANYDATA=m
# CONFIG_USB_SERIAL_ARK3116 is not set
CONFIG_USB_SERIAL_BELKIN=m
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP2101=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
# CONFIG_USB_SERIAL_FUNSOFT is not set
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_HP4X=m
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_GOTEMP is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_MTHCA=m
CONFIG_INFINIBAND_MTHCA_DEBUG=y
CONFIG_IPATH_CORE=m
CONFIG_INFINIBAND_IPATH=m
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
# CONFIG_INFINIBAND_ISER is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISER4_FS is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_CRAMFS=y
CONFIG_VXFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m
CONFIG_9P_FS=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_SHIRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_MUTEX_ALLOC=y
CONFIG_DEBUG_MUTEX_DEADLOCKS=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_PROVE_SPIN_LOCKING=y
CONFIG_PROVE_RW_LOCKING=y
CONFIG_PROVE_MUTEX_LOCKING=y
CONFIG_PROVE_RWSEM_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=y
# CONFIG_UNWIND_INFO is not set
CONFIG_FORCED_INLINING=y
# CONFIG_DEBUG_SYNCHRO_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_PROFILE_LIKELY=y
# CONFIG_WANT_EXTRA_DEBUG_INFORMATION is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_IOMMU_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_ROOTPLUG=m
CONFIG_SECURITY_SECLVL=m
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_X86_64=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_PLIST=y

--=-=-=--
