Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVBWOCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVBWOCh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 09:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVBWOCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 09:02:37 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:62970 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261353AbVBWOBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 09:01:54 -0500
Message-ID: <421C8CB4.5060605@tiscali.de>
Date: Wed, 23 Feb 2005 15:01:24 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rui Nuno Capela <rncbc@rncbc.org>
CC: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc4-RT-V0.7.39-02 kernel BUG
References: <40114.195.245.190.93.1109155418.squirrel@195.245.190.93>
In-Reply-To: <40114.195.245.190.93.1109155418.squirrel@195.245.190.93>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Nuno Capela wrote:

> Hi,
>
> I'm back :) just shortly, to report an annoying kernel crash that
> sometimes I'm experiencing at boot time on my laptop (P4@2.533Ghz/UP),
> running 2.6.11-rc4-RT-V0.7.39-02 (PREEMPT_RT=y, config attached).
>
> This BUG is happening in some probabilistic fashion, like 1 on each 3
> boots, rendering the whole USB subsystem completely unusable as the most
> notable consequence.
>
> Taken from dmesg (integral output is attached):
>
> BUG: Unable to handle kernel paging request at virtual address 0811eb68
> printing eip:
> c0127927
> *pde = 1e41d067
> *pte = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: natsemi crc32 ohci1394 ieee1394 loop subfs evdev
> ohci_hcd usbcore video thermal processor fan button battery ac
> CPU: 0
> EIP: 0060:[<c0127927>] Not tainted VLI
> EFLAGS: 00010082 (2.6.11-rc4-RT-V0.7.39-02.0)
> EIP is at change_owner+0x1a/0x5a
> eax: de65c550 ebx: de65c550 ecx: 0811eb68 edx: df180550
> esi: df0c3cc8 edi: df180a48 ebp: df0c3cc8 esp: de59ded0
> ds: 007b es: 007b ss: 0068 preempt: 00000004
> Process IRQ 10 (pid: 1439, threadinfo=de59c000 task=df406000)
> Stack: de65c550 df0c3cc8 df03ff70 df180550 c0127b5c de65c550 df0c3cc8
> c0127d31
> 00000000 df03ff70 00000286 00000000 de59c000 de558000 00010000
> 00000001
> c01283f5 e00d4400 e00c2cb0 00000001 de55a4d4 e00b0bf6 00000001
> 00000017
> Call Trace:
> [<c0127b5c>] set_new_owner+0x17/0x2b (20)
> [<c0127d31>] __up_mutex+0xa4/0x193 (12)
> [<c01283f5>] up+0x35/0x3d (36)
> [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
> [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
> [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
> [<c012d77a>] __do_IRQ+0xca/0x180 (4)
> [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
> [<c012dd86>] do_hardirq+0x61/0x112 (48)
> [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
> [<c012de37>] do_irqd+0x0/0x96 (20)
> [<c012de9d>] do_irqd+0x66/0x96 (4)
> [<c0127018>] kthread+0x94/0xc8 (28)
> [<c0126f84>] kthread+0x0/0xc8 (16)
> [<c0100791>] kernel_thread_helper+0x5/0xb (16)
> Code: 8b 6c 24 18 83 c4 1c c3 b8 da ff ff ff c3 90 90 c3 55 39 ca 89 c5 57
> 89 c8 56 53 74 49 8b 8a f8 04 00 00 8d ba f8 04 00 00 39 cf <8b> 19 74 37
> 8d b0 f8 04 00 00 eb 08 89 d9 8b 1b 39 cf 74 27 39
> <6>note: IRQ 10[1439] exited with preempt_count 3
> BUG: scheduling while atomic: IRQ 10/0x00000003/1439
> caller is do_exit+0x1da/0x34d
> [<c029f03a>] __sched_text_start+0x48e/0x5d7 (8)
> [<c01163bb>] exit_notify+0x60b/0x8f4 (24)
> [<c01148fc>] vprintk+0x101/0x142 (24)
> [<c011687e>] do_exit+0x1da/0x34d (32)
> [<c010349f>] do_trap+0x0/0xfe (40)
> [<c010e8fc>] do_page_fault+0x0/0x524 (48)
> [<c010e8fc>] do_page_fault+0x0/0x524 (12)
> [<c010ec42>] do_page_fault+0x346/0x524 (4)
> [<c029f2ea>] preempt_schedule+0x50/0x6b (80)
> [<c010fcdb>] try_to_wake_up+0x104/0x106 (20)
> [<e00b0516>] dma_trm_reset+0x36/0x11e [ohci1394] (24)
> [<c01106ab>] __wake_up_common+0x35/0x55 (16)
> [<c010e8fc>] do_page_fault+0x0/0x524 (60)
> [<c0102d57>] error_code+0x2b/0x30 (8)
> [<c0127927>] change_owner+0x1a/0x5a (44)
> [<c0127b5c>] set_new_owner+0x17/0x2b (28)
> [<c0127d31>] __up_mutex+0xa4/0x193 (12)
> [<c01283f5>] up+0x35/0x3d (36)
> [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
> [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
> [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
> [<c012d77a>] __do_IRQ+0xca/0x180 (4)
> [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
> [<c012dd86>] do_hardirq+0x61/0x112 (48)
> [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
> [<c012de37>] do_irqd+0x0/0x96 (20)
> [<c012de9d>] do_irqd+0x66/0x96 (4)
> [<c0127018>] kthread+0x94/0xc8 (28)
> [<c0126f84>] kthread+0x0/0xc8 (16)
> [<c0100791>] kernel_thread_helper+0x5/0xb (16)
> prev->state: 2 != TASK_RUNNING??
> IRQ 10/1439: BUG in __schedule at kernel/sched.c:3028
> [<c029efa9>] __sched_text_start+0x3fd/0x5d7 (8)
> [<c011687e>] do_exit+0x1da/0x34d (80)
> [<c010349f>] do_trap+0x0/0xfe (40)
> [<c010e8fc>] do_page_fault+0x0/0x524 (48)
> [<c010e8fc>] do_page_fault+0x0/0x524 (12)
> [<c010ec42>] do_page_fault+0x346/0x524 (4)
> [<c029f2ea>] preempt_schedule+0x50/0x6b (80)
> [<c010fcdb>] try_to_wake_up+0x104/0x106 (20)
> [<e00b0516>] dma_trm_reset+0x36/0x11e [ohci1394] (24)
> [<c01106ab>] __wake_up_common+0x35/0x55 (16)
> [<c010e8fc>] do_page_fault+0x0/0x524 (60)
> [<c0102d57>] error_code+0x2b/0x30 (8)
> [<c0127927>] change_owner+0x1a/0x5a (44)
> [<c0127b5c>] set_new_owner+0x17/0x2b (28)
> [<c0127d31>] __up_mutex+0xa4/0x193 (12)
> [<c01283f5>] up+0x35/0x3d (36)
> [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
> [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
> [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
> [<c012d77a>] __do_IRQ+0xca/0x180 (4)
> [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
> [<c012dd86>] do_hardirq+0x61/0x112 (48)
> [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
> [<c012de37>] do_irqd+0x0/0x96 (20)
> [<c012de9d>] do_irqd+0x66/0x96 (4)
> [<c0127018>] kthread+0x94/0xc8 (28)
> [<c0126f84>] kthread+0x0/0xc8 (16)
> [<c0100791>] kernel_thread_helper+0x5/0xb (16)
>
>
> Please, feel free to ask me for anything else, if relevant to get rid of
> this casual crash behavior. I'm already running the RT patch/kernel 100%
> of the time, on all my boxes, althought I have no record of this happening
> on my other P4@3.333Ghz/HT(SMP) box.
>
> Cheers.
>
> ------------------------------------------------------------------------
>
> Linux version 2.6.11-rc4-RT-V0.7.39-02.0 (root@lambda) (gcc version 
> 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1 Tue Feb 15 09:37:36 WET 2005
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000001f770000 (usable)
> BIOS-e820: 000000001f770000 - 000000001f77f000 (ACPI data)
> BIOS-e820: 000000001f77f000 - 000000001f780000 (ACPI NVS)
> BIOS-e820: 000000001f780000 - 000000001f800000 (reserved)
> BIOS-e820: 000000002f780000 - 000000002f800000 (reserved)
> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> 503MB LOWMEM available.
> On node 0 totalpages: 128880
> DMA zone: 4096 pages, LIFO batch:1
> Normal zone: 124784 pages, LIFO batch:16
> HighMem zone: 0 pages, LIFO batch:1
> DMI 2.3 present.
> ACPI: RSDP (v000 PTLTD ) @ 0x000f6c70
> ACPI: RSDT (v001 PTLTD RSDT 0x06040000 LTP 0x00000000) @ 0x1f7783fd
> ACPI: FADT (v001 ATI Salmon 0x06040000 ATI 0x000f4240) @ 0x1f77ef64
> ACPI: BOOT (v001 PTLTD $SBFTBL$ 0x06040000 LTP 0x00000001) @ 0x1f77efd8
> ACPI: DSDT (v001 ATI MS2_1535 0x06040000 MSFT 0x0100000e) @ 0x00000000
> Real-Time Preemption Support (c) Ingo Molnar
> Built 1 zonelists
> Kernel command line: auto BOOT_IMAGE=linux-RT-V0.7.39-02.0 ro root=305 
> devfs=nomount acpi=on
> Local APIC disabled by BIOS -- you can enable it with "lapic"
> mapped APIC to ffffd000 (013f3000)
> Initializing CPU#0
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Detected 2524.845 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 507996k/515520k available (1669k kernel code, 7136k reserved, 
> 585k data, 152k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor 
> mode... Ok.
> Calibrating delay loop... 4980.73 BogoMIPS (lpj=2490368)
> Security Framework v1.0.0 initialized
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000 
> 00004400 00000000 00000000
> CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000 
> 00004400 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080 
> 00004400 00000000 00000000
> CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 07
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> ACPI: setting ELCR to 0200 (from 0420)
> spawn_desched_task(00000000)
> desched cpu_callback 3/00000000
> ksoftirqd started up.
> softirq RT prio: 24.
> desched cpu_callback 2/00000000
> desched thread 0 started up.
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfd88b, last bus=2
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20050125
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
> ACPI: PCI Interrupt Link [LNK0] (IRQs 7 10) *0, disabled.
> ACPI: PCI Interrupt Link [LNK1] (IRQs 7 *10)
> ACPI: PCI Interrupt Link [LNK2] (IRQs 7 10) *0, disabled.
> ACPI: PCI Interrupt Link [LNK3] (IRQs 7 10) *0, disabled.
> ACPI: PCI Interrupt Link [LNK4] (IRQs 7 *10)
> ACPI: PCI Interrupt Link [LNK5] (IRQs 7 *11)
> ACPI: PCI Interrupt Link [LNK6] (IRQs 7 10) *0, disabled.
> ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
> ACPI: PCI Interrupt Link [LNK8] (IRQs 7 *10)
> ACPI: Embedded Controller [EC0] (gpe 24)
> SCSI subsystem initialized
> PCI: Using ACPI for IRQ routing
> ** PCI interrupts are no longer routed automatically. If this
> ** causes a device to stop working, it is probably because the
> ** driver failed to call pci_enable_device(). As a temporary
> ** workaround, the "pci=routeirq" argument restores the old
> ** behavior. If this argument makes the device work again,
> ** please email the output of "lspci" to bjorn.helgaas@hp.com
> ** so I can fix the driver.
> Simple Boot Flag at 0x37 set to 0x1
> Activating ISA DMA hang workarounds.
> Real Time Clock Driver v1.12
> ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1
> ACPI: PS/2 Mouse Controller [MSE0] at irq 12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> PCI: Enabling device 0000:00:08.0 (0000 -> 0003)
> ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 10
> PCI: setting IRQ 10 as level-triggered
> ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 10 (level, low) -> IRQ 10
> ttyS0 at I/O 0x1428 (irq = 10) is a 8250
> ttyS2 at I/O 0x1440 (irq = 10) is a 8250
> ttyS3 at I/O 0x1450 (irq = 10) is a 8250
> ttyS4 at I/O 0x1460 (irq = 10) is a 8250
> ttyS5 at I/O 0x1470 (irq = 10) is a 8250
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> ALI15X3: IDE controller at PCI slot 0000:00:10.0
> ACPI: PCI interrupt 0000:00:10.0[A]: no GSI - using IRQ 0
> ALI15X3: chipset revision 196
> ALI15X3: not 100% native mode: will probe irqs later
> ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
> ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: IC25N040ATCS04-0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> Probing IDE interface ide4...
> Probing IDE interface ide5...
> hda: max request size: 128KiB
> hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, 
> UDMA(100)
> hda: cache flushes not supported
> hda: hda1 hda2 < hda5 hda6 hda7 >
> hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.20
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> Synaptics Touchpad, model: 1
> Firmware: 5.8
> Sensor: 35
> new absolute packet format
> Touchpad has extended capability bits
> -> multifinger detection
> -> palm detection
> input: SynPS/2 Synaptics TouchPad on isa0060/serio1
> NET: Registered protocol family 2
> IP: routing cache hash table of 1024 buckets, 32Kbytes
> TCP established hash table entries: 16384 (order: 7, 524288 bytes)
> TCP bind hash table entries: 16384 (order: 6, 393216 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 152k freed
> kjournald starting. Commit interval 5 seconds
> ACPI: AC Adapter [ACAD] (on-line)
> ACPI: Battery Slot [BAT1] (battery present)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID]
> ACPI: CPU0 (power states: C1[C1] C2[C2])
> ACPI: Thermal Zone [THRM] (25 C)
> ACPI: Video Device [VGA] (multi-head: yes rom: no post: no)
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
> ohci_hcd 0000:00:02.0: OHCI Host Controller
> ohci_hcd 0000:00:02.0: irq 10, pci mem 0xd4000000
> ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 10 (level, low) -> IRQ 10
> ohci_hcd 0000:00:0f.0: OHCI Host Controller
> ohci_hcd 0000:00:0f.0: irq 10, pci mem 0xd4009000
> ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> EXT3 FS on hda5, internal journal
> Adding 506008k swap on /dev/hda6. Priority:-1 extents:1
> kjournald starting. Commit interval 5 seconds
> EXT3 FS on hda7, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> subfs 0.9
> loop: loaded (max 8 devices)
> ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
> PCI: Enabling device 0000:00:0c.0 (0010 -> 0012)
> ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10] 
> MMIO=[d4008000-d40087ff] Max Packet=[2048]
> natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
> originally by Donald Becker <becker@scyld.com>
> http://www.scyld.com/network/natsemi.html
> 2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
> ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 10 (level, low) -> IRQ 10
> natsemi eth0: NatSemi DP8381[56] at 0xd400a000 (0000:00:12.0), 
> 00:0b:cd:85:0f:54, IRQ 10, port TP.
> BUG: Unable to handle kernel paging request at virtual address 0811eb68
> printing eip:
> c0127927
> *pde = 1e41d067
> *pte = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: natsemi crc32 ohci1394 ieee1394 loop subfs evdev 
> ohci_hcd usbcore video thermal processor fan button battery ac
> CPU: 0
> EIP: 0060:[<c0127927>] Not tainted VLI
> EFLAGS: 00010082 (2.6.11-rc4-RT-V0.7.39-02.0)
> EIP is at change_owner+0x1a/0x5a
> eax: de65c550 ebx: de65c550 ecx: 0811eb68 edx: df180550
> esi: df0c3cc8 edi: df180a48 ebp: df0c3cc8 esp: de59ded0
> ds: 007b es: 007b ss: 0068 preempt: 00000004
> Process IRQ 10 (pid: 1439, threadinfo=de59c000 task=df406000)
> Stack: de65c550 df0c3cc8 df03ff70 df180550 c0127b5c de65c550 df0c3cc8 
> c0127d31
> 00000000 df03ff70 00000286 00000000 de59c000 de558000 00010000 00000001
> c01283f5 e00d4400 e00c2cb0 00000001 de55a4d4 e00b0bf6 00000001 00000017
> Call Trace:
> [<c0127b5c>] set_new_owner+0x17/0x2b (20)
> [<c0127d31>] __up_mutex+0xa4/0x193 (12)
> [<c01283f5>] up+0x35/0x3d (36)
> [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
> [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
> [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
> [<c012d77a>] __do_IRQ+0xca/0x180 (4)
> [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
> [<c012dd86>] do_hardirq+0x61/0x112 (48)
> [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
> [<c012de37>] do_irqd+0x0/0x96 (20)
> [<c012de9d>] do_irqd+0x66/0x96 (4)
> [<c0127018>] kthread+0x94/0xc8 (28)
> [<c0126f84>] kthread+0x0/0xc8 (16)
> [<c0100791>] kernel_thread_helper+0x5/0xb (16)
> Code: 8b 6c 24 18 83 c4 1c c3 b8 da ff ff ff c3 90 90 c3 55 39 ca 89 
> c5 57 89 c8 56 53 74 49 8b 8a f8 04 00 00 8d ba f8 04 00 00 39 cf <8b> 
> 19 74 37 8d b0 f8 04 00 00 eb 08 89 d9 8b 1b 39 cf 74 27 39
> <6>note: IRQ 10[1439] exited with preempt_count 3
> BUG: scheduling while atomic: IRQ 10/0x00000003/1439
> caller is do_exit+0x1da/0x34d
> [<c029f03a>] __sched_text_start+0x48e/0x5d7 (8)
> [<c01163bb>] exit_notify+0x60b/0x8f4 (24)
> [<c01148fc>] vprintk+0x101/0x142 (24)
> [<c011687e>] do_exit+0x1da/0x34d (32)
> [<c010349f>] do_trap+0x0/0xfe (40)
> [<c010e8fc>] do_page_fault+0x0/0x524 (48)
> [<c010e8fc>] do_page_fault+0x0/0x524 (12)
> [<c010ec42>] do_page_fault+0x346/0x524 (4)
> [<c029f2ea>] preempt_schedule+0x50/0x6b (80)
> [<c010fcdb>] try_to_wake_up+0x104/0x106 (20)
> [<e00b0516>] dma_trm_reset+0x36/0x11e [ohci1394] (24)
> [<c01106ab>] __wake_up_common+0x35/0x55 (16)
> [<c010e8fc>] do_page_fault+0x0/0x524 (60)
> [<c0102d57>] error_code+0x2b/0x30 (8)
> [<c0127927>] change_owner+0x1a/0x5a (44)
> [<c0127b5c>] set_new_owner+0x17/0x2b (28)
> [<c0127d31>] __up_mutex+0xa4/0x193 (12)
> [<c01283f5>] up+0x35/0x3d (36)
> [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
> [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
> [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
> [<c012d77a>] __do_IRQ+0xca/0x180 (4)
> [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
> [<c012dd86>] do_hardirq+0x61/0x112 (48)
> [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
> [<c012de37>] do_irqd+0x0/0x96 (20)
> [<c012de9d>] do_irqd+0x66/0x96 (4)
> [<c0127018>] kthread+0x94/0xc8 (28)
> [<c0126f84>] kthread+0x0/0xc8 (16)
> [<c0100791>] kernel_thread_helper+0x5/0xb (16)
> prev->state: 2 != TASK_RUNNING??
> IRQ 10/1439: BUG in __schedule at kernel/sched.c:3028
> [<c029efa9>] __sched_text_start+0x3fd/0x5d7 (8)
> [<c011687e>] do_exit+0x1da/0x34d (80)
> [<c010349f>] do_trap+0x0/0xfe (40)
> [<c010e8fc>] do_page_fault+0x0/0x524 (48)
> [<c010e8fc>] do_page_fault+0x0/0x524 (12)
> [<c010ec42>] do_page_fault+0x346/0x524 (4)
> [<c029f2ea>] preempt_schedule+0x50/0x6b (80)
> [<c010fcdb>] try_to_wake_up+0x104/0x106 (20)
> [<e00b0516>] dma_trm_reset+0x36/0x11e [ohci1394] (24)
> [<c01106ab>] __wake_up_common+0x35/0x55 (16)
> [<c010e8fc>] do_page_fault+0x0/0x524 (60)
> [<c0102d57>] error_code+0x2b/0x30 (8)
> [<c0127927>] change_owner+0x1a/0x5a (44)
> [<c0127b5c>] set_new_owner+0x17/0x2b (28)
> [<c0127d31>] __up_mutex+0xa4/0x193 (12)
> [<c01283f5>] up+0x35/0x3d (36)
> [<e00c2cb0>] highlevel_host_reset+0x3b/0x49 [ieee1394] (8)
> [<e00b0bf6>] ohci_irq_handler+0x576/0x713 [ohci1394] (12)
> [<c029ec06>] __sched_text_start+0x5a/0x5d7 (28)
> [<c012d77a>] __do_IRQ+0xca/0x180 (4)
> [<c012d634>] handle_IRQ_event+0x5c/0xc8 (36)
> [<c012dd86>] do_hardirq+0x61/0x112 (48)
> [<c0110dbd>] do_sched_setscheduler+0x73/0xa0 (4)
> [<c012de37>] do_irqd+0x0/0x96 (20)
> [<c012de9d>] do_irqd+0x66/0x96 (4)
> [<c0127018>] kthread+0x94/0xc8 (28)
> [<c0126f84>] kthread+0x0/0xc8 (16)
> [<c0100791>] kernel_thread_helper+0x5/0xb (16)
> Linux Kernel Card Services
> options: [pci] [cardbus] [pm]
> PCI: Enabling device 0000:00:0a.0 (0005 -> 0007)
> ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
> PCI: setting IRQ 11 as level-triggered
> ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
> Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0850]
> Yenta O2: res at 0x94/0xD4: 00/ea
> Yenta O2: enabling read prefetch/write burst
> Yenta: ISA IRQ mask 0x00b8, PCI irq 11
> Socket status: 30000007
> cs: IO port probe 0xc00-0xcff: clean.
> cs: IO port probe 0x100-0x4ff: excluding 0x408-0x40f 0x480-0x48f 
> 0x4d0-0x4d7
> cs: IO port probe 0xa00-0xaff: clean.
> prism2_cs: Ignoring new-style parameters in presence of obsolete ones
> prism2cs_init: prism2_cs.o: 0.2.1-pre26 Loaded
> prism2cs_init: dev_info is: prism2_cs
> PCI: Enabling device 0000:00:06.0 (0005 -> 0007)
> ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
> PCI: setting IRQ 5 as level-triggered
> ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
> usbcore: registered new driver snd-usb-usx2y
> Realtime LSM initialized (group 81, mlock=1)
> mtrr: no more MTRRs available

Hi!
The first bug is in the usbb ohci module (report it to 
http://buzilla.kernel.org and its Maintainers). The second one is caused 
by the first one.

Matthias-Christian Ott
