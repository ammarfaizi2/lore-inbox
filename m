Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSL1Ca1>; Fri, 27 Dec 2002 21:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbSL1Ca1>; Fri, 27 Dec 2002 21:30:27 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:63438 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265385AbSL1CaH>; Fri, 27 Dec 2002 21:30:07 -0500
Message-ID: <3E0D1159.10101@kegel.com>
Date: Fri, 27 Dec 2002 18:50:01 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at slab.c:815! in 2.4.17: jbd initialized twice?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled-in modules are only supposed to get initialized
once, right?
Was there some bug fixed after 2.4.17 that caused
compiled-in modules to get initialized twice?

[1.] One line summary of the problem:
"kernel BUG at slab.c:815!" during boot.  Boot fails.

[2.] Full description of the problem/report:
100% reproducible crash on boot with 2.4.17.
(Probably old news, but I felt like tracking it down since
it bit me, and there was no obvious resolution posted on lkml.)

Looks like the revoke_record cache got created twice
because fs/jdb got initialized twice.  Config file had
CONFIG_JBD=y

[4.] Kernel version (from /proc/version):
2.4.17 from kernel.org

[5.] Output of Oops.. message

Here's the boot log captured via null modem,
after adding the print suggested by Andrew Morton last year
when somebody else ran into this same BUG message,
http://marc.theaimsgroup.com/?l=linux-kernel&m=100889399223438&w=2
I also added a printk at the top of journal_init_revoke_caches.

Note that the message 'Journalled Block Device driver loaded'
occurs twice!  (The printk at the top of journal_init_revoke_caches
only occurs the first time, though, which is strange.)

  Linux version 2.4.17 (root@dual) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #25 SMP Fri 
Dec 27 17:59:43 PST 2002
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000019ffd000 (usable)
  BIOS-e820: 0000000019ffd000 - 0000000019fff000 (ACPI data)
  BIOS-e820: 0000000019fff000 - 000000001a000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f6e80
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 106493
zone(0): 4096 pages.
zone(1): 102397 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
     Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: ro root=LABEL=/1 console=ttyS0,57600 console=tty0 nosmp
Initializing CPU#0
Detected 651.490 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1300.88 BogoMIPS
Memory: 416308k/425972k available (1325k kernel code, 9280k reserved, 378k data, 252k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.72 usecs.
SMP mode deactivated, forcing use of dummy APIC emulation.
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded           <------ #1 -------<
journal_init_revoke_caches
Detected PS/2 Mouse Port.
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD205BA, ATA DISK drive
hdc: SONY CD-ROM CDU4821, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=2495/255/63, UDMA(33)
ide-floppy driver 0.97.sv
Partition check:
  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 > hda3
  hda3: <solaris: [s0] hda11 [s1] hda12 [s2] hda13 [s7] hda14 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 201k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
i91u: PCI Base=0xA800, IRQ=10, BIOS=0xFF000, SCSI ID=7
i91u: Reset SCSI Bus ...
scsi0 : Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g
   Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0f
   Type:   CD-ROM                             ANSI SCSI revision: 02
Journalled Block Device driver loaded    <------ #2  -------<
kmem_cache_create: revoke_record
kernel BUG at slab.c:816!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131f69>]    Not tainted
EFLAGS: 00010282
eax: 0000001a   ebx: d9fefc7c   ecx: c0292d58   edx: 000017fe
esi: da83bf22   edi: da83bf30   ebp: c1696430   esp: d9fdbed4
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 13, stackpage=d9fdb000)
Stack: c025a4f0 00000330 c025a50e da83bf22 ffffffe0 00000000 ffffffea 00000000
        00000000 da834000 da838e27 da83bf22 00000020 00000020 00022000 00000000
        00000000 da83b3d5 da83b410 da83df20 ffffffea c011c543 00000000 400475a7
Call Trace: [<da83bf22>] [<da838e27>] [<da83bf22>] [<da83b3d5>] [<da83b410>]
    [<da83df20>] [<c011c543>] [<da834060>] [<c01074a3>]


The output of ksymoops isn't that interesting - it doesn't seem to
have a useful backtrace.  Here's one from a previous run:

ksymoops 2.4.5 on i686 2.4.18-14smp.  Options used
      -v /usr/src/linux/vmlinux (specified)
      -K (specified)
      -L (specified)
      -o /lib/modules/2.4.17 (specified)
      -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
kernel BUG at slab.c:816!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131f69>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001a   ebx: d9fbac7c   ecx: c0292d38   edx: 000017e0
esi: da83bf22   edi: da83bf30   ebp: c1697430   esp: d9fdbed4
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 13, stackpage=d9fdb000)
Stack: c025a4f0 00000330 c025a50e da83bf22 ffffffe0 00000000 ffffffea 00000000
        00000000 da834000 da838e27 da83bf22 00000020 00000020 00022000 00000000
        00000000 da83b3d5 da83b410 da83df20 ffffffea c011c543 00000000 400475a7
Call Trace: [<da83bf22>] [<da838e27>] [<da83bf22>] [<da83b3d5>] [<da83b410>]
    [<da83df20>] [<c011c543>] [<da834060>] [<c01074a3>]
Code: 0f 0b 83 c4 10 eb 9b 55 e8 5a 0a 00 00 5f e9 4f ff ff ff 6a


 >>EIP; c0131f69 <kmem_cache_create+359/400>   <=====

 >>ebx; d9fbac7c <END_OF_CODE+19c6c0d0/????>
 >>ecx; c0292d38 <console_sem+0/14>
 >>edx; 000017e0 Before first symbol
 >>esi; da83bf22 <END_OF_CODE+1a4ed376/????>
 >>edi; da83bf30 <END_OF_CODE+1a4ed384/????>
 >>ebp; c1697430 <END_OF_CODE+1348884/????>
 >>esp; d9fdbed4 <END_OF_CODE+19c8d328/????>

Trace; da83bf22 <END_OF_CODE+1a4ed376/????>
Trace; da838e27 <END_OF_CODE+1a4ea27b/????>
Trace; da83bf22 <END_OF_CODE+1a4ed376/????>
Trace; da83b3d5 <END_OF_CODE+1a4ec829/????>
Trace; da83b410 <END_OF_CODE+1a4ec864/????>
Trace; da83df20 <END_OF_CODE+1a4ef374/????>
Trace; c011c543 <sys_init_module+4f3/640>
Trace; da834060 <END_OF_CODE+1a4e54b4/????>
Trace; c01074a3 <system_call+33/40>

Code;  c0131f69 <kmem_cache_create+359/400>
00000000 <_EIP>:
Code;  c0131f69 <kmem_cache_create+359/400>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c0131f6b <kmem_cache_create+35b/400>
    2:   83 c4 10                  add    $0x10,%esp
Code;  c0131f6e <kmem_cache_create+35e/400>
    5:   eb 9b                     jmp    ffffffa2 <_EIP+0xffffffa2>
Code;  c0131f70 <kmem_cache_create+360/400>
    7:   55                        push   %ebp
Code;  c0131f71 <kmem_cache_create+361/400>
    8:   e8 5a 0a 00 00            call   a67 <_EIP+0xa67>
Code;  c0131f76 <kmem_cache_create+366/400>
    d:   5f                        pop    %edi
Code;  c0131f77 <kmem_cache_create+367/400>
    e:   e9 4f ff ff ff            jmp    ffffff62 <_EIP+0xffffff62>
Code;  c0131f7c <kmem_cache_create+36c/400>
   13:   6a 00                     push   $0x0

[7.] Environment
redhat 8.0, but with 2.4.17 vanilla kernel

[7.1.] Software (add the output of the ver_linux script here)

(after booting into redhat 8.0 and its normal kernel)
Linux dual 2.4.18-14smp #1 SMP Wed Sep 4 12:34:47 EDT 2002 i686 i686 i386 GNU/Linux

Gnu C                  gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7) Copyright (C) 2002 Free 
Software Foundation, Inc. This is free software; see the source for copying conditions. There is NO 
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 651.454
cache size      : 256 KB
Physical processor ID   : 0
Number of siblings      : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1292.74

Happens even when booted nosmp.

[7.3.] Module information (from /proc/modules):

we renamed /lib/modules/2.4.17 to /lib/modules/2.4.17.foo to avoid
loading any modules.  It didn't change anything.  Also removed
/lib/modules/2.4.17/fs/jbd/jbd.o.  No change.

Kernel config file:

Mostly just a red hat 8.0 config file passed through 'make oldconfig'
and with largish chunks of stuff turned off via 'make menuconfig'.
No idea if it's a good config.

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
CONFIG_M586=y
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_TOSHIBA=m
CONFIG_I8K=m
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_EISA=y
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_I82092=y
CONFIG_I82365=y
CONFIG_TCIC=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_XD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_KHTTPD is not set
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_VLAN_8021Q=m
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DECNET=m
CONFIG_DECNET_SIOCGIFCONF=y
CONFIG_DECNET_ROUTER=y
CONFIG_DECNET_ROUTE_FWMARK=y
CONFIG_BRIDGE=m
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
CONFIG_NET_DIVERT=y
# CONFIG_ECONET is not set
CONFIG_WAN_ROUTER=m
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_CSZ=m
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_ISAPNP=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_AEC62XX_TUNING=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_PDC202XX_BURST is not set
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_HPT=m

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=4
CONFIG_CHR_DEV_SG=m
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_7000FASST=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_AIC7XXX_OLD_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_OLD_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_OLD_PROC_STATS=y
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_IN2000=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_MEGARAID=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_CPQFCTS=m
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_DTC3280=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
# CONFIG_SCSI_EATA_LINKED_COMMANDS is not set
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_EATA_DMA=m
CONFIG_SCSI_EATA_PIO=m
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_GENERIC_NCR5380=m
# CONFIG_SCSI_GENERIC_NCR53C400 is not set
CONFIG_SCSI_G_NCR5380_PORT=y
# CONFIG_SCSI_G_NCR5380_MEM is not set
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_NCR53C406A=m
CONFIG_SCSI_NCR53C7xx=m
# CONFIG_SCSI_NCR53C7xx_sync is not set
CONFIG_SCSI_NCR53C7xx_FAST=y
CONFIG_SCSI_NCR53C7xx_DISCONNECT=y
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=40
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_PCI2000=m
CONFIG_SCSI_PCI2220I=m
CONFIG_SCSI_PSI240I=m
CONFIG_SCSI_QLOGIC_FAS=m
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
# CONFIG_SCSI_QLOGIC_FC_FIRMWARE is not set
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_SEAGATE=m
CONFIG_SCSI_SIM710=m
CONFIG_SCSI_SYM53C416=m
CONFIG_SCSI_DC390T=m
# CONFIG_SCSI_DC390T_NOGENSUPP is not set
CONFIG_SCSI_T128=m
CONFIG_SCSI_U14_34F=m
# CONFIG_SCSI_U14_34F_LINKED_COMMANDS is not set
CONFIG_SCSI_U14_34F_MAX_TAGS=8
CONFIG_SCSI_ULTRASTOR=m
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
CONFIG_SCSI_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Appletalk devices
#
# CONFIG_APPLETALK is not set
CONFIG_LTPC=m
CONFIG_COPS=m
CONFIG_COPS_DAYNA=y
CONFIG_COPS_TANGENT=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
CONFIG_NET_SB1000=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
CONFIG_HAPPYMEAL=m
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNLANCE is not set
CONFIG_SUNGEM=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
# CONFIG_ULTRAMCA is not set
CONFIG_ULTRA=m
CONFIG_ULTRA32=m
CONFIG_SMC9194=m
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI5010=m
CONFIG_NI52=m
CONFIG_NI65=m
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
CONFIG_NET_ISA=y
CONFIG_E2100=m
# CONFIG_EWRK3 is not set
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_LP486E=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=m
CONFIG_LNE390=m
# CONFIG_FEALNX is not set
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_NE3210=m
CONFIG_ES3210=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_WINBOND_840=m
CONFIG_NET_POCKET=y
CONFIG_ATP=m
CONFIG_DE600=m
CONFIG_DE620=m

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
CONFIG_DL2K=m
# CONFIG_MYRI_SBUS is not set
CONFIG_NS83820=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_SK98LIN=m
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
CONFIG_PPPOATM=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
CONFIG_NET_FC=y
CONFIG_IPHASE5526=m
CONFIG_RCPCI=m
CONFIG_SHAPER=m

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_ZATM_EXACT_TS=y
CONFIG_ATM_NICSTAR=m
CONFIG_ATM_NICSTAR_USE_SUNI=y
CONFIG_ATM_NICSTAR_USE_IDT77105=y
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=m
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=m
CONFIG_ATM_FORE200E_PCA=y
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=y
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_FORE200E=m

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
CONFIG_SERIAL_MULTIPORT=y
# CONFIG_HUB6 is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
CONFIG_ESPSERIAL=m
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_ISI=m
CONFIG_SYNCLINK=m
CONFIG_N_HDLC=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
CONFIG_SPECIALIX_RTSCTS=y
CONFIG_SX=m
# CONFIG_RIO is not set
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=512
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
CONFIG_BUSMOUSE=m
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
CONFIG_INPUT_NS558=m
CONFIG_INPUT_LIGHTNING=m
CONFIG_INPUT_PCIGAME=m
CONFIG_INPUT_CS461X=m
CONFIG_INPUT_EMU10K1=m
CONFIG_INPUT_SERIO=m
CONFIG_INPUT_SERPORT=m
CONFIG_INPUT_ANALOG=m
CONFIG_INPUT_A3D=m
CONFIG_INPUT_ADI=m
CONFIG_INPUT_COBRA=m
CONFIG_INPUT_GF2K=m
CONFIG_INPUT_GRIP=m
CONFIG_INPUT_INTERACT=m
CONFIG_INPUT_TMDC=m
CONFIG_INPUT_SIDEWINDER=m
# CONFIG_INPUT_IFORCE_USB is not set
CONFIG_INPUT_IFORCE_232=m
CONFIG_INPUT_WARRIOR=m
CONFIG_INPUT_MAGELLAN=m
CONFIG_INPUT_SPACEORB=m
CONFIG_INPUT_SPACEBALL=m
CONFIG_INPUT_STINGER=m
CONFIG_INPUT_DB9=m
CONFIG_INPUT_GAMECON=m
CONFIG_INPUT_TURBOGRAFX=m
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDT=m
CONFIG_WDTPCI=m
# CONFIG_WDT_501 is not set
CONFIG_PCWATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_I810_TCO=m
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
CONFIG_W83877F_WDT=m
CONFIG_MACHZ_WDT=m
CONFIG_INTEL_RNG=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
CONFIG_R3964=m
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
# CONFIG_FT_PROC_FS is not set
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m

#
# PCMCIA character devices
#
CONFIG_PCMCIA_SERIAL_CS=m
CONFIG_MWAVE=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_BFS_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=m
CONFIG_VXFS_FS=m
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_RW=y
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_ZISOFS_FS=y
CONFIG_ZLIB_FS_INFLATE=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MDA_CONSOLE=m

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=m
CONFIG_FB_CLGEN=m
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_PM2_PCI=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_HGA=m
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
# CONFIG_FB_MATROX_G450 is not set
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_ATY=m
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_RADEON=m
CONFIG_FB_ATY128=m
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_3DFX=m
CONFIG_FB_VOODOO1=m
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_HGA=m
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_BUGVERBOSE=y


-- 
Dan Kegel
Linux User #78045
http://www.kegel.com

