Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285347AbSADNA6>; Fri, 4 Jan 2002 08:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSADNAl>; Fri, 4 Jan 2002 08:00:41 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:30726 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285347AbSADNAV>;
	Fri, 4 Jan 2002 08:00:21 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-xfs oops on laptop resume, usb?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 Jan 2002 00:00:06 +1100
Message-ID: <4758.1010149206@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.17-xfs laptop oopsed when coming out of suspend state.  esi is way
out of range, it contains 'FIRE'.  Although this failed in xfs code, I
suspect that something in the resume code has corrupted the stack.
Does this ring any bells?

usb-ohci.c: USB suspend: usb-00:10.0
usb-ohci.c: USB continue: usb-00:10.0 from host wakeup
Unable to handle kernel paging request at virtual address 4649528

ksymoops 2.4.3 on i586 2.4.17-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-xfs/ (default)
     -m /lib/modules/2.4.17-xfs/System.map (specified)

Intel Pentium with F0 0F bug - workaround enabled.
SGI XFS with ACLs, EAs, DMAPI, quota, no debug enabled
Unable to handle kernel paging request at virtual address 46495281
c01afc40
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01afc40>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010816
eax: 00005f73   ebx: 000000d4   ecx: c114d9ac   edx: c3343e50
esi: 46495245   edi: 00000286   ebp: c114d9ac   esp: c3343d90
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 465, stackpage=c3343000)
Stack: c3880000 00000001 00000000 00000000 00000000 c015f79f 0000050b 0001650b 
       00000000 c3d7f22c c015e982 c3d7f22c c1141d5c 00000001 0000050b c3d7f22c 
       00000002 000000d4 c114d9ac c39917a8 c3343e4c c01afe92 c114d9ac 00000000 
Call Trace: [<c015f79f>] [<c015e982>] [<c01afe92>] [<c01af733>] [<c01ae91c>] 
   [<c01ba8c3>] [<c01b9eec>] [<c01bc12c>] [<c01c0231>] [<c01c033b>] [<c01c769b>] 
   [<c013410a>] [<c0106f33>] 
Code: 66 8b 46 3c a9 41 00 00 00 0f 85 30 01 00 00 80 7e 3c 00 0f 

>>EIP; c01afc40 <xlog_state_do_callback+50/240>   <=====
Trace; c015f79e <set_buffer_dirty_uptodate+3e/70>
Trace; c015e982 <pagebuf_commit_write+42/70>
Trace; c01afe92 <xlog_state_get_iclog_space+12/170>
Trace; c01af732 <xlog_write+142/440>
Trace; c01ae91c <xfs_log_write+3c/60>
Trace; c01ba8c2 <xfs_trans_commit+172/290>
Trace; c01b9eec <xfs_trans_reserve+8c/150>
Trace; c01bc12c <xfs_trans_log_inode+1c/50>
Trace; c01c0230 <xfs_fsync+1d0/300>
Trace; c01c033a <xfs_fsync+2da/300>
Trace; c01c769a <linvfs_fsync+3a/50>
Trace; c013410a <sys_fsync+5a/90>
Trace; c0106f32 <system_call+32/40>
Code;  c01afc40 <xlog_state_do_callback+50/240>
00000000 <_EIP>:
Code;  c01afc40 <xlog_state_do_callback+50/240>   <=====
   0:   66 8b 46 3c               mov    0x3c(%esi),%ax   <=====
Code;  c01afc44 <xlog_state_do_callback+54/240>
   4:   a9 41 00 00 00            test   $0x41,%eax
Code;  c01afc48 <xlog_state_do_callback+58/240>
   9:   0f 85 30 01 00 00         jne    13f <_EIP+0x13f> c01afd7e <xlog_state_do_callback+18e/240>
Code;  c01afc4e <xlog_state_do_callback+5e/240>
   f:   80 7e 3c 00               cmpb   $0x0,0x3c(%esi)
Code;  c01afc52 <xlog_state_do_callback+62/240>
  13:   0f 00 00                  sldt   (%eax)


Dump of assembler code for function xlog_state_do_callback:
0xc01afbf0 <xlog_state_do_callback>:    push   %ebp
0xc01afbf1 <xlog_state_do_callback+1>:  push   %edi
0xc01afbf2 <xlog_state_do_callback+2>:  push   %esi
0xc01afbf3 <xlog_state_do_callback+3>:  push   %ebx
0xc01afbf4 <xlog_state_do_callback+4>:  sub    $0x44,%esp
0xc01afbf7 <xlog_state_do_callback+7>:  mov    0x58(%esp,1),%ebp
0xc01afbfb <xlog_state_do_callback+11>: movl   $0x0,0x10(%esp,1)
0xc01afc03 <xlog_state_do_callback+19>: pushf  
0xc01afc04 <xlog_state_do_callback+20>: pop    %edi
0xc01afc05 <xlog_state_do_callback+21>: cli    
0xc01afc06 <xlog_state_do_callback+22>: mov    0x30(%ebp),%eax
0xc01afc09 <xlog_state_do_callback+25>: mov    %eax,(%esp,1)
0xc01afc0c <xlog_state_do_callback+28>: movl   $0x0,0xc(%esp,1)
0xc01afc14 <xlog_state_do_callback+36>: movl   $0x0,0x4(%esp,1)
0xc01afc1c <xlog_state_do_callback+44>: jmp    0xc01afc26 <xlog_state_do_callback+54>
0xc01afc1e <xlog_state_do_callback+46>: mov    %esi,%esi
0xc01afc20 <xlog_state_do_callback+48>: mov    0x30(%ebp),%eax
0xc01afc23 <xlog_state_do_callback+51>: mov    %eax,(%esp,1)
0xc01afc26 <xlog_state_do_callback+54>: mov    0x4(%esp,1),%eax
0xc01afc2a <xlog_state_do_callback+58>: mov    (%esp,1),%esi
0xc01afc2d <xlog_state_do_callback+61>: inc    %eax
0xc01afc2e <xlog_state_do_callback+62>: movl   $0x0,0x8(%esp,1)
0xc01afc36 <xlog_state_do_callback+70>: mov    %eax,0x4(%esp,1)
0xc01afc3a <xlog_state_do_callback+74>: lea    0x0(%esi),%esi
0xc01afc40 <xlog_state_do_callback+80>: mov    0x3c(%esi),%ax
0xc01afc44 <xlog_state_do_callback+84>: test   $0x41,%eax

gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)
GNU ld version 2.10.91 (with BFD 2.10.91.0.2)

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_M586TSC=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_I82365=y
CONFIG_TCIC=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
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
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
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
CONFIG_KHTTPD=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_PCMCIA_XIRTULIP=m
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_NETWAVE=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_AIRONET4500_CS=m
CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_OPTIONS=y
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_PPDEV=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_PCMCIA_SERIAL_CS=m
CONFIG_QUOTA=y
CONFIG_FS_POSIX_ACL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_PAGE_BUF=y
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_HAVE_ATTRCTL=y
CONFIG_XFS_DMAPI=y
CONFIG_HAVE_XFS_DMAPI=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_YM3812=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_USBNET=m
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_RIO500=m
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KDB=y
CONFIG_KDB_MODULES=m
CONFIG_KALLSYMS=y

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 8
model name	: Mobile Pentium MMX
stepping	: 1
cpu MHz		: 267.280
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 532.48

00:00.0 Host bridge: OPTi Inc. 82C701 [FireStar Plus] (rev 32)
        Flags: bus master, medium devsel, latency 0

00:01.0 ISA bridge: OPTi Inc. 82C700 (rev 31)
        Flags: bus master, medium devsel, latency 0

00:10.0 USB Controller: Compaq Computer Corporation USB Open Host Controller (rev 06) (prog-if 10 [OHCI])
        Subsystem: Compaq Computer Corporation USB Open Host Controller
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at 41000000 (32-bit, non-prefetchable) [size=4K]

00:11.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

00:11.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001

00:12.0 VGA compatible controller: Chips and Technologies F68554 HiQVision (rev a2) (prog-if 00 [VGA])
        Flags: stepping, medium devsel
        Memory at 40000000 (32-bit, non-prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:14.0 IDE interface: OPTi Inc. 82C825 [Firebridge 2] (rev 30) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 0
        I/O ports at 1000 [size=16]

sb                      8896   0
sb_lib                 39200   0 [sb]
uart401                 7392   0 [sb_lib]
autofs                 11204   1 (autoclean)
3c589_cs                8964   1
ds                      8000   2 [3c589_cs]
yenta_socket           11456   2
pcmcia_core            50880   0 [3c589_cs ds yenta_socket]
ipchains               38184   0
sound                  66828   0 (autoclean) [sb_lib uart401]
soundcore               5636   4 (autoclean) [sb_lib sound]
vfat                   11356   1 (autoclean)
fat                    35736   0 (autoclean) [vfat]
ide-cd                 29952   0 (autoclean)
cdrom                  31456   0 (autoclean) [ide-cd]
usb-ohci               20352   0 (unused)
usbcore                60608   1 [usb-ohci]

