Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262599AbSJIXb7>; Wed, 9 Oct 2002 19:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262344AbSJIXbn>; Wed, 9 Oct 2002 19:31:43 -0400
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:48624 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S262547AbSJIXam>; Wed, 9 Oct 2002 19:30:42 -0400
Date: Wed, 9 Oct 2002 16:36:24 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] pl2303 oops in 2.4.20-pre10 (and 2.5 too)
Message-ID: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On one of my systems, when minicom opens /dev/ttyUSB0 (a PL2303) and
the kernel is 2.4.20-pre10 (compiled with Mandrake 9's gcc 3.2),
minicom segfaults and the kernel oopses.

2.4.19 does not have this problem, whether compiled with gcc 2.96 from
Mandrake 8.2 or gcc 3.2 from Mandrake 9.0. The oops happens with
2.4.20-pre5 and -pre9, 2.5.41, and 2.5.41-ac1 as well.

The decoded oops (from 2.4.20-pre10), and the .config (with blank/comment
lines stripped), follow. FWIW, it's a monolithic kernel (module support
disabled). If any more info or data is needed, I'll try my best to
provide it. This bug is 100% reproducible.

ksymoops 2.4.5 on i686 2.4.19-16mdksmp.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000010
c01d8cd8
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01d8cd8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c1339400   ecx: 00000021   edx: c134b800
esi: c133941c   edi: 00000000   ebp: cd993e9c   esp: cd993e2c
ds: 0018   es: 0018   ss: 0018
Process minicom (pid: 110, stackpage=cd993000)
Stack: c133f600 cd993e60 00000001 00000040 00000002 00000004 00000000 00000000 
       00000064 cd936006 c0295f5c cd993e70 c017b921 cd936000 00000000 00001000 
       c02e0d20 cd993ebc c0178123 00000000 00000000 00000024 00000000 00000000 
Call Trace:    [<c017b921>] [<c0178123>] [<c01d57bb>] [<c0178e44>] [<c01413a3>]
  [<c015914a>] [<c01378aa>] [<c0136081>] [<c0135fa6>] [<c0140953>] [<c0136351>]
  [<c0107417>]
Code: 89 50 10 8b 46 20 89 04 24 e8 5a e9 fe ff 85 c0 75 76 a1 1c 


>>EIP; c01d8cd8 <pl2303_open+508/890>   <=====

>>ebx; c1339400 <END_OF_CODE+10553a8/????>
>>edx; c134b800 <END_OF_CODE+10677a8/????>
>>esi; c133941c <END_OF_CODE+10553c4/????>
>>ebp; cd993e9c <END_OF_CODE+d6afe44/????>
>>esp; cd993e2c <END_OF_CODE+d6afdd4/????>

Trace; c017b921 <n_tty_open+91/b0>
Trace; c0178123 <init_dev+a3/4d0>
Trace; c01d57bb <serial_open+fb/140>
Trace; c0178e44 <tty_open+244/3d0>
Trace; c01413a3 <link_path_walk+593/710>
Trace; c015914a <ext2_free_blocks+21a/300>
Trace; c01378aa <chrdev_open+5a/60>
Trace; c0136081 <dentry_open+d1/1e0>
Trace; c0135fa6 <filp_open+66/70>
Trace; c0140953 <getname+93/d0>
Trace; c0136351 <sys_open+51/a0>
Trace; c0107417 <system_call+33/38>

Code;  c01d8cd8 <pl2303_open+508/890>
00000000 <_EIP>:
Code;  c01d8cd8 <pl2303_open+508/890>   <=====
   0:   89 50 10                  mov    %edx,0x10(%eax)   <=====
Code;  c01d8cdb <pl2303_open+50b/890>
   3:   8b 46 20                  mov    0x20(%esi),%eax
Code;  c01d8cde <pl2303_open+50e/890>
   6:   89 04 24                  mov    %eax,(%esp,1)
Code;  c01d8ce1 <pl2303_open+511/890>
   9:   e8 5a e9 fe ff            call   fffee968 <_EIP+0xfffee968> c01c7640 <usb_submit_urb+0/50>
Code;  c01d8ce6 <pl2303_open+516/890>
   e:   85 c0                     test   %eax,%eax
Code;  c01d8ce8 <pl2303_open+518/890>
  10:   75 76                     jne    88 <_EIP+0x88> c01d8d60 <pl2303_open+590/890>
Code;  c01d8cea <pl2303_open+51a/890>
  12:   a1 1c 00 00 00            mov    0x1c,%eax

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_PCNET32=y
CONFIG_PPP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_RTC=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI=y
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_PL2303=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
