Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285404AbRLGEfc>; Thu, 6 Dec 2001 23:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285408AbRLGEfX>; Thu, 6 Dec 2001 23:35:23 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:28065 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S285405AbRLGEfL>; Thu, 6 Dec 2001 23:35:11 -0500
Date: Thu, 6 Dec 2001 23:37:59 -0500
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de, torvalds@transmeta.com
Subject: Oops on 2.5.1-pre6 doing mkreiserfs on loop device
Message-ID: <20011206233759.A173@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The three commands below are what executed just before the Oops.
Output to console and ps show that mkreiserfs command was executing.
The commands are a portion of a script I've run without Oops on
other kernels.

dd if=/dev/zero of=root_fs seek=100 count=1 bs=1M
losetup /dev/loop0 /usr/src/uml/linux/root_fs
yes | mkreiserfs /dev/loop0

The ksymoops output below is with the default options.  
/usr/src/linux was the 2.5.1-pre6 tree.

First oops:

Unable to handle kernel paging request at virtual address 61616179
c012b422
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012b422>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 61616161   ebx: 61616161   ecx: 61616161   edx: 00000000
esi: 00000000   edi: f32a0000   ebp: 00000001   esp: cfab5fa0
ds: 0018   es: 0018   ss: 0018
Process loop0 (pid: 11340, stackpage=cfab5000)
Stack: c012e582 cfab4000 c6477fc0 e0a5e000 00000001 0000000c 00000286 f1c52d40 
c01344d3 c6477fc0 00000008 fac2ec19 c6477fc0 00000001 00000008 e0a5e000 
c6477fc0 00000f00 f7637f2c e0a5e000 c01054e8 e0a5e000 00000078 f74ec0c0 
Call Trace: [<c012e582>] [<c01344d3>] [<fac2ec19>] [<c01054e8>] 
Code: 8b 41 18 f6 c4 40 75 11 ff 49 14 0f 94 c0 84 c0 74 07 89 c8 

>>EIP; c012b422 <__free_pages+2/20>   <=====
Trace; c012e582 <bounce_end_io_read+132/170>
Trace; c01344d2 <bio_endio+22/30>
Trace; fac2ec18 <[loop]loop_thread+c8/150>
Trace; c01054e8 <kernel_thread+28/40>
Code;  c012b422 <__free_pages+2/20>
00000000 <_EIP>:
Code;  c012b422 <__free_pages+2/20>   <=====
   0:   8b 41 18                  mov    0x18(%ecx),%eax   <=====
Code;  c012b424 <__free_pages+4/20>
   3:   f6 c4 40                  test   $0x40,%ah
Code;  c012b428 <__free_pages+8/20>
   6:   75 11                     jne    19 <_EIP+0x19> c012b43a <__free_pages+1a/20>
Code;  c012b42a <__free_pages+a/20>
   8:   ff 49 14                  decl   0x14(%ecx)
Code;  c012b42c <__free_pages+c/20>
   b:   0f 94 c0                  sete   %al
Code;  c012b430 <__free_pages+10/20>
   e:   84 c0                     test   %al,%al
Code;  c012b432 <__free_pages+12/20>
  10:   74 07                     je     19 <_EIP+0x19> c012b43a <__free_pages+1a/20>
Code;  c012b434 <__free_pages+14/20>
  12:   89 c8                     mov    %ecx,%eax


2nd oops after fresh boot running the same script.


Unable to handle kernel NULL pointer dereference at virtual address 00000018
c012b422
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012b422>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: f398a000   ebp: 00000001   esp: f3995fa0
ds: 0018   es: 0018   ss: 0018
Process loop0 (pid: 123, stackpage=f3995000)
Stack: c012e582 f3994000 f7eaf4c0 f3c43000 00000001 0000000c 00000286 f7eb0d00 
c01344d3 f7eaf4c0 00000008 fac2ec19 f7eaf4c0 00000001 00000008 f3c43000 
f7eaf4c0 00000f00 f39a7f2c f3c43000 c01054e8 f3c43000 00000078 f3a55cc0 
Call Trace: [<c012e582>] [<c01344d3>] [<fac2ec19>] [<c01054e8>] 
Code: 8b 41 18 f6 c4 40 75 11 ff 49 14 0f 94 c0 84 c0 74 07 89 c8 

>>EIP; c012b422 <__free_pages+2/20>   <=====
Trace; c012e582 <bounce_end_io_read+132/170>
Trace; c01344d2 <bio_endio+22/30>
Trace; fac2ec18 <[loop]loop_thread+c8/150>
Trace; c01054e8 <kernel_thread+28/40>
Code;  c012b422 <__free_pages+2/20>
00000000 <_EIP>:
Code;  c012b422 <__free_pages+2/20>   <=====
   0:   8b 41 18                  mov    0x18(%ecx),%eax   <=====
Code;  c012b424 <__free_pages+4/20>
   3:   f6 c4 40                  test   $0x40,%ah
Code;  c012b428 <__free_pages+8/20>
   6:   75 11                     jne    19 <_EIP+0x19> c012b43a <__free_pages+1a/20>
Code;  c012b42a <__free_pages+a/20>
   8:   ff 49 14                  decl   0x14(%ecx)
Code;  c012b42c <__free_pages+c/20>
   b:   0f 94 c0                  sete   %al
Code;  c012b430 <__free_pages+10/20>
   e:   84 c0                     test   %al,%al
Code;  c012b432 <__free_pages+12/20>
  10:   74 07                     je     19 <_EIP+0x19> c012b43a <__free_pages+1a/20>
Code;  c012b434 <__free_pages+14/20>
  12:   89 c8                     mov    %ecx,%eax

Linux rushmore 2.5.1-pre6 #1 Thu Dec 6 20:18:20 EST 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11m
mount                  2.11m
modutils               2.4.12
e2fsprogs              1.25
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         loop

Hardware:
Athlon 1333
1024 MB RAM
IDE disk

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

I've run these commands several times on 2.4.17-pre2.

diff 2.5.1-pre6 2.4.17-pre2
> CONFIG_NETLINK=y
> CONFIG_RTNETLINK=y
> CONFIG_IP_NF_QUEUE=m
> CONFIG_ETHERTAP=m


CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=m
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_ISA=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_PPP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=128
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=m
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G100=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=y
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=y
CONFIG_SOUND_CMPCI=y
CONFIG_SOUND_CMPCI_CM8738=y
CONFIG_SOUND_CMPCI_SPEAKERS=2
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

Hope this helps.

Sorry if the mail saying Jen's patch fixing 2.5.1-pre3 on highmem
was incorrectly addressed.  I applied Jen's patch to 2.5.1-pre3 before 
pre4 came out and verified the fix.
-- 
Randy Hron

