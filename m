Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263309AbRFEILJ>; Tue, 5 Jun 2001 04:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263307AbRFEIKz>; Tue, 5 Jun 2001 04:10:55 -0400
Received: from mout1.freenet.de ([194.97.50.132]:32186 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S263302AbRFEIKl>;
	Tue, 5 Jun 2001 04:10:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: "Kernel-Mailingliste" <linux-kernel@vger.kernel.org>
Subject: [2.4.5] Mysterious behaviour of pppd at 56K modem
Date: Tue, 5 Jun 2001 10:10:25 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01060510102500.09957@athlon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo all!

I detected a very mysterious behaviour with my serial connected 56K modem. If 
you do a ftp-download e.g., the datas come at the following way:

5,9 kB   -- -- ---  -- -- -- --  --


4,4 kB  -  -  -   --  -  -  -   -

The speed of the incoming data is always swinging between 5.9kB and 4.4kB. 
Why? I didn't have this problem with Kernel 2.2.x (with the same 
pppd-versions).
Neverthless, the overallspeed seems to be equal to kernel 2.2.x (about 
5.1kB/s) - but not slower; it even could be faster. But I think, the speed 
could be much higher, if it wouldn't swing as much.

I'm using pppd 2.4.0b or 2.4.1. My modem (USR Sportster Message +) is 
connected with 115200 Baud (56000 tested but doesn't work properly), the 
connect to my provider is 50,6kB/s.
My serial hardware is
ttyS00 at 0x03f8 (irq = 4) is a 16550A
on a AMD K6 2 400 with ALI 1541-chipset.

I can't see any errors in messages or with ifconfig.
I tested it with or without firewall - always the same behaviour.

The login-protocoll seems not to bee suspicious:
Jun  5 08:55:23 kernel: CSLIP: code copyright 1989 Regents of the University 
of California
Jun  5 08:55:23 kernel: PPP generic driver version 2.4.1
Jun  5 08:55:23 pppd[1559]: pppd 2.4.1 started by ausgang, uid 1003
Jun  5 08:55:23 pppd[1559]: using channel 1
Jun  5 08:55:23 pppd[1559]: Using interface ppp0
Jun  5 08:55:23 pppd[1559]: Connect: ppp0 <--> /dev/ttyS0
Jun  5 08:55:23 pppd[1559]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 
0x165bafd8> <pcomp> <accomp>]
Jun  5 08:55:25 last message repeated 2 times
Jun  5 08:55:25 pppd[1559]: rcvd [LCP ConfAck id=0x1 <asyncmap 0x0> <magic 
0x165bafd8> <pcomp> <accomp>]
Jun  5 08:55:26 pppd[1559]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 
0x165bafd8> <pcomp> <accomp>]
Jun  5 08:55:26 pppd[1559]: rcvd [LCP ConfReq id=0xd6 <asyncmap 0xa0000> 
<auth pap> <magic 0x3ceda072> <pcomp> <accomp>]
Jun  5 08:55:26 pppd[1559]: sent [LCP ConfAck id=0xd6 <asyncmap 0xa0000> 
<auth pap> <magic 0x3ceda072> <pcomp> <accomp>]
Jun  5 08:55:26 pppd[1559]: rcvd [LCP ConfAck id=0x1 <asyncmap 0x0> <magic 
0x165bafd8> <pcomp> <accomp>]
Jun  5 08:55:26 pppd[1559]: sent [PAP AuthReq id=0x1 user="somebody" 
password=<hidden>]
Jun  5 08:55:26 pppd[1559]: rcvd [PAP AuthAck id=0x1 ""]
Jun  5 08:55:26 pppd[1559]: sent [IPCP ConfReq id=0x1 <addr 192.168.1.2> 
<compress VJ 0f 01>]
Jun  5 08:55:26 pppd[1559]: rcvd [IPCP ConfReq id=0xaa <addr 62.104.220.42>]
Jun  5 08:55:26 pppd[1559]: sent [IPCP ConfAck id=0xaa <addr 62.104.220.42>]
Jun  5 08:55:26 pppd[1559]: rcvd [IPCP ConfRej id=0x1 <compress VJ 0f 01>]
Jun  5 08:55:26 pppd[1559]: sent [IPCP ConfReq id=0x2 <addr 192.168.1.2>]
Jun  5 08:55:27 pppd[1559]: rcvd [IPCP ConfNak id=0x2 <addr 213.7.17.225>]
Jun  5 08:55:27 pppd[1559]: sent [IPCP ConfReq id=0x3 <addr 213.7.17.225>]
Jun  5 08:55:27 pppd[1559]: rcvd [IPCP ConfAck id=0x3 <addr 213.7.17.225>]
Jun  5 08:55:27 pppd[1559]: local  IP address 213.7.17.225
Jun  5 08:55:27 pppd[1559]: remote IP address 62.104.220.42

I tried to switch off all softwarecompression. But it doesn't matter.


Do you have any advice for me?


Regards,
Andreas Hartmann


lspci

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP 
System Controller
        Flags: bus master, slow devsel, latency 64
        Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [b0] AGP version 1.0

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 00 
[Normal decode])
        Flags: bus master, slow devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e4800000-e5ffffff
        Prefetchable memory behind bridge: e7f00000-e7ffffff
 
00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management 
Controller
        Flags: medium devsel
 
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV] (rev c3)
        Flags: bus master, medium devsel, latency 0
 
00:0a.0 Multimedia audio controller: Xilinx, Inc. RME Digi96
        Flags: slow devsel, IRQ 12
        Memory at e3000000 (32-bit, non-prefetchable) [size=16M]
 
00:0b.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet 
Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at b800 [size=256]
        Memory at e2800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 1
 
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) 
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at b400 [size=16]
 
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X 
(rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 11
        Memory at e5000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at d800 [size=256]
        Memory at e4800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at e7fe0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0



Linux name 2.4.5 #3 Sam Jun 2 16:07:35 CEST 2001 i586 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.76.1
binutils               2.9.5.0.12
util-linux             2.10s
mount                  2.10s
modutils               2.4.6
e2fsprogs              1.14
PPP                    2.4.1
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.2
Net-tools              1.55
Kbd                    0.96
Sh-utils               2.0g
Modules Loaded         ipt_LOG ipt_REJECT ipt_state iptable_filter ip_tables 
ip_conntrack_ftp ip_conntrack sis900 serial reiserfs unix


grep -v "not set" .config 

#
# Automatically generated by make menuconfig: don't edit
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
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_MK6=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y

#
# Memory Technology Devices (MTD)
#

#
# Parallel port support
#

#
# Plug and Play configuration
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096

#
# Multi-device support (RAID and LVM)
#

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_NETFILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y

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
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m

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
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#

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
CONFIG_SIS900=m

#
# Ethernet (1000 Mbit)
#
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m

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
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#

#
# Mice
#

#
# Joysticks
#

#
# Watchdog Cards
#

#
# Ftape, the floppy tape device driver
#

#
# Multimedia devices
#

#
# File systems
#
CONFIG_REISERFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y

#
# Partition Types
#
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
 
#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
 
#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
 
#
# Frame-buffer support
#
 
#
# Sound
#
CONFIG_SOUND=m
 
#
# USB support
#
CONFIG_USB=y
CONFIG_USB_UHCI_ALT=y
 
#
# USB Serial Converter support
#
 
#
# Kernel hacking
#
