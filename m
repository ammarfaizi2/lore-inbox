Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265621AbTFNHV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 03:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265623AbTFNHV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 03:21:57 -0400
Received: from [64.35.99.205] ([64.35.99.205]:6411 "EHLO www.theshore.net")
	by vger.kernel.org with ESMTP id S265621AbTFNHVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 03:21:48 -0400
Message-ID: <003a01c33247$da8df8b0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
To: <linux-kernel@vger.kernel.org>
References: <20030614063539.GA508@bouh.unh.edu>
Subject: [BUG] 2.4.21 - kernel BUG at dev.c:991
Date: Sat, 14 Jun 2003 02:37:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[1.] One line summary of the problem:

I'm experiencing a reproducible "kernel BUG at dev.c:991!" call from
core/net/dev.c in 2.4.21.

[2.] Full description of the problem/report:

It happens by running a perl script which launches 8 scripts in the background -
each script (process) creates a tuntap device, and adds it's device to bridge.
The scripts execute correctly, but after a second or two I get the BUG...

[3.] Keywords (i.e., modules, networking, kernel):

dev.c 991 bridge tuntap

[4.] Kernel version (from /proc/version):

Linux version 2.4.21host15 (root@host1.linode.com) (gcc version 3.2.2 20030222
(Red Hat Linux 3.2.2-5)) #1 SMP Sat Jun 14 02:03:34 EDT 2003

[5.] Output of Oops.. message (if applicable) with symbolic information resolved
(see Documentation/oops-tracing.txt)

kernel BUG at dev.c:991!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c02a1b39>]    Not tainted
EFLAGS: 00010202
eax: 0000c7ac   ebx: f75de980   ecx: 6d1e5a8c   edx: 00000030
esi: 0000c7aa   edi: f75e2830   ebp: c2f03800   esp: f6d3be30
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 879, stackpage=f6d3b000)
Stack: f75de980 0000000e 00000030 6d1e5a8c c2f1642c f75de980 f7049d00 c02a1e89
       f75de980 f6e48780 f75de980 f75de880 f7049d00 c02f224b f75de980 f6dae508
       f75de880 f7049500 c02f228b f75de980 f75de8ac 00000030 f7049500 f75de880
Call Trace:    [<c02a1e89>] [<c02f224b>] [<c02f228b>] [<c02f2497>] [<c02f2330>]
  [<c02f2567>] [<c02f2330>] [<c02f3000>] [<c02f321d>] [<c02a23b1>] [<c02a255c>]
  [<c02a2699>] [<c0125679>] [<c010b099>] [<c010ddb8>]

Code: 0f 0b df 03 73 11 32 c0 89 c8 c1 e1 10 25 00 00 ff ff 01 c8
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

[6.] A small shell script or example program which triggers the
     problem (if possible)



[7.] Environment

SuperMicro server, no load, fresh reboot, redhat 9

[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 4
cpu MHz         : 2399.759
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4784.12

[7.3.] Module information (from /proc/modules):
iptable_filter          2380   0 (autoclean) (unused)
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0330-0331 : i2c (isa bus adapter)
0376-0376 : ide1
0378-037f : i2c (Vellemann adapter)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0500-050f : Intel Corp. 82801BA/BAM SMBus
0cf8-0cff : PCI conf1
c000-c03f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  c000-c03f : e100
c400-c43f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  c400-c43f : e100
c800-c8ff : ATI Technologies Inc Rage XL
f000-f00f : Intel Corp. 82801BA IDE U100
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000c9000-000c9fff : Extension ROM
000f0000-000fffff : System ROM
00100000-9ffeffff : System RAM
  00100000-0030d493 : Kernel code
  0030d494-003852c3 : Kernel data
9fff0000-9fff2fff : ACPI Non-volatile Storage
9fff3000-9fffffff : ACPI Tables
e1000000-e1ffffff : ATI Technologies Inc Rage XL
e2000000-e20fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  e2000000-e20fffff : e100
e2100000-e21fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  e2100000-e21fffff : e100
e2200000-e2200fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  e2200000-e2200fff : e100
e2201000-e2201fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  e2201000-e2201fff : e100
e2202000-e2202fff : ATI Technologies Inc Rage XL
e3000000-e33fffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
ffb00000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev
04)
        Subsystem: Super Micro Computer Inc: Unknown device 3280
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR+ <PERR-
        Latency: 0
        Region 0: Memory at e3000000 (32-bit, prefetchable) [size=4M]
        Capabilities: [e4] #09 [9104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e0000000-e2ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if 80 [Master])
        Subsystem: Super Micro Computer Inc: Unknown device 3280
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at f000 [size=16]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
        Subsystem: Super Micro Computer Inc: Unknown device 3280
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 7
        Region 4: I/O ports at 0500 [size=16]

02:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter (PILA8470B)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e2200000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at c000 [size=64]
        Region 2: Memory at e2100000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter (PILA8470B)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2201000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at c400 [size=64]
        Region 2: Memory at e2000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:08.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if
00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at c800 [size=256]
        Region 2: Memory at e2202000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):


CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUM4=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
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
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_PROC_MM=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_BLK_DEV_LVM=y
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
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
CONFIG_NET_IPIP=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_VLAN_8021Q=y
CONFIG_BRIDGE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_TUN=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_TIGON3=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ELV=y
CONFIG_I2C_VELLEMAN=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ELEKTOR=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_JFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

[X.] Other notes, patches, fixes, workarounds:

Here is a quick view of core/net/dev.c:

    973 /* Calculate csum in the case, when packet is misrouted.
    974  * If it failed by some reason, ignore and send skb with wrong
    975  * checksum.
    976  */
    977 struct sk_buff * skb_checksum_help(struct sk_buff *skb)
    978 {
    979         int offset;
    980         unsigned int csum;
    981
    982         offset = skb->h.raw - skb->data;
    983         if (offset > (int)skb->len)
    984                 BUG();
    985         csum = skb_checksum(skb, offset, skb->len-offset, 0);
    986
    987         offset = skb->tail - skb->h.raw;
    988         if (offset <= 0)
    989                 BUG();
    990         if (skb->csum+2 > offset)
    991                 BUG();
    992
    993         *(u16*)(skb->h.raw + skb->csum) = csum_fold(csum);
    994         skb->ip_summed = CHECKSUM_NONE;
    995         return skb;
    996 }

-Chris

