Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbTA1HVo>; Tue, 28 Jan 2003 02:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTA1HVo>; Tue, 28 Jan 2003 02:21:44 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:56337 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267330AbTA1HV2>; Tue, 28 Jan 2003 02:21:28 -0500
Date: Tue, 28 Jan 2003 08:30:30 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: SMP instability in 2.4.21-pre3-ac4, oops provided
Message-ID: <20030128073030.GA1032@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing instability in my new system, a dual Intel P3/1400 tualatin
system. memcheck86 runs multiple passes just fine (to be expected, it's
registered ecc ddr memory), and if I boot a non-smp kernel I'm not able
to bring the box down. What does bring the box down after some time
(15-240 minutes) is something with the disks.  If I untar a big file, or
do a backup-rsync with another server, it will sometimes oops. 

I've been lucky enough to catch one (and another one right behind it).
Most often, the system just hangs hard and I have to reach for the
reset-button.
Searching google for 'oops kmem_cache_alloc_batch' doesn't really give
any hints.

Some hints as to how to solve this instability would be appreciated.
Thanks,
Jurriaan

Jan 28 08:09:39 middle kernel:  printing eip:
Jan 28 08:09:39 middle kernel: c013e564
Jan 28 08:09:39 middle kernel: Oops: 0000
Jan 28 08:09:39 middle kernel: CPU:    0
Jan 28 08:09:39 middle kernel: EIP:    0010:[kmem_cache_alloc_batch+132/320]    Not tainted
Jan 28 08:09:39 middle kernel: EFLAGS: 00010012
Jan 28 08:09:39 middle kernel: eax: cfcfcfcf   ebx: cfcfcfcf   ecx: dafee000   edx: c158bee8
Jan 28 08:09:39 middle kernel: esi: 0000007b   edi: 00000002   ebp: d8575e1c   esp: d8575df4
Jan 28 08:09:39 middle kernel: ds: 0018   es: 0018   ss: 0018
Jan 28 08:09:39 middle kernel: Process slrn (pid: 919, stackpage=d8575000)
Jan 28 08:09:39 middle kernel: Stack: 00000001 c0ea65a0 c158bef0 c158bef8 c158bf0c 00000001 c0ea65a0 c158bee8 
Jan 28 08:09:39 middle kernel:        00000246 000000f0 d8575e4c c013f4ab c158bee8 c15b7c00 000000f0 d8575eac 
Jan 28 08:09:39 middle kernel:        c017b12f c0087d60 0000074a 00000000 00000000 00001000 d8575e68 c014db03 
Jan 28 08:09:39 middle kernel: Call Trace:    [__kmem_cache_alloc+91/448] [ext2_get_block+575/784] [get_unused_buffer_head+211/384] [create_buffers+43/352] [create_empty_buffers+38/112]
Jan 28 08:09:39 middle kernel:   [__block_prepare_write+730/752] [block_prepare_write+51/80] [ext2_get_block+0/784] [generic_file_write+1019/1792] [ext2_get_block+0/784] [generic_file_read+154/336]
Jan 28 08:09:39 middle kernel:   [sys_write+150/464] [system_call+51/56]
Jan 28 08:09:39 middle kernel: 
Jan 28 08:09:39 middle kernel: Code: 8b 44 81 18 0f af 5a 18 8b 51 0c 89 41 14 01 d3 40 74 57 8b 
Jan 28 08:09:40 middle kernel:  <1>Unable to handle kernel paging request at virtual address bafee024
Jan 28 08:09:40 middle kernel:  printing eip:
Jan 28 08:09:40 middle kernel: c014db07
Jan 28 08:09:40 middle kernel: Oops: 0002
Jan 28 08:09:40 middle kernel: CPU:    0
Jan 28 08:09:40 middle kernel: EIP:    0010:[get_unused_buffer_head+215/384]    Not tainted
Jan 28 08:09:40 middle kernel: EFLAGS: 00010282
Jan 28 08:09:40 middle kernel: eax: bafee020   ebx: 00000000   ecx: 00000050   edx: bafee020
Jan 28 08:09:40 middle kernel: esi: 00000000   edi: 00001000   ebp: c15a9e28   esp: c15a9e14
Jan 28 08:09:40 middle kernel: ds: 0018   es: 0018   ss: 0018
Jan 28 08:09:40 middle kernel: Process kupdated (pid: 10, stackpage=c15a9000)
Jan 28 08:09:40 middle kernel: Stack: c158bee8 000000f0 df1c9e20 c1427c8c c15a9e50 c15a9e50 c014dc4b 00000000 
Jan 28 08:09:40 middle kernel:        00000000 00000000 c15a9e6c c0152dee c1427c8c 00001000 00001000 c15a9e6c 
Jan 28 08:09:40 middle kernel:        c014f98b c1427c8c 00001000 00000000 dfe7bde0 00000fa7 c15a9e94 c014fb99 
Jan 28 08:09:40 middle kernel: Call Trace:    [create_buffers+43/352] [bdget+110/544] [grow_dev_page+123/208] [grow_buffers+153/272] [getblk+60/96]
Jan 28 08:09:40 middle kernel:   [do_journal_end+1238/2832] [kupdate_one_transaction+192/576] [flush_old_commits+289/432] [ext3:__insmod_ext3_O/lib/modules/2.4.21-pre3-ac4/kernel/fs/ext3/+-28088/96] [reiserfs_write_super+195/224] [ext3:__insmod_ext3_S.text_L52814+51278/64864]
Jan 28 08:09:40 middle kernel:   [sync_supers+326/464] [sync_old_buffers+102/352] [kupdate+423/480] [kupdate+0/480] [rest_init+0/128] [rest_init+0/128]
Jan 28 08:09:40 middle kernel:   [kernel_thread+46/64] [kupdate+0/480]
Jan 28 08:09:40 middle kernel: 
Jan 28 08:09:40 middle kernel: Code: c7 40 04 ff ff ff ff c7 40 28 00 00 00 00 eb a5 8b 4d 08 85 

mounted:

/dev/hda7 on / type ext2 (rw,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda6 on /grub-boot type ext2 (rw,errors=remount-ro)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
/dev/hda8 on /usr type ext2 (rw)
/dev/hda10 on /var type ext3 (rw)
/dev/hda11 on /var/spool type reiserfs (rw)
/dev/hda12 on /vmware type reiserfs (rw)
/dev/hdc1 on /home type reiserfs (rw)
/dev/hdc2 on /var/spool/newszilla type reiserfs (rw)
/dev/hde1 on /space1 type reiserfs (rw)
/dev/hde2 on /space2 type reiserfs (rw)
/dev/hdf1 on /space3 type reiserfs (rw)
/dev/hdf2 on /space4 type reiserfs (rw)
/dev/hda1 on /dos/c type ntfs (ro,noexec,nosuid,nodev,uid=500,gid=500)
/dev/hda5 on /dos/d type vfat (rw,noexec,nosuid,nodev,umask=022,uid=1000,gid=100)

.config:
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID5=m
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=m
CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_MGA=m
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G100A=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_SOUND=y
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_OSS=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=m
CONFIG_USB_STORAGE=m
CONFIG_USB_SCANNER=m
CONFIG_DEBUG_KERNEL=y
CONFIG_FRAME_POINTER=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y

versions: 
Linux middle 2.4.21-pre3-ac4 #1 SMP Tue Jan 28 06:39:48 CET 2003 i686 unknown unknown GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.21
e2fsprogs              1.32
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.4
Modules Loaded         ext3 jbd md w83781d eeprom i2c-proc i2c-isa i2c-viapro i2c-core snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-util-mem snd-pcm snd-timer snd-rawmidi snd-hwdep snd-seq-device snd-ac97-codec snd vfat udf ntfs isofs fat usb-storage scanner usb-uhci usbcore sound mga agpgart loop rtc

lspci:
00:00.0 Host bridge: VIA Technologies, Inc. VT8653 Host Bridge
	Flags: bus master, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: da000000-dcffffff
	Prefetchable memory behind bridge: d8000000-d9ffffff
	Capabilities: [80] Power Management version 2

00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c860 (rev 13)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 9000 [size=256]
	Memory at de000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! Player 5.1
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at 9400 [size=32]
	Capabilities: [dc] Power Management version 1

00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at 9800 [size=8]
	Capabilities: [dc] Power Management version 1

00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 9c00 [size=256]
	Capabilities: [c0] Power Management version 2

00:0f.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 04)
	Subsystem: Triones Technologies, Inc. HPT370A
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 11
	I/O ports at a000 [size=8]
	I/O ports at a400 [size=4]
	I/O ports at a800 [size=8]
	I/O ports at ac00 [size=4]
	I/O ports at b000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at b400 [size=16]
	Capabilities: [c0] Power Management version 2

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at bc00 [size=32]
	Capabilities: [80] Power Management version 2

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at c000 [size=32]
	Capabilities: [80] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 62)
	Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at c400 [size=256]
	Memory at de001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 32Mb SGRAM
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at d8000000 (32-bit, prefetchable) [size=32M]
	Memory at da000000 (32-bit, non-prefetchable) [size=16K]
	Memory at db000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0

dmesg:

Linux version 2.4.21-pre3-ac4 (root@middle) (gcc version 3.2.2 20030124 (Debian prerelease)) #1 SMP Tue Jan 28 06:39:48 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f4f40
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 2
Kernel command line: root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram hdg=scsi apm=power-off
ide_setup: hdg=scsi
Initializing CPU#0
Detected 1415.759 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2824.60 BogoMIPS
Memory: 515352k/524224k available (1587k kernel code, 8484k reserved, 396k data, 308k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) III CPU - S         1400MHz stepping 04
per-CPU timeslice cutoff: 1463.03 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2831.15 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel(R) Pentium(R) III CPU - S         1400MHz stepping 04
Total of 2 processors activated (5655.75 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 23.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  1    1    0   1   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
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
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1415.7166 MHz.
..... host bus clock speed is 134.8300 MHz.
cpu: 0, clocks: 1348300, slice: 449433
CPU0<T0:1348288,T1:898848,D:7,S:449433,C:1348300>
cpu: 1, clocks: 1348300, slice: 449433
CPU1<T0:1348288,T1:449408,D:14,S:449433,C:1348300>
migration_task 0 on cpu=0
migration_task 1 on cpu=1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3101] at 00:00.0
PCI->APIC IRQ transform: (B0,I10,P0) -> 10
PCI->APIC IRQ transform: (B0,I11,P0) -> 11
PCI->APIC IRQ transform: (B0,I14,P0) -> 10
PCI->APIC IRQ transform: (B0,I15,P0) -> 11
PCI->APIC IRQ transform: (B0,I17,P3) -> 10
PCI->APIC IRQ transform: (B0,I17,P3) -> 10
PCI->APIC IRQ transform: (B0,I17,P3) -> 10
PCI->APIC IRQ transform: (B0,I18,P0) -> 5
PCI->APIC IRQ transform: (B1,I0,P0) -> 5
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe (power off active).
Starting kswapd
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xD8000000, mapped to 0xe0805000, size 33554432
Console: switching to colour frame buffer device 133x54
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Software Watchdog Timer: 0.05, timer margin: 60 sec
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
via-rhine.c:v1.10-LK1.1.15  November-22-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xde001000, 00:d0:68:00:5a:8b, IRQ 5.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT370A: IDE controller at PCI slot 00:0f.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 33073H3, ATA DISK drive
hda: DMA disabled
blk: queue c03a42a0, I/O limit 4095Mb (mask 0xffffffff)
hdc: IBM-DTLA-307045, ATA DISK drive
hdc: DMA disabled
blk: queue c03a472c, I/O limit 4095Mb (mask 0xffffffff)
hde: Maxtor 4G120J6, ATA DISK drive
hdf: Maxtor 4G120J6, ATA DISK drive
blk: queue c03a4bb8, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03a4d14, I/O limit 4095Mb (mask 0xffffffff)
hdg: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
hdg: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdg: set_drive_speed_status: error=0x04
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xa000-0xa007,0xa402 on irq 11
ide3 at 0xa800-0xa807,0xac02 on irq 11
hda: host protected area => 1
hda: 60032448 sectors (30737 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
hdc: host protected area => 1
hdc: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hde: host protected area => 1
hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
hdf: host protected area => 1
hdf: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
ide-cd: passing drive hdg to ide-scsi emulation.
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
 hdc:<6> [PTBL] [5606/255/63] hdc1 hdc2
 hde: hde1 hde2
 hdf: hdf1 hdf2
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 10, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c860 detected 
sym53c860-0: rev 0x13 on pci bus 0 device 10 function 0 irq 10
sym53c860-0: ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr3 at scsi1, channel 0, id 0, lun 0
sym53c860-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sym53c860-0-<2,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
sr1: scsi-1 drive
sym53c860-0-<5,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 7)
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 255x/48x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 21845)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 308k freed
Adding Swap: 1574328k swap-space (priority -1)
ide: no cache flush required.
ide: no cache flush required.
Real Time Clock Driver v1.10e
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro 266T chipset
agpgart: AGP aperture is 128M @ 0xd0000000
[drm] AGP 0.99 on VIA Apollo Pro 266T @ 0xd0000000 128MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 06:42:46 Jan 28 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xb800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xbc00, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xc000, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver usbscanner
scanner.c: 0.4.9:USB Scanner Driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NTFS driver v1.1.22 [Flags: R/O MODULE]
udf: registering filesystem
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-viapro.o version 2.6.5 (20020915)
i2c-viapro.o: Found Via VT8233 device
i2c-viapro.o: Via Pro SMBus detected and initialized
i2c-isa.o version 2.6.5 (20020915)
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.7.0 (20021208)
eeprom.o version 2.6.5 (20020915)
w83781d.o version 2.6.5 (20020915)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
ide: no cache flush required.
<snip>
ide: no cache flush required.
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:0b) ...
reiserfs: replayed 5 transactions in 2 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:0c) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 16:01) ...
reiserfs: replayed 13 transactions in 1 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 16:02) ...
reiserfs: replayed 14 transactions in 2 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:41) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:42) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.

-- 
We followed an unlikely star
Never thought we'd get this far
Now we don't know where we are
But hey... we're hanging on...
	Oysterband - I know it's mine
GNU/Linux 2.4.21-pre3-ac4 SMP/ReiserFS 2x2824 bogomips load av: 1.18 1.58 1.07
