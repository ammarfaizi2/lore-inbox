Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVAYQLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVAYQLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVAYQLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:11:11 -0500
Received: from mailfe09.tele2.se ([212.247.155.1]:44725 "EHLO
	mailfe09.swip.net") by vger.kernel.org with ESMTP id S261993AbVAYQK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:10:58 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: PANIC in check_process_timers() running 2.6.11-rc2-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: roland@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 25 Jan 2005 17:10:52 +0100
Message-Id: <1106669452.705.29.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland

Just got this running LTP-20050107 on 2.6.11-rc2-mm1, haven't looked
further yet. Box is i386 UP with preempt, I'm putting dmesg at the 
bottom of mail.


alex@boxen:~$ nc -u -l -p 7001
divide error: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c012dac8>]    Not tainted VLI
EFLAGS: 00010002   (2.6.11-rc2-mm1)
EIP is at check_process_timers+0x298/0x440
eax: 00000001   ebx: 00004e27   ecx: 00000000   edx: 00000000
esi: cd0c7fb0   edi: c043ef90   ebp: c043ef88   esp: c043ef44
ds: 007b   es: 007b   ss: 0068
Process profil01 (pid: 3003, threadinfo=c043e000 task=cd6da5b0)
Stack: 00001925 c1730000 c1730220 00000000 00000000 00000000 00000000 a7400a14
       00000004 00004e28 00000000 00003502 cd0c7e78 cd6da5b0 cd6da5b0 c043e000
       00000000 c043efa4 c012e00f c043ef90 c043ef90 c043e000 cd1d1e30 00000000
Call Trace:
 [<c0103d7a>] show_stack+0x7a/0x90
 [<c0103ef8>] show_registers+0x148/0x1b0
 [<c01040e4>] die+0xe4/0x170
 [<c01042d4>] do_divide_error+0xa4/0xb0
 [<c01039d7>] error_code+0x2b/0x30
 [<c012e00f>] run_posix_cpu_timers+0xaf/0x160
 [<c0107833>] timer_interrupt+0x63/0x130
 [<c0132e9a>] handle_IRQ_event+0x2a/0x60
 [<c0132f9d>] __do_IRQ+0xcd/0x130
 [<c0105141>] do_IRQ+0x41/0x60
 =======================
 [<c0103932>] common_interrupt+0x1a/0x20
 [<c01428a1>] zap_pmd_range+0x41/0x60
 [<c01428f0>] zap_pud_range+0x30/0x50
 [<c0142970>] unmap_page_range+0x60/0x80
 [<c0142a7a>] unmap_vmas+0xea/0x1f0
 [<c0147146>] exit_mmap+0x76/0x150
 [<c011670e>] mmput+0x3e/0x100
 [<c011aaf8>] do_exit+0xa8/0x390
 [<c011ae52>] do_group_exit+0x32/0xa0
 [<c0102fc3>] syscall_call+0x7/0xb
Code: 85 ff 75 0c 8b 4d d4 0b 4d d0 0f 84 0b 01 00 00 8b 45 ec 31 d2 8b 48 04 c7 45 cc 00 00 00 00 c7 45 c8 00 00 00 00 8b 45 e0 29 d8 <f7> f1 31 d2 89 45 c4 8b 45 e4 2b 45 e8 f7 f1 8b 55 d4 0b 55 d0
 <0>Kernel panic - not syncing: Fatal exception in interrupt



 Linux version 2.6.11-rc2-mm1 (alex@boxen) (gcc version 3.3.5 (Debian 1:3.3.5-1)) #2 Tue Jan 25 15:35:15 UTC 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
 BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
 BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
247MB LOWMEM available.
DMI 2.2 present.
Built 1 zonelists
Local APIC disabled by BIOS -- you can enable it with "lapic"
Initializing CPU#0
Kernel command line: BOOT_IMAGE=x86_kernel root=/dev/hda1 profile=1 nmi_watchdog=1 apic=debug netconsole=4444@192.168.1.11/eth0,7001@192.168.1.1/ kgdboe=8001@192.168.1.11/eth0,4423@192.168.1.1/
kernel profiling enabled (shift: 1)
netconsole: local port 4444
netconsole: local IP 192.168.1.11
netconsole: interface eth0
netconsole: remote port 7001
netconsole: remote IP 192.168.1.1
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
CPU 0 irqstacks, hard=c043e000 soft=c043d000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1000.466 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 242916k/253888k available (2296k kernel code, 10380k reserved, 604k data, 388k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0008 (from 0c28)
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb1a0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050114
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
Disabling VIA memory write queue (PCI ID 3112, rev 00): [55] f9 & 1f -> 19
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with realtime, no debug enabled
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC0] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
tulip0:  MII transceiver #2 config 1000 status 786d advertising 05e1.
tulip0:  MII transceiver #3 config 1000 status 786d advertising 05e1.
tulip0:  MII transceiver #4 config 1000 status 786d advertising 05e1.
eth0: ADMtek Comet rev 17 at 0001ec00, 00:10:DC:34:B2:15, IRQ 11.
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears flaky, waiting 10 seconds
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y080L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG CD-ROM SC-152L, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
SLPB PCI0 USB0 USB1 UAR1 LPT1
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 388k freed
Adding 1919192k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal


