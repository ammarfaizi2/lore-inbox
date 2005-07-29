Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVG2QUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVG2QUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVG2QUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:20:14 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:47312 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S262639AbVG2QUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:20:08 -0400
Date: Fri, 29 Jul 2005 18:20:06 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc4: no hyperthreading and idr_remove() stack traces
Message-ID: <20050729162006.GA18866@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.13-rc4 does not recognize the second CPU of a 3GHz HT P4:

/proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 1
cpu MHz         : 2993.277
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx pni monitor ds_cpl cid xtpr
bogomips        : 5995.71
(no second CPU, but "ht" flag is present)

/var/log/messages:
Jul 29 17:54:56 kotka syslogd 1.4.1#17: restart.
klogd 1.4.1#17, log source = /proc/kmsg started.
Inspecting /boot/System.map-2.6.13-rc4-y117
Loaded 37375 symbols from /boot/System.map-2.6.13-rc4-y117.
Symbols match kernel version 2.6.13.
No module symbols loaded - kernel modules not enabled. 
Linux version 2.6.13-rc4-y117 (fvm@espoo) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP Fri Jul 29 17:45:54 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fe86c00 (usable)
 BIOS-e820: 000000003fe86c00 - 000000003fe88c00 (ACPI NVS)
 BIOS-e820: 000000003fe88c00 - 000000003fe8ac00 (ACPI data)
 BIOS-e820: 000000003fe8ac00 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: Opti GX280   APIC at: 0xFEE00000
Processor #0 15:4 APIC version 20
I/O APIC #8 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 40000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.13-rc4-y117 ro root=802 nomodules
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2993.277 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1030340k/1047064k available (3395k kernel code, 15952k reserved, 1710k data, 240k init, 129560k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5995.71 BogoMIPS (lpj=11991422)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Total of 1 processors activated (5995.71 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb258, last bus=4
PCI: Using configuration type 1
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2640] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 22
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:1d.3[D] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:1d.7[A] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:1e.2[A] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1f.2[C] -> IRQ 20
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 16
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: dfd00000-dfefffff
  PREFETCH window: d0000000-d7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: dfc00000-dfcfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: dfb00000-dfbfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: No IRQ known for interrupt pin A of device 0000:00:01.0. Probably buggy MP table.
PCI: No IRQ known for interrupt pin A of device 0000:00:1c.0. Probably buggy MP table.
PCI: No IRQ known for interrupt pin B of device 0000:00:1c.1. Probably buggy MP table.
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: No IRQ known for interrupt pin A of device 0000:00:01.0. Probably buggy MP table.
pcie_portdrv_probe->Dev[2581:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
PCI: No IRQ known for interrupt pin A of device 0000:00:1c.0. Probably buggy MP table.
pcie_portdrv_probe->Dev[2660:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
PCI: No IRQ known for interrupt pin B of device 0000:00:1c.1. Probably buggy MP table.
pcie_portdrv_probe->Dev[2662:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random hardware driver 1.0.0 loaded
ppdev: user-space parallel port driver
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915G Chipset.
agpgart: AGP aperture is 256M @ 0x0
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
idr_remove called for id=34 which is not allocated.
 [dump_stack+23/32] dump_stack+0x17/0x20
 [idr_remove_warning+22/32] idr_remove_warning+0x16/0x20
 [sub_remove+252/256] sub_remove+0xfc/0x100
 [idr_remove+31/144] idr_remove+0x1f/0x90
 [release_inode_number+40/64] release_inode_number+0x28/0x40
 [free_proc_entry+29/80] free_proc_entry+0x1d/0x50
 [remove_proc_entry+160/288] remove_proc_entry+0xa0/0x120
 [unregister_proc_table+120/128] unregister_proc_table+0x78/0x80
 [unregister_proc_table+87/128] unregister_proc_table+0x57/0x80
Jul 29 17:54:56 kotka last message repeated 3 times
 [unregister_sysctl_table+49/64] unregister_sysctl_table+0x31/0x40
 [parport_device_proc_unregister+38/48] parport_device_proc_unregister+0x26/0x30
 [parport_unregister_device+15/304] parport_unregister_device+0xf/0x130
 [parport_close+12/16] parport_close+0xc/0x10
 [parport_device_id+107/384] parport_device_id+0x6b/0x180
 [parport_daisy_init+136/480] parport_daisy_init+0x88/0x1e0
 [parport_announce_port+14/208] parport_announce_port+0xe/0xd0
 [parport_pc_probe_port+1107/1680] parport_pc_probe_port+0x453/0x690
 [parport_pc_find_isa_ports+64/112] parport_pc_find_isa_ports+0x40/0x70
 [parport_pc_find_nonpci_ports+16/32] parport_pc_find_nonpci_ports+0x10/0x20
 [parport_pc_find_ports+30/80] parport_pc_find_ports+0x1e/0x50
 [parport_pc_init+149/160] parport_pc_init+0x95/0xa0
 [do_initcalls+43/176] do_initcalls+0x2b/0xb0
 [do_basic_setup+33/48] do_basic_setup+0x21/0x30
 [init+172/368] init+0xac/0x170
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
idr_remove called for id=34 which is not allocated.
 [dump_stack+23/32] dump_stack+0x17/0x20
 [idr_remove_warning+22/32] idr_remove_warning+0x16/0x20
 [sub_remove+252/256] sub_remove+0xfc/0x100
 [idr_remove+31/144] idr_remove+0x1f/0x90
 [release_inode_number+40/64] release_inode_number+0x28/0x40
 [free_proc_entry+29/80] free_proc_entry+0x1d/0x50
 [remove_proc_entry+160/288] remove_proc_entry+0xa0/0x120
 [unregister_proc_table+120/128] unregister_proc_table+0x78/0x80
 [unregister_proc_table+87/128] unregister_proc_table+0x57/0x80
Jul 29 17:54:56 kotka last message repeated 2 times
 [unregister_sysctl_table+49/64] unregister_sysctl_table+0x31/0x40
 [parport_device_proc_unregister+38/48] parport_device_proc_unregister+0x26/0x30
 [parport_unregister_device+15/304] parport_unregister_device+0xf/0x130
 [parport_close+12/16] parport_close+0xc/0x10
 [parport_device_id+107/384] parport_device_id+0x6b/0x180
 [parport_daisy_init+136/480] parport_daisy_init+0x88/0x1e0
 [parport_announce_port+14/208] parport_announce_port+0xe/0xd0
 [parport_pc_probe_port+1107/1680] parport_pc_probe_port+0x453/0x690
 [parport_pc_find_isa_ports+64/112] parport_pc_find_isa_ports+0x40/0x70
 [parport_pc_find_nonpci_ports+16/32] parport_pc_find_nonpci_ports+0x10/0x20
 [parport_pc_find_ports+30/80] parport_pc_find_ports+0x1e/0x50
 [parport_pc_init+149/160] parport_pc_init+0x95/0xa0
 [do_initcalls+43/176] do_initcalls+0x2b/0xb0
 [do_basic_setup+33/48] do_basic_setup+0x21/0x30
 [init+172/368] init+0xac/0x170
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
idr_remove called for id=34 which is not allocated.
 [dump_stack+23/32] dump_stack+0x17/0x20
 [idr_remove_warning+22/32] idr_remove_warning+0x16/0x20
 [sub_remove+252/256] sub_remove+0xfc/0x100
 [idr_remove+31/144] idr_remove+0x1f/0x90
 [release_inode_number+40/64] release_inode_number+0x28/0x40
 [free_proc_entry+29/80] free_proc_entry+0x1d/0x50
 [remove_proc_entry+160/288] remove_proc_entry+0xa0/0x120
 [unregister_proc_table+120/128] unregister_proc_table+0x78/0x80
 [unregister_proc_table+87/128] unregister_proc_table+0x57/0x80
 [unregister_proc_table+87/128] unregister_proc_table+0x57/0x80
 [unregister_sysctl_table+49/64] unregister_sysctl_table+0x31/0x40
 [parport_device_proc_unregister+38/48] parport_device_proc_unregister+0x26/0x30
 [parport_unregister_device+15/304] parport_unregister_device+0xf/0x130
 [parport_close+12/16] parport_close+0xc/0x10
 [parport_device_id+107/384] parport_device_id+0x6b/0x180
 [parport_daisy_init+136/480] parport_daisy_init+0x88/0x1e0
 [parport_announce_port+14/208] parport_announce_port+0xe/0xd0
 [parport_pc_probe_port+1107/1680] parport_pc_probe_port+0x453/0x690
 [parport_pc_find_isa_ports+64/112] parport_pc_find_isa_ports+0x40/0x70
 [parport_pc_find_nonpci_ports+16/32] parport_pc_find_nonpci_ports+0x10/0x20
 [parport_pc_find_ports+30/80] parport_pc_find_ports+0x1e/0x50
 [parport_pc_init+149/160] parport_pc_init+0x95/0xa0
 [do_initcalls+43/176] do_initcalls+0x2b/0xb0
 [do_basic_setup+33/48] do_basic_setup+0x21/0x30
 [init+172/368] init+0xac/0x170
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
idr_remove called for id=34 which is not allocated.
 [dump_stack+23/32] dump_stack+0x17/0x20
 [idr_remove_warning+22/32] idr_remove_warning+0x16/0x20
 [sub_remove+252/256] sub_remove+0xfc/0x100
 [idr_remove+31/144] idr_remove+0x1f/0x90
 [release_inode_number+40/64] release_inode_number+0x28/0x40
 [free_proc_entry+29/80] free_proc_entry+0x1d/0x50
 [remove_proc_entry+160/288] remove_proc_entry+0xa0/0x120
 [unregister_proc_table+120/128] unregister_proc_table+0x78/0x80
 [unregister_proc_table+87/128] unregister_proc_table+0x57/0x80
Jul 29 17:54:56 kotka last message repeated 3 times
 [unregister_sysctl_table+49/64] unregister_sysctl_table+0x31/0x40
 [parport_device_proc_unregister+38/48] parport_device_proc_unregister+0x26/0x30
 [parport_unregister_device+15/304] parport_unregister_device+0xf/0x130
 [parport_close+12/16] parport_close+0xc/0x10
 [parport_device_id+107/384] parport_device_id+0x6b/0x180
 [parport_daisy_init+136/480] parport_daisy_init+0x88/0x1e0
 [parport_announce_port+14/208] parport_announce_port+0xe/0xd0
 [parport_pc_probe_port+1107/1680] parport_pc_probe_port+0x453/0x690
 [parport_pc_find_isa_ports+64/112] parport_pc_find_isa_ports+0x40/0x70
 [parport_pc_find_nonpci_ports+16/32] parport_pc_find_nonpci_ports+0x10/0x20
 [parport_pc_find_ports+30/80] parport_pc_find_ports+0x1e/0x50
 [parport_pc_init+149/160] parport_pc_init+0x95/0xa0
 [do_initcalls+43/176] do_initcalls+0x2b/0xb0
 [do_basic_setup+33/48] do_basic_setup+0x21/0x30
 [init+172/368] init+0xac/0x170
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
idr_remove called for id=34 which is not allocated.
 [dump_stack+23/32] dump_stack+0x17/0x20
 [idr_remove_warning+22/32] idr_remove_warning+0x16/0x20
 [sub_remove+252/256] sub_remove+0xfc/0x100
 [idr_remove+31/144] idr_remove+0x1f/0x90
 [release_inode_number+40/64] release_inode_number+0x28/0x40
 [free_proc_entry+29/80] free_proc_entry+0x1d/0x50
 [remove_proc_entry+160/288] remove_proc_entry+0xa0/0x120
 [unregister_proc_table+120/128] unregister_proc_table+0x78/0x80
 [unregister_proc_table+87/128] unregister_proc_table+0x57/0x80
Jul 29 17:54:56 kotka last message repeated 2 times
 [unregister_sysctl_table+49/64] unregister_sysctl_table+0x31/0x40
 [parport_device_proc_unregister+38/48] parport_device_proc_unregister+0x26/0x30
 [parport_unregister_device+15/304] parport_unregister_device+0xf/0x130
 [parport_close+12/16] parport_close+0xc/0x10
 [parport_device_id+107/384] parport_device_id+0x6b/0x180
 [parport_daisy_init+136/480] parport_daisy_init+0x88/0x1e0
 [parport_announce_port+14/208] parport_announce_port+0xe/0xd0
 [parport_pc_probe_port+1107/1680] parport_pc_probe_port+0x453/0x690
 [parport_pc_find_isa_ports+64/112] parport_pc_find_isa_ports+0x40/0x70
 [parport_pc_find_nonpci_ports+16/32] parport_pc_find_nonpci_ports+0x10/0x20
 [parport_pc_find_ports+30/80] parport_pc_find_ports+0x1e/0x50
 [parport_pc_init+149/160] parport_pc_init+0x95/0xa0
 [do_initcalls+43/176] do_initcalls+0x2b/0xb0
 [do_basic_setup+33/48] do_basic_setup+0x21/0x30
 [init+172/368] init+0xac/0x170
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
idr_remove called for id=2 which is not allocated.
 [dump_stack+23/32] dump_stack+0x17/0x20
 [idr_remove_warning+22/32] idr_remove_warning+0x16/0x20
 [sub_remove+252/256] sub_remove+0xfc/0x100
 [idr_remove+31/144] idr_remove+0x1f/0x90
 [release_inode_number+40/64] release_inode_number+0x28/0x40
 [free_proc_entry+29/80] free_proc_entry+0x1d/0x50
 [remove_proc_entry+160/288] remove_proc_entry+0xa0/0x120
 [unregister_proc_table+120/128] unregister_proc_table+0x78/0x80
 [unregister_proc_table+87/128] unregister_proc_table+0x57/0x80
 [unregister_proc_table+87/128] unregister_proc_table+0x57/0x80
 [unregister_sysctl_table+49/64] unregister_sysctl_table+0x31/0x40
 [parport_device_proc_unregister+38/48] parport_device_proc_unregister+0x26/0x30
 [parport_unregister_device+15/304] parport_unregister_device+0xf/0x130
 [parport_close+12/16] parport_close+0xc/0x10
 [parport_device_id+107/384] parport_device_id+0x6b/0x180
 [parport_daisy_init+136/480] parport_daisy_init+0x88/0x1e0
 [parport_announce_port+14/208] parport_announce_port+0xe/0xd0
 [parport_pc_probe_port+1107/1680] parport_pc_probe_port+0x453/0x690
 [parport_pc_find_isa_ports+64/112] parport_pc_find_isa_ports+0x40/0x70
 [parport_pc_find_nonpci_ports+16/32] parport_pc_find_nonpci_ports+0x10/0x20
 [parport_pc_find_ports+30/80] parport_pc_find_ports+0x1e/0x50
 [parport_pc_init+149/160] parport_pc_init+0x95/0xa0
 [do_initcalls+43/176] do_initcalls+0x2b/0xb0
 [do_basic_setup+33/48] do_basic_setup+0x21/0x30
 [init+172/368] init+0xac/0x170
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
Copyright (c) 1999-2005 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
tg3.c:v3.34 (July 25, 2005)
eth0: Tigon3 [partno(BCM95751) rev 4001 PHY(5750)] (PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:12:3f:84:84:fe
eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000]
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ICH6: chipset revision 3
ICH6: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
hda: TSST CD-RW/DVD-ROM TSH492B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 20
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 20
ata1: dev 0 ATA, max UDMA/133, 156250000 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ATA: abnormal status 0xFF on port 0xFE27
ata2: disabling port
scsi1 : ata_piix
  Vendor: ATA       Model: ST380013AS        Rev: 8.12
  Type:   Direct-Access                      ANSI SCSI revision: 05
st: Version 20050501, fixed bufsize 32768, s/g segs 256
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4

config:
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13-rc4-y117
# Fri Jul 29 17:33:52 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
CONFIG_X86_PC=y
CONFIG_M586TSC=y
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=32
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y

#
# Firmware Drivers
#
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_SECCOMP=y
CONFIG_HZ_250=y
CONFIG_HZ=250
CONFIG_PHYSICAL_START=0x100000

#
# Power management options (ACPI, APM)
#

#
# CPU Frequency scaling
#

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_NAMES=y
CONFIG_ISA_DMA_API=y

#
# PCCARD (PCMCIA/CardBus) support
#

#
# PCI Hotplug Support
#

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_TUNNEL=y
CONFIG_IP_TCPDIAG=y
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_MATCH_ADDRTYPE=y
CONFIG_IP_NF_MATCH_REALM=y
CONFIG_IP_NF_MATCH_COMMENT=y
CONFIG_IP_NF_MATCH_CONNMARK=y
CONFIG_IP_NF_MATCH_HASHLIMIT=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_CONNMARK=y
CONFIG_IP_NF_RAW=y
CONFIG_IP_NF_TARGET_NOTRACK=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Memory Technology Devices (MTD)
#

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y

#
# SCSI low-level drivers
#
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_SCSI_SATA=y
CONFIG_SCSI_ATA_PIIX=y
CONFIG_SCSI_QLA2XXX=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MIRROR=y

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#

#
# I2O device support
#

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_TUN=y

#
# ARCnet devices
#

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y

#
# Tulip family network device support
#
CONFIG_NET_PCI=y
CONFIG_B44=y
CONFIG_E100=y
CONFIG_8139TOO=y

#
# Ethernet (1000 Mbit)
#
CONFIG_E1000=y
CONFIG_TIGON3=y

#
# Ethernet (10000 Mbit)
#

#
# Token Ring devices
#

#
# Wireless LAN (non-hamradio)
#

#
# Wan interfaces
#
CONFIG_PPP=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#

#
# Telephony Support
#

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
CONFIG_INPUT_EVDEV=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_LIBPS2=y

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PPDEV=y

#
# IPMI
#

#
# Watchdog Cards
#
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_NVIDIA=y
CONFIG_DRM=y
CONFIG_DRM_I810=y
CONFIG_HANGCHECK_TIMER=y

#
# TPM devices
#

#
# I2C support
#

#
# Dallas's 1-wire bus
#

#
# Hardware Monitoring support
#
CONFIG_HWMON=y

#
# Misc devices
#

#
# Multimedia devices
#

#
# Digital Video Broadcasting Devices
#

#
# Graphics support
#
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_RTCTIMER=y

#
# Generic devices
#

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_INTEL8X0=y

#
# USB devices
#

#
# Open Sound System
#

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
CONFIG_USB_PRINTER=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DPCM=y

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_WACOM=y

#
# USB Imaging devices
#

#
# USB Multimedia devices
#

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
CONFIG_USB_MON=y

#
# USB port drivers
#

#
# USB Serial Converter support
#

#
# USB Miscellaneous drivers
#

#
# USB DSL modem support
#

#
# USB Gadget Support
#

#
# MMC/SD Card support
#

#
# InfiniBand support
#

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
CONFIG_ROMFS_FS=y
CONFIG_INOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-15"

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
CONFIG_CRAMFS=y

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y

#
# Partition Types
#
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y

#
# Profiling support
#
CONFIG_PROFILING=y

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_FS=y
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_CRC32C=y

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y
-- 
Frank
