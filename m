Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbUDMTYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263577AbUDMTYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:24:42 -0400
Received: from adsl-67-65-232-1.dsl.lgvwtx.swbell.net ([67.65.232.1]:53132
	"HELO rooker.dyndns.org") by vger.kernel.org with SMTP
	id S263602AbUDMTWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:22:31 -0400
Message-ID: <004201c4218c$801f4ed0$6600a8c0@pixl>
From: "Peter Maas" <peter@goquest.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.5-mm5-1 ACCRAID dies under heavy io load
Date: Tue, 13 Apr 2004 14:21:19 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just started testing 2.6.5-mm5-1 today. when i run the benchmark
program iozone it appears to be killing the raid subsystem. On 2.6.5-mm3
this did not occur.

I have this box remote sysloging to another box because the filesystems go
read-only at the time the raid dies
/var/log/messages

#iozone -Ra -i0 -i1

Apr 13 13:53:03 244.69-93-26.reverse.theplanet.com kernel:
aacraid:ID(0:00:0) Abort Time-out. Resetting bus.
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: aacraid:SCSI bus
reset issued on channel 0
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com syslogd:
/var/log/messages: Read-only file system
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel:
aacraid:ID(0:00:0) Abort Time-out. Resetting bus.
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: aacraid:SCSI bus
reset issued on channel 0
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: aacraid: Host
adapter reset request. SCSI hang ?
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: aacraid: SCSI bus
appears hung
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: scsi: Device
offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: scsi: Device
offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: SCSI error : <0 0
0 0> return code = 0x6000000
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: end_request: I/O
error, dev sda, sector 8857175
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: SCSI error : <0 0
0 0> return code = 0x6000000
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: end_request: I/O
error, dev sda, sector 19358548
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda6, logical block 58658
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda6
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda6, logical block 4048
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda6
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda5, logical block 2702
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda5
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: Aborting journal
on device sda5.
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: Aborting journal
on device sda6.
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: EXT3-fs error
(device sda6) in ext3_dirty_inode: IO failure
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: journal commit
I/O error
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda6, logical block 0
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda6
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: ext3_abort
called.
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: EXT3-fs abort
(device sda6): ext3_journal_start: Detected aborted journal
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: Remounting
filesystem read-only
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: EXT3-fs error
(device sda6) in start_transaction: Journal has aborted
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: journal commit
I/O error
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: ext3_abort
called.
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: EXT3-fs abort
(device sda5): ext3_journal_start: Detected aborted journal
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: Remounting
filesystem read-only
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com last message repeated 3
times
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda3, logical block 0
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda3
Apr 13 13:54:20 244.69-93-26.reverse.theplanet.com kernel: EXT2-fs error
(device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group =
0, inode_bitmap = 3
Apr 13 13:54:36 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com last message repeated 3
times
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda5, logical block 1
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda5
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda6, logical block 2261002
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda6
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda6, logical block 15138818
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda6
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda6, logical block 15138820
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda6
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda6, logical block 15138821
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda6
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda5, logical block 4
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda5
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda5, logical block 504
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda5
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda5, logical block 98306
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda5
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda5, logical block 98307
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda5
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: Buffer I/O error
on device sda5, logical block 98308
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: lost page write
due to I/O error on sda5
Apr 13 13:54:53 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:58:24 244.69-93-26.reverse.theplanet.com last message repeated 15
times
Apr 13 13:58:24 244.69-93-26.reverse.theplanet.com kernel: EXT3-fs error
(device sda6) in start_transaction: Journal has aborted
Apr 13 13:58:24 244.69-93-26.reverse.theplanet.com last message repeated 2
times
Apr 13 13:58:24 244.69-93-26.reverse.theplanet.com kernel: scsi0 (0:0):
rejecting I/O to offline device
Apr 13 13:58:47 244.69-93-26.reverse.theplanet.com last message repeated 3
times
Apr 13 13:58:47 244.69-93-26.reverse.theplanet.com kernel: EXT3-fs error
(device sda6) in start_transaction: Journal has aborted
Apr 13 13:58:48 244.69-93-26.reverse.theplanet.com kernel: EXT3-fs error
(device sda6) in start_transaction: Journal has aborted










_____________________________________________
lspci -v

00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
Subsystem: Super Micro Computer Inc: Unknown device 3580
Flags: bus master, fast devsel, latency 0
Capabilities: [40] #09 [1105]

00:00.1 Class ff00: Intel Corp. E7000 Series Host RASUM Controller (rev 01)
Subsystem: Super Micro Computer Inc: Unknown device 3580
Flags: fast devsel

00:02.0 PCI bridge: Intel Corp. E7000 Series Hub Interface B PCI-to-PCI
Bridge (rev 01) (prog-if 00 [Normal decode])
Flags: bus master, 66Mhz, fast devsel, latency 64
Bus: primary=00, secondary=01, subordinate=04, sec-latency=0
I/O behind bridge: 00003000-00004fff
Memory behind bridge: f4100000-f43fffff
Prefetchable memory behind bridge: f8000000-fbffffff

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
(prog-if 00 [UHCI])
Subsystem: Super Micro Computer Inc: Unknown device 3580
Flags: bus master, medium devsel, latency 0, IRQ 153
I/O ports at 2000 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
(prog-if 00 [UHCI])
Subsystem: Super Micro Computer Inc: Unknown device 3580
Flags: bus master, medium devsel, latency 0, IRQ 169
I/O ports at 2020 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
(prog-if 00 [UHCI])
Subsystem: Super Micro Computer Inc: Unknown device 3580
Flags: bus master, medium devsel, latency 0, IRQ 161
I/O ports at 2040 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI
Bridge (rev 42) (prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 0
Bus: primary=00, secondary=05, subordinate=05, sec-latency=64
I/O behind bridge: 00005000-00005fff
Memory behind bridge: f4400000-f5ffffff

00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev
02) (prog-if 8a [Master SecP PriP])
Subsystem: Super Micro Computer Inc: Unknown device 3580
Flags: bus master, medium devsel, latency 0
I/O ports at <ignored>
I/O ports at <ignored>
I/O ports at <ignored>
I/O ports at <ignored>
I/O ports at 2060 [size=16]
Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
Subsystem: Super Micro Computer Inc: Unknown device 3580
Flags: medium devsel
I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20
[IO(X)-APIC])
Subsystem: Super Micro Computer Inc: Unknown device 3580
Flags: bus master, 66Mhz, fast devsel, latency 0
Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [50] PCI-X non-bridge device.

01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
(prog-if 00 [Normal decode])
Flags: bus master, 66Mhz, fast devsel, latency 64
Bus: primary=01, secondary=02, subordinate=03, sec-latency=48
I/O behind bridge: 00003000-00004fff
Memory behind bridge: f4200000-f43fffff
Capabilities: [50] PCI-X non-bridge device.

01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20
[IO(X)-APIC])
Subsystem: Super Micro Computer Inc: Unknown device 3580
Flags: bus master, 66Mhz, fast devsel, latency 0
Memory at f4101000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [50] PCI-X non-bridge device.

01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
(prog-if 00 [Normal decode])
Flags: bus master, 66Mhz, fast devsel, latency 64
Bus: primary=01, secondary=04, subordinate=04, sec-latency=48
Prefetchable memory behind bridge: 00000000f8000000-00000000fbf00000
Capabilities: [50] PCI-X non-bridge device.

02:01.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge (prog-if 00 [Normal
decode])
Flags: bus master, 66Mhz, medium devsel, latency 64
Bus: primary=02, secondary=03, subordinate=03, sec-latency=68
I/O behind bridge: 00004000-00004fff
Memory behind bridge: f4300000-f43fffff
Capabilities: [dc] Power Management version 1

02:03.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller
(Copper) (rev 01)
Subsystem: RLX Technologies: Unknown device 1011
Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 201
Memory at f4200000 (64-bit, non-prefetchable) [size=128K]
I/O ports at 3000 [size=64]
Capabilities: [dc] Power Management version 2
Capabilities: [e4] PCI-X non-bridge device.
Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

02:03.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller
(Copper) (rev 01)
Subsystem: RLX Technologies: Unknown device 1011
Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 209
Memory at f4220000 (64-bit, non-prefetchable) [size=128K]
I/O ports at 3040 [size=64]
Capabilities: [dc] Power Management version 2
Capabilities: [e4] PCI-X non-bridge device.
Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

03:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0d)
Subsystem: Intel Corp. EtherExpress PRO/100 S Dual Port Server Adapter
Flags: bus master, medium devsel, latency 66, IRQ 185
Memory at f4300000 (32-bit, non-prefetchable) [size=4K]
I/O ports at 4000 [size=64]
Memory at f4320000 (32-bit, non-prefetchable) [size=128K]
Capabilities: [dc] Power Management version 2

03:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0d)
Subsystem: Intel Corp. EtherExpress PRO/100 S Dual Port Server Adapter
Flags: bus master, medium devsel, latency 66, IRQ 193
Memory at f4301000 (32-bit, non-prefetchable) [size=4K]
I/O ports at 4040 [size=64]
Memory at f4340000 (32-bit, non-prefetchable) [size=128K]
Capabilities: [dc] Power Management version 2

04:01.0 RAID bus controller: Adaptec AAC-RAID (rev 01)
Subsystem: Adaptec 2120S (Crusader)
Flags: bus master, fast Back2Back, 66Mhz, slow devsel, latency 64, IRQ 177
Memory at f8000000 (32-bit, prefetchable) [size=64M]
Expansion ROM at <unassigned> [disabled] [size=64K]
Capabilities: [80] Power Management version 2

05:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
Subsystem: ATI Technologies Inc Rage XL
Flags: bus master, stepping, medium devsel, latency 64, IRQ 153
Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
I/O ports at 5000 [size=256]
Memory at f4400000 (32-bit, non-prefetchable) [size=4K]
Expansion ROM at <unassigned> [disabled] [size=128K]
Capabilities: [5c] Power Management version 2
__________________________________________________________________
kernel .config (2.6.5-mm5-1)

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=15
# CONFIG_HOTPLUG is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=4
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_USE_VECTOR=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#

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
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_CARMEL is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_REPORT_LUNS=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
CONFIG_SCSI_AACRAID=y
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=m
# CONFIG_E100_NAPI is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

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
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I8XX_TCO is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=y

#
# I2C support
#
# CONFIG_I2C is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

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
CONFIG_NLS_CODEPAGE_437=y
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
CONFIG_NLS_ISO8859_1=y
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
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_LOCKMETER is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_FRAME_POINTER is not set
CONFIG_4KSTACKS=y
CONFIG_SCHEDSTATS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y
____________________________________________________________________________
______________________________

dmesg

Linux version 2.6.5-mm5 (root@tcdynamic02) (gcc version 3.2.3 20030502 (Red
Hat Linux 3.2.3-24)) #1 SMP Tue Apr 13 12:39:33 CDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
 BIOS-e820: 000000007fef0000 - 000000007fef8000 (ACPI data)
 BIOS-e820: 000000007fef8000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 000000007ff80000 (usable)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7190
On node 0 totalpages: 524160
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294784 pages, LIFO batch:16
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f71f0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x7fef4510
ACPI: FADT (v001 INTEL  K_CANYON 0x06040000 PTL  0x00000008) @ 0x7fef7e78
ACPI: MADT (v001 PTLTD  APIC   0x06040000  LTP 0x00000000) @ 0x7fef7eec
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x7fef7f88
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x7fef7fb0
ACPI: DSDT (v001  INTEL   PLUMAS 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: Kings Canyon APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80400.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Processors: 4
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/sda6 console=tty0 console=ttyS0,38400
idebus=66
ide_setup: idebus=66
CPU 0 irqstacks, hard=c0365000 soft=c0361000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2799.941 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 2076016k/2096640k available (1514k kernel code, 19420k reserved,
568k data, 328k init, 1179072k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5521.40 BogoMIPS
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
per-CPU timeslice cutoff: 1463.17 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c0366000 soft=c0362000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5586.94 BogoMIPS
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 2/6 eip 2000
CPU 2 irqstacks, hard=c0367000 soft=c0363000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5586.94 BogoMIPS
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU#2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 3/7 eip 2000
CPU 3 irqstacks, hard=c0368000 soft=c0364000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5586.94 BogoMIPS
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU#3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Total of 4 processors activated (22282.24 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-17, 2-20, 2-21, 2-22, 2-23, 3-1,
3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15,
3-16, 3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3-23, 4-2, 4-3, 4-4, 4-5, 4-8,
4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21,
4-22, 4-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 23.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 24.
number of IO-APIC #4 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02008000
.......    : physical APIC id: 02
.......    : Delivery Type: 1
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    79
 0d 001 01  0    0    0   0   0    1    1    81
 0e 001 01  0    0    0   0   0    1    1    89
 0f 001 01  0    0    0   0   0    1    1    91
 10 001 01  1    1    0   1   0    1    1    99
 11 000 00  1    0    0   0   0    0    0    00
 12 001 01  1    1    0   1   0    1    1    A1
 13 001 01  1    1    0   1   0    1    1    A9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 03000000
.......     : arbitration: 03
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 001 01  1    1    0   1   0    1    1    B1
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 04000000
.......     : arbitration: 04
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 001 01  1    1    0   1   0    1    1    B9
 01 001 01  1    1    0   1   0    1    1    C1
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  1    1    0   1   0    1    1    C9
 07 001 01  1    1    0   1   0    1    1    D1
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ24 -> 1:0
IRQ48 -> 2:0
IRQ49 -> 2:1
IRQ54 -> 2:6
IRQ55 -> 2:7
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2798.0762 MHz.
..... host bus clock speed is 133.0274 MHz.
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
CPU0:  online
 domain 0: span 3
  groups: 1 2
  domain 1: span f
   groups: 3 c
CPU1:  online
 domain 0: span 3
  groups: 2 1
  domain 1: span f
   groups: 3 c
CPU2:  online
 domain 0: span c
  groups: 4 8
  domain 1: span f
   groups: c 3
CPU3:  online
 domain 0: span c
  groups: 8 4
  domain 1: span f
   groups: c 3
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8c5, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 10 [IRQ]
PCI: Discovered primary peer bus 11 [IRQ]
PCI: Discovered primary peer bus 12 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/2480] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 153
PCI->APIC IRQ transform: (B0,I29,P1) -> 169
PCI->APIC IRQ transform: (B0,I29,P2) -> 161
PCI->APIC IRQ transform: (B2,I3,P0) -> 201
PCI->APIC IRQ transform: (B2,I3,P1) -> 209
PCI->APIC IRQ transform: (B3,I4,P0) -> 185
PCI->APIC IRQ transform: (B3,I5,P0) -> 193
PCI->APIC IRQ transform: (B4,I1,P0) -> 177
PCI->APIC IRQ transform: (B5,I1,P0) -> 153
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
Starting balanced_irq
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec
(nowayout= 0)
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60
seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
ICH3: IDE controller at PCI slot 0000:00:1f.1
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2060-0x2067, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2068-0x206f, BIOS settings: hdc:pio, hdd:pio
hdc: CD-232E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Red Hat/Adaptec aacraid driver (1.1.2-lk1 Apr 13 2004)
AAC0: kernel 4.0.4 build 6008
AAC0: monitor 4.0.4 build 6008
AAC0: bios 4.0.0 build 6008
AAC0: serial b9198ffafaf001
scsi0 : aacraid
  Vendor: ADAPTEC   Model: Adaptec Mirror    Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
aacraid:        NMI ISR: NMI_PRIMARY_ATU_ERROR
SCSI device sda: 143552512 512-byte hdwr sectors (73499 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 328k freed
EXT3 FS on sda6, internal journal
Adding 2097136k swap on /dev/sda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT2-fs warning (device sda3): ext2_fill_super: mounting ext3 filesystem as
ext2

kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

