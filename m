Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264316AbUD2MRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264316AbUD2MRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbUD2MRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:17:03 -0400
Received: from chico.rediris.es ([130.206.1.3]:14818 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S264316AbUD2MQC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:16:02 -0400
From: David =?iso-8859-15?q?Mart=EDnez_Moreno?= <ender@debian.org>
Organization: Debian
To: sct@redhat.com, akpm@digeo.com, adilger@clusterfs.com
Subject: Ext3 problems (aborting journal).
Date: Thu, 29 Apr 2004 14:15:46 +0200
User-Agent: KMail/1.6.2
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org, ender@debian.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404291415.46949.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

	Hello all. I'm writing to all the people in charge of ext3 fs (from MAINTAINERS).

	When I touch some files from /usr/src it aborts:

[...]
Apr 29 12:13:34 arsinoe kernel: eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.
Apr 29 12:13:34 arsinoe kernel: process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 65700260, count = 1
Apr 29 12:21:21 arsinoe kernel: Aborting journal on device sda7.
Apr 29 12:21:21 arsinoe kernel: ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>EXT3-fs error (device sda7) in ext3_free_blocks: Journal has aborted
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1077209303, count = 1
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1075908393, count = 1
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1071716394, count = 1
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks in system zones - Block = 65636, count = 1
Apr 29 12:21:21 arsinoe kernel: ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>EXT3-fs error (device sda7) in ext3_free_blocks: Journal has aborted
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks in system zones - Block = 8, count = 1
Apr 29 12:21:21 arsinoe kernel: ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>EXT3-fs error (device sda7) in ext3_free_blocks: Journal has aborted
Apr 29 12:21:21 arsinoe last message repeated 2 times
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 65700260, count = 1
Apr 29 12:21:21 arsinoe kernel: ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>EXT3-fs error (device sda7) in ext3_free_blocks: Journal has aborted
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1077209303, count = 1
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1075908393, count = 1
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1073059338, count = 1
Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks in system zones - Block = 65636, count = 1
[...]

	Previously this box paniced, about 6 days ago, with 2.6.4-rc1-mm1 (IIRC):

Apr 19 18:13:05 arsinoe kernel: kjournald starting.  Commit interval 5 seconds
Apr 19 18:13:05 arsinoe kernel: EXT3 FS on sda6, internal journal
Apr 19 18:13:05 arsinoe kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 19 18:13:05 arsinoe kernel: kjournald starting.  Commit interval 5 seconds
Apr 19 18:13:05 arsinoe kernel: EXT3 FS on sda7, internal journal
Apr 19 18:13:05 arsinoe kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 19 18:13:05 arsinoe kernel: XFS mounting filesystem md0
Apr 19 18:13:05 arsinoe kernel: Ending clean XFS mount for filesystem: md0
Apr 19 18:13:05 arsinoe kernel: process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
Apr 23 10:58:58 arsinoe kernel: eth0: Setting promiscuous mode.
Apr 23 10:58:58 arsinoe kernel: device eth0 entered promiscuous mode
Apr 23 10:59:14 arsinoe kernel: device eth0 left promiscuous mode
Apr 23 10:59:17 arsinoe kernel: eth1: Promiscuous mode enabled.
Apr 23 10:59:17 arsinoe kernel: device eth1 entered promiscuous mode
Apr 23 10:59:22 arsinoe kernel: device eth1 left promiscuous mode
Apr 23 10:59:46 arsinoe kernel: eth0: Setting promiscuous mode.
Apr 23 10:59:46 arsinoe kernel: device eth0 entered promiscuous mode
Apr 23 11:00:44 arsinoe kernel: device eth0 left promiscuous mode
Apr 23 11:01:46 arsinoe kernel: eth0: Setting promiscuous mode.
Apr 23 11:01:46 arsinoe kernel: device eth0 entered promiscuous mode
Apr 23 11:15:47 arsinoe kernel: device eth0 left promiscuous mode
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 2553887680, count = 1
Apr 23 20:35:41 arsinoe kernel: Aborting journal on device sda7.
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 33554432, count = 1
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 4197450496, count = 1
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 762804087, count = 1
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1635017060, count = 1
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1668572463, count = 1
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1869767471, count = 1
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 795094638, count = 1
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1735684717, count = 1
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1852796160, count = 1
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1819242356, count = 1
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks in system zones - Block = 115, count = 1
Apr 23 20:35:41 arsinoe kernel: ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>EXT3-fs error (device sda7) in ext3_free_blocks: Journal has aborted
Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1075532092, count = 1
[...]
Apr 23 20:35:41 arsinoe kernel: Assertion failure in journal_forget() at fs/jbd/transaction.c:1227: "!jh->b_committed_data"
Apr 23 20:35:41 arsinoe kernel: ------------[ cut here ]------------
Apr 23 20:35:41 arsinoe kernel: kernel BUG at fs/jbd/transaction.c:1227!
Apr 23 20:35:41 arsinoe kernel: invalid operand: 0000 [#1]
Apr 23 20:35:41 arsinoe kernel: CPU:    0
Apr 23 20:35:41 arsinoe kernel: EIP:    0060:[journal_forget+377/448]    Not tainted VLI
Apr 23 20:35:41 arsinoe kernel: EFLAGS: 00010282
Apr 23 20:35:41 arsinoe kernel: EIP is at journal_forget+0x179/0x1c0
Apr 23 20:35:41 arsinoe kernel: eax: 0000005f   ebx: c0018a50   ecx: 00000001   edx: c03a9158
Apr 23 20:35:41 arsinoe kernel: esi: c2564480   edi: c93df440   ebp: da09f3e4   esp: c3f4bdb4
Apr 23 20:35:41 arsinoe kernel: ds: 007b   es: 007b   ss: 0068
Apr 23 20:35:41 arsinoe kernel: Process ld (pid: 23751, threadinfo=c3f4a000 task=c50ccea0)
Apr 23 20:35:41 arsinoe kernel: Stack: c03736a0 c035cf27 c0370154 000004cb c037026a 00000002 cef1a4cc c0018a50
Apr 23 20:35:41 arsinoe kernel:        c017a720 da09f3e4 c0018a50 c0177a43 dfa33000 c035c120 00000002 d77b7e94
Apr 23 20:35:41 arsinoe kernel:        da09f3e4 cef1a4cc c017cc2a da09f3e4 00000000 cef1a4cc c0018a50 00000002
Apr 23 20:35:41 arsinoe kernel: Call Trace:
Apr 23 20:35:41 arsinoe kernel:  [ext3_forget+224/240] ext3_forget+0xe0/0xf0
Apr 23 20:35:41 arsinoe kernel:  [ext3_free_blocks+867/1168] ext3_free_blocks+0x363/0x490
Apr 23 20:35:41 arsinoe kernel:  [ext3_clear_blocks+266/352] ext3_clear_blocks+0x10a/0x160
Apr 23 20:35:41 arsinoe kernel:  [ext3_free_data+152/336] ext3_free_data+0x98/0x150
Apr 23 20:35:41 arsinoe kernel:  [ext3_free_branches+230/624] ext3_free_branches+0xe6/0x270
Apr 23 20:35:41 arsinoe kernel:  [ext3_truncate+1262/1520] ext3_truncate+0x4ee/0x5f0
Apr 23 20:35:41 arsinoe kernel:  [journal_start+169/208] journal_start+0xa9/0xd0
Apr 23 20:35:41 arsinoe kernel:  [start_transaction+35/96] start_transaction+0x23/0x60
Apr 23 20:35:41 arsinoe kernel:  [ext3_delete_inode+198/272] ext3_delete_inode+0xc6/0x110
Apr 23 20:35:41 arsinoe kernel:  [ext3_delete_inode+0/272] ext3_delete_inode+0x0/0x110
Apr 23 20:35:41 arsinoe kernel:  [generic_delete_inode+101/224] generic_delete_inode+0x65/0xe0
Apr 23 20:35:41 arsinoe kernel:  [ext3_put_inode+19/48] ext3_put_inode+0x13/0x30
Apr 23 20:35:41 arsinoe kernel:  [iput_final+38/48] iput_final+0x26/0x30
Apr 23 20:35:41 arsinoe kernel:  [sys_unlink+270/320] sys_unlink+0x10e/0x140
Apr 23 20:35:41 arsinoe kernel:  [sysenter_past_esp+67/101] sysenter_past_esp+0x43/0x65
Apr 23 20:35:41 arsinoe kernel:
Apr 23 20:35:41 arsinoe kernel: Code: 44 24 10 6a 02 37 c0 c7 44 24 0c cb 04 00 00 c7 44 24 08 54 01 37 c0 c7 44 24 04 27 cf 35 c0 c7 04 24 a0 36 37 c0 e8 27 18 f9 ff <0f> 0b cb 04 54 01 37 c0 e9 6c ff ff ff c7 44 24 10 80 02 37 c0
Apr 23 20:35:41 arsinoe kernel:  <2>ext3_abort called.
Apr 23 20:35:41 arsinoe kernel: EXT3-fs abort (device sda7): ext3_journal_start: Detected aborted journal
Apr 23 20:35:41 arsinoe kernel: Remounting filesystem read-only

	The dmesg after that:

Apr 23 20:38:46 arsinoe kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Apr 23 20:38:47 arsinoe kernel: Inspecting /boot/System.map-2.6.4-rc1-mm1
Apr 23 20:38:47 arsinoe kernel: Loaded 21949 symbols from /boot/System.map-2.6.4-rc1-mm1.
Apr 23 20:38:47 arsinoe kernel: Symbols match kernel version 2.6.4.
Apr 23 20:38:47 arsinoe kernel: No module symbols loaded - kernel modules not enabled.
Apr 23 20:38:47 arsinoe kernel: Linux version 2.6.4-rc1-mm1 (root@arsinoe.utopia) (gcc versión 3.3.2 (Debian)) #18 Fri Mar 5 14:17:53 CET 2004
Apr 23 20:38:47 arsinoe kernel: BIOS-provided physical RAM map:
Apr 23 20:38:47 arsinoe kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Apr 23 20:38:47 arsinoe kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Apr 23 20:38:47 arsinoe kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Apr 23 20:38:47 arsinoe kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Apr 23 20:38:47 arsinoe kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Apr 23 20:38:47 arsinoe kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Apr 23 20:38:47 arsinoe kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Apr 23 20:38:47 arsinoe kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Apr 23 20:38:47 arsinoe kernel: 511MB LOWMEM available.
Apr 23 20:38:47 arsinoe kernel: found SMP MP-table at 000f51a0
Apr 23 20:38:47 arsinoe kernel: zapping low mappings.
Apr 23 20:38:47 arsinoe kernel: On node 0 totalpages: 131056
Apr 23 20:38:47 arsinoe kernel:   DMA zone: 4096 pages, LIFO batch:1
Apr 23 20:38:47 arsinoe kernel:   Normal zone: 126960 pages, LIFO batch:16
Apr 23 20:38:47 arsinoe kernel:   HighMem zone: 0 pages, LIFO batch:1
Apr 23 20:38:47 arsinoe kernel: DMI 2.3 present.
Apr 23 20:38:47 arsinoe kernel: ACPI: RSDP (v000 GBT                                       ) @ 0x000f6a60
Apr 23 20:38:47 arsinoe kernel: ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
Apr 23 20:38:47 arsinoe kernel: ACPI: RSDP (v000 GBT                                       ) @ 0x000f6a60
Apr 23 20:38:47 arsinoe kernel: ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
Apr 23 20:38:47 arsinoe kernel: ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
Apr 23 20:38:47 arsinoe kernel: ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff5d40
Apr 23 20:38:47 arsinoe kernel: ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Apr 23 20:38:47 arsinoe kernel: ACPI: Local APIC address 0xfee00000
Apr 23 20:38:47 arsinoe kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Apr 23 20:38:47 arsinoe kernel: Processor #0 6:8 APIC version 16
Apr 23 20:38:47 arsinoe kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Apr 23 20:38:47 arsinoe kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Apr 23 20:38:47 arsinoe kernel: IOAPIC[0]: Assigned apic_id 2
Apr 23 20:38:47 arsinoe kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
Apr 23 20:38:47 arsinoe kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Apr 23 20:38:47 arsinoe kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Apr 23 20:38:47 arsinoe kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Apr 23 20:38:47 arsinoe kernel: Using ACPI (MADT) for SMP configuration information
Apr 23 20:38:47 arsinoe kernel: Built 1 zonelists
Apr 23 20:38:47 arsinoe kernel: Initializing CPU#0
Apr 23 20:38:47 arsinoe kernel: Kernel command line: auto BOOT_IMAGE=dev ro root=801
Apr 23 20:38:47 arsinoe kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Apr 23 20:38:47 arsinoe kernel: Detected 1542.070 MHz processor.
Apr 23 20:38:47 arsinoe kernel: Using tsc for high-res timesource
Apr 23 20:38:47 arsinoe kernel: Console: colour VGA+ 80x25
Apr 23 20:38:47 arsinoe kernel: Memory: 514528k/524224k available (2387k kernel code, 8936k reserved, 655k data, 356k init, 0k highmem)
Apr 23 20:38:47 arsinoe kernel: Calibrating delay loop... 3039.23 BogoMIPS
Apr 23 20:38:47 arsinoe kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Apr 23 20:38:47 arsinoe kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Apr 23 20:38:47 arsinoe kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Apr 23 20:38:47 arsinoe kernel: CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
Apr 23 20:38:47 arsinoe kernel: CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
Apr 23 20:38:47 arsinoe kernel: CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f
Apr 23 20:38:47 arsinoe kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Apr 23 20:38:47 arsinoe kernel: CPU: L2 Cache: 256K (64 bytes/line)
Apr 23 20:38:47 arsinoe kernel: CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Apr 23 20:38:47 arsinoe kernel: Intel machine check architecture supported.
Apr 23 20:38:47 arsinoe kernel: Intel machine check reporting enabled on CPU#0.
Apr 23 20:38:47 arsinoe kernel: CPU: AMD Athlon(tm) XP 1800+ stepping 01
Apr 23 20:38:47 arsinoe kernel: Enabling fast FPU save and restore... done.
Apr 23 20:38:47 arsinoe kernel: Enabling unmasked SIMD FPU exception support... done.
Apr 23 20:38:47 arsinoe kernel: Checking 'hlt' instruction... OK.
Apr 23 20:38:47 arsinoe kernel: POSIX conformance testing by UNIFIX
Apr 23 20:38:47 arsinoe kernel: enabled ExtINT on CPU#0
Apr 23 20:38:47 arsinoe kernel: POSIX conformance testing by UNIFIX
Apr 23 20:38:47 arsinoe kernel: enabled ExtINT on CPU#0
Apr 23 20:38:47 arsinoe kernel: ESR value before enabling vector: 00000000
Apr 23 20:38:47 arsinoe kernel: ESR value after enabling vector: 00000000
Apr 23 20:38:47 arsinoe kernel: ENABLING IO-APIC IRQs
Apr 23 20:38:47 arsinoe kernel: init IO_APIC IRQs
Apr 23 20:38:47 arsinoe kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Apr 23 20:38:47 arsinoe kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Apr 23 20:38:47 arsinoe kernel: Using local APIC timer interrupts.
Apr 23 20:38:47 arsinoe kernel: calibrating APIC timer ...
Apr 23 20:38:47 arsinoe kernel: ..... CPU clock speed is 1541.0007 MHz.
Apr 23 20:38:47 arsinoe kernel: ..... host bus clock speed is 268.0001 MHz.
Apr 23 20:38:47 arsinoe kernel: NET: Registered protocol family 16
Apr 23 20:38:47 arsinoe kernel: PCI: PCI BIOS revision 2.10 entry at 0xfa2c0, last bus=1
Apr 23 20:38:47 arsinoe kernel: PCI: Using configuration type 1
Apr 23 20:38:47 arsinoe kernel: mtrr: v2.0 (20020519)
Apr 23 20:38:47 arsinoe kernel: ACPI: Subsystem revision 20040220
Apr 23 20:38:47 arsinoe kernel: IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
Apr 23 20:38:47 arsinoe kernel: ACPI: Interpreter enabled
Apr 23 20:38:47 arsinoe kernel: ACPI: Using IOAPIC for interrupt routing
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Apr 23 20:38:47 arsinoe kernel: PCI: Probing PCI hardware (bus 00)
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
Apr 23 20:38:47 arsinoe kernel: SCSI subsystem initialized
Apr 23 20:38:47 arsinoe kernel: drivers/usb/core/usb.c: registered new driver usbfs
Apr 23 20:38:47 arsinoe kernel: drivers/usb/core/usb.c: registered new driver hub
Apr 23 20:38:47 arsinoe kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
Apr 23 20:38:47 arsinoe kernel: 00:00:09[A] -> 2-17 -> IRQ 17
Apr 23 20:38:47 arsinoe kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
Apr 23 20:38:47 arsinoe kernel: 00:00:09[B] -> 2-18 -> IRQ 18
Apr 23 20:38:47 arsinoe kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
Apr 23 20:38:47 arsinoe kernel: 00:00:09[C] -> 2-19 -> IRQ 19
Apr 23 20:38:47 arsinoe kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
Apr 23 20:38:47 arsinoe kernel: 00:00:09[D] -> 2-16 -> IRQ 16
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Apr 23 20:38:47 arsinoe kernel: IOAPIC[0]: Set PCI routing entry (2-11 -> 0x81 -> IRQ 11 Mode:1 Active:1)
Apr 23 20:38:47 arsinoe kernel: 00:00:07[A] -> 2-11 -> IRQ 11
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Apr 23 20:38:47 arsinoe kernel: 00:00:07[A] -> 2-11 -> IRQ 11
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Apr 23 20:38:47 arsinoe kernel: IOAPIC[0]: Set PCI routing entry (2-10 -> 0x79 -> IRQ 10 Mode:1 Active:1)
Apr 23 20:38:47 arsinoe kernel: 00:00:07[B] -> 2-10 -> IRQ 10
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Apr 23 20:38:47 arsinoe kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Apr 23 20:38:47 arsinoe kernel: number of MP IRQ sources: 15.
Apr 23 20:38:47 arsinoe kernel: number of IO-APIC #2 registers: 24.
Apr 23 20:38:47 arsinoe kernel: testing the IO APIC.......................
Apr 23 20:38:47 arsinoe kernel: IO APIC #2......
Apr 23 20:38:47 arsinoe kernel: .... register #00: 02000000
Apr 23 20:38:47 arsinoe kernel: .......    : physical APIC id: 02
Apr 23 20:38:47 arsinoe kernel: .......    : Delivery Type: 0
Apr 23 20:38:47 arsinoe kernel: .......    : LTS          : 0
Apr 23 20:38:47 arsinoe kernel: .... register #01: 00178011
Apr 23 20:38:47 arsinoe kernel: .......     : max redirection entries: 0017
Apr 23 20:38:47 arsinoe kernel: .......     : PRQ implemented: 1
Apr 23 20:38:47 arsinoe kernel: .......     : IO APIC version: 0011
Apr 23 20:38:47 arsinoe kernel: .... register #02: 00000000
Apr 23 20:38:47 arsinoe kernel: .......     : arbitration: 00
Apr 23 20:38:47 arsinoe kernel: .... IRQ redirection table:
Apr 23 20:38:47 arsinoe kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Apr 23 20:38:47 arsinoe kernel:  00 000 00  1    0    0   0   0    0    0    00
Apr 23 20:38:47 arsinoe kernel:  01 001 01  0    0    0   0   0    1    1    39
Apr 23 20:38:47 arsinoe kernel:  02 001 01  0    0    0   0   0    1    1    31
Apr 23 20:38:47 arsinoe kernel:  03 001 01  0    0    0   0   0    1    1    41
Apr 23 20:38:47 arsinoe kernel:  04 001 01  0    0    0   0   0    1    1    49
Apr 23 20:38:47 arsinoe kernel:  05 001 01  0    0    0   0   0    1    1    51
Apr 23 20:38:47 arsinoe kernel:  06 001 01  0    0    0   0   0    1    1    59
Apr 23 20:38:47 arsinoe kernel:  07 001 01  0    0    0   0   0    1    1    61
Apr 23 20:38:47 arsinoe kernel:  08 001 01  0    0    0   0   0    1    1    69
Apr 23 20:38:47 arsinoe kernel:  09 001 01  0    1    0   1   0    1    1    71
Apr 23 20:38:47 arsinoe kernel:  0a 001 01  1    1    0   1   0    1    1    79
Apr 23 20:38:47 arsinoe kernel:  0b 001 01  1    1    0   1   0    1    1    81
Apr 23 20:38:47 arsinoe kernel:  0c 001 01  0    0    0   0   0    1    1    89
Apr 23 20:38:47 arsinoe kernel:  0d 001 01  0    0    0   0   0    1    1    91
Apr 23 20:38:47 arsinoe kernel:  0e 001 01  0    0    0   0   0    1    1    99
Apr 23 20:38:47 arsinoe kernel:  0f 001 01  0    0    0   0   0    1    1    A1
Apr 23 20:38:47 arsinoe kernel:  10 001 01  1    1    0   1   0    1    1    C1
Apr 23 20:38:47 arsinoe kernel:  11 001 01  1    1    0   1   0    1    1    A9
Apr 23 20:38:47 arsinoe kernel:  12 001 01  1    1    0   1   0    1    1    B1
Apr 23 20:38:47 arsinoe kernel:  13 001 01  1    1    0   1   0    1    1    B9
Apr 23 20:38:47 arsinoe kernel:  12 001 01  1    1    0   1   0    1    1    B1
Apr 23 20:38:47 arsinoe kernel:  13 001 01  1    1    0   1   0    1    1    B9
Apr 23 20:38:47 arsinoe kernel:  14 000 00  1    0    0   0   0    0    0    00
Apr 23 20:38:47 arsinoe kernel:  15 000 00  1    0    0   0   0    0    0    00
Apr 23 20:38:47 arsinoe kernel:  16 000 00  1    0    0   0   0    0    0    00
Apr 23 20:38:47 arsinoe kernel:  17 000 00  1    0    0   0   0    0    0    00
Apr 23 20:38:47 arsinoe kernel: IRQ to pin mappings:
Apr 23 20:38:47 arsinoe kernel: IRQ0 -> 0:2
Apr 23 20:38:47 arsinoe kernel: IRQ1 -> 0:1
Apr 23 20:38:47 arsinoe kernel: IRQ3 -> 0:3
Apr 23 20:38:47 arsinoe kernel: IRQ4 -> 0:4
Apr 23 20:38:47 arsinoe kernel: IRQ5 -> 0:5
Apr 23 20:38:47 arsinoe kernel: IRQ6 -> 0:6
Apr 23 20:38:47 arsinoe kernel: IRQ7 -> 0:7
Apr 23 20:38:47 arsinoe kernel: IRQ8 -> 0:8
Apr 23 20:38:47 arsinoe kernel: IRQ9 -> 0:9-> 0:9
Apr 23 20:38:47 arsinoe kernel: IRQ10 -> 0:10-> 0:10
Apr 23 20:38:47 arsinoe kernel: IRQ11 -> 0:11-> 0:11
Apr 23 20:38:47 arsinoe kernel: IRQ12 -> 0:12
Apr 23 20:38:47 arsinoe kernel: IRQ13 -> 0:13
Apr 23 20:38:47 arsinoe kernel: IRQ14 -> 0:14
Apr 23 20:38:47 arsinoe kernel: IRQ15 -> 0:15
Apr 23 20:38:47 arsinoe kernel: IRQ16 -> 0:16
Apr 23 20:38:47 arsinoe kernel: IRQ17 -> 0:17
Apr 23 20:38:47 arsinoe kernel: IRQ18 -> 0:18
Apr 23 20:38:47 arsinoe kernel: IRQ19 -> 0:19
Apr 23 20:38:47 arsinoe kernel: .................................... done.
Apr 23 20:38:47 arsinoe kernel: PCI: Using ACPI for IRQ routing
Apr 23 20:38:47 arsinoe kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Apr 23 20:38:47 arsinoe kernel: Machine check exception polling timer started.
Apr 23 20:38:47 arsinoe kernel: ikconfig 0.7 with /proc/config*
Apr 23 20:38:47 arsinoe kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Apr 23 20:38:47 arsinoe kernel: SGI XFS with no debug enabled
Apr 23 20:38:47 arsinoe kernel: PCI: Enabling Via external APIC routing
Apr 23 20:38:47 arsinoe kernel: ACPI: Power Button (FF) [PWRF]
Apr 23 20:38:47 arsinoe kernel: ACPI: Sleep Button (CM) [SLPB]
Apr 23 20:38:47 arsinoe kernel: ACPI: Processor [CPU0] (supports C1, 2 throttling states)
Apr 23 20:38:47 arsinoe kernel: ACPI: Thermal Zone [THRM] (32 C)
Apr 23 20:38:47 arsinoe kernel: Real Time Clock Driver v1.12
Apr 23 20:38:47 arsinoe kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Apr 23 20:38:47 arsinoe kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Apr 23 20:38:47 arsinoe kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Apr 23 20:38:47 arsinoe kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Apr 23 20:38:47 arsinoe kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Apr 23 20:38:47 arsinoe kernel: Using anticipatory io scheduler
Apr 23 20:38:47 arsinoe kernel: Floppy drive(s): fd0 is 1.44M
Apr 23 20:38:47 arsinoe kernel: FDC 0 is a post-1991 82077
Apr 23 20:38:47 arsinoe kernel: loop: loaded (max 8 devices)
Apr 23 20:38:47 arsinoe kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Apr 23 20:38:47 arsinoe kernel: 0000:00:0c.0: 3Com PCI 3c905C Tornado at 0xc800. Vers LK1.1.19
Apr 23 20:38:47 arsinoe kernel: Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
Apr 23 20:38:47 arsinoe kernel: eth1: ADMtek Comet rev 17 at 0xe0806000, 00:05:1C:0F:1A:FC, IRQ 19.
Apr 23 20:38:47 arsinoe kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Apr 23 20:38:47 arsinoe kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Apr 23 20:38:47 arsinoe kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
Apr 23 20:38:47 arsinoe kernel: VP_IDE: chipset revision 6
Apr 23 20:38:47 arsinoe kernel: VP_IDE: not 100%% native mode: will probe irqs later
Apr 23 20:38:47 arsinoe kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
Apr 23 20:38:47 arsinoe kernel:     ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:pio, hdb:pio
Apr 23 20:38:47 arsinoe kernel:     ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:pio, hdd:pio
Apr 23 20:38:47 arsinoe kernel: SiI680: IDE controller at PCI slot 0000:00:0a.0
Apr 23 20:38:47 arsinoe kernel: SiI680: chipset revision 2
Apr 23 20:38:47 arsinoe kernel: SiI680: BASE CLOCK == 133
Apr 23 20:38:47 arsinoe kernel: SiI680: 100%% native mode on irq 18
Apr 23 20:38:47 arsinoe kernel:     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
Apr 23 20:38:47 arsinoe kernel:     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
Apr 23 20:38:47 arsinoe kernel: hde: IC35L080AVVA07-0, ATA DISK drive
Apr 23 20:38:47 arsinoe kernel: ide2 at 0xe080a080-0xe080a087,0xe080a08a on irq 18
Apr 23 20:38:47 arsinoe kernel: hdg: SAMSUNG SP8004H, ATA DISK drive
Apr 23 20:38:47 arsinoe kernel: ide3 at 0xe080a0c0-0xe080a0c7,0xe080a0ca on irq 18
Apr 23 20:38:47 arsinoe kernel: SiI680: IDE controller at PCI slot 0000:00:0d.0
Apr 23 20:38:47 arsinoe kernel: SiI680: chipset revision 2
Apr 23 20:38:47 arsinoe kernel: SiI680: BASE CLOCK == 133
Apr 23 20:38:47 arsinoe kernel: SiI680: 100%% native mode on irq 17
Apr 23 20:38:47 arsinoe kernel:     ide4: MMIO-DMA , BIOS settings: hdi:pio, hdj:pio
Apr 23 20:38:47 arsinoe kernel:     ide5: MMIO-DMA , BIOS settings: hdk:pio, hdl:pio
Apr 23 20:38:47 arsinoe kernel: hdi: ST380011A, ATA DISK drive
Apr 23 20:38:47 arsinoe kernel: ide4 at 0xe080c080-0xe080c087,0xe080c08a on irq 17
Apr 23 20:38:47 arsinoe kernel: hdk: ST380021A, ATA DISK drive
Apr 23 20:38:47 arsinoe kernel: ide5 at 0xe080c0c0-0xe080c0c7,0xe080c0ca on irq 17
Apr 23 20:38:47 arsinoe kernel: hde: max request size: 64KiB
Apr 23 20:38:47 arsinoe kernel: hde: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
Apr 23 20:38:47 arsinoe kernel:  hde: hde1
Apr 23 20:38:47 arsinoe kernel: hdg: max request size: 64KiB
Apr 23 20:38:47 arsinoe kernel:  hde: hde1
Apr 23 20:38:47 arsinoe kernel: hdg: max request size: 64KiB
Apr 23 20:38:47 arsinoe kernel: hdg: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Apr 23 20:38:47 arsinoe kernel:  hdg: hdg1
Apr 23 20:38:47 arsinoe kernel: hdi: max request size: 64KiB
Apr 23 20:38:47 arsinoe kernel: hdi: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
Apr 23 20:38:47 arsinoe kernel:  hdi: hdi1
Apr 23 20:38:47 arsinoe kernel: hdk: max request size: 64KiB
Apr 23 20:38:47 arsinoe kernel: hdk: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Apr 23 20:38:47 arsinoe kernel:  hdk: hdk1
Apr 23 20:38:47 arsinoe kernel: i91u: PCI Base=0xB000, IRQ=17, BIOS=0xD0000, SCSI ID=7
Apr 23 20:38:47 arsinoe kernel: i91u: Reset SCSI Bus ...
Apr 23 20:38:47 arsinoe kernel: ERROR: SCSI host `INI9100U' has no error handling
Apr 23 20:38:47 arsinoe kernel: ERROR: This is not a safe way to run your SCSI host
Apr 23 20:38:47 arsinoe kernel: ERROR: The error handling must be added to this driver
Apr 23 20:38:47 arsinoe kernel: Call Trace:
Apr 23 20:38:47 arsinoe kernel:  [scsi_host_alloc+660/672] scsi_host_alloc+0x294/0x2a0
Apr 23 20:38:47 arsinoe kernel:  [init_tulip+689/720] init_tulip+0x2b1/0x2d0
Apr 23 20:38:47 arsinoe kernel:  [scsi_register+31/112] scsi_register+0x1f/0x70
Apr 23 20:38:47 arsinoe kernel:  [i91u_detect+428/688] i91u_detect+0x1ac/0x2b0
Apr 23 20:38:47 arsinoe kernel:  [ide_register_driver+200/224] ide_register_driver+0xc8/0xe0
Apr 23 20:38:47 arsinoe kernel:  [init_this_scsi_driver+61/272] init_this_scsi_driver+0x3d/0x110
Apr 23 20:38:47 arsinoe kernel:  [do_initcalls+43/160] do_initcalls+0x2b/0xa0
Apr 23 20:38:47 arsinoe kernel:  [init_workqueues+15/96] init_workqueues+0xf/0x60
Apr 23 20:38:47 arsinoe kernel:  [init+0/304] init+0x0/0x130
Apr 23 20:38:47 arsinoe kernel:  [init+42/304] init+0x2a/0x130
Apr 23 20:38:47 arsinoe kernel:  [kernel_thread_helper+0/12] kernel_thread_helper+0x0/0xc
Apr 23 20:38:47 arsinoe kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Apr 23 20:38:47 arsinoe kernel:
Apr 23 20:38:47 arsinoe kernel: scsi0 : Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g
Apr 23 20:38:47 arsinoe kernel:   Vendor: SONY      Model: SDT-9000          Rev: 0601
Apr 23 20:38:47 arsinoe kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Apr 23 20:38:47 arsinoe kernel:   Vendor: IBM       Model: DDRS-39130W       Rev: S97B
Apr 23 20:38:47 arsinoe kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Apr 23 20:38:47 arsinoe kernel: st: Version 20040213, fixed bufsize 32768, s/g segs 256
Apr 23 20:38:47 arsinoe kernel: Attached scsi tape st0 at scsi0, channel 0, id 0, lun 0
Apr 23 20:38:47 arsinoe kernel: st0: try direct i/o: yes, max page reachable by HBA 131056
Apr 23 20:38:47 arsinoe kernel: SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
Apr 23 20:38:47 arsinoe kernel: SCSI device sda: drive cache: write back
Apr 23 20:38:47 arsinoe kernel:  sda: sda1 sda2 < sda5 sda6 sda7 >
Apr 23 20:38:47 arsinoe kernel: Attached scsi disk sda at scsi0, channel 0, id 4, lun 0
Apr 23 20:38:47 arsinoe kernel: USB Universal Host Controller Interface driver v2.2
Apr 23 20:38:47 arsinoe kernel: Attached scsi disk sda at scsi0, channel 0, id 4, lun 0
Apr 23 20:38:47 arsinoe kernel: USB Universal Host Controller Interface driver v2.2
Apr 23 20:38:47 arsinoe kernel: drivers/usb/core/usb.c: registered new driver hid
Apr 23 20:38:47 arsinoe kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Apr 23 20:38:47 arsinoe kernel: mice: PS/2 mouse device common for all mice
Apr 23 20:38:47 arsinoe kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Apr 23 20:38:47 arsinoe kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Apr 23 20:38:47 arsinoe kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr 23 20:38:47 arsinoe kernel: md: raid5 personality registered as nr 4
Apr 23 20:38:47 arsinoe kernel: raid5: measuring checksumming speed
Apr 23 20:38:47 arsinoe kernel:    8regs     :  2072.000 MB/sec
Apr 23 20:38:47 arsinoe kernel:    8regs_prefetch:  2120.000 MB/sec
Apr 23 20:38:47 arsinoe kernel:    32regs    :  1584.000 MB/sec
Apr 23 20:38:47 arsinoe kernel:    32regs_prefetch:  1492.000 MB/sec
Apr 23 20:38:47 arsinoe kernel:    pIII_sse  :  4212.000 MB/sec
Apr 23 20:38:47 arsinoe kernel:    pII_mmx   :  4152.000 MB/sec
Apr 23 20:38:47 arsinoe kernel:    p5_mmx    :  5568.000 MB/sec
Apr 23 20:38:47 arsinoe kernel: raid5: using function: pIII_sse (4212.000 MB/sec)
Apr 23 20:38:47 arsinoe kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Apr 23 20:38:47 arsinoe kernel: NET: Registered protocol family 2
Apr 23 20:38:47 arsinoe kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Apr 23 20:38:47 arsinoe kernel: TCP: Hash tables configured (established 32768 bind 65536)
Apr 23 20:38:47 arsinoe kernel: ip_conntrack version 2.1 (4095 buckets, 32760 max) - 296 bytes per conntrack
Apr 23 20:38:47 arsinoe kernel: ip_tables: (C) 2000-2002 Netfilter core team
Apr 23 20:38:47 arsinoe kernel: NET: Registered protocol family 1
Apr 23 20:38:47 arsinoe kernel: NET: Registered protocol family 17
Apr 23 20:38:47 arsinoe kernel: NET: Registered protocol family 5
Apr 23 20:38:47 arsinoe kernel: BIOS EDD facility v0.12 2004-Jan-26, 5 devices found
Apr 23 20:38:47 arsinoe kernel: Please report your BIOS at http://linux.dell.com/edd/results.html
Apr 23 20:38:47 arsinoe kernel: md: Autodetecting RAID arrays.
Apr 23 20:38:47 arsinoe kernel: md: autorun ...
Apr 23 20:38:47 arsinoe kernel: md: considering hdk1 ...
Apr 23 20:38:47 arsinoe kernel: md:  adding hdk1 ...
Apr 23 20:38:47 arsinoe kernel: md:  adding hdi1 ...
Apr 23 20:38:47 arsinoe kernel: md:  adding hdg1 ...
Apr 23 20:38:47 arsinoe kernel: md:  adding hde1 ...
Apr 23 20:38:47 arsinoe kernel: md: created md0
Apr 23 20:38:47 arsinoe kernel: md: bind<hde1>
Apr 23 20:38:47 arsinoe kernel: md: bind<hdg1>
Apr 23 20:38:47 arsinoe kernel: md: bind<hdi1>
Apr 23 20:38:47 arsinoe kernel: md: bind<hdk1>
Apr 23 20:38:47 arsinoe kernel: md: running: <hdk1><hdi1><hdg1><hde1>
Apr 23 20:38:47 arsinoe kernel: md: bind<hdk1>
Apr 23 20:38:47 arsinoe kernel: md: running: <hdk1><hdi1><hdg1><hde1>
Apr 23 20:38:47 arsinoe kernel: raid5: device hdk1 operational as raid disk 3
Apr 23 20:38:47 arsinoe kernel: raid5: device hdi1 operational as raid disk 2
Apr 23 20:38:47 arsinoe kernel: raid5: device hdg1 operational as raid disk 1
Apr 23 20:38:47 arsinoe kernel: raid5: device hde1 operational as raid disk 0
Apr 23 20:38:47 arsinoe kernel: raid5: allocated 4184kB for md0
Apr 23 20:38:47 arsinoe kernel: raid5: raid level 5 set md0 active with 4 out of 4 devices, algorithm 0
Apr 23 20:38:47 arsinoe kernel: RAID5 conf printout:
Apr 23 20:38:47 arsinoe kernel:  --- rd:4 wd:4 fd:0
Apr 23 20:38:47 arsinoe kernel:  disk 0, o:1, dev:hde1
Apr 23 20:38:47 arsinoe kernel:  disk 1, o:1, dev:hdg1
Apr 23 20:38:47 arsinoe kernel:  disk 2, o:1, dev:hdi1
Apr 23 20:38:47 arsinoe kernel:  disk 3, o:1, dev:hdk1
Apr 23 20:38:47 arsinoe kernel: md: ... autorun DONE.
Apr 23 20:38:47 arsinoe kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Apr 23 20:38:47 arsinoe kernel: EXT3-fs: write access will be enabled during recovery.
Apr 23 20:38:47 arsinoe kernel: kjournald starting.  Commit interval 5 seconds
Apr 23 20:38:47 arsinoe kernel: EXT3-fs: recovery complete.
Apr 23 20:38:47 arsinoe kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 23 20:38:47 arsinoe kernel: VFS: Mounted root (ext3 filesystem) readonly.
Apr 23 20:38:47 arsinoe kernel: Freeing unused kernel memory: 356k freed
Apr 23 20:38:47 arsinoe kernel: blk: queue dfd8b600, I/O limit 4095Mb (mask 0xffffffff)
Apr 23 20:38:47 arsinoe kernel: blk: queue dfd80e00, I/O limit 4095Mb (mask 0xffffffff)
Apr 23 20:38:47 arsinoe kernel: blk: queue dfd80600, I/O limit 4095Mb (mask 0xffffffff)
Apr 23 20:38:47 arsinoe kernel: blk: queue dfd73e00, I/O limit 4095Mb (mask 0xffffffff)
Apr 23 20:38:47 arsinoe kernel: Adding 497972k swap on /dev/sda5.  Priority:-1 extents:1
Apr 23 20:38:47 arsinoe kernel: EXT3 FS on sda1, internal journal
Apr 23 20:38:47 arsinoe kernel: st0: Mode 0 options: buffer writes: 1, async writes: 1, read ahead: 1
Apr 23 20:38:47 arsinoe kernel: st0:    can bsr: 1, two FMs: 0, fast mteom: 0, auto lock: 1,
Apr 23 20:38:47 arsinoe kernel: st0:    defs for wr: 0, no block limits: 0, partitions: 1, s2 log: 1
Apr 23 20:38:47 arsinoe kernel: st0:    sysv: 0 nowait: 0
Apr 23 20:38:47 arsinoe kernel: st0: Default block size set to 64 bytes.
Apr 23 20:38:47 arsinoe kernel: st0: Compression default set to 1
Apr 23 20:38:47 arsinoe kernel: st0: Mode 1 options: buffer writes: 1, async writes: 1, read ahead: 1
Apr 23 20:38:47 arsinoe kernel: st0:    can bsr: 1, two FMs: 0, fast mteom: 0, auto lock: 1,
Apr 23 20:38:47 arsinoe kernel: st0:    defs for wr: 0, no block limits: 0, partitions: 1, s2 log: 1
Apr 23 20:38:47 arsinoe kernel: st0:    sysv: 0 nowait: 0
Apr 23 20:38:47 arsinoe kernel: st0: Default block size set to 10240 bytes.
Apr 23 20:38:47 arsinoe kernel: st0: Compression default set to 1
Apr 23 20:38:47 arsinoe kernel: st0: Mode 2 options: buffer writes: 1, async writes: 1, read ahead: 1
Apr 23 20:38:47 arsinoe kernel: st0:    can bsr: 1, two FMs: 0, fast mteom: 0, auto lock: 1,
Apr 23 20:38:47 arsinoe kernel: st0: Mode 2 options: buffer writes: 1, async writes: 1, read ahead: 1
Apr 23 20:38:47 arsinoe kernel: st0:    can bsr: 1, two FMs: 0, fast mteom: 0, auto lock: 1,
Apr 23 20:38:47 arsinoe kernel: st0:    defs for wr: 0, no block limits: 0, partitions: 1, s2 log: 1
Apr 23 20:38:47 arsinoe kernel: st0:    sysv: 0 nowait: 0
Apr 23 20:38:47 arsinoe kernel: st0: Default block size set to 64 bytes.
Apr 23 20:38:47 arsinoe kernel: st0: Compression default set to 0
Apr 23 20:38:47 arsinoe kernel: st0: Mode 3 options: buffer writes: 1, async writes: 1, read ahead: 1
Apr 23 20:38:47 arsinoe kernel: st0:    can bsr: 1, two FMs: 0, fast mteom: 0, auto lock: 1,
Apr 23 20:38:47 arsinoe kernel: st0:    defs for wr: 0, no block limits: 0, partitions: 1, s2 log: 1
Apr 23 20:38:47 arsinoe kernel: st0:    sysv: 0 nowait: 0
Apr 23 20:38:47 arsinoe kernel: st0: Default block size set to 10240 bytes.
Apr 23 20:38:47 arsinoe kernel: st0: Compression default set to 0
Apr 23 20:38:47 arsinoe kernel: kjournald starting.  Commit interval 5 seconds
Apr 23 20:38:47 arsinoe kernel: EXT3 FS on sda6, internal journal
Apr 23 20:38:47 arsinoe kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 23 20:38:47 arsinoe kernel: kjournald starting.  Commit interval 5 seconds
Apr 23 20:38:47 arsinoe kernel: EXT3 FS on sda7, internal journal
Apr 23 20:38:47 arsinoe kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 23 20:38:47 arsinoe kernel: XFS mounting filesystem md0
Apr 23 20:38:47 arsinoe kernel: Starting XFS recovery on filesystem: md0 (dev: md0)
Apr 23 20:38:47 arsinoe kernel: Ending XFS recovery on filesystem: md0 (dev: md0)
Apr 23 20:38:47 arsinoe kernel: process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT

	I tried again to access files on sda7:

Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 2553887680, count = 1
Apr 23 20:40:30 arsinoe kernel: Aborting journal on device sda7.
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 33554432, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 4197450496, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 762804087, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1635017060, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1668572463, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1869767471, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 795094638, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1735684717, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1852796160, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1819242356, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks in system zones - Block = 115, count = 1
Apr 23 20:40:30 arsinoe kernel: ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>EXT3-fs error (device sda7) in ext3_free_blocks: Journal has aborted
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1075532092, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 3221216840, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 3221217228, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1073763689, count = 1
Apr 23 20:40:30 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1075535872, count = 1
[...]

	I forced to fsck all the ext3 drives (/dev/sda{1,6,7}) and installed 2.6.6-rc2.
It fsck'ed one of the partitions, then wanted to reboot, then fsck'ed the three
partitions, and it finished. I used e2fsprogs 1.35-WIP (07-Dec-2003).

	A tune2fs from the affected partition:

arsinoe:/usr/src/dev# tune2fs -l /dev/sda7
tune2fs 1.35-WIP (07-Dec-2003)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          6b9d38e7-7487-444b-b8e4-68404673964f
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Default mount options:    (none)
Filesystem state:         clean with errors
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              306432
Block count:              612470
Reserved block count:     30623
Free blocks:              319333
Free inodes:              230893
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16128
Inode blocks per group:   504
Filesystem created:       Mon Jan 12 16:15:58 2004
Last mount time:          Thu Apr 29 12:13:27 2004
Last write time:          Thu Apr 29 12:21:24 2004
Mount count:              32
Maximum mount count:      39
Last checked:             Mon Jan 12 16:15:58 2004
Check interval:           15552000 (6 months)
Next check after:         Sat Jul 10 17:15:58 2004
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal inode:            8
First orphan inode:       263379
Default directory hash:   tea
Directory Hash Seed:      52a67fcd-9ee1-40ac-9cf4-469c34980721
Journal backup:           inode blocks

	Most of the needed information can be extracted from the dmesg, but anyway:

AMD Athlon(tm) XP 1800+
SCSI disk (system) ext3
4xIDE 80 GB RAID5 + XFS

	What can I do for fixing this issue?

	Regards,


		Ender.
- -- 
So much to do, so little time...
		-- Joker (Batman).
- --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Red.es - Madrid (Spain)
Tlf (+34) 91.212.76.25
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAkPHyWs/EhA1iABsRAt2YAKCsZnNgx4c3XgjkKlciKAAY0M9aJACfa5Yc
UqBz/ulmck9xYj8UTSuLRD8=
=GAYB
-----END PGP SIGNATURE-----
