Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVBWLcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVBWLcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 06:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVBWLcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 06:32:14 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:47408 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261462AbVBWLa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 06:30:58 -0500
Message-ID: <40114.195.245.190.93.1109155418.squirrel@195.245.190.93>
Date: Wed, 23 Feb 2005 10:43:38 -0000 (WET)
Subject: 2.6.11-rc4-RT-V0.7.39-02 kernel BUG
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "LKML" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050223104338_16777"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 23 Feb 2005 11:30:54.0144 (UTC) FILETIME=[229FA400:01C5199B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050223104338_16777
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I'm back :) just shortly, to report an annoying kernel crash that
sometimes I'm experiencing at boot time on my laptop (P4@2.533Ghz/UP),
running 2.6.11-rc4-RT-V0.7.39-02 (PREEMPT_RT=y, config attached).

This BUG is happening in some probabilistic fashion, like 1 on each 3
boots, rendering the whole USB subsystem completely unusable as the most
notable consequence.

Taken from dmesg (integral output is attached):

BUG: Unable to handle kernel paging request at virtual address 0811eb68
 printing eip:
c0127927
*pde = 1e41d067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: natsemi crc32 ohci1394 ieee1394 loop subfs evdev
ohci_hcd usbcore video thermal processor fan button battery ac
CPU:    0
EIP:    0060:[<c0127927>]    Not tainted VLI
EFLAGS: 00010082   (2.6.11-rc4-RT-V0.7.39-02.0)
EIP is at change_owner+0x1a/0x5a
eax: de65c550   ebx: de65c550   ecx: 0811eb68   edx: df180550
esi: df0c3cc8   edi: df180a48   ebp: df0c3cc8   esp: de59ded0
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process IRQ 10 (pid: 1439, threadinfo=de59c000 task=df406000)
Stack: de65c550 df0c3cc8 df03ff70 df180550 c0127b5c de65c550 df0c3cc8
c0127d31
       00000000 df03ff70 00000286 00000000 de59c000 de558000 00010000
00000001
       c01283f5 e00d4400 e00c2cb0 00000001 de55a4d4 e00b0bf6 00000001
00000017
Call Trace:
 [<c0127b5c>] set_new_owner+0x17/0x2b (20)
 [<c0127d31>] __up_mutex+0xa4/0x193 (12)
 [<c01283f5>] up+0x35/0x3d (36)
 [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
 [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
 [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
 [<c012d77a>] __do_IRQ+0xca/0x180 (4)
 [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
 [<c012dd86>] do_hardirq+0x61/0x112 (48)
 [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
 [<c012de37>] do_irqd+0x0/0x96 (20)
 [<c012de9d>] do_irqd+0x66/0x96 (4)
 [<c0127018>] kthread+0x94/0xc8 (28)
 [<c0126f84>] kthread+0x0/0xc8 (16)
 [<c0100791>] kernel_thread_helper+0x5/0xb (16)
Code: 8b 6c 24 18 83 c4 1c c3 b8 da ff ff ff c3 90 90 c3 55 39 ca 89 c5 57
89 c8 56 53 74 49 8b 8a f8 04 00 00 8d ba f8 04 00 00 39 cf <8b> 19 74 37
8d b0 f8 04 00 00 eb 08 89 d9 8b 1b 39 cf 74 27 39
 <6>note: IRQ 10[1439] exited with preempt_count 3
BUG: scheduling while atomic: IRQ 10/0x00000003/1439
caller is do_exit+0x1da/0x34d
 [<c029f03a>] __sched_text_start+0x48e/0x5d7 (8)
 [<c01163bb>] exit_notify+0x60b/0x8f4 (24)
 [<c01148fc>] vprintk+0x101/0x142 (24)
 [<c011687e>] do_exit+0x1da/0x34d (32)
 [<c010349f>] do_trap+0x0/0xfe (40)
 [<c010e8fc>] do_page_fault+0x0/0x524 (48)
 [<c010e8fc>] do_page_fault+0x0/0x524 (12)
 [<c010ec42>] do_page_fault+0x346/0x524 (4)
 [<c029f2ea>] preempt_schedule+0x50/0x6b (80)
 [<c010fcdb>] try_to_wake_up+0x104/0x106 (20)
 [<e00b0516>] dma_trm_reset+0x36/0x11e [ohci1394] (24)
 [<c01106ab>] __wake_up_common+0x35/0x55 (16)
 [<c010e8fc>] do_page_fault+0x0/0x524 (60)
 [<c0102d57>] error_code+0x2b/0x30 (8)
 [<c0127927>] change_owner+0x1a/0x5a (44)
 [<c0127b5c>] set_new_owner+0x17/0x2b (28)
 [<c0127d31>] __up_mutex+0xa4/0x193 (12)
 [<c01283f5>] up+0x35/0x3d (36)
 [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
 [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
 [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
 [<c012d77a>] __do_IRQ+0xca/0x180 (4)
 [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
 [<c012dd86>] do_hardirq+0x61/0x112 (48)
 [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
 [<c012de37>] do_irqd+0x0/0x96 (20)
 [<c012de9d>] do_irqd+0x66/0x96 (4)
 [<c0127018>] kthread+0x94/0xc8 (28)
 [<c0126f84>] kthread+0x0/0xc8 (16)
 [<c0100791>] kernel_thread_helper+0x5/0xb (16)
prev->state: 2 != TASK_RUNNING??
IRQ 10/1439: BUG in __schedule at kernel/sched.c:3028
 [<c029efa9>] __sched_text_start+0x3fd/0x5d7 (8)
 [<c011687e>] do_exit+0x1da/0x34d (80)
 [<c010349f>] do_trap+0x0/0xfe (40)
 [<c010e8fc>] do_page_fault+0x0/0x524 (48)
 [<c010e8fc>] do_page_fault+0x0/0x524 (12)
 [<c010ec42>] do_page_fault+0x346/0x524 (4)
 [<c029f2ea>] preempt_schedule+0x50/0x6b (80)
 [<c010fcdb>] try_to_wake_up+0x104/0x106 (20)
 [<e00b0516>] dma_trm_reset+0x36/0x11e [ohci1394] (24)
 [<c01106ab>] __wake_up_common+0x35/0x55 (16)
 [<c010e8fc>] do_page_fault+0x0/0x524 (60)
 [<c0102d57>] error_code+0x2b/0x30 (8)
 [<c0127927>] change_owner+0x1a/0x5a (44)
 [<c0127b5c>] set_new_owner+0x17/0x2b (28)
 [<c0127d31>] __up_mutex+0xa4/0x193 (12)
 [<c01283f5>] up+0x35/0x3d (36)
 [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
 [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
 [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
 [<c012d77a>] __do_IRQ+0xca/0x180 (4)
 [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
 [<c012dd86>] do_hardirq+0x61/0x112 (48)
 [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
 [<c012de37>] do_irqd+0x0/0x96 (20)
 [<c012de9d>] do_irqd+0x66/0x96 (4)
 [<c0127018>] kthread+0x94/0xc8 (28)
 [<c0126f84>] kthread+0x0/0xc8 (16)
 [<c0100791>] kernel_thread_helper+0x5/0xb (16)


Please, feel free to ask me for anything else, if relevant to get rid of
this casual crash behavior. I'm already running the RT patch/kernel 100%
of the time, on all my boxes, althought I have no record of this happening
on my other P4@3.333Ghz/HT(SMP) box.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

------=_20050223104338_16777
Content-Type: text/plain; name="dmesg-2.6.11-rc4-RT-V0.7.39-02.0-1.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="dmesg-2.6.11-rc4-RT-V0.7.39-02.0-1.txt"

Linux version 2.6.11-rc4-RT-V0.7.39-02.0 (root@lambda) (gcc version 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1 Tue Feb 15 09:37:36 WET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f770000 (usable)
 BIOS-e820: 000000001f770000 - 000000001f77f000 (ACPI data)
 BIOS-e820: 000000001f77f000 - 000000001f780000 (ACPI NVS)
 BIOS-e820: 000000001f780000 - 000000001f800000 (reserved)
 BIOS-e820: 000000002f780000 - 000000002f800000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
503MB LOWMEM available.
On node 0 totalpages: 128880
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 124784 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6c70
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1f7783fd
ACPI: FADT (v001 ATI    Salmon   0x06040000 ATI  0x000f4240) @ 0x1f77ef64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1f77efd8
ACPI: DSDT (v001    ATI MS2_1535 0x06040000 MSFT 0x0100000e) @ 0x00000000
Real-Time Preemption Support (c) Ingo Molnar
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=linux-RT-V0.7.39-02.0 ro root=305 devfs=nomount acpi=on
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (013f3000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2524.845 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 507996k/515520k available (1669k kernel code, 7136k reserved, 585k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4980.73 BogoMIPS (lpj=2490368)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080 00004400 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0420)
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd88b, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050125
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK2] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK5] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNK6] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
ACPI: PCI Interrupt Link [LNK8] (IRQs 7 *10)
ACPI: Embedded Controller [EC0] (gpe 24)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x37 set to 0x1
Activating ISA DMA hang workarounds.
Real Time Clock Driver v1.12
ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [MSE0] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PCI: Enabling device 0000:00:08.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 10 (level, low) -> IRQ 10
ttyS0 at I/O 0x1428 (irq = 10) is a 8250
ttyS2 at I/O 0x1440 (irq = 10) is a 8250
ttyS3 at I/O 0x1450 (irq = 10) is a 8250
ttyS4 at I/O 0x1460 (irq = 10) is a 8250
ttyS5 at I/O 0x1470 (irq = 10) is a 8250
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: PCI interrupt 0000:00:10.0[A]: no GSI - using IRQ 0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC25N040ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.8
 Sensor: 35
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 7, 524288 bytes)
TCP bind hash table entries: 16384 (order: 6, 393216 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
kjournald starting.  Commit interval 5 seconds
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (25 C)
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: irq 10, pci mem 0xd4000000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:0f.0: OHCI Host Controller
ohci_hcd 0000:00:0f.0: irq 10, pci mem 0xd4009000
ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
EXT3 FS on hda5, internal journal
Adding 506008k swap on /dev/hda6.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
subfs 0.9
loop: loaded (max 8 devices)
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:00:0c.0 (0010 -> 0012)
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d4008000-d40087ff]  Max Packet=[2048]
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 10 (level, low) -> IRQ 10
natsemi eth0: NatSemi DP8381[56] at 0xd400a000 (0000:00:12.0), 00:0b:cd:85:0f:54, IRQ 10, port TP.
BUG: Unable to handle kernel paging request at virtual address 0811eb68
 printing eip:
c0127927
*pde = 1e41d067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: natsemi crc32 ohci1394 ieee1394 loop subfs evdev ohci_hcd usbcore video thermal processor fan button battery ac
CPU:    0
EIP:    0060:[<c0127927>]    Not tainted VLI
EFLAGS: 00010082   (2.6.11-rc4-RT-V0.7.39-02.0) 
EIP is at change_owner+0x1a/0x5a
eax: de65c550   ebx: de65c550   ecx: 0811eb68   edx: df180550
esi: df0c3cc8   edi: df180a48   ebp: df0c3cc8   esp: de59ded0
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process IRQ 10 (pid: 1439, threadinfo=de59c000 task=df406000)
Stack: de65c550 df0c3cc8 df03ff70 df180550 c0127b5c de65c550 df0c3cc8 c0127d31 
       00000000 df03ff70 00000286 00000000 de59c000 de558000 00010000 00000001 
       c01283f5 e00d4400 e00c2cb0 00000001 de55a4d4 e00b0bf6 00000001 00000017 
Call Trace:
 [<c0127b5c>] set_new_owner+0x17/0x2b (20)
 [<c0127d31>] __up_mutex+0xa4/0x193 (12)
 [<c01283f5>] up+0x35/0x3d (36)
 [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
 [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
 [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
 [<c012d77a>] __do_IRQ+0xca/0x180 (4)
 [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
 [<c012dd86>] do_hardirq+0x61/0x112 (48)
 [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
 [<c012de37>] do_irqd+0x0/0x96 (20)
 [<c012de9d>] do_irqd+0x66/0x96 (4)
 [<c0127018>] kthread+0x94/0xc8 (28)
 [<c0126f84>] kthread+0x0/0xc8 (16)
 [<c0100791>] kernel_thread_helper+0x5/0xb (16)
Code: 8b 6c 24 18 83 c4 1c c3 b8 da ff ff ff c3 90 90 c3 55 39 ca 89 c5 57 89 c8 56 53 74 49 8b 8a f8 04 00 00 8d ba f8 04 00 00 39 cf <8b> 19 74 37 8d b0 f8 04 00 00 eb 08 89 d9 8b 1b 39 cf 74 27 39 
 <6>note: IRQ 10[1439] exited with preempt_count 3
BUG: scheduling while atomic: IRQ 10/0x00000003/1439
caller is do_exit+0x1da/0x34d
 [<c029f03a>] __sched_text_start+0x48e/0x5d7 (8)
 [<c01163bb>] exit_notify+0x60b/0x8f4 (24)
 [<c01148fc>] vprintk+0x101/0x142 (24)
 [<c011687e>] do_exit+0x1da/0x34d (32)
 [<c010349f>] do_trap+0x0/0xfe (40)
 [<c010e8fc>] do_page_fault+0x0/0x524 (48)
 [<c010e8fc>] do_page_fault+0x0/0x524 (12)
 [<c010ec42>] do_page_fault+0x346/0x524 (4)
 [<c029f2ea>] preempt_schedule+0x50/0x6b (80)
 [<c010fcdb>] try_to_wake_up+0x104/0x106 (20)
 [<e00b0516>] dma_trm_reset+0x36/0x11e [ohci1394] (24)
 [<c01106ab>] __wake_up_common+0x35/0x55 (16)
 [<c010e8fc>] do_page_fault+0x0/0x524 (60)
 [<c0102d57>] error_code+0x2b/0x30 (8)
 [<c0127927>] change_owner+0x1a/0x5a (44)
 [<c0127b5c>] set_new_owner+0x17/0x2b (28)
 [<c0127d31>] __up_mutex+0xa4/0x193 (12)
 [<c01283f5>] up+0x35/0x3d (36)
 [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
 [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
 [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
 [<c012d77a>] __do_IRQ+0xca/0x180 (4)
 [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
 [<c012dd86>] do_hardirq+0x61/0x112 (48)
 [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
 [<c012de37>] do_irqd+0x0/0x96 (20)
 [<c012de9d>] do_irqd+0x66/0x96 (4)
 [<c0127018>] kthread+0x94/0xc8 (28)
 [<c0126f84>] kthread+0x0/0xc8 (16)
 [<c0100791>] kernel_thread_helper+0x5/0xb (16)
prev->state: 2 != TASK_RUNNING??
IRQ 10/1439: BUG in __schedule at kernel/sched.c:3028
 [<c029efa9>] __sched_text_start+0x3fd/0x5d7 (8)
 [<c011687e>] do_exit+0x1da/0x34d (80)
 [<c010349f>] do_trap+0x0/0xfe (40)
 [<c010e8fc>] do_page_fault+0x0/0x524 (48)
 [<c010e8fc>] do_page_fault+0x0/0x524 (12)
 [<c010ec42>] do_page_fault+0x346/0x524 (4)
 [<c029f2ea>] preempt_schedule+0x50/0x6b (80)
 [<c010fcdb>] try_to_wake_up+0x104/0x106 (20)
 [<e00b0516>] dma_trm_reset+0x36/0x11e [ohci1394] (24)
 [<c01106ab>] __wake_up_common+0x35/0x55 (16)
 [<c010e8fc>] do_page_fault+0x0/0x524 (60)
 [<c0102d57>] error_code+0x2b/0x30 (8)
 [<c0127927>] change_owner+0x1a/0x5a (44)
 [<c0127b5c>] set_new_owner+0x17/0x2b (28)
 [<c0127d31>] __up_mutex+0xa4/0x193 (12)
 [<c01283f5>] up+0x35/0x3d (36)
 [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
 [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
 [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
 [<c012d77a>] __do_IRQ+0xca/0x180 (4)
 [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
 [<c012dd86>] do_hardirq+0x61/0x112 (48)
 [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
 [<c012de37>] do_irqd+0x0/0x96 (20)
 [<c012de9d>] do_irqd+0x66/0x96 (4)
 [<c0127018>] kthread+0x94/0xc8 (28)
 [<c0126f84>] kthread+0x0/0xc8 (16)
 [<c0100791>] kernel_thread_helper+0x5/0xb (16)
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:00:0a.0 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0850]
Yenta O2: res at 0x94/0xD4: 00/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000007
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0xa00-0xaff: clean.
prism2_cs: Ignoring new-style parameters in presence of obsolete ones
prism2cs_init: prism2_cs.o: 0.2.1-pre26 Loaded
prism2cs_init: dev_info is: prism2_cs
PCI: Enabling device 0000:00:06.0 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
usbcore: registered new driver snd-usb-usx2y
Realtime LSM initialized (group 81, mlock=1)
mtrr: no more MTRRs available

------=_20050223104338_16777
Content-Type: application/x-gzip-compressed;
      name="config-2.6.11-rc4-RT-V0.7.39-02.0.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="config-2.6.11-rc4-RT-V0.7.39-02.0.gz"

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
qKmHAAA=
------=_20050223104338_16777--


