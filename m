Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285378AbRLNOAw>; Fri, 14 Dec 2001 09:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285380AbRLNOAn>; Fri, 14 Dec 2001 09:00:43 -0500
Received: from raq381.uk2net.com ([213.239.42.214]:53008 "EHLO
	raq381.uk2net.com") by vger.kernel.org with ESMTP
	id <S285378AbRLNOAe>; Fri, 14 Dec 2001 09:00:34 -0500
Date: Fri, 14 Dec 2001 14:00:31 +0000
From: Andrew Wood <kernel@ivarch.com>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.4.17-rc1 on K7 shortly after booting
Message-ID: <20011214140031.A4930@raq381.uk2net.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii

An Oops keeps happening using kernel 2.4.17-rc1 on a Squid transparent proxy
server machine I run. It happens shortly after everything has finished
mounting, booting, etc (10-30 seconds after entering runlevel 3) and it is
always the Distributed.Net client (dnetc) which is listed in the oops.

The machine is an 1GHz Athlon with 512MB of RAM, a 40GB IDE HDD, and an
RTL8139-based NIC. It had been running fine on 2.4.16-pre1 for a while.

NB modules are disabled, Ext3 is being used, and ipchains support is needed;
those are the only non-standard-ish things I can think of in there.

Attached is the oops report as processed by ksymoops, along with a copy of
the useful parts of the .config file, plus a software version list.

For more information, including System.map and copies of vmlinux and other
relevant files from when I tried two more times with slightly different
configurations, plus "lspci -vv" output so people more knowledgeable than I
can tell what's actually in the box, I've put up a page:

  http://www.ivarch.com/oops-2.4.17-rc1/

Thanks,

- Andrew

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.4.3 on i686 2.4.16-pre1.  Options used
     -v /boot/vmlinux-2.4.17-rc1 (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.17-rc1 (specified)

Unable to handle kernel paging request at virtual address 00001434
00001434
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00001434>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c0259514   ebx: 00000064     ecx: dea7f91c       edx: c0259514
esi: c0258080   edi: 00000000     ebp: 00001434       esp: dec8df50
ds: 0018        es: 0018       ss: 0018
Process dnetc (pid: 694, stackpage=dec8d000)
Stack:  c01169cc 00000064 00000000 c0258080 00000000 c0258340 c0116a51 c010ad46
        dec8dfc4 c011393a c0113870 00000000 c0258340 00000001 fffffffe c011366d
        c0258340 00000000 00000000 c020b044 dec8dfbc 00000046 c010813f 00000003
Call Trace: [<c01169cc>] [<c0116a51>] [<c010ad46>] [<c011393a>] [<c0113870>] [<c011366d>] [<c010813f>] [<c0109f98>]
Code: Bad EIP value.

>>EIP; 00001434 Before first symbol   <=====
Trace; c01169cc <timer_bh+21c/260>
Trace; c0116a50 <do_timer+40/80>
Trace; c010ad46 <timer_interrupt+76/130>
Trace; c011393a <bh_action+1a/50>
Trace; c0113870 <tasklet_hi_action+40/60>
Trace; c011366c <do_softirq+5c/b0>
Trace; c010813e <do_IRQ+9e/b0>
Trace; c0109f98 <call_do_IRQ+6/e>

 <0>Kernel panic: Aiee, killing interrupt handler!

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=stripped-config

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
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
CONFIG_NOHIGHMEM=y
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
CONFIG_BLK_DEV_FD=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=y
CONFIG_8139TOO=y
CONFIG_SIS900=y
CONFIG_WINBOND_840=y
CONFIG_PPP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_QUOTA=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="versions.txt"

Kernel modules         2.3.21
Gnu C                  egcs-2.91.66
Binutils               2.9.5.0.22  
Linux C Library        2.4.so
Procps                 2.0.6 
Mount                  2.10r 
Net-tools              (1999-04-20)
Kbd                    (console-tools) 0.3.3
Sh-utils               2.0

--yrj/dFKFPuw6o+aM--
