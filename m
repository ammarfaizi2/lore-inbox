Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUIEWct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUIEWct (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUIEWct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:32:49 -0400
Received: from scrat.cs.umu.se ([130.239.40.18]:41109 "EHLO scrat.cs.umu.se")
	by vger.kernel.org with ESMTP id S267298AbUIEWcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:32:33 -0400
Date: Mon, 6 Sep 2004 00:32:29 +0200
From: Set Norman <set@cs.umu.se>
To: linux-kernel@vger.kernel.org
Subject: [2.6.8.1] OOPS in page_waitqueue
Message-ID: <20040905223229.GA22034@lav.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel is 2.6.8.1 (monolithic), OOPS related to page_waitqueue.

Found this OOPS in my syslog a couple of hours ago. Don't know if it is of any
significance, haven't seen it on lkml. Let me know if further information is
required.

System is debian unstable, Pentium II @ 700. Has been running every 2.6 kernel
I have tried without problems. This particular one had been up and running for
almost two weeks before the OOPS. The system is/was not under any significant
load.

Thanks,
Set Norman - set@acc.umu.se

Linux riot 2.6.8.1 #1 Thu Aug 26 21:10:48 CEST 2004 i686 GNU/Linux

Unable to handle kernel NULL pointer dereference at virtual address 000000d8
c0129fbe
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0129fbe>]    Not tainted
EFLAGS: 00010a06   (2.6.8.1) 
eax: 96a00760   ebx: c1000760   ecx: 00000020   edx: 00000000
esi: 00000000   edi: 00000002   ebp: cfeebde8   esp: cfeebd94
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 27, threadinfo=cfeea000 task=cfed9100)
Stack: c012a183 c1000760 cfeebe20 00000000 cfeebdc8 c012a4c5 cde80a30 cfeebe38 
       00000000 00000010 00000000 cfeebe30 00000010 cfeebde8 c0133d93 cde80a2c 
       cfeebe20 00000000 c1000760 00000000 00000002 cfeebe8c c0165918 cfeebe30 
Call Trace:
 [<c010465f>] show_stack+0x7f/0xa0
 [<c0104801>] show_registers+0x151/0x1b0
 [<c0104986>] die+0x66/0xd0
 [<c010f65d>] do_page_fault+0x2dd/0x5d0
 [<c01042e9>] error_code+0x2d/0x38
 [<c0165918>] mpage_writepages+0x288/0x320
 [<c012f812>] do_writepages+0x42/0x50
 [<c0163dc6>] __sync_single_inode+0x56/0x1e0
 [<c0164184>] sync_sb_inodes+0x194/0x2a0
 [<c016432c>] writeback_inodes+0x9c/0xa0
 [<c012f5d6>] wb_kupdate+0x96/0x110
 [<c012ff34>] __pdflush+0xa4/0x180
 [<c0130038>] pdflush+0x28/0x30
 [<c0124b3a>] kthread+0xaa/0xb0
 [<c01024f5>] kernel_thread_helper+0x5/0x10
Code: 2b 8a d8 00 00 00 8b 92 d0 00 00 00 d3 e8 8d 04 c2 c3 55 89 


>>EIP; c0129fbe <page_waitqueue+1e/30>   <=====

>>ebx; c1000760 <pg0+be8760/3fbe6000>
>>ebp; cfeebde8 <pg0+fad3de8/3fbe6000>
>>esp; cfeebd94 <pg0+fad3d94/3fbe6000>

Code;  c0129fbe <page_waitqueue+1e/30>
00000000 <_EIP>:
Code;  c0129fbe <page_waitqueue+1e/30>   <=====
   0:   2b 8a d8 00 00 00         sub    0xd8(%edx),%ecx   <=====
Code;  c0129fc4 <page_waitqueue+24/30>
   6:   8b 92 d0 00 00 00         mov    0xd0(%edx),%edx
Code;  c0129fca <page_waitqueue+2a/30>
   c:   d3 e8                     shr    %cl,%eax
Code;  c0129fcc <page_waitqueue+2c/30>
   e:   8d 04 c2                  lea    (%edx,%eax,8),%eax
Code;  c0129fcf <page_waitqueue+2f/30>
  11:   c3                        ret    
Code;  c0129fd0 <wake_up_page+0/40>
  12:   55                        push   %ebp
Code;  c0129fd1 <wake_up_page+1/40>
  13:   89 00                     mov    %eax,(%eax)

 [<c010469e>] dump_stack+0x1e/0x30
 [<c0111c28>] __might_sleep+0x98/0xa0
 [<c013c4fa>] anon_vma_prepare+0x2a/0xb0
 [<c013a647>] expand_stack+0x17/0xa0
 [<c010f492>] do_page_fault+0x112/0x5d0
 [<c01042e9>] error_code+0x2d/0x38
 [<c012dc6a>] rmqueue_bulk+0x3a/0x60
 [<c012e06f>] buffered_rmqueue+0x15f/0x180
 [<c012e144>] __alloc_pages+0xb4/0x370
 [<c0138276>] do_anonymous_page+0x66/0x150
 [<c01383bf>] do_no_page+0x5f/0x2b0
 [<c01387e2>] handle_mm_fault+0xe2/0x150
 [<c010f500>] do_page_fault+0x180/0x5d0
 [<c01042e9>] error_code+0x2d/0x38
Unable to handle kernel paging request at virtual address 4cf4b366
c012db73
*pde = 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c012db73>]    Not tainted
EFLAGS: 00010012   (2.6.8.1) 
eax: 4cf4b362   ebx: 00000000   ecx: c1000718   edx: c034322c
esi: c03431e0   edi: c034322c   ebp: cfeebde4   esp: cfeebdc0
ds: 007b   es: 007b   ss: 0068
Stack: 00000002 0000263a c106c740 00000001 00000202 c1000700 00000000 c03432cc 
       00000000 cfeebe04 c012dc6a c03431e0 00000000 00000092 c03431e0 00000246 
       c03432bc cfeebe2c c012e06f c03431e0 00000000 00000001 c03432cc 00000000 
Call Trace:
 [<c010465f>] show_stack+0x7f/0xa0
 [<c0104801>] show_registers+0x151/0x1b0
 [<c0104986>] die+0x66/0xd0
 [<c010f65d>] do_page_fault+0x2dd/0x5d0
 [<c01042e9>] error_code+0x2d/0x38
 [<c012dc6a>] rmqueue_bulk+0x3a/0x60
 [<c012e06f>] buffered_rmqueue+0x15f/0x180
 [<c012e144>] __alloc_pages+0xb4/0x370
 [<c0138276>] do_anonymous_page+0x66/0x150
 [<c01383bf>] do_no_page+0x5f/0x2b0
 [<c01387e2>] handle_mm_fault+0xe2/0x150
 [<c010f500>] do_page_fault+0x180/0x5d0
 [<c01042e9>] error_code+0x2d/0x38
Code: 89 50 04 89 02 c7 41 04 00 02 20 00 c7 01 00 01 10 00 8b 4d 


>>EIP; c012db73 <__rmqueue+53/110>   <=====

>>ecx; c1000718 <pg0+be8718/3fbe6000>
>>edx; c034322c <contig_page_data+4c/3c8>
>>esi; c03431e0 <contig_page_data+0/3c8>
>>edi; c034322c <contig_page_data+4c/3c8>
>>ebp; cfeebde4 <pg0+fad3de4/3fbe6000>
>>esp; cfeebdc0 <pg0+fad3dc0/3fbe6000>

Code;  c012db73 <__rmqueue+53/110>
00000000 <_EIP>:
Code;  c012db73 <__rmqueue+53/110>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012db76 <__rmqueue+56/110>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012db78 <__rmqueue+58/110>
   5:   c7 41 04 00 02 20 00      movl   $0x200200,0x4(%ecx)
Code;  c012db7f <__rmqueue+5f/110>
   c:   c7 01 00 01 10 00         movl   $0x100100,(%ecx)
Code;  c012db85 <__rmqueue+65/110>
  12:   8b 4d 00                  mov    0x0(%ebp),%ecx

________________________________________________________________________
my .config

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
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
CONFIG_HPET_TIMER=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PM=y
CONFIG_ACPI_BOOT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_PCMCIA_PROBE=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y
CONFIG_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_TUN=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_TULIP=y
CONFIG_DM9102=y
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=y
CONFIG_8139TOO=y
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
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_SECURITY=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

-- 
----- Set Norman - set@{cs,acc}.umu.se -----
