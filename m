Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVBHE2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVBHE2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 23:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVBHE2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 23:28:34 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:8720 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261463AbVBHE2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 23:28:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=HtEK9ssqX+mIZF0+VbWgY6Z5U86do1Z1ZkcHrOaL2CB3CnPU+IOTG0f+N3E6giYWog1m0gV6rRq7wt0hm2ttkcH9cFVb4rVXdfy4Ts8t8+zICABF9b1Icanqg+9eGvBqvw0mEaSmL17tHgkTaXKllPveuKivaN8lf0iaxuhD640=
Message-ID: <9e3f248805020720287bd0ca55@mail.gmail.com>
Date: Tue, 8 Feb 2005 09:58:05 +0530
From: Vishwas Pai <vishwaspai@gmail.com>
Reply-To: Vishwas Pai <vishwaspai@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic while executing init. (2.6.11-rc3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel panic'ed while booting (on HP rx5670 - 2 CPU) the kernel
2.6.11-rc3, configured
and compiled with zx1_defconfig target.

I want follow the below given steps to understand and debug the problem. Please
correct me if they are not the correct way of attacking problems of this kind.

1. Disassemble "create_elf_tables" from vmlinux
2. Locate the code. with the help of IP offset available in the panic dump.
3. Use the register values to see what might have gone wrong.

I am not sure how I will be able to do the following.

1. How get the kernel data structure values at the time of panic ?
2. How to know what fault has caused the problem (data page fault,
    instruction fault etc.) ?

-- vishwas

ELILO boot: test2611rc3
Uncompressing Linux... done
Linux version 2.6.11-rc3 (paivi@spr96148) (gcc version 3.2.3 20030502
(Red Hat Linux 3.2.3-42)) #1 SMP Mon Feb 7 12:37:59 IST 2005
EFI v1.10 by HP: SALsystab=0x3ff88000 ACPI 2.0=0x3fdf6000
SMBIOS=0x3ff8a000 HCDP=0x3fdf5000
PCDP: v0 at 0x3fdf5000
Early serial console at MMIO 0x80006000 (options '9600n8')
warning: skipping physical page 0
SAL 0.20: INTEL   MSL     REF     SAL      version 2.0
SAL: AP wakeup using external interrupt vector 0xff
ACPI: Local APIC address c0000000fee00000
GSI 20 (level, low) -> CPU 0 (0x0000) vector 48
2 CPUs available, 2 CPUs total
MCA related initialization done
Virtual mem_map starts at 0xa0007fffc7200000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=scsi2:EFI\redhat\vmlinuz-2611rc3 
root=/dev/sdb3 ro
PID hash table entries: 4096 (order: 12, 131072 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 9, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 8, 4194304 bytes)
Memory: 6236480k/6284976k available (8001k code, 48160k reserved,
3681k data, 272k init)
Leaving McKinley Errata 9 workaround enabled
Mount-cache hash table entries: 1024 (order: 0, 16384 bytes)
Boot processor id 0x0/0x0
task migration cache decay timeout: 10 msecs.
CPU 1: synchronized ITC with CPU 0 (last diff 0 cycles, maxerr 435 cycles)
Brought up 2 CPUs
Total of 2 processors activated (2694.04 BogoMIPS).
NET: Registered protocol family 16
ACPI: Subsystem revision 20050125
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Root Bridge [PCI1] (00:20)
ACPI: PCI Root Bridge [PCI2] (00:40)
ACPI: PCI Root Bridge [PCI3] (00:60)
ACPI: PCI Root Bridge [PCI4] (00:80)
ACPI: PCI Root Bridge [PCI5] (00:a0)
ACPI: PCI Root Bridge [PCI6] (00:c0)
ACPI: PCI Root Bridge [PCI7] (00:e0)
SCSI subsystem initialized
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
IOC: zx1 2.3 HPA 0xfed01000 IOVA space 1024Mb at 0x40000000
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Thermal Zone [THM0] (27 C)
EFI Time Services Driver v0.4
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
GSI 16 (level, low) -> CPU 1 (0x0100) vector 49
ACPI: PCI interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 49
ttyS0 at MMIO 0x80007000 (irq = 49) is a 16550A
ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 16 (level, low) -> IRQ 49
ttyS1 at MMIO 0x80006000 (irq = 49) is a 16550A
ttyS2 at MMIO 0x80006010 (irq = 49) is a 16550A
ttyS3 at MMIO 0x80006038 (irq = 49) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2
Copyright (c) 1999-2004 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
tg3.c:v3.19 (January 26, 2005)
GSI 27 (level, low) -> CPU 0 (0x0000) vector 50
ACPI: PCI interrupt 0000:21:04.0[A] -> GSI 27 (level, low) -> IRQ 50
eth0: Tigon3 [partno(A6794-60001) rev 0105 PHY(5701)]
(PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:30:6e:49:1f:a2
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0]
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
GSI 17 (level, low) -> CPU 1 (0x0100) vector 51
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 17 (level, low) -> IRQ 51
sym0: <896> rev 0x7 at pci 0000:00:02.0 irq 51
sym0: No NVRAM, ID 7, Fast-40, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18n
  Vendor: HP 36.4G  Model: ST336753LC        Rev: HPC3
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
 target0:0:0: Beginning Domain Validation
sym0:0: wide asynchronous.
sym0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 31)
 target0:0:0: Ending Domain Validation
GSI 18 (level, low) -> CPU 0 (0x0000) vector 52
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 18 (level, low) -> IRQ 52
sym1: <896> rev 0x7 at pci 0000:00:02.1 irq 52
sym1: No NVRAM, ID 7, Fast-40, SE, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.1.18n
  Vendor: HP        Model: DVD-ROM 305       Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:3: Beginning Domain Validation
 target1:0:3: Domain Validation skipping write tests
sym1:3: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 16)
 target1:0:3: Ending Domain Validation
GSI 28 (level, low) -> CPU 1 (0x0100) vector 53
ACPI: PCI interrupt 0000:21:01.0[A] -> GSI 28 (level, low) -> IRQ 53
sym2: <1010-66> rev 0x1 at pci 0000:21:01.0 irq 53
sym2: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym2: open drain IRQ line driver, using on-chip SRAM
sym2: using LOAD/STORE-based firmware.
sym2: handling phase mismatch from SCRIPTS.
sym2: SCSI BUS has been reset.
scsi2 : sym-2.1.18n
GSI 29 (level, low) -> CPU 0 (0x0000) vector 54
ACPI: PCI interrupt 0000:21:01.1[B] -> GSI 29 (level, low) -> IRQ 54
sym3: <1010-66> rev 0x1 at pci 0000:21:01.1 irq 54
sym3: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym3: open drain IRQ line driver, using on-chip SRAM
sym3: using LOAD/STORE-based firmware.
sym3: handling phase mismatch from SCRIPTS.
sym3: SCSI BUS has been reset.
scsi3 : sym-2.1.18n
  Vendor: HP 36.4G  Model: ST336752LC        Rev: HP02
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym3:0:0: tagged command queuing enabled, command queue depth 16.
 target3:0:0: Beginning Domain Validation
sym3:0: wide asynchronous.
sym3:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 31)
 target3:0:0: Ending Domain Validation
st: Version 20041025, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.3
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi3, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg2 at scsi3, channel 0, id 0, lun 0,  type 0
Fusion MPT base driver 3.01.18
Copyright (c) 1999-2004 LSI Logic Corporation
Fusion MPT SCSI Host driver 3.01.18
USB Universal Host Controller Interface driver v2.2
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
EFI Variables Facility v0.08 2004-May-17
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13
09:39:32 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 131072 buckets, 2048Kbytes
TCP established hash table entries: 4194304 (order: 12, 67108864 bytes)
TCP bind hash table entries: 65536 (order: 6, 1048576 bytes)
TCP: Hash tables configured (established 4194304 bind 65536)
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
Adding console on ttyS1 at MMIO 0x80006000 (options '9600n8')
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 272kB freed
t[1]: IA-64 Illegal operation fault 0 [1]
Modules linked in:

Pid: 1, CPU 0, comm:                 init
psr : 0000101008026018 ifs : 8000000000000710 ip  :
[<a000000100189220>]    Not tainted
ip is at create_elf_tables+0x3c0/0x800
unat: 0000000000000000 pfs : 0000000000000000 rsc : 0000000000000000
rnat: 0000000000000000 bsps: e000000000010e30 pr  : 000000000000641b
ldrs: 0000000000880000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010000a640 b6  : 0000000000000000 b7  : 0000000000000000
f6  : 000000000000000000000 f7  : 000000000000000000000
f8  : 000000000000000000000 f9  : 000000000000000000000
f10 : 000000000000000000000 f11 : 000000000000000000000
r1  : a000000100d4ce00 r2  : e000000000017d10 r3  : 0000000000000308
r8  : 0000000000000000 r9  : 0000000000000000 r10 : 0000000000000000
r11 : 0000000000000000 r12 : 60000fffffffbe40 r13 : e000000000010000
r14 : 0000000000000000 r15 : 0000000000000409 r16 : e000000000010e30
r17 : ffffffffffffffc1 r18 : 0000000000000040 r19 : 0000000000000000
r20 : 0009804c0270033f r21 : a000000100009290 r22 : 0000000000000000
r23 : 60000fff7fffc000 r24 : 0000000000000000 r25 : 0000000000000000
r26 : 0000000000000186 r27 : 000000000000000f r28 : 2000000000002cc0
r29 : 00001013085a6000 r30 : 0000000000000003 r31 : 0000000000005541

Call Trace:
 [<a00000010000f5e0>] show_stack+0x80/0xa0
                                sp=e000000000017b30 bsp=e000000000010f28
 [<a00000010000fec0>] show_regs+0x860/0x880
                                sp=e000000000017d00 bsp=e000000000010ec8
 [<a000000100034f30>] die+0x170/0x200
                                sp=e000000000017d10 bsp=e000000000010e90
 [<a000000100035000>] die_if_kernel+0x40/0x60
                                sp=e000000000017d10 bsp=e000000000010e68
 [<a000000100035a40>] ia64_illegal_op_fault+0x60/0x140
                                sp=e000000000017d10 bsp=e000000000010e48
 [<a000000100003f20>] dispatch_illegal_op_fault+0x300/0x800
                                sp=e000000000017e30 bsp=e000000000010e48
 <0>Kernel panic - not syncing: Attempted to kill init!
