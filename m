Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUITSeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUITSeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 14:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUITSeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 14:34:16 -0400
Received: from wasp.net.au ([203.190.192.17]:31363 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S267184AbUITSck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 14:32:40 -0400
Message-ID: <414F225D.8090004@wasp.net.au>
Date: Mon, 20 Sep 2004 22:33:01 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc2 kswapd0: page allocation failure. order:2, mode:0x20
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,

Just checked my server to find a bucketload of these in the syslog. They would likely have been 
triggered by copying about 4GB with ftp across a 100BaseT ethernet connection to one of the RAID-5 
arrays.
It does not appear to be too serious as nothing has failed and there is no oops, but I figured 
better to report it. I have included pretty much everything I can think of that might be relevant.

This box ran 2.6.5 for months of heavy use and uptime with no glitches. It ran 2.6.9-rc1 for a 
couple of weeks until I tried to re-export an nfs share with knfsd and it went down in flames. This 
has been up for 2 days of light usage with 2.6.9-rc2 and I first saw these about 2 hours ago.

I know there is tonnes of stuff here, but I'd rather make sure I get everything that might help.

Regards,
Brad

(This dis contiguous syslog timing has me baffled but it's not the first time I have seen it happen!)

brad@srv:/usr/src/linux-2.6.9-rc1$ cat /var/log/syslog | grep "page allocation failure"
Sep 20 19:30:49 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 19:30:49 srv kernel: kswapd0: page allocation failure. order:2, mode:0x20
Sep 20 19:30:49 srv kernel: kswapd0: page allocation failure. order:2, mode:0x20
Sep 20 19:30:50 srv kernel: kswapd0: page allocation failure. order:2, mode:0x20
Sep 20 19:30:50 srv kernel: kswapd0: page allocation failure. order:2, mode:0x20
Sep 20 19:30:50 srv kernel: kswapd0: page allocation failure. order:2, mode:0x20
Sep 20 19:30:53 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 19:30:53 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 19:30:53 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 19:31:04 srv kernel: nfsd: page allocation failure. order:2, mode:0x20
Sep 20 19:31:04 srv kernel: nfsd: page allocation failure. order:2, mode:0x20
Sep 20 19:31:04 srv kernel: nfsd: page allocation failure. order:2, mode:0x20
Sep 20 20:43:13 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 20:43:13 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 20:43:13 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 20:43:15 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 20:43:15 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 20:43:15 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 20:43:15 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 20:43:15 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 20:43:15 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 19:31:43 srv kernel: swapper: page allocation failure. order:2, mode:0x20
Sep 20 19:31:49 srv kernel: swapper: page allocation failure. order:2, mode:0x20
Sep 20 19:32:14 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 19:32:14 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 19:32:14 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 19:32:15 srv kernel: nfsd: page allocation failure. order:2, mode:0x20
Sep 20 19:32:15 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 19:32:19 srv kernel: swapper: page allocation failure. order:2, mode:0x20
Sep 20 19:32:25 srv kernel: swapper: page allocation failure. order:2, mode:0x20

A couple of examples

Sep 20 19:30:49 srv kernel: kblockd/0: page allocation failure. order:2, mode:0x20
Sep 20 19:30:49 srv kernel:  [<c0138260>] __alloc_pages+0x1c0/0x350
Sep 20 19:30:49 srv kernel:  [<c013840f>] __get_free_pages+0x1f/0x40
Sep 20 19:30:49 srv kernel:  [<c013b4c7>] kmem_getpages+0x17/0xb0
Sep 20 19:30:49 srv kernel:  [<c013c0b9>] cache_grow+0xa9/0x150
Sep 20 19:30:49 srv kernel:  [<c013c2be>] cache_alloc_refill+0x15e/0x230
Sep 20 19:30:49 srv kernel:  [<c013c779>] __kmalloc+0x79/0xa0
Sep 20 19:30:49 srv kernel:  [<c02b1b52>] alloc_skb+0x32/0xd0
Sep 20 19:30:49 srv kernel:  [<e08ba616>] FillRxDescriptor+0x26/0xb0 [sk98lin]
Sep 20 19:30:49 srv kernel:  [<e08ba5d4>] FillRxRing+0x44/0x60 [sk98lin]
Sep 20 19:30:49 srv kernel:  [<e08b97d6>] SkGeIsrOnePort+0x146/0x160 [sk98lin]
Sep 20 19:30:49 srv kernel:  [<c010653b>] handle_IRQ_event+0x2b/0x60
Sep 20 19:30:49 srv kernel:  [<c01068a0>] do_IRQ+0x90/0x130
Sep 20 19:30:49 srv kernel:  [<c01049f4>] common_interrupt+0x18/0x20
Sep 20 19:30:49 srv kernel:  [<c026f371>] scsi_dispatch_cmd+0x181/0x240
Sep 20 19:30:49 srv kernel:  [<c0274938>] scsi_request_fn+0x1e8/0x3e0
Sep 20 19:30:49 srv kernel:  [<c024b672>] elv_next_request+0x42/0xf0
Sep 20 19:30:49 srv kernel:  [<c024d1ad>] __generic_unplug_device+0x2d/0x30
Sep 20 19:30:49 srv kernel:  [<c024d1c1>] generic_unplug_device+0x11/0x30
Sep 20 19:30:49 srv kernel:  [<c029ac68>] unplug_slaves+0xa8/0xc0
Sep 20 19:30:49 srv kernel:  [<c024d206>] blk_unplug_work+0x6/0x10
Sep 20 19:30:49 srv kernel:  [<c0128de9>] worker_thread+0x1a9/0x270
Sep 20 19:30:49 srv kernel:  [<c011646a>] activate_task+0x5a/0x70
Sep 20 19:30:49 srv kernel:  [<c024d200>] blk_unplug_work+0x0/0x10
Sep 20 19:30:49 srv kernel:  [<c0116db0>] default_wake_function+0x0/0x10
Sep 20 19:30:49 srv kernel:  [<c0116df7>] __wake_up_common+0x37/0x60
Sep 20 19:30:49 srv kernel:  [<c0116db0>] default_wake_function+0x0/0x10
Sep 20 19:30:49 srv kernel:  [<c0128c40>] worker_thread+0x0/0x270
Sep 20 19:30:49 srv kernel:  [<c012c904>] kthread+0x94/0xa0
Sep 20 19:30:49 srv kernel:  [<c012c870>] kthread+0x0/0xa0
Sep 20 19:30:49 srv kernel:  [<c010227d>] kernel_thread_helper+0x5/0x18
Sep 20 19:30:49 srv kernel: kswapd0: page allocation failure. order:2, mode:0x20
Sep 20 19:30:49 srv kernel:  [<c0138260>] __alloc_pages+0x1c0/0x350
Sep 20 19:30:49 srv kernel:  [<c013840f>] __get_free_pages+0x1f/0x40
Sep 20 19:30:49 srv kernel:  [<c013b4c7>] kmem_getpages+0x17/0xb0
Sep 20 19:30:49 srv kernel:  [<c013c0b9>] cache_grow+0xa9/0x150
Sep 20 19:30:49 srv kernel:  [<c0137e8a>] free_hot_cold_page+0xba/0x110
Sep 20 19:30:49 srv kernel:  [<c013c2be>] cache_alloc_refill+0x15e/0x230
Sep 20 19:30:49 srv kernel:  [<c013c779>] __kmalloc+0x79/0xa0
Sep 20 19:30:49 srv kernel:  [<c02b1b52>] alloc_skb+0x32/0xd0
Sep 20 19:30:49 srv kernel:  [<e08ba616>] FillRxDescriptor+0x26/0xb0 [sk98lin]
Sep 20 19:30:49 srv kernel:  [<e08ba5d4>] FillRxRing+0x44/0x60 [sk98lin]
Sep 20 19:30:49 srv kernel:  [<e08b97d6>] SkGeIsrOnePort+0x146/0x160 [sk98lin]
Sep 20 19:30:49 srv kernel:  [<c010653b>] handle_IRQ_event+0x2b/0x60
Sep 20 19:30:49 srv kernel:  [<c01068a0>] do_IRQ+0x90/0x130
Sep 20 19:30:49 srv kernel:  [<c01049f4>] common_interrupt+0x18/0x20
Sep 20 19:30:49 srv kernel:  [<c013e8a9>] shrink_cache+0x9/0x320
Sep 20 19:30:49 srv kernel:  [<c013e1c6>] shrink_slab+0x76/0x170
Sep 20 19:30:49 srv kernel:  [<c013f0f9>] shrink_zone+0x89/0xa0
Sep 20 19:30:49 srv kernel:  [<c013f484>] balance_pgdat+0x1b4/0x210
Sep 20 19:30:49 srv kernel:  [<c013f59e>] kswapd+0xbe/0xd0
Sep 20 19:30:49 srv kernel:  [<c0117fe0>] autoremove_wake_function+0x0/0x50
Sep 20 19:30:49 srv kernel:  [<c0103f5e>] ret_from_fork+0x6/0x14
Sep 20 19:30:49 srv kernel:  [<c0117fe0>] autoremove_wake_function+0x0/0x50
Sep 20 19:30:49 srv kernel:  [<c013f4e0>] kswapd+0x0/0xd0
Sep 20 19:30:49 srv kernel:  [<c010227d>] kernel_thread_helper+0x5/0x18

Here is the initial boot dmesg

Sep 18 20:31:48 srv kernel: Linux version 2.6.9-rc2 (brad@srv) (gcc version 3.3.4 (Debian 
1:3.3.4-6sarge1)) #5 Sat Sep 18 20:30:02 GST 2004
Sep 18 20:31:48 srv kernel: BIOS-provided physical RAM map:
Sep 18 20:31:48 srv kernel:  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
Sep 18 20:31:48 srv kernel:  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
Sep 18 20:31:48 srv kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Sep 18 20:31:48 srv kernel:  BIOS-e820: 0000000000100000 - 000000001fffb000 (usable)
Sep 18 20:31:48 srv kernel:  BIOS-e820: 000000001fffb000 - 000000001ffff000 (ACPI data)
Sep 18 20:31:48 srv kernel:  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
Sep 18 20:31:48 srv kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Sep 18 20:31:48 srv kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Sep 18 20:31:48 srv kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Sep 18 20:31:48 srv kernel: 511MB LOWMEM available.
Sep 18 20:31:48 srv kernel: On node 0 totalpages: 131067
Sep 18 20:31:48 srv kernel:   DMA zone: 4096 pages, LIFO batch:1
Sep 18 20:31:48 srv kernel:   Normal zone: 126971 pages, LIFO batch:16
Sep 18 20:31:48 srv kernel:   HighMem zone: 0 pages, LIFO batch:1
Sep 18 20:31:48 srv kernel: DMI 2.3 present.
Sep 18 20:31:48 srv kernel: ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5e30
Sep 18 20:31:48 srv kernel: ACPI: RSDT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffb000
Sep 18 20:31:48 srv kernel: ACPI: FADT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffb0b2
Sep 18 20:31:48 srv kernel: ACPI: BOOT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffb030
Sep 18 20:31:48 srv kernel: ACPI: MADT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffb058
Sep 18 20:31:48 srv kernel: ACPI: DSDT (v001   ASUS A7V600   0x00001000 MSFT 0x0100000b) @ 0x00000000
Sep 18 20:31:48 srv kernel: ACPI: Local APIC address 0xfee00000
Sep 18 20:31:48 srv kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Sep 18 20:31:49 srv kernel: Processor #0 6:10 APIC version 16
Sep 18 20:31:49 srv kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Sep 18 20:31:49 srv kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Sep 18 20:31:49 srv kernel: IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
Sep 18 20:31:49 srv kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
Sep 18 20:31:49 srv kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Sep 18 20:31:49 srv kernel: ACPI: IRQ0 used by override.
Sep 18 20:31:49 srv kernel: ACPI: IRQ2 used by override.
Sep 18 20:31:49 srv kernel: ACPI: IRQ9 used by override.
Sep 18 20:31:49 srv kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Sep 18 20:31:49 srv kernel: Using ACPI (MADT) for SMP configuration information
Sep 18 20:31:49 srv kernel: Built 1 zonelists
Sep 18 20:31:49 srv kernel: Kernel command line: vga=1 console=ttyS0,38400 console=tty0 root=/dev/hda1
Sep 18 20:31:49 srv kernel: Initializing CPU#0
Sep 18 20:31:49 srv kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Sep 18 20:31:49 srv kernel: Detected 1916.546 MHz processor.
Sep 18 20:31:49 srv kernel: Using tsc for high-res timesource
Sep 18 20:31:49 srv kernel: Console: colour VGA+ 80x50
Sep 18 20:31:49 srv kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Sep 18 20:31:49 srv kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Sep 18 20:31:49 srv kernel: Memory: 514932k/524268k available (2122k kernel code, 8784k reserved, 
1222k data, 152k init, 0k highmem)
Sep 18 20:31:49 srv kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Sep 18 20:31:49 srv kernel: Calibrating delay loop... 3776.51 BogoMIPS (lpj=1888256)
Sep 18 20:31:49 srv kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Sep 18 20:31:49 srv kernel: CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
Sep 18 20:31:49 srv kernel: CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
Sep 18 20:31:49 srv kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Sep 18 20:31:49 srv kernel: CPU: L2 Cache: 512K (64 bytes/line)
Sep 18 20:31:49 srv kernel: CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
Sep 18 20:31:49 srv kernel: Intel machine check architecture supported.
Sep 18 20:31:49 srv kernel: Intel machine check reporting enabled on CPU#0.
Sep 18 20:31:49 srv kernel: CPU: AMD Athlon(TM) XP 2600+ stepping 00
Sep 18 20:31:49 srv kernel: Enabling fast FPU save and restore... done.
Sep 18 20:31:49 srv kernel: Enabling unmasked SIMD FPU exception support... done.
Sep 18 20:31:49 srv kernel: Checking 'hlt' instruction... OK.
Sep 18 20:31:49 srv kernel: ENABLING IO-APIC IRQs
Sep 18 20:31:49 srv kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Sep 18 20:31:49 srv kernel: NET: Registered protocol family 16
Sep 18 20:31:49 srv kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=1
Sep 18 20:31:49 srv kernel: mtrr: v2.0 (20020519)
Sep 18 20:31:49 srv kernel: ACPI: Subsystem revision 20040715
Sep 18 20:31:49 srv kernel: ACPI: Interpreter enabled
Sep 18 20:31:49 srv kernel: ACPI: Using IOAPIC for interrupt routing
Sep 18 20:31:49 srv kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
Sep 18 20:31:49 srv kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12)
Sep 18 20:31:49 srv kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12)
Sep 18 20:31:49 srv kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *7 9 10 11 12)
Sep 18 20:31:49 srv kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 *6 7 9 10 11 12)
Sep 18 20:31:49 srv kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 *6 7 9 10 11 12)
Sep 18 20:31:49 srv kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12)
Sep 18 20:31:49 srv kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12) *15, disabled.
Sep 18 20:31:49 srv kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep 18 20:31:49 srv kernel: PCI: Probing PCI hardware (bus 00)
Sep 18 20:31:49 srv kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep 18 20:31:49 srv kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Sep 18 20:31:49 srv kernel: SCSI subsystem initialized
Sep 18 20:31:49 srv kernel: PCI: Using ACPI for IRQ routing
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 18 (level, low) -> IRQ 18
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 19 (level, low) -> IRQ 19
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 17
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 18
Sep 18 20:31:49 srv kernel: Simple Boot Flag at 0x3a set to 0x80
Sep 18 20:31:49 srv kernel: Machine check exception polling timer started.
Sep 18 20:31:49 srv kernel: devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
Sep 18 20:31:49 srv kernel: devfs: boot_options: 0x0
Sep 18 20:31:49 srv kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Sep 18 20:31:49 srv kernel: PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 5
Sep 18 20:31:49 srv kernel: PCI: Via IRQ fixup for 0000:00:10.1, from 0 to 5
Sep 18 20:31:49 srv kernel: PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 5
Sep 18 20:31:49 srv kernel: PCI: Via IRQ fixup for 0000:00:10.3, from 0 to 5
Sep 18 20:31:49 srv kernel: ACPI: Power Button (FF) [PWRF]
Sep 18 20:31:49 srv kernel: ACPI: Processor [CPU0] (supports C1)
Sep 18 20:31:49 srv kernel: Real Time Clock Driver v1.12
Sep 18 20:31:49 srv kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Sep 18 20:31:49 srv kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep 18 20:31:49 srv kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Sep 18 20:31:49 srv kernel: orinoco 0.13e (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin 
<proski@gnu.org>, et al)
Sep 18 20:31:49 srv kernel: orinoco_pci 0.13e (Pavel Roskin <proski@gnu.org>, David Gibson 
<hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
Sep 18 20:31:49 srv kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep 18 20:31:49 srv kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 18 20:31:49 srv kernel: VP_IDE: IDE controller at PCI slot 0000:00:0f.1
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
Sep 18 20:31:49 srv kernel: VP_IDE: chipset revision 6
Sep 18 20:31:49 srv kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep 18 20:31:49 srv kernel: VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
Sep 18 20:31:49 srv kernel:     ide0: BM-DMA at 0x6800-0x6807, BIOS settings: hda:DMA, hdb:pio
Sep 18 20:31:49 srv kernel: Probing IDE interface ide0...
Sep 18 20:31:49 srv kernel: hda: WDC WD2000JB-00FUA0, ATA DISK drive
Sep 18 20:31:49 srv kernel: Using anticipatory io scheduler
Sep 18 20:31:49 srv kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 18 20:31:49 srv kernel: hda: max request size: 1024KiB
Sep 18 20:31:49 srv kernel: hda: Host Protected Area detected.
Sep 18 20:31:49 srv kernel: ^Icurrent capacity is 390719855 sectors (200048 MB)
Sep 18 20:31:49 srv kernel: ^Inative  capacity is 390721968 sectors (200049 MB)
Sep 18 20:31:49 srv kernel: hda: 390719855 sectors (200048 MB) w/8192KiB Cache, CHS=24321/255/63, 
UDMA(100)
Sep 18 20:31:49 srv kernel: hda: cache flushes supported
Sep 18 20:31:49 srv kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Sep 18 20:31:49 srv kernel: libata version 1.02 loaded.
Sep 18 20:31:49 srv kernel: sata_promise version 1.00
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
Sep 18 20:31:49 srv kernel: ata1: SATA max UDMA/133 cmd 0xE0806200 ctl 0xE0806238 bmdma 0x0 irq 19
Sep 18 20:31:49 srv kernel: ata2: SATA max UDMA/133 cmd 0xE0806280 ctl 0xE08062B8 bmdma 0x0 irq 19
Sep 18 20:31:49 srv kernel: ata3: SATA max UDMA/133 cmd 0xE0806300 ctl 0xE0806338 bmdma 0x0 irq 19
Sep 18 20:31:49 srv kernel: ata4: SATA max UDMA/133 cmd 0xE0806380 ctl 0xE08063B8 bmdma 0x0 irq 19
Sep 18 20:31:49 srv kernel: ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
Sep 18 20:31:49 srv kernel: ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata1: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi0 : sata_promise
Sep 18 20:31:49 srv kernel: ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
Sep 18 20:31:49 srv kernel: ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata2: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi1 : sata_promise
Sep 18 20:31:49 srv kernel: ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
Sep 18 20:31:49 srv kernel: ata3: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata3: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi2 : sata_promise
Sep 18 20:31:49 srv kernel: ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
Sep 18 20:31:49 srv kernel: ata4: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata4: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi3 : sata_promise
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 17
Sep 18 20:31:49 srv kernel: ata5: SATA max UDMA/133 cmd 0xE080E200 ctl 0xE080E238 bmdma 0x0 irq 17
Sep 18 20:31:49 srv kernel: ata6: SATA max UDMA/133 cmd 0xE080E280 ctl 0xE080E2B8 bmdma 0x0 irq 17
Sep 18 20:31:49 srv kernel: ata7: SATA max UDMA/133 cmd 0xE080E300 ctl 0xE080E338 bmdma 0x0 irq 17
Sep 18 20:31:49 srv kernel: ata8: SATA max UDMA/133 cmd 0xE080E380 ctl 0xE080E3B8 bmdma 0x0 irq 17
Sep 18 20:31:49 srv kernel: ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
Sep 18 20:31:49 srv kernel: ata5: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata5: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi4 : sata_promise
Sep 18 20:31:49 srv kernel: ata6: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
Sep 18 20:31:49 srv kernel: ata6: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata6: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi5 : sata_promise
Sep 18 20:31:49 srv kernel: ata7: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
Sep 18 20:31:49 srv kernel: ata7: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata7: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi6 : sata_promise
Sep 18 20:31:49 srv kernel: ata8: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
Sep 18 20:31:49 srv kernel: ata8: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata8: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi7 : sata_promise
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 18
Sep 18 20:31:49 srv kernel: ata9: SATA max UDMA/133 cmd 0xE0810200 ctl 0xE0810238 bmdma 0x0 irq 18
Sep 18 20:31:49 srv kernel: ata10: SATA max UDMA/133 cmd 0xE0810280 ctl 0xE08102B8 bmdma 0x0 irq 18
Sep 18 20:31:49 srv kernel: ata11: SATA max UDMA/133 cmd 0xE0810300 ctl 0xE0810338 bmdma 0x0 irq 18
Sep 18 20:31:49 srv kernel: ata12: SATA max UDMA/133 cmd 0xE0810380 ctl 0xE08103B8 bmdma 0x0 irq 18
Sep 18 20:31:49 srv kernel: ata9: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
Sep 18 20:31:49 srv kernel: ata9: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata9: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi8 : sata_promise
Sep 18 20:31:49 srv kernel: ata10: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
Sep 18 20:31:49 srv kernel: ata10: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata10: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi9 : sata_promise
Sep 18 20:31:49 srv kernel: ata11: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:007f
Sep 18 20:31:49 srv kernel: ata11: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata11: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi10 : sata_promise
Sep 18 20:31:49 srv kernel: ata12: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:007f
Sep 18 20:31:49 srv kernel: ata12: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Sep 18 20:31:49 srv kernel: ata12: dev 0 configured for UDMA/133
Sep 18 20:31:49 srv kernel: scsi11 : sata_promise
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel: sata_via version 0.20
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
Sep 18 20:31:49 srv kernel: sata_via(0000:00:0f.0): routed to hard irq line 0
Sep 18 20:31:49 srv kernel: ata13: SATA max UDMA/133 cmd 0x8800 ctl 0x8402 bmdma 0x7400 irq 20
Sep 18 20:31:49 srv kernel: ata14: SATA max UDMA/133 cmd 0x8000 ctl 0x7802 bmdma 0x7408 irq 20
Sep 18 20:31:49 srv kernel: ata13: no device found (phy stat 00000000)
Sep 18 20:31:49 srv kernel: scsi12 : sata_via
Sep 18 20:31:49 srv kernel: ata14: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 
88:003f
Sep 18 20:31:49 srv kernel: ata14: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
Sep 18 20:31:49 srv kernel: ata14(0): applying bridge limits
Sep 18 20:31:49 srv kernel: ata14: dev 0 configured for UDMA/100
Sep 18 20:31:49 srv kernel: scsi13 : sata_via
Sep 18 20:31:49 srv kernel:   Vendor: ATA       Model: WDC WD2500BB-00D  Rev: 15.0
Sep 18 20:31:49 srv kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Sep 18 20:31:49 srv kernel: SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sda: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host0/bus0/target0/lun0: p1
Sep 18 20:31:49 srv kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdb: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host1/bus0/target0/lun0: p1
Sep 18 20:31:49 srv kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdc: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdc: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host2/bus0/target0/lun0: p1
Sep 18 20:31:49 srv kernel: Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdd: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host3/bus0/target0/lun0: p1
Sep 18 20:31:49 srv kernel: Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sde: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sde: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host4/bus0/target0/lun0: p1
Sep 18 20:31:49 srv kernel: Attached scsi disk sde at scsi4, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdf: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdf: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host5/bus0/target0/lun0: p1
Sep 18 20:31:49 srv kernel: Attached scsi disk sdf at scsi5, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdg: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdg: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host6/bus0/target0/lun0: p1
Sep 18 20:31:49 srv kernel: Attached scsi disk sdg at scsi6, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdh: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdh: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host7/bus0/target0/lun0: p1
Sep 18 20:31:49 srv kernel: Attached scsi disk sdh at scsi7, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdi: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdi: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host8/bus0/target0/lun0: p1
Sep 18 20:31:49 srv kernel: Attached scsi disk sdi at scsi8, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdj: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdj: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host9/bus0/target0/lun0: p1
Sep 18 20:31:49 srv kernel: Attached scsi disk sdj at scsi9, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdk: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdk: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host10/bus0/target0/lun0: unknown partition table
Sep 18 20:31:49 srv kernel: Attached scsi disk sdk at scsi10, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdl: 490234752 512-byte hdwr sectors (251000 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdl: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host11/bus0/target0/lun0: unknown partition table
Sep 18 20:31:49 srv kernel: Attached scsi disk sdl at scsi11, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: SCSI device sdm: 488397168 512-byte hdwr sectors (250059 MB)
Sep 18 20:31:49 srv kernel: SCSI device sdm: drive cache: write back
Sep 18 20:31:49 srv kernel:  /dev/scsi/host13/bus0/target0/lun0: unknown partition table
Sep 18 20:31:49 srv kernel: Attached scsi disk sdm at scsi13, channel 0, id 0, lun 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg4 at scsi4, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg5 at scsi5, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg6 at scsi6, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg7 at scsi7, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg8 at scsi8, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg9 at scsi9, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg10 at scsi10, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg11 at scsi11, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: Attached scsi generic sg12 at scsi13, channel 0, id 0, lun 0,  type 0
Sep 18 20:31:49 srv kernel: mice: PS/2 mouse device common for all mice
Sep 18 20:31:49 srv kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 18 20:31:49 srv kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 18 20:31:49 srv kernel: i2c /dev entries driver
Sep 18 20:31:49 srv kernel: md: raid0 personality registered as nr 2
Sep 18 20:31:49 srv kernel: md: raid5 personality registered as nr 4
Sep 18 20:31:49 srv kernel: raid5: automatically using best checksumming function: pIII_sse
Sep 18 20:31:49 srv kernel:    pIII_sse  :  2144.000 MB/sec
Sep 18 20:31:49 srv kernel: raid5: using function: pIII_sse (2144.000 MB/sec)
Sep 18 20:31:49 srv kernel: raid6: int32x1    769 MB/s
Sep 18 20:31:49 srv kernel: raid6: int32x2   1039 MB/s
Sep 18 20:31:49 srv kernel: raid6: int32x4    671 MB/s
Sep 18 20:31:49 srv kernel: raid6: int32x8    609 MB/s
Sep 18 20:31:49 srv kernel: raid6: mmxx1     1597 MB/s
Sep 18 20:31:49 srv kernel: raid6: mmxx2     2914 MB/s
Sep 18 20:31:49 srv kernel: raid6: sse1x1    1511 MB/s
Sep 18 20:31:49 srv kernel: raid6: sse1x2    2500 MB/s
Sep 18 20:31:49 srv kernel: raid6: using algorithm sse1x2 (2500 MB/s)
Sep 18 20:31:49 srv kernel: md: raid6 personality registered as nr 8
Sep 18 20:31:49 srv kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Sep 18 20:31:49 srv kernel: oprofile: using NMI interrupt.
Sep 18 20:31:49 srv kernel: NET: Registered protocol family 2
Sep 18 20:31:49 srv kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Sep 18 20:31:49 srv kernel: TCP: Hash tables configured (established 32768 bind 65536)
Sep 18 20:31:49 srv kernel: NET: Registered protocol family 1
Sep 18 20:31:49 srv kernel: NET: Registered protocol family 17
Sep 18 20:31:49 srv kernel: ACPI: (supports S0 S1 S4 S5)
Sep 18 20:31:49 srv kernel: ACPI wakeup devices:
Sep 18 20:31:49 srv kernel: PCI0 PCI1 USB0 USB1 USB2 USB3 SU20 MC97
Sep 18 20:31:49 srv kernel: md: Autodetecting RAID arrays.
Sep 18 20:31:49 srv kernel: md: autorun ...
Sep 18 20:31:49 srv kernel: md: ... autorun DONE.
Sep 18 20:31:49 srv kernel: kjournald starting.  Commit interval 5 seconds
Sep 18 20:31:49 srv kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 18 20:31:49 srv kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep 18 20:31:49 srv kernel: Freeing unused kernel memory: 152k freed
Sep 18 20:31:49 srv kernel: Adding 987988k swap on /dev/hda2.  Priority:-1 extents:1
Sep 18 20:31:49 srv kernel: EXT3 FS on hda1, internal journal
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 18 (level, low) -> IRQ 18
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 18 (level, low) -> IRQ 18
Sep 18 20:31:49 srv kernel: eth0: 3Com Gigabit LOM (3C940)
Sep 18 20:31:49 srv kernel:       PrefPort:A  RlmtMode:Check Link State
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
Sep 18 20:31:49 srv kernel: eth1: SMC EZ Card 1000 (SMC9452TX V.2)
Sep 18 20:31:49 srv kernel:       PrefPort:A  RlmtMode:Check Link State
Sep 18 20:31:49 srv kernel: ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 19 (level, low) -> IRQ 19
Sep 18 20:31:49 srv kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19] 
MMIO=[dd000000-dd0007ff]  Max Packet=[2048]
Sep 18 20:31:49 srv kernel: kjournald starting.  Commit interval 5 seconds
Sep 18 20:31:49 srv kernel: EXT3 FS on hda3, internal journal
Sep 18 20:31:49 srv kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 18 20:31:49 srv kernel: usbcore: registered new driver usbfs
Sep 18 20:31:49 srv kernel: usbcore: registered new driver hub
Sep 18 20:31:49 srv kernel: USB Universal Host Controller Interface driver v2.2
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.0: irq 21, io base 00006400
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.0: detected 2 ports
Sep 18 20:31:49 srv kernel: usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
Sep 18 20:31:49 srv kernel: usb usb1: default language 0x0409
Sep 18 20:31:49 srv kernel: usb usb1: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
Sep 18 20:31:49 srv kernel: usb usb1: Manufacturer: Linux 2.6.9-rc2 uhci_hcd
Sep 18 20:31:49 srv kernel: usb usb1: SerialNumber: 0000:00:10.0
Sep 18 20:31:49 srv kernel: usb usb1: hotplug
Sep 18 20:31:49 srv kernel: usb usb1: adding 1-0:1.0 (config #1, interface 0)
Sep 18 20:31:49 srv kernel: usb 1-0:1.0: hotplug
Sep 18 20:31:49 srv kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001206000000133f]
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: usb_probe_interface
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: usb_probe_interface - got id
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: USB hub found
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: 2 ports detected
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: standalone hub
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: no power switching (usb 1.0)
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: individual port over-current protection
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: power on to power good time: 2ms
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: local power source is good
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.1: irq 21, io base 00006000
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.1: detected 2 ports
Sep 18 20:31:49 srv kernel: usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
Sep 18 20:31:49 srv kernel: usb usb2: default language 0x0409
Sep 18 20:31:49 srv kernel: usb usb2: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
Sep 18 20:31:49 srv kernel: usb usb2: Manufacturer: Linux 2.6.9-rc2 uhci_hcd
Sep 18 20:31:49 srv kernel: usb usb2: SerialNumber: 0000:00:10.1
Sep 18 20:31:49 srv kernel: usb usb2: hotplug
Sep 18 20:31:49 srv kernel: usb usb2: adding 2-0:1.0 (config #1, interface 0)
Sep 18 20:31:49 srv kernel: usb 2-0:1.0: hotplug
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.0: port 1 portsc 018a
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: usb_probe_interface
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: usb_probe_interface - got id
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: USB hub found
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: 2 ports detected
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: standalone hub
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: no power switching (usb 1.0)
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: individual port over-current protection
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: power on to power good time: 2ms
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: local power source is good
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#3)
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.0: port 2 portsc 018a
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.2: irq 21, io base 00005800
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.2: detected 2 ports
Sep 18 20:31:49 srv kernel: usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
Sep 18 20:31:49 srv kernel: usb usb3: default language 0x0409
Sep 18 20:31:49 srv kernel: usb usb3: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#3)
Sep 18 20:31:49 srv kernel: hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
Sep 18 20:31:49 srv kernel: usb usb3: Manufacturer: Linux 2.6.9-rc2 uhci_hcd
Sep 18 20:31:49 srv kernel: usb usb3: SerialNumber: 0000:00:10.2
Sep 18 20:31:49 srv kernel: usb usb3: hotplug
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.1: port 1 portsc 008a
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
Sep 18 20:31:49 srv kernel: usb usb3: adding 3-0:1.0 (config #1, interface 0)
Sep 18 20:31:49 srv kernel: usb 3-0:1.0: hotplug
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: usb_probe_interface
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: usb_probe_interface - got id
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: USB hub found
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: 2 ports detected
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: standalone hub
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: no power switching (usb 1.0)
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: individual port over-current protection
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: power on to power good time: 2ms
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: local power source is good
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#4)
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.1: port 2 portsc 018a
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.3: irq 21, io base 00005400
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.3: detected 2 ports
Sep 18 20:31:49 srv kernel: hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
Sep 18 20:31:49 srv kernel: usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
Sep 18 20:31:49 srv kernel: usb usb4: default language 0x0409
Sep 18 20:31:49 srv kernel: usb usb4: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#4)
Sep 18 20:31:49 srv kernel: usb usb4: Manufacturer: Linux 2.6.9-rc2 uhci_hcd
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.2: port 1 portsc 018a
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
Sep 18 20:31:49 srv kernel: usb usb4: SerialNumber: 0000:00:10.3
Sep 18 20:31:49 srv kernel: usb usb4: hotplug
Sep 18 20:31:49 srv kernel: usb usb4: adding 4-0:1.0 (config #1, interface 0)
Sep 18 20:31:49 srv kernel: usb 4-0:1.0: hotplug
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: usb_probe_interface
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: usb_probe_interface - got id
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: USB hub found
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: 2 ports detected
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: standalone hub
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: no power switching (usb 1.0)
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: individual port over-current protection
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: power on to power good time: 2ms
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: local power source is good
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.2: port 2 portsc 008a
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
Sep 18 20:31:49 srv kernel: hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
Sep 18 20:31:49 srv kernel: ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
Sep 18 20:31:49 srv kernel: ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
Sep 18 20:31:49 srv kernel: ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
Sep 18 20:31:49 srv kernel: ehci_hcd 0000:00:10.4: reset hcs_params 0x4208 dbg=0 cc=4 pcc=2 ordered 
!ppc ports=8
Sep 18 20:31:49 srv kernel: ehci_hcd 0000:00:10.4: reset hcc_params 6872 thresh 7 uframes 256/512/1024
Sep 18 20:31:49 srv kernel: ehci_hcd 0000:00:10.4: capability 0001 at 68
Sep 18 20:31:49 srv kernel: ehci_hcd 0000:00:10.4: irq 21, pci mem e090a000
Sep 18 20:31:49 srv kernel: ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
Sep 18 20:31:49 srv kernel: ehci_hcd 0000:00:10.4: reset command 080002 (park)=0 ithresh=8 
period=1024 Reset HALT
Sep 18 20:31:49 srv kernel: ehci_hcd 0000:00:10.4: init command 010009 (park)=0 ithresh=1 period=256 RUN
Sep 18 20:31:49 srv kernel: ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.3: port 1 portsc 018a
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
Sep 18 20:31:49 srv kernel: ehci_hcd 0000:00:10.4: supports USB remote wakeup
Sep 18 20:31:49 srv kernel: usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
Sep 18 20:31:49 srv kernel: usb usb5: default language 0x0409
Sep 18 20:31:49 srv kernel: usb usb5: Product: VIA Technologies, Inc. USB 2.0
Sep 18 20:31:49 srv kernel: usb usb5: Manufacturer: Linux 2.6.9-rc2 ehci_hcd
Sep 18 20:31:49 srv kernel: usb usb5: SerialNumber: 0000:00:10.4
Sep 18 20:31:49 srv kernel: usb usb5: hotplug
Sep 18 20:31:49 srv kernel: usb usb5: adding 5-0:1.0 (config #1, interface 0)
Sep 18 20:31:49 srv kernel: usb 5-0:1.0: hotplug
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: usb_probe_interface
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: usb_probe_interface - got id
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: USB hub found
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: 8 ports detected
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: standalone hub
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: ganged power switching
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: individual port over-current protection
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: Single TT
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: TT requires at most 8 FS bit times
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: power on to power good time: 20ms
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: local power source is good
Sep 18 20:31:49 srv kernel: hub 5-0:1.0: enabling power on all ports
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.3: port 2 portsc 008a
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
Sep 18 20:31:49 srv kernel: hub 4-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.0: suspend_hc
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.1: suspend_hc
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.2: suspend_hc
Sep 18 20:31:49 srv kernel: eth1: network connection down
Sep 18 20:31:49 srv kernel: uhci_hcd 0000:00:10.3: suspend_hc
Sep 18 20:31:49 srv kernel: eth0: network connection up using port A
Sep 18 20:31:49 srv kernel:     speed:           100
Sep 18 20:31:49 srv kernel:     autonegotiation: yes
Sep 18 20:31:49 srv kernel:     duplex mode:     full
Sep 18 20:31:49 srv kernel:     flowctrl:        symmetric
Sep 18 20:31:49 srv kernel:     irq moderation:  disabled
Sep 18 20:31:49 srv kernel:     scatter-gather:  enabled
Sep 18 20:31:49 srv kernel: eth1: network connection up using port A
Sep 18 20:31:49 srv kernel:     speed:           1000
Sep 18 20:31:49 srv kernel:     autonegotiation: yes
Sep 18 20:31:49 srv kernel:     duplex mode:     full
Sep 18 20:31:49 srv kernel:     flowctrl:        symmetric
Sep 18 20:31:49 srv kernel:     role:            slave
Sep 18 20:31:49 srv kernel:     irq moderation:  disabled
Sep 18 20:31:49 srv kernel:     scatter-gather:  enabled
Sep 18 20:31:50 srv lpd[2017]: restarted
Sep 18 20:31:51 srv xfs-xtt: Warning: font renderer for ".TTF" already registered at priority 10
Sep 18 20:31:51 srv xfs-xtt: Warning: font renderer for ".TTC" already registered at priority 10
Sep 18 20:31:52 srv xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable)
Sep 18 20:31:52 srv xfs: ignoring font path element /usr/lib/X11/fonts/CID (unreadable)
Sep 18 20:31:52 srv xfs-xtt: ignoring font path element /var/lib/defoma/x-ttcidfont-conf.d/dirs/CID 
(unreadable)
Sep 18 20:31:52 srv rpc.statd[2086]: Version 1.0.6 Starting
Sep 18 20:31:52 srv rpc.statd[2086]: statd running as root. chown /var/lib/nfs/sm to choose 
different user
Sep 18 20:31:52 srv xfs-xtt: ignoring font path element /usr/lib/X11/fonts/cyrillic/:unscaled 
(unreadable)
Sep 18 20:31:52 srv ntpd[2089]: ntpd 4.2.0a@1:4.2.0a-11-r Tue Jul 27 04:55:54 CEST 2004 (1)
Sep 18 20:31:52 srv ntpd[2089]: precision = 1.000 usec
Sep 18 20:31:52 srv ntpd[2089]: Listening on interface wildcard, 0.0.0.0#123
Sep 18 20:31:52 srv ntpd[2089]: Listening on interface lo, 127.0.0.1#123
Sep 18 20:31:52 srv ntpd[2089]: Listening on interface eth0, 192.168.3.82#123
Sep 18 20:31:52 srv ntpd[2089]: Listening on interface eth1, 192.168.2.82#123
Sep 18 20:31:52 srv ntpd[2089]: kernel time sync status 0040
Sep 18 20:31:52 srv ntpd[2089]: frequency initialized -60.881 PPM from /var/lib/ntp/ntp.drift
Sep 18 20:31:52 srv /usr/sbin/cron[2109]: (CRON) INFO (pidfile fd = 3)
Sep 18 20:31:52 srv /usr/sbin/cron[2110]: (CRON) STARTUP (fork ok)
Sep 18 20:31:52 srv /usr/sbin/cron[2110]: (CRON) INFO (Running @reboot jobs)
Sep 18 20:31:52 srv kernel: md: md0 stopped.
Sep 18 20:31:53 srv kernel: md: bind<sdb1>
Sep 18 20:31:53 srv kernel: md: bind<sdc1>
Sep 18 20:31:53 srv kernel: md: bind<sdd1>
Sep 18 20:31:53 srv kernel: md: bind<sde1>
Sep 18 20:31:53 srv kernel: md: bind<sdf1>
Sep 18 20:31:53 srv kernel: md: bind<sdg1>
Sep 18 20:31:53 srv kernel: md: bind<sdh1>
Sep 18 20:31:53 srv kernel: md: bind<sdi1>
Sep 18 20:31:53 srv kernel: md: bind<sdj1>
Sep 18 20:31:53 srv kernel: md: bind<sda1>
Sep 18 20:31:53 srv kernel: raid5: device sda1 operational as raid disk 0
Sep 18 20:31:53 srv kernel: raid5: device sdj1 operational as raid disk 9
Sep 18 20:31:53 srv kernel: raid5: device sdi1 operational as raid disk 8
Sep 18 20:31:53 srv kernel: raid5: device sdh1 operational as raid disk 7
Sep 18 20:31:53 srv kernel: raid5: device sdg1 operational as raid disk 6
Sep 18 20:31:53 srv kernel: raid5: device sdf1 operational as raid disk 5
Sep 18 20:31:53 srv kernel: raid5: device sde1 operational as raid disk 4
Sep 18 20:31:53 srv kernel: raid5: device sdd1 operational as raid disk 3
Sep 18 20:31:53 srv kernel: raid5: device sdc1 operational as raid disk 2
Sep 18 20:31:53 srv kernel: raid5: device sdb1 operational as raid disk 1
Sep 18 20:31:53 srv kernel: raid5: allocated 10447kB for md0
Sep 18 20:31:53 srv kernel: raid5: raid level 5 set md0 active with 10 out of 10 devices, algorithm 0
Sep 18 20:31:53 srv kernel: RAID5 conf printout:
Sep 18 20:31:53 srv kernel:  --- rd:10 wd:10 fd:0
Sep 18 20:31:53 srv kernel:  disk 0, o:1, dev:sda1
Sep 18 20:31:53 srv kernel:  disk 1, o:1, dev:sdb1
Sep 18 20:31:53 srv kernel:  disk 2, o:1, dev:sdc1
Sep 18 20:31:53 srv kernel:  disk 3, o:1, dev:sdd1
Sep 18 20:31:53 srv kernel:  disk 4, o:1, dev:sde1
Sep 18 20:31:53 srv kernel:  disk 5, o:1, dev:sdf1
Sep 18 20:31:53 srv kernel:  disk 6, o:1, dev:sdg1
Sep 18 20:31:53 srv kernel:  disk 7, o:1, dev:sdh1
Sep 18 20:31:53 srv kernel:  disk 8, o:1, dev:sdi1
Sep 18 20:31:53 srv kernel:  disk 9, o:1, dev:sdj1
Sep 18 20:31:53 srv kernel: kjournald starting.  Commit interval 5 seconds
Sep 18 20:31:53 srv kernel: EXT3 FS on md0, internal journal
Sep 18 20:31:53 srv kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 18 20:31:53 srv kernel: md: md2 stopped.
Sep 18 20:31:53 srv kernel: md: bind<sdk>
Sep 18 20:31:53 srv kernel: md: bind<sdm>
Sep 18 20:31:53 srv kernel: md: bind<sdl>
Sep 18 20:31:53 srv kernel: raid5: device sdl operational as raid disk 0
Sep 18 20:31:53 srv kernel: raid5: device sdm operational as raid disk 2
Sep 18 20:31:53 srv kernel: raid5: device sdk operational as raid disk 1
Sep 18 20:31:53 srv kernel: raid5: allocated 3160kB for md2
Sep 18 20:31:53 srv kernel: raid5: raid level 5 set md2 active with 3 out of 3 devices, algorithm 2
Sep 18 20:31:53 srv kernel: RAID5 conf printout:
Sep 18 20:31:53 srv kernel:  --- rd:3 wd:3 fd:0
Sep 18 20:31:53 srv kernel:  disk 0, o:1, dev:sdl
Sep 18 20:31:53 srv kernel:  disk 1, o:1, dev:sdk
Sep 18 20:31:53 srv kernel:  disk 2, o:1, dev:sdm
Sep 18 20:31:53 srv kernel: kjournald starting.  Commit interval 5 seconds
Sep 18 20:31:53 srv kernel: EXT3 FS on md2, internal journal
Sep 18 20:31:53 srv kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 18 20:33:57 srv rpc.mountd: authenticated mount request from tv:764 for /raid (/raid)


brad@srv:/usr/src/linux-2.6.9-rc1$ cat .config | awk '{ if ($0 ~ "^CONFIG" ) print $0 }'
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_SHMEM=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_PROMISE=y
CONFIG_SCSI_SATA_VIA=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID5=y
CONFIG_MD_RAID6=y
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_BRIDGE=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_SK98LIN=m
CONFIG_TIGON3=m
CONFIG_NET_RADIO=y
CONFIG_HERMES=y
CONFIG_PCI_HERMES=y
CONFIG_NET_WIRELESS=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_HW_RANDOM=y
CONFIG_RTC=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ISA=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_IT87=m
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRC32=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

brad@srv:/usr/src/linux-2.6.9-rc1$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux srv 2.6.9-rc2 #5 Sat Sep 18 20:30:02 GST 2004 i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         ehci_hcd uhci_hcd usbcore it87 i2c_sensor i2c_isa ohci1394 ieee1394 sk98lin

brad@srv:/usr/src/linux-2.6.9-rc1$ cat /proc/mdstat
Personalities : [raid0] [raid5] [raid6]
md2 : active raid5 sdl[0] sdm[2] sdk[1]
       488396800 blocks level 5, 128k chunk, algorithm 2 [3/3] [UUU]

md0 : active raid5 sda1[0] sdj1[9] sdi1[8] sdh1[7] sdg1[6] sdf1[5] sde1[4] sdd1[3] sdc1[2] sdb1[1]
       2206003968 blocks level 5, 128k chunk, algorithm 0 [10/10] [UUUUUUUUUU]

unused devices: <none>

brad@srv:/usr/src/linux-2.6.9-rc1$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(TM) XP 2600+
stepping        : 0
cpu MHz         : 1916.546
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr 
sse syscall mmxext 3dnowext 3dnow
bogomips        : 3776.51

brad@srv:/usr/src/linux-2.6.9-rc1$ df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda1              19G   11G  6.6G  63% /
tmpfs                 252M     0  252M   0% /dev/shm
/dev/hda3             165G   22G  135G  14% /raid0
/dev/md2              459G  113G  347G  25% /raid2
/dev/md0              2.1T  2.1T   16G 100% /raid

srv:/usr/src/linux-2.6.9-rc1# cat /etc/fstab
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>               <dump>  <pass>
/dev/hda1       /               ext3    errors=remount-ro       0       1
/dev/hda2       none            swap    sw                      0       0
/dev/hda3       /raid0          ext3    defaults                0       1

proc            /proc           proc    defaults                0       0
none            /proc/bus/usb   usbdevfs defaults               0       0
none            /proc/fs/nfsd   nfsd    defaults                0       0
none            /dev/devfs      devfs   defaults                0       0
none            /sysfs          sysfs   defaults                0       0

/dev/fd0        /floppy         auto    user,noauto             0       0
/dev/sr0        /cdrom          iso9660 ro,user,noauto          0       0
/dev/md0        /raid           ext3    defaults,noauto         0       0
#/dev/md1       /raid0          ext3    defaults,noauto         0       0
/dev/md2        /raid2          ext3    defaults,noauto         0       0

gateway:/server /server         nfs     defaults,noauto,user    0       0

brad@srv:/usr/src/linux-2.6.9-rc1$ cat /proc/meminfo
MemTotal:       515244 kB
MemFree:          1844 kB
Buffers:          6588 kB
Cached:         466996 kB
SwapCached:       1516 kB
Active:         165616 kB
Inactive:       311372 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       515244 kB
LowFree:          1844 kB
SwapTotal:      987988 kB
SwapFree:       965972 kB
Dirty:              20 kB
Writeback:           0 kB
Mapped:           7808 kB
Slab:            19616 kB
Committed_AS:    40488 kB
PageTables:        688 kB
VmallocTotal:   516024 kB
VmallocUsed:      1504 kB
VmallocChunk:   514408 kB

brad@srv:/usr/src/linux-2.6.9-rc1$ cat /proc/modules
ehci_hcd 37636 0 - Live 0xe0989000
uhci_hcd 28684 0 - Live 0xe08fa000
usbcore 111460 4 ehci_hcd,uhci_hcd, Live 0xe0912000
it87 19176 0 - Live 0xe08ea000
i2c_sensor 3008 1 it87, Live 0xe088c000
i2c_isa 1728 0 - Live 0xe08e0000
ohci1394 30148 0 - Live 0xe08a7000
ieee1394 303860 1 ohci1394, Live 0xe093d000
sk98lin 155368 2 - Live 0xe08b9000

srv:/usr/src/linux-2.6.9-rc1# lspci -vvv
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
         Subsystem: Asustek Computer, Inc. A7V8X motherboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- 
<PERR-
         Latency: 0
         Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [80] AGP version 3.5
                 Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- 
Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- 
<PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: df000000-dfdfffff
         Prefetchable memory behind bridge: dff00000-f7ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (5750ns min, 7750ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at de800000 (32-bit, non-prefetchable) [size=16K]
         Region 1: I/O ports at b800 [size=256]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data

0000:00:0b.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 96 (1000ns min, 4500ns max), Cache Line Size: 0x90 (576 bytes)
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at b400 [size=64]
         Region 1: I/O ports at b000 [size=16]
         Region 2: I/O ports at a800 [size=128]
         Region 3: Memory at de000000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at dd800000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

srv:/usr/src/linux-2.6.9-rc1# lspci -vvv
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
         Subsystem: Asustek Computer, Inc. A7V8X motherboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- 
<PERR-
         Latency: 0
         Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [80] AGP version 3.5
                 Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- 
Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- 
<PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: df000000-dfdfffff
         Prefetchable memory behind bridge: dff00000-f7ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (5750ns min, 7750ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at de800000 (32-bit, non-prefetchable) [size=16K]
         Region 1: I/O ports at b800 [size=256]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data

0000:00:0b.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 96 (1000ns min, 4500ns max), Cache Line Size: 0x90 (576 bytes)
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at b400 [size=64]
         Region 1: I/O ports at b000 [size=16]
         Region 2: I/O ports at a800 [size=128]
         Region 3: Memory at de000000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at dd800000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32
         Interrupt: pin B routed to IRQ 20
         Region 0: I/O ports at 8800 [size=8]
         Region 1: I/O ports at 8400 [size=4]
         Region 2: I/O ports at 8000 [size=8]
         Region 3: I/O ports at 7800 [size=4]
         Region 4: I/O ports at 7400 [size=16]
         Region 5: I/O ports at 7000 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 20
         Region 4: I/O ports at 6800 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 21
         Region 4: I/O ports at 6400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 21
         Region 4: I/O ports at 6000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin B routed to IRQ 21
         Region 4: I/O ports at 5800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin B routed to IRQ 21
         Region 4: I/O ports at 5400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x10 (64 bytes)
         Interrupt: pin C routed to IRQ 21
         Region 0: Memory at db000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:13.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at 5000 [size=64]
         Region 1: I/O ports at 4800 [size=16]
         Region 2: I/O ports at 4400 [size=128]
         Region 3: Memory at da800000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at da000000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display 
Adapter (prog-if 00 [VGA])
         Subsystem: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 71 (750ns min, 4000ns max)
         BIST result: 00
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=256K]
         Region 2: I/O ports at d800 [size=128]
         Expansion ROM at dfff0000 [disabled] [size=64K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] AGP version 2.0
                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- 
Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

brad@srv:/usr/src/linux-2.6.9-rc1$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0290-0297 :
02f8-02ff : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
4400-447f : 0000:00:13.0
   4400-447f : sata_promise
4800-480f : 0000:00:13.0
   4800-480f : sata_promise
5000-503f : 0000:00:13.0
   5000-503f : sata_promise
5400-541f : 0000:00:10.3
   5400-541f : uhci_hcd
5800-581f : 0000:00:10.2
   5800-581f : uhci_hcd
6000-601f : 0000:00:10.1
   6000-601f : uhci_hcd
6400-641f : 0000:00:10.0
   6400-641f : uhci_hcd
6800-680f : 0000:00:0f.1
   6800-6807 : ide0
7000-70ff : 0000:00:0f.0
   7000-70ff : sata_via
7400-740f : 0000:00:0f.0
   7400-740f : sata_via
7800-7803 : 0000:00:0f.0
   7800-7803 : sata_via
8000-8007 : 0000:00:0f.0
   8000-8007 : sata_via
8400-8403 : 0000:00:0f.0
   8400-8403 : sata_via
8800-8807 : 0000:00:0f.0
   8800-8807 : sata_via
9000-907f : 0000:00:0e.0
   9000-907f : sata_promise
9400-940f : 0000:00:0e.0
   9400-940f : sata_promise
9800-983f : 0000:00:0e.0
   9800-983f : sata_promise
a000-a0ff : 0000:00:0d.0
   a000-a0ff : SysKonnect SK-98xx
a400-a47f : 0000:00:0c.0
a800-a87f : 0000:00:0b.0
   a800-a87f : sata_promise
b000-b00f : 0000:00:0b.0
   b000-b00f : sata_promise
b400-b43f : 0000:00:0b.0
   b400-b43f : sata_promise
b800-b8ff : 0000:00:09.0
   b800-b8ff : SysKonnect SK-98xx
d000-dfff : PCI Bus #01
   d800-d87f : 0000:01:00.0
e400-e47f : motherboard
   e400-e403 : PM1a_EVT_BLK
   e404-e405 : PM1a_CNT_BLK
   e408-e40b : PM_TMR
   e420-e423 : GPE0_BLK
e800-e81f : motherboard

brad@srv:/usr/src/linux-2.6.9-rc1$ cat /proc/interrupts
            CPU0
   0:  179346374    IO-APIC-edge  timer
   4:          7    IO-APIC-edge  serial
   8:          4    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  14:     519492    IO-APIC-edge  ide0
  16:   12438636   IO-APIC-level  SysKonnect SK-98xx
  17:     199106   IO-APIC-level  libata
  18:    5643137   IO-APIC-level  libata, SysKonnect SK-98xx
  19:     192822   IO-APIC-level  libata, ohci1394
  20:     202428   IO-APIC-level  libata
  21:          0   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd, uhci_hcd, ehci_hcd
NMI:          0
LOC:  179361446
ERR:          0
MIS:          0

brad@srv:/usr/src/linux-2.6.9-rc1$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi7 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi8 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi9 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi10 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi11 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi13 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD2500BB-00D Rev: 15.0
   Type:   Direct-Access                    ANSI SCSI revision: 05


srv:/usr/src/linux-2.6.9-rc1# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0E:A6:41:45:94
           inet addr:192.168.3.82  Bcast:192.168.3.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:2505313 errors:0 dropped:0 overruns:0 frame:0
           TX packets:1101990 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:3785329081 (3.5 GiB)  TX bytes:77296359 (73.7 MiB)
           Interrupt:18 Memory:de800000-0

eth1      Link encap:Ethernet  HWaddr 00:04:E2:8E:1E:AD
           inet addr:192.168.2.82  Bcast:192.168.2.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:9000  Metric:1
           RX packets:8101990 errors:298 dropped:298 overruns:0 frame:0
           TX packets:7859057 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:1202379255 (1.1 GiB)  TX bytes:2608264738 (2.4 GiB)
           Interrupt:16 Memory:dc800000-0

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:86 errors:0 dropped:0 overruns:0 frame:0
           TX packets:86 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:8120 (7.9 KiB)  TX bytes:8120 (7.9 KiB)
