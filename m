Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbTDIVeU (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTDIVeU (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:34:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1731 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263831AbTDIVeO (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 17:34:14 -0400
Date: Wed, 9 Apr 2003 14:45:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm1 cause framebuffer crash at bootup
Message-Id: <20030409144520.12fc0f81.rddunlap@osdl.org>
In-Reply-To: <1A6006592C@vcnet.vc.cvut.cz>
References: <1A6006592C@vcnet.vc.cvut.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__9_Apr_2003_14:45:20_-0700_08327b40"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__9_Apr_2003_14:45:20_-0700_08327b40
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2003 22:58:45 +0200 "Petr Vandrovec" <VANDROVE@vc.cvut.cz> wrote:

| [As this one is matroxfb only, I removed others...]
| 
| > I can reproduce the problem with the earlier-keyboard-init.patch, but if
| > I reverse it, I get this [using Petr's 2.5.66-bk12 mga patch].  Is that the
| > right one to use?  do I need to use any kernel command line options with it?
| > Matrox G400 dual-head capable, but only using one of them.
| > 
| > 
| > matroxfb: Matrox G450 detected
| > matroxfb: MTRR's turned on
| > matroxfb: 640x480x8bpp (virtual: 640x26208)
| > matroxfb: framebuffer at 0xEC000000, mapped to 0xf8805000, size 16777216
| > <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
| >  printing eip:
| > 00000000
| > *pde = 00000000
| 
| It should not happen. Did not you get some rejects while patching?

No.

| > Oops: 0000 [#1]
| > CPU:    0
| > EIP:    0060:[<00000000>]    Not tainted
| > EFLAGS: 00010246
| > EIP is at 0x0
| > eax: c04b77c8   ebx: f7f9fccc   ecx: c1ada17f   edx: c04b6f40
| > esi: ffffffff   edi: 00000030   ebp: 00000030   esp: f7f9fc78
| > ds: 007b   es: 007b   ss: 0068
| > Process swapper (pid: 1, threadinfo=f7f9e000 task=f7f9c080)
| > Stack: c0292c1e c04b6f40 f7f9fccc ffffffff ffffffff 00000000 00000000 00000400 
| >        00000008 00000001 000000ff 0000000c c04b6f40 00000030 c1a41480 c0292e65 
| >        c1a41480 c04b6f40 f7f9fccc 00000030 c00bb1c0 00000000 00000108 00000180 
| > Call Trace:
| >  [<c0292c1e>] putcs_aligned+0x16e/0x1b0
| >  [<c0292e65>] accel_putcs+0xc5/0xf0
| >  [<c02939ce>] fbcon_putcs+0x7e/0x90
| 
| If your kernel binary is simillar to mine, it looks like that 
| fbops->fb_imageblit was NULL. It should not happen, as matroxfb's 
| fb_imageblit should point either to no_imageblit (which currenlty does 
| nothing, but it should complain loudly) or to cfb_imageblit (which 
| paints character) or matroxfb_imageblit (which should paint character too).
| 
| But from call trace it looks like that some printk() error got
| triggered on your config. Can you try booting with serial console? 
| Do you see penguins on the screen, or not? 

No penguins on screen.
I don't see any problems logged.  I did boot with serial console.
It's attached.

| Or remove body from drivers/video/console/fbcon.c:check_vc() - it should
| is not triggered on Linus kernels, but maybe -mm1 moved something around.
| It looks like that it is time to download -mm1 :-(

Actually this is just 2.5.67 + mga-2.5.66-bk12 with and without my
earlier-keyboard-init.patch...

--
~Randy

--Multipart_Wed__9_Apr_2003_14:45:20_-0700_08327b40
Content-Type: text/plain;
 name="mfb2-capture.txt"
Content-Disposition: attachment;
 filename="mfb2-capture.txt"
Content-Transfer-Encoding: 7bit

Synchronizing SCSI caches: sda 
Shutting down devices
Restarting system.
Linux version 2.5.67 (rddunlap@gargoyle.pdx.osdl.net) (gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #10 SMP Wed Apr 9 13:01:23 PDT 2003
Video mode to be used for restore is f06
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f52a0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 15:1 APIC version 17
Processor #1 15:0 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=lin2567nkb root=304 hdd=ide-scsi devfs=nomount debug console=ttyS0,38400n8 console=tty1 profile=4
ide_setup: hdd=ide-scsi
kernel profiling enabled
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1684.911 MHz processor.
Console: colour VGA+ 80x34
Calibrating delay loop... 3317.76 BogoMIPS
Memory: 1032604k/1048512k available (2396k kernel code, 14988k reserved, 991k data, 140k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: Hyper-Threading is disabled
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02
per-CPU timeslice cutoff: 731.63 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3358.72 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: Hyper-Threading is disabled
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 1700MHz stepping 0a
Total of 2 processors activated (6676.48 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-12, 2-18, 2-21, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 20.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81
 10 001 01  1    1    0   1   0    1    1    89
 11 001 01  1    1    0   1   0    1    1    91
 12 000 00  1    0    0   0   0    0    0    00
 13 001 01  1    1    0   1   0    1    1    99
 14 001 01  1    1    0   1   0    1    1    A1
 15 000 00  1    0    0   0   0    0    0    00
 16 001 01  1    1    0   1   0    1    1    A9
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ22 -> 0:22
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1684.0925 MHz.
..... host bus clock speed is 99.0113 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 8
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
PCI: PCI BIOS revision 2.10 entry at 0xfb110, last bus=4
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.96 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
PCI->APIC IRQ transform: (B1,I0,P0) -> 22
PCI->APIC IRQ transform: (B3,I1,P0) -> 20
PCI->APIC IRQ transform: (B3,I1,P1) -> 20
PCI->APIC IRQ transform: (B4,I4,P0) -> 16
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
highmem bounce pool size: 64 pages
Journalled Block Device driver loaded
udf: registering filesystem
matroxfb: Matrox G450 detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xEC000000, mapped to 0xf8805000, size 16777216
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010246
EIP is at 0x0
eax: c04b77c8   ebx: f7f9fccc   ecx: c1ada17f   edx: c04b6f40
esi: ffffffff   edi: 00000030   ebp: 00000030   esp: f7f9fc78
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7f9e000 task=f7f9c080)
Stack: c0292c1e c04b6f40 f7f9fccc ffffffff ffffffff 00000000 00000000 00000400 
       00000008 00000001 000000ff 0000000c c04b6f40 00000030 c1a41480 c0292e65 
       c1a41480 c04b6f40 f7f9fccc 00000030 c00bb1c0 00000000 00000108 00000180 
Call Trace:
 [<c0292c1e>] putcs_aligned+0x16e/0x1b0
 [<c0292e65>] accel_putcs+0xc5/0xf0
 [<c02939ce>] fbcon_putcs+0x7e/0x90
 [<c01feb73>] vt_console_print+0x103/0x2b0
 [<c011f616>] __call_console_drivers+0x46/0x60
 [<c011f762>] call_console_drivers+0xc2/0xf0
 [<c011fb23>] release_console_sem+0xa3/0x140
 [<c011f9d8>] printk+0x1d8/0x230
 [<c029367a>] fbcon_set_display+0x33a/0x4c0
 [<c01f8031>] set_inverse_transl+0x41/0xa0
 [<c013ecad>] kmalloc+0xdd/0x190
 [<c010b592>] do_IRQ+0x112/0x1f0
 [<c02930cd>] fbcon_init+0xdd/0xf0
 [<c01fba0f>] visual_init+0x9f/0x100
 [<c01ff3bd>] take_over_console+0xad/0x180
 [<c02981f5>] register_framebuffer+0x175/0x1a0
 [<c029be10>] initMatrox2+0x8e0/0x990
 [<c02d07ad>] pcibios_enable_device+0x1d/0x20
 [<c029c3c2>] matroxfb_probe+0x2c2/0x2f0
 [<c01e320f>] pci_device_probe+0x3f/0x60
 [<c021d4c4>] bus_match+0x34/0x60
 [<c021d594>] driver_attach+0x34/0x60
 [<c021d847>] bus_add_driver+0x97/0xd0
 [<c01e3326>] pci_register_driver+0x46/0x60
 [<c01050fb>] init+0x7b/0x220
 [<c0105080>] init+0x0/0x220
 [<c0107165>] kernel_thread_helper+0x5/0x10

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!
 
--Multipart_Wed__9_Apr_2003_14:45:20_-0700_08327b40--
