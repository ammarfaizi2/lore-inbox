Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTCEMxh>; Wed, 5 Mar 2003 07:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbTCEMxD>; Wed, 5 Mar 2003 07:53:03 -0500
Received: from main.gmane.org ([80.91.224.249]:35206 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S266379AbTCEMwx>;
	Wed, 5 Mar 2003 07:52:53 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Metzler <lkml-2003-03@downhill.at.eu.org>
Subject: [2.4.21-pre5] compile error in ip_conntrack_ftp.c:440:
Date: Wed, 5 Mar 2003 12:56:37 +0000 (UTC)
Message-ID: <b44s65$pdl$1@main.gmane.org>
X-Complaints-To: usenet@main.gmane.org
X-Archive: encrypt
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.21-pre4 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since iirc 2.4.20 I get this error when compiling a kernel:
|-------------------
| make[2]: Entering directory `/tmp/KERNEL/linux-2.4.20-pre5/net/ipv4/netfilter'
| make[2]: Circular /tmp/KERNEL/linux-2.4.20-pre5/include/linux/netfilter_ipv4/ip_conntrack_helper.h <- /tmp/KERNEL/linux-2.4.20-pre5/include/linux/netfilter_ipv4/ip_conntrack.h dependency dropped.
| ld -m elf_i386 -r -o ip_conntrack.o ip_conntrack_standalone.o ip_conntrack_core.o ip_conntrack_proto_generic.o ip_conntrack_proto_tcp.o ip_conntrack_proto_udp.o ip_conntrack_proto_icmp.o
| gcc -D__KERNEL__ -I/tmp/KERNEL/linux-2.4.20-pre5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ip_conntrack_ftp  -c -o ip_conntrack_ftp.o ip_conntrack_ftp.c
| ip_conntrack_ftp.c:440: parse error before `this_object_must_be_defined_as_export_objs_in_the_Makefile'
| ip_conntrack_ftp.c:440: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'
| ip_conntrack_ftp.c:440: warning: data definition has no type or storage class
| make[2]: *** [ip_conntrack_ftp.o] Error 1
| make[2]: Leaving directory `/tmp/KERNEL/linux-2.4.20-pre5/net/ipv4/netfilter'
| make[1]: *** [_modsubdir_ipv4/netfilter] Error 2
| make[1]: Leaving directory `/tmp/KERNEL/linux-2.4.20-pre5/net'
| make: *** [_mod_net] Error 2
|-------------------

IIRC the error is in ip_conntrack_itc, too.

How to reproduce:
make mrproper
copy config below to .config
make menuconfig --> Exit&Save
make dep
# optional: make bzImage - Logfile above was generated this way
make modules

This looks exactly like
http://www.uwsg.iu.edu/hypermail/linux/kernel/0209.2/0923.html
but hasn't this been fixed since?

Please Cc me on replies.
            thanks, cu andreas

----------stripped down example config---------
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_KMOD=y
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
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BINFMT_ELF=y
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_INET_ECN=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
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
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_ZLIB_INFLATE=y
----------------------------------------

