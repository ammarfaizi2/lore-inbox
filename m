Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131820AbQKJVeS>; Fri, 10 Nov 2000 16:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131733AbQKJVeI>; Fri, 10 Nov 2000 16:34:08 -0500
Received: from PTP283.UNI-MUENSTER.DE ([128.176.197.201]:930 "EHLO
	pt2037.uni-muenster.de") by vger.kernel.org with ESMTP
	id <S131792AbQKJVd5>; Fri, 10 Nov 2000 16:33:57 -0500
From: Bernd Nottelmann <nottelm@uni-muenster.de>
Organization: Universitaet Muenster
Date: Fri, 10 Nov 2000 22:34:19 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: reiserfs-list@namesys.com.nottelm@uni-muenster.de
Subject: Oops with 2.4.0-test10 during ripping an audio cd with cdda2wav
MIME-Version: 1.0
Message-Id: <00111022341900.16665@pt2037>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not sure, if this is a reiserfs related issue, so I send this Oops 
report both to the kernel mailing list and to the reiserfs people
(kernel has been patched with reiserfs-3.6.18).

During ripping the last song from a cd (a long time song of 9.50 min)
I was wondering about the time consumption of this process.
After the cdda2wav process had been finished I found the following
oops:


---------------------- starts here ---------------------- 
ksymoops 2.3.5 on i686 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at slab.c:1542!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012b8b0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b   ebx: 00000b00   ecx: 0000001f   edx: 00000002
esi: ffffc8e0   edi: fffffffa   ebp: 00040bce   esp: c5c819e0
ds: 0018   es: 0018   ss: 0018
Process cdda2wav (pid: 16228, stackpage=c5c81000)
Stack: c022dbe5 c022dc65 00000606 00000b00 ffffc8e0 fffffffa 00040bce 
c5c80000 
       c01e0806 ffffc8e0 00000007 0000530e 080701d0 0000530e 080701d0 
cfae0c00 
       c5c81aec 00000000 c017486a c01748d1 00000000 c5c81efc c0181721 
00004980 
Call Trace: [<c022dbe5>] [<c022dc65>] [<c01e0806>] [<c017486a>] [<c01748d1>] 
[<c0181721>] [<c01a2b3a>] 
       [<c01e84a0>] [<c01e8657>] [<c01ea345>] [<c010cb35>] [<c01dfef2>] 
[<c0168850>] [<c01601f1>] [<c01e6d94>] 
       [<c0172870>] [<c01ea217>] [<c01a2502>] [<c01a8f51>] [<c01ad036>] 
[<c01acf30>] [<c01aa77c>] [<c01acf30>] 
       [<c010c911>] [<c0117db7>] [<c0114eba>] [<c0114f7d>] [<c0115267>] 
[<c0140e7b>] [<c01acf30>] [<d0914c00>] 
       [<c020c034>] [<c020c3a2>] [<c01f30df>] [<c01f3040>] [<c0140ee2>] 
[<d0914c00>] [<c020c034>] [<c020c3a2>] 
       [<c01f30df>] [<c01f3040>] [<c01e6d94>] [<c01f2cb8>] [<c01f3040>] 
[<c01f3322>] [<c01f3158>] [<c01e6d94>] 
       [<c0117db7>] [<c013c6cc>] [<c013a4cc>] [<c01413c7>] [<c010b197>] 
Code: 0f 0b 83 c4 0c 31 c0 5b 5e 5f 5d 59 c3 8d 76 00 83 ec 04 57 

>>EIP; c012b8b0 <kmalloc+100/110>   <=====
Trace; c022dbe5 <tvecs+161d/ba58>
Trace; c022dc65 <tvecs+169d/ba58>
Trace; c01e0806 <mmc_ioctl+2e6/d58>
Trace; c017486a <get_cnode+1e/90>
Trace; c01748d1 <get_cnode+85/90>
Trace; c0181721 <end_that_request_first+61/b8>
Trace; c01a2b3a <tulip_interrupt+5b2/6d8>
Trace; c01e84a0 <kfree_skbmem+28/84>
Trace; c01e8657 <__kfree_skb+15b/164>
Trace; c01ea345 <net_tx_action+59/110>
Trace; c010cb35 <do_IRQ+e5/f4>
Trace; c01dfef2 <cdrom_ioctl+87e/e00>
Trace; c0168850 <reiserfs_kfree+14/38>
Trace; c01601f1 <do_balance+ed/fc>
Trace; c01e6d94 <nf_hook_slow+7c/b8>
Trace; c0172870 <reiserfs_insert_item+98/100>
Trace; c01ea217 <netif_rx+bb/128>
Trace; c01a2502 <tulip_rx+2d6/35c>
Trace; c01a8f51 <ide_set_handler+65/78>
Trace; c01ad036 <write_intr+106/128>
Trace; c01acf30 <write_intr+0/128>
Trace; c01aa77c <ide_intr+128/194>
Trace; c01acf30 <write_intr+0/128>
Trace; c010c911 <handle_IRQ_event+4d/78>
Trace; c0117db7 <reschedule_idle+20f/218>
Trace; c0114eba <deliver_signal+4a/88>
Trace; c0114f7d <send_sig_info+85/b0>
Trace; c0115267 <send_sig+1b/20>
Trace; c0140e7b <send_sigio_to_task+d3/e0>
Trace; c01acf30 <write_intr+0/128>
Trace; d0914c00 <[ipchains]ip_conntrack_protocol_udp+0/40>
Trace; c020c034 <udp_queue_rcv_skb+68/e0>
Trace; c020c3a2 <udp_rcv+14a/27c>
Trace; c01f30df <ip_local_deliver_finish+9f/118>
Trace; c01f3040 <ip_local_deliver_finish+0/118>
Trace; c0140ee2 <send_sigio+5a/a4>
Trace; d0914c00 <[ipchains]ip_conntrack_protocol_udp+0/40>
Trace; c020c034 <udp_queue_rcv_skb+68/e0>
Trace; c020c3a2 <udp_rcv+14a/27c>
Trace; c01f30df <ip_local_deliver_finish+9f/118>
Trace; c01f3040 <ip_local_deliver_finish+0/118>
Trace; c01e6d94 <nf_hook_slow+7c/b8>
Trace; c01f2cb8 <ip_local_deliver+15c/164>
Trace; c01f3040 <ip_local_deliver_finish+0/118>
Trace; c01f3322 <ip_rcv_finish+1ca/218>
Trace; c01f3158 <ip_rcv_finish+0/218>
Trace; c01e6d94 <nf_hook_slow+7c/b8>
Trace; c0117db7 <reschedule_idle+20f/218>
Trace; c013c6cc <pipe_write+230/2ac>
Trace; c013a4cc <blkdev_ioctl+28/34>
Trace; c01413c7 <sys_ioctl+1bb/214>
Trace; c010b197 <system_call+33/38>
Code;  c012b8b0 <kmalloc+100/110>
00000000 <_EIP>:
Code;  c012b8b0 <kmalloc+100/110>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012b8b2 <kmalloc+102/110>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012b8b5 <kmalloc+105/110>
   5:   31 c0                     xor    %eax,%eax
Code;  c012b8b7 <kmalloc+107/110>
   7:   5b                        pop    %ebx
Code;  c012b8b8 <kmalloc+108/110>
   8:   5e                        pop    %esi
Code;  c012b8b9 <kmalloc+109/110>
   9:   5f                        pop    %edi
Code;  c012b8ba <kmalloc+10a/110>
   a:   5d                        pop    %ebp
Code;  c012b8bb <kmalloc+10b/110>
   b:   59                        pop    %ecx
Code;  c012b8bc <kmalloc+10c/110>
   c:   c3                        ret    
Code;  c012b8bd <kmalloc+10d/110>
   d:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c012b8c0 <kmem_cache_free+0/88>
  10:   83 ec 04                  sub    $0x4,%esp
Code;  c012b8c3 <kmem_cache_free+3/88>
  13:   57                        push   %edi


1 warning issued.  Results may not be reliable.
---------------------- ends here ---------------------- 

The oops should have been emitted by the BUG() in
void * kmalloc (size_t size, int flags) in linux/mm/slab.c.

cdda2wav (version 1.9) was called with the following options (I think this 
options are correct, but I am not really sure, because it was called by grip)

-D1,0,0 -x -H -t9 -O wav

the .wav-file has been written to the reiserfs partition (ide-disk,
without DMA).
The cdrom drive is a Ricoh MP9060A, up to now there never
occured any problems with that. The ide-scsi driver has not been
compiled as a module, it is tightly integrated into the kernel as
well as the generic scsi support (sg).

(Maybe I should mention that the kernel has been compiled with
gcc-2.95.2, but I think, it is not very important.)

For the sake of completeness I append my .config at the end of this mail
(all lines with "is not set" removed)

My hardware:
Soyo SMP board SY-D6IBA
(from lspci:)
Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 02)
IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
SCSI storage controller: Adaptec AIC-7880U (rev 01)
Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip] (rev 
24)
Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
Input device controller: Creative Labs SB Live! (rev 08)
VGA compatible controller: nVidia Corporation Riva TnT2 Ultra [NV5] (rev 
11)
256 MB RAM

  Bernd

---------------------- snip here ---------------------- 
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_RTC_IS_GMT=y

#
# Memory Technology Devices (MTD)
#

#
# Parallel port support
#
CONFIG_PARPORT=m

#
# Plug and Play configuration
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m

#
# Parallel IDE protocol modules
#
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096

#
# Multi-device support (RAID and LVM)
#

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=m
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y

#
#  
#
CONFIG_IPX=m
CONFIG_IPX_INTERN=y

#
# QoS and/or fair queueing
#

#
# Telephony Support
#

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y

#
# SCSI low-level drivers
#
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY=10
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m

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

#
# ARCnet devices
#
CONFIG_DUMMY=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y

#
# Ethernet (1000 Mbit)
#
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y

#
# Wireless LAN (non-hamradio)
#

#
# Token Ring devices
#

#
# Wan interfaces
#

#
# Amateur Radio support
#

#
# IrDA (infrared) support
#

#
# ISDN subsystem
#

#
# Old CD-ROM drivers (not SCSI, not IDE)
#

#
# Input core support
#

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m

#
# I2C support
#

#
# Mice
#
CONFIG_MOUSE=y

#
# Joysticks
#

#
# Game port support
#

#
# Gameport joysticks
#

#
# Serial port support
#

#
# Serial port joysticks
#

#
# Parallel port joysticks
#

#
# Watchdog Cards
#
CONFIG_NVRAM=m
CONFIG_RTC=y

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_INTEL=y

#
# Multimedia devices
#

#
# File systems
#
CONFIG_AUTOFS_FS=m
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_JFFS_FS_VERBOSE=0
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m

#
# Partition Types
#
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_15=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Frame-buffer support
#

#
# Sound
#
CONFIG_SOUND=m
CONFIG_SOUND_EMU10K1=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m

#
# USB support
#
CONFIG_USB=m

#
# Miscellaneous USB options
#

#
# USB Controllers
#

#
# USB Devices
#

#
# USB Human Interface Devices (HID)
#

#
#   Input core support is needed for USB HID
#

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
