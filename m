Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbTENEnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 00:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTENEnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 00:43:00 -0400
Received: from adsl-065-081-070-095.sip.gnv.bellsouth.net ([65.81.70.95]:43455
	"HELO medicaldictation.com") by vger.kernel.org with SMTP
	id S261272AbTENEmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 00:42:55 -0400
Date: Wed, 14 May 2003 00:56:07 -0400
From: Chuck Berg <chuck@encinc.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69 panic in ide_dma_intr on Via KT400
Message-ID: <20030514005607.A17701@timetrax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine with a Soyo Dragon motherboard (Via KT400 chipset) that
when booting 2.5.69 panics while detecting the ide drives. First I get
"hde: lost interrupt" and after a few more errors, a panic.

With 2.4(.20, .21-rc1 and -rc2-ac1) I have the same problem, but it takes
reading from drives on the HPT372 controller at the same time as heavy PCI
activity to crash the system - 2.5.69 crashes right away.  My post about 2.4
is at http://marc.theaimsgroup.com/?l=linux-kernel&m=105167850927613&w=2
(with lspci -vvv, /proc/cpuinfo, ioports, iomem, interrupts output).
Both appear to be on the same line of code in ide-dma.c, "struct request
*rq = HWGROUP(drive)->rq;" (HWGROUP(drive) is null)

bootup messages and ksymoops output:
Linux version 4.5.69up (root@trance) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #5 Mon May 12 12:13:24 EDT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 KT400                      ) @ 0x000f76d0
ACPI: RSDT (v001 KT400  AWRDACPI 16944.11825) @ 0x1fff3000
ACPI: FADT (v001 KT400  AWRDACPI 16944.11825) @ 0x1fff3040
ACPI: MADT (v001 KT400  AWRDACPI 16944.11825) @ 0x1fff6d00
ACPI: DSDT (v001 KT400  AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: ro root=/dev/sda1 nmi_watchdog=1 console=tty0 console=ttyS0,115200
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1734.223 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3416.06 BogoMIPS
Memory: 513676k/524224k available (2841k kernel code, 9796k reserved, 1226k data, 160k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: CLK_CTL MSR was 6003d223. Reprogramming to 2003d223
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2100+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030418
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..........................................................................................................................................
Table [DSDT] - 495 Objects with 46 Devices 138 Methods 25 Regions
ACPI Namespace successfully loaded at root c053539c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0740 [06] ev_create_gpe_block   : GPE Block: [_GPE] 2 registers at 0000000000004020 on interrupt 9
evgpeblk-0745 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 to GPE 0x0F
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L03 as GPE number 0x03
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L05 as GPE number 0x05
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L08 as GPE number 0x08
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L09 as GPE number 0x09
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0E as GPE number 0x0E
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L04 as GPE number 0x04
Executing all Device _STA and_INI methods:..............................................
46 Devices found containing: 46 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:...................................................................
Initialized 20/25 Regions 11/13 Fields 17/18 Buffers 19/19 Packages (495 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
pci_link-0256 [17] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
pci_link-0256 [19] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
pci_link-0256 [21] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
pci_link-0256 [23] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)
Linux Plug and Play Support v0.96 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
pci_link-0256 [21] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
pci_link-0256 [22] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
pci_link-0256 [23] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
pci_link-0256 [24] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Initializing RT netlink socket
Machine check exception polling timer started.
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Capability LSM initialized
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
ACPI: Thermal Zone [THRM] (45 C)
pty: 256 Unix98 ptys configured
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro KT400 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
FDC 0 is a post-1991 82077
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x9800. Vers LK1.1.19
via-rhine.c:v1.10-LK1.1.17  March-1-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth1: VIA VT6102 Rhine-II at 0xc400, 00:50:2c:05:76:34, IRQ 12.
eth1: MII PHY found at address 1, status 0x782d advertising 01e1 Link 41e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT372: IDE controller at PCI slot 00:0f.0
HPT372: chipset revision 5
HPT372: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:DMA, hdh:pio
hde: SAMSUNG SV1204H, ATA DISK drive
ide2 at 0xa000-0xa007,0xa402 on irq 11
hdg: SAMSUNG SV1204H, ATA DISK drive
ide3 at 0xa800-0xa807,0xac02 on irq 11
hda: SAMSUNG SV1204H, ATA DISK drive
hdc: SAMSUNG SV1204H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: host protected area => 1
hde: 234493056 sectors (120060 MB) w/2048KiB Cache, CHS=232632/16/63, UDMA(100)
hde: lost interrupt
hde: lost interrupt
 hde:<4>hde: dma_timer_expiry: dma status == 0x24
hde: lost interrupt

[ksymoops output below]
Unable to handle kernel NULL pointer dereference at virtual address 00000014
c02ad5d9
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02ad5d9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: c053f7fc   ecx: 00000005   edx: c049d2c0
esi: 00000050   edi: 00000000   ebp: c04fbecc   esp: c04fbeb4
ds: 007b   es: 007b   ss: 0068
Stack: c053f7fc 00000001 00000012 c053f7fc dfd85c80 c02ad546 c04fbef8 c029b358 
       c053f7fc c053f7fc 00000000 c053f750 dfd85ca4 00000286 c029b2ae dfd85ca4 
       c04fbf0c c04fbf24 c011f492 dfd85c80 c04fbf1c c010dfa7 c052bf00 c052bf00 
 [<c02ad546>] ide_dma_intr+0x0/0xba
 [<c029b358>] ide_timer_expiry+0xaa/0x1b4
 [<c029b2ae>] ide_timer_expiry+0x0/0x1b4
 [<c011f492>] run_timer_softirq+0x94/0x14c
 [<c010dfa7>] timer_interrupt+0x29/0x100
 [<c011bbe1>] do_softirq+0xa1/0xa4
 [<c010a95b>] do_IRQ+0xcd/0xd6
 [<c0109144>] common_interrupt+0x18/0x20
 [<c02384a2>] acpi_processor_idle+0x15a/0x1f0
 [<c0107204>] kernel_thread_helper+0x0/0xc
 [<c0238348>] acpi_processor_idle+0x0/0x1f0
 [<c010700a>] default_idle+0x0/0x2c
 [<c01070a3>] cpu_idle+0x31/0x3a
 [<c0105000>] _stext+0x0/0x2a
 [<c04fc680>] start_kernel+0x15c/0x182
 [<c04fc402>] unknown_bootoption+0x0/0xf6
Code: 8b 40 14 89 44 24 08 ff 52 20 31 c0 eb c2 0f b6 c0 c7 04 24 


>>EIP; c02ad5d9 <ide_dma_intr+93/ba>   <=====

>>ebx; c053f7fc <ide_hwifs+121c/5730>
>>edx; c049d2c0 <idedisk_driver+0/c0>
>>ebp; c04fbecc <init_thread_union+1ecc/2000>
>>esp; c04fbeb4 <init_thread_union+1eb4/2000>

Code;  c02ad5d9 <ide_dma_intr+93/ba>
00000000 <_EIP>:
Code;  c02ad5d9 <ide_dma_intr+93/ba>   <=====
   0:   8b 40 14                  mov    0x14(%eax),%eax   <=====
Code;  c02ad5dc <ide_dma_intr+96/ba>
   3:   89 44 24 08               mov    %eax,0x8(%esp,1)
Code;  c02ad5e0 <ide_dma_intr+9a/ba>
   7:   ff 52 20                  call   *0x20(%edx)
Code;  c02ad5e3 <ide_dma_intr+9d/ba>
   a:   31 c0                     xor    %eax,%eax
Code;  c02ad5e5 <ide_dma_intr+9f/ba>
   c:   eb c2                     jmp    ffffffd0 <_EIP+0xffffffd0>
Code;  c02ad5e7 <ide_dma_intr+a1/ba>
   e:   0f b6 c0                  movzbl %al,%eax
Code;  c02ad5ea <ide_dma_intr+a4/ba>
  11:   c7 04 24 00 00 00 00      movl   $0x0,(%esp,1)

 <0>Kernel panic: Fatal exception in interrupt
