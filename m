Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUENOra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUENOra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUENOra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:47:30 -0400
Received: from science.horizon.com ([192.35.100.1]:51778 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261369AbUENOqf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:46:35 -0400
Date: 14 May 2004 14:46:33 -0000
Message-ID: <20040514144633.25562.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: 2.6.6 is crashing repeatedly
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded a server from 2.6.3 (which was stable) to 2.6.6 on
Tuesday night.  In the last 3 days, it has crashed twice, both
times around 02:45.

Basically:
Wednesday morning at 02:45 (less than 4 hours after kernel ugrade) - crash.
	Person in the morning forgot to reboot to the old kernel, so we
	left 2.6.6. running some more for a while.
Thursday morning - no crash.  Interesting.
Friday morning: kaboom.  Thus this report.

The only thing I can find in the crontab is the multi-system Amanda backup
process kicks off nightly at 02:00, and for those who don't know, it
starts with a fairly long phase of computing the size of compressed level-N
backups on each of the associated file systems and various values of N
before deciding which combination will fit on the backup tape and starting the
backup in earnest.

Notably the directory where Amanda stages the network backup images has been
empty both times.

I'm sory I don't have the oops logs or any other meaningful error-tracing
info, but the morning people have been rebooting the server as fast as
possible to get work done.  I'll go run some backups by hand to see if
I can trigger the problem at a more convenient time and capture enough
data to debug it.

I just thought I'd at least mention it in case anyone else is seeing
instability (the association with the kernel upgrade is just too strong)
to bring some reports to the front.  I haven't seen any other reports, but
it's hard to imageine I'm the only one who's managed to trigger it.

2.6.6. has been stable on my home machine where I test new Debian packages
and kernels before upgrading the servers.  In particular, I've been
testing regparm=y for quite a while before enabling it.

Some info:

=== grep ^CONFIG .config
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MSR=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_REGPARM=y
CONFIG_ACPI_BOOT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_DEBUG=y
CONFIG_YENTA=y
CONFIG_CARDBUS=y
CONFIG_PCMCIA_PROBE=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_BUSLOGIC=y
CONFIG_SCSI_OMIT_FLASHPOINT=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_NET_IPIP=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_AMANDA=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_AMANDA=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_NOTRACK=y
CONFIG_IP_NF_RAW=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_DELAY=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
CONFIG_NET_RADIO=y
CONFIG_PCMCIA_WAVELAN=y
CONFIG_PCMCIA_NETWAVE=y
CONFIG_PCMCIA_RAYCS=y
CONFIG_AIRO=y
CONFIG_HERMES=y
CONFIG_PCMCIA_HERMES=y
CONFIG_AIRO_CS=y
CONFIG_NET_WIRELESS=y
CONFIG_NET_PCMCIA=y
CONFIG_PPP=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SMB_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_STD_RESOURCES=y
CONFIG_PC=y

Notes about the above:
- There was some thought about adding an 802.11 card to the machine so it
  could play firewall, but that's never been done.  The PCMICA modules and
  cardbus adapater are unused.
- Likewise, IPSEC is planned, but not currently used at all.
- Backup device is a SCSI tape drive.
- Machine does a lot of firewalling and file serving.
- RAID-0 and RAID-1 are used a lot.  Main storage space is RAID-10
  (2-way RAID-0 over 2-way RAID-1).  All swap space is 2-way RAID-1.
- Console is not used much, although it has an X session left up on it
  sometimes.

=== /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 467.915
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 923.64

=== lspci
0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
0000:00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
0000:00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
0000:00:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
0000:00:09.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
0000:00:0a.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10] (rev 08)
0000:00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)
0000:00:0c.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)
0000:00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta/Vanta LT] (rev 15)
0000:02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
0000:02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
0000:02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
0000:02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)

=== lspci -vn
0000:00:00.0 Class 0600: 8086:7190 (rev 03)
	Flags: bus master, medium devsel, latency 64
	Memory at e6000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 1.0

0000:00:01.0 Class 0604: 8086:7191 (rev 03)
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: e2000000-e3cfffff
	Prefetchable memory behind bridge: e3f00000-e5ffffff

0000:00:04.0 Class 0601: 8086:7110 (rev 02)
	Flags: bus master, medium devsel, latency 0

0000:00:04.1 Class 0101: 8086:7111 (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 48
	I/O ports at d800 [size=16]

0000:00:04.2 Class 0c03: 8086:7112 (rev 01)
	Flags: bus master, medium devsel, latency 48, IRQ 9
	I/O ports at d400 [size=32]

0000:00:04.3 Class 0680: 8086:7113 (rev 02)
	Flags: medium devsel, IRQ 9

0000:00:09.0 Class 0607: 1180:0476 (rev 80)
	Subsystem: 14ef:0202
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 40000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 40400000-407ff000 (prefetchable)
	Memory window 1: 40800000-40bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

0000:00:09.1 Class 0607: 1180:0476 (rev 80)
	Subsystem: 14ef:0202
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 40001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 40c00000-40fff000 (prefetchable)
	Memory window 1: 41000000-413ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

0000:00:0a.0 Class 0100: 104b:1040 (rev 08)
	Subsystem: 104b:1040
	Flags: bus master, fast devsel, latency 48, IRQ 9
	I/O ports at d000
	Memory at e1800000 (32-bit, non-prefetchable) [size=4K]

0000:00:0b.0 Class 0180: 105a:4d68 (rev 01) (prog-if 85)
	Subsystem: 105a:4d68
	Flags: bus master, 66MHz, slow devsel, latency 48, IRQ 10
	I/O ports at b800
	I/O ports at b400 [size=4]
	I/O ports at b000 [size=8]
	I/O ports at a800 [size=4]
	I/O ports at a400 [size=16]
	Memory at e1000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 1

0000:00:0c.0 Class 0180: 105a:4d68 (rev 01) (prog-if 85)
	Subsystem: 105a:4d68
	Flags: bus master, 66MHz, slow devsel, latency 48, IRQ 11
	I/O ports at a000
	I/O ports at 9800 [size=4]
	I/O ports at 9400 [size=8]
	I/O ports at 9000 [size=4]
	I/O ports at 8800 [size=16]
	Memory at e0800000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 1

0000:00:0d.0 Class 0604: 1011:0024 (rev 03)
	Flags: bus master, medium devsel, latency 48
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=48
	I/O behind bridge: 00006000-00007fff
	Memory behind bridge: de800000-e07fffff
	Prefetchable memory behind bridge: 00000000e3d00000-00000000e3d00000
	Expansion ROM at 00006000 [disabled] [size=8K]
	Capabilities: [dc] Power Management version 1

0000:01:00.0 Class 0300: 10de:002c (rev 15)
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
	Memory at e2000000 (32-bit, non-prefetchable) [size=e3ff0000]
	Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at 00010000 [disabled]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0

0000:02:04.0 Class 0200: 1011:0019 (rev 41)
	Subsystem: 1186:1112
	Flags: bus master, medium devsel, latency 48, IRQ 9
	I/O ports at 7800
	Memory at e0000000 (32-bit, non-prefetchable) [size=1K]

0000:02:05.0 Class 0200: 1011:0019 (rev 41)
	Subsystem: 1186:1112
	Flags: bus master, medium devsel, latency 48, IRQ 11
	I/O ports at 7400
	Memory at df800000 (32-bit, non-prefetchable) [size=1K]

0000:02:06.0 Class 0200: 1011:0019 (rev 41)
	Subsystem: 1186:1112
	Flags: bus master, medium devsel, latency 48, IRQ 10
	I/O ports at 7000
	Memory at df000000 (32-bit, non-prefetchable) [size=1K]

0000:02:07.0 Class 0200: 1011:0019 (rev 41)
	Subsystem: 1186:1112
	Flags: bus master, medium devsel, latency 48, IRQ 9
	I/O ports at 6800
	Memory at de800000 (32-bit, non-prefetchable) [size=1K]

