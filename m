Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVDZOD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVDZOD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVDZOD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:03:26 -0400
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:18104 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S261517AbVDZOA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:00:28 -0400
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: ftp server crashes on heavy load: possible scheduler bug
User-Agent: KMail/1.8
Cc: rnl@rnl.ist.utl.pt
MIME-Version: 1.0
Date: Tue, 26 Apr 2005 14:02:54 +0100
Content-Type: multipart/signed;
  boundary="nextPart1152416.Be1h076jPO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504261402.57375.pjvenda@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1152416.Be1h076jPO
Content-Type: multipart/mixed;
  boundary="Boundary-01=_+vjbCdh8Usdghds"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_+vjbCdh8Usdghds
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi everyone,

We've made some changes on our ftp server, and since that it's been crashin=
g=20
frequently (everyday) with a kernel panic.=20

We've configured the 5 IDE 160GB drives into md raid5 arrays with LVM on to=
p=20
of that. All filesystems are reiserfs. The other change we made to the serv=
er=20
was changing from a patched 2.6.10-ac12 kernel into a newer 2.6.11.7.

Not being able to see the whole stacktrace on screen, we've started a=20
netconsole to investigate. Started the server and loaded it pretty bad with=
=20
rsyncs and such... until it crashed after just 20 minutes.

The netconsole log was surprising - "kernel BUG at kernel/sched.c:2634!"

Any help would be GREATLY appreciated.

information is also attached:
netconsole crashdump: ftp.crashdump.log
ver_linux script output: ftp.ver_linux.out
kernel configuration: ftp.kernelconfig

netconsole crashdump:
=2D-----------[ cut here ]------------
kernel BUG at kernel/sched.c:2634!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c0112938>]    Not tainted VLI
EFLAGS: 00010082   (2.6.11.7)
EIP is at add_preempt_count+0x28/0x40
eax: b8a4168c   ebx: c33f217c   ecx: 00000001   edx: c33f2000
esi: c03cda55   edi: c0103480   ebp: c33f2070   esp: c33f2070
ds: 007b   es: 007b   ss: 0068
Recursive die() failure, output suppressed
 <1>Unable to handle kernel paging request at virtual address 322f2e9a
 printing eip:
c010dc01
*pde =3D 00000000
Oops: 0000 [#2]
PREEMPT
CPU:    0
EIP:    0060:[<c010dc01>]    Not tainted VLI
EFLAGS: 00010002   (2.6.11.7)
EIP is at do_page_fault+0xa1/0x5d5
eax: c04db000   ebx: 0000000b   ecx: 0000000d   edx: 00030001
esi: 0000000e   edi: c03cea74   ebp: 322f2e2e   esp: c04db0fc
ds: 007b   es: 007b   ss: 0068
Process pure-ftpd (pid: 2792, threadinfo=3Dc04da000 task=3Dcc8c2520)
Stack: c04d804c 0000000d c04db11c 00000000 00000000 322f2e9a 00000000 c04db=
1d0
       c04db1d0 c03cea74 00000000 0000000e 0000000b 00000000 00000000 00000=
000
       00000000 00000000 00030001 00000000 00000000 00000000 00000000 00000=
000
Call Trace:
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c0111c78>] recalc_task_prio+0x88/0x150
 [<c0111e7a>] try_to_wake_up+0x8a/0xc0
 [<c0111c78>] recalc_task_prio+0x88/0x150
 [<c0111c78>] recalc_task_prio+0x88/0x150
 [<c0111da2>] activate_task+0x62/0x80
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c012007b>] __exit_signal+0xfb/0x160
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c022efd2>] __delay+0x12/0x20
 [<c02bd7d0>] ide_dma_intr+0x0/0xb0
 [<c02b7bef>] ide_execute_command+0xaf/0xe0
 [<c02bdea3>] ide_dma_exec_cmd+0x33/0x40
 [<c02bdee5>] ide_dma_start+0x35/0x50
 [<c02bfcd1>] __ide_do_rw_disk+0x311/0x5d0
 [<c022efd2>] __delay+0x12/0x20
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c012ab3f>] autoremove_wake_function+0x2f/0x60
 [<c01129f1>] __wake_up_common+0x41/0x70
 [<c0111c78>] recalc_task_prio+0x88/0x150
 [<c0111da2>] activate_task+0x62/0x80
 [<c0111e7a>] try_to_wake_up+0x8a/0xc0
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c0135f3d>] mempool_free+0xbd/0xe0
 [<c029468c>] as_put_request+0x7c/0xd0
 [<c028ceac>] __freed_request+0x9c/0xb0
 [<c028cee9>] freed_request+0x29/0xa0
 [<c028ecd1>] end_that_request_last+0x61/0xd0
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c0112515>] account_system_time+0x15/0xf0
 [<c011f13a>] update_process_times+0x10a/0x110
 [<c0106c85>] timer_interrupt+0x45/0x110
 [<c0130dd0>] handle_IRQ_event+0x30/0x70
 [<c0130eec>] __do_IRQ+0xdc/0x160
 [<c01042f7>] do_IRQ+0x47/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c0103480>] do_invalid_op+0x0/0xd0
 [<c01028be>] common_interrupt+0x1a/0x20
 [<c0103480>] do_invalid_op+0x0/0xd0
 [<c0103030>] die+0x110/0x190
 [<c010e696>] fixup_exception+0x16/0x40
 [<c0112938>] add_preempt_count+0x28/0x40
 [<c0103193>] do_trap+0xe3/0x120
 [<c0103532>] do_invalid_op+0xb2/0xd0
 [<c0112938>] add_preempt_count+0x28/0x40
 [<c01028f7>] error_code+0x2b/0x30
 [<c0103480>] do_invalid_op+0x0/0xd0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Unable to handle kernel paging request at virtual address 312d6572
 printing eip:
c0102b8e
*pde =3D 00000000
Oops: 0000 [#3]
PREEMPT
CPU:    0
EIP:    0060:[<c0102b8e>]    Not tainted VLI
EFLAGS: 00010093   (2.6.11.7)
EIP is at show_trace+0x2e/0x90
eax: 312d6ffd   ebx: 312d6572   ecx: 00000000   edx: 00000001
esi: 312d6572   edi: 312d6000   ebp: 00000001   esp: c04daf58
ds: 007b   es: 007b   ss: 0068
Process pure-ftpd (pid: 2792, threadinfo=3Dc04da000 task=3Dcc8c2520)
Stack: c03cd965 c0103480 c04db15c 00000018 00000000 c0102c70 00000000 c04db=
0fc
       c04db0fc c04db0c8 00000000 c0102df8 00000000 c04db0fc 00000ae8 c04da=
000
       cc8c2520 00010002 c0414402 c04db0c8 c03cead6 c03cea74 cc8c2520 c0103=
014
Call Trace:
 [<c0103480>] do_invalid_op+0x0/0xd0
 [<c0102c70>] show_stack+0x80/0xa0
 [<c0102df8>] show_registers+0x148/0x1b0
 [<c0103014>] die+0xf4/0x190
 [<c01162d7>] printk+0x17/0x20
 [<c010de3a>] do_page_fault+0x2da/0x5d5
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c013229d>] add_to_page_cache+0xad/0xd0
 [<c0177ae1>] mpage_readpages+0x131/0x160
 [<c0193f30>] reiserfs_get_block+0x0/0x14e0
 [<c0136bf1>] __rmqueue+0xb1/0xf0
 [<c0136c5e>] rmqueue_bulk+0x2e/0x90
 [<c0136b30>] prep_new_page+0x60/0x70
 [<c01399f2>] read_pages+0x132/0x140
 [<c0193f30>] reiserfs_get_block+0x0/0x14e0
 [<c0137573>] __alloc_pages+0x2e3/0x420
 [<c0139b07>] __do_page_cache_readahead+0x107/0x190
 [<c0133a2f>] filemap_nopage+0x2ff/0x3e0
 [<c01427ef>](chunking)

ver_linux script output:
ftp scripts # ./ver_linux=20
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux ftp 2.6.11.7 #4 Tue Apr 26 10:53:58 WEST 2005 i686 Intel(R) Pentium(R=
) 4=20
CPU 2.00GHz GenuineIntel GNU/Linux
=20
Gnu C                  3.3.5-20050130
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.19
reiser4progs           line
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.4
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   045
ftp scripts #=20

kernel configuration:
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_EXPERIMENTAL=3Dy
CONFIG_CLEAN_COMPILE=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_LOCK_KERNEL=3Dy
CONFIG_LOCALVERSION=3D""
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_AUDIT=3Dy
CONFIG_AUDITSYSCALL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_HOTPLUG=3Dy
CONFIG_KOBJECT_UEVENT=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_CC_ALIGN_FUNCTIONS=3D0
CONFIG_CC_ALIGN_LABELS=3D0
CONFIG_CC_ALIGN_LOOPS=3D0
CONFIG_CC_ALIGN_JUMPS=3D0
CONFIG_X86_PC=3Dy
CONFIG_MPENTIUM4=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_BKL=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
CONFIG_NOHIGHMEM=3Dy
CONFIG_MTRR=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy
CONFIG_PM=3Dy
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_BLACKLIST_YEAR=3D0
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_PCI_LEGACY_PROC=3Dy
CONFIG_PCI_NAMES=3Dy
CONFIG_ISA=3Dy
CONFIG_PCMCIA_PROBE=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
CONFIG_PNP=3Dy
CONFIG_PNPACPI=3Dy
CONFIG_BLK_DEV_FD=3Dy
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_CRYPTOLOOP=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_LBD=3Dy
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
CONFIG_IDE_GENERIC=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_PIIX=3Dy
CONFIG_BLK_DEV_PDC202XX_NEW=3Dy
CONFIG_BLK_DEV_SIS5513=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dy
CONFIG_MD_RAID1=3Dy
CONFIG_MD_RAID5=3Dy
CONFIG_BLK_DEV_DM=3Dy
CONFIG_DM_CRYPT=3Dy
CONFIG_DM_SNAPSHOT=3Dy
CONFIG_DM_MIRROR=3Dy
CONFIG_DM_ZERO=3Dy
CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_TCPDIAG=3Dy
CONFIG_IP_TCPDIAG_IPV6=3Dy
CONFIG_IPV6=3Dy
CONFIG_IPV6_PRIVACY=3Dy
CONFIG_INET6_AH=3Dy
CONFIG_INET6_ESP=3Dy
CONFIG_INET6_IPCOMP=3Dy
CONFIG_INET6_TUNNEL=3Dy
CONFIG_IPV6_TUNNEL=3Dy
CONFIG_NETFILTER=3Dy
CONFIG_IP_NF_CONNTRACK=3Dy
CONFIG_IP_NF_CT_ACCT=3Dy
CONFIG_IP_NF_CONNTRACK_MARK=3Dy
CONFIG_IP_NF_CT_PROTO_SCTP=3Dy
CONFIG_IP_NF_FTP=3Dy
CONFIG_IP_NF_IRC=3Dy
CONFIG_IP_NF_TFTP=3Dy
CONFIG_IP_NF_AMANDA=3Dy
CONFIG_IP_NF_QUEUE=3Dy
CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_MATCH_LIMIT=3Dy
CONFIG_IP_NF_MATCH_IPRANGE=3Dy
CONFIG_IP_NF_MATCH_MAC=3Dy
CONFIG_IP_NF_MATCH_PKTTYPE=3Dy
CONFIG_IP_NF_MATCH_MARK=3Dy
CONFIG_IP_NF_MATCH_MULTIPORT=3Dy
CONFIG_IP_NF_MATCH_TOS=3Dy
CONFIG_IP_NF_MATCH_RECENT=3Dy
CONFIG_IP_NF_MATCH_ECN=3Dy
CONFIG_IP_NF_MATCH_DSCP=3Dy
CONFIG_IP_NF_MATCH_AH_ESP=3Dy
CONFIG_IP_NF_MATCH_LENGTH=3Dy
CONFIG_IP_NF_MATCH_TTL=3Dy
CONFIG_IP_NF_MATCH_TCPMSS=3Dy
CONFIG_IP_NF_MATCH_HELPER=3Dy
CONFIG_IP_NF_MATCH_STATE=3Dy
CONFIG_IP_NF_MATCH_CONNTRACK=3Dy
CONFIG_IP_NF_MATCH_OWNER=3Dy
CONFIG_IP_NF_MATCH_ADDRTYPE=3Dy
CONFIG_IP_NF_MATCH_REALM=3Dy
CONFIG_IP_NF_MATCH_SCTP=3Dy
CONFIG_IP_NF_MATCH_COMMENT=3Dy
CONFIG_IP_NF_MATCH_CONNMARK=3Dy
CONFIG_IP_NF_MATCH_HASHLIMIT=3Dy
CONFIG_IP_NF_FILTER=3Dy
CONFIG_IP_NF_TARGET_REJECT=3Dy
CONFIG_IP_NF_TARGET_LOG=3Dy
CONFIG_IP_NF_TARGET_ULOG=3Dy
CONFIG_IP_NF_TARGET_TCPMSS=3Dy
CONFIG_IP_NF_NAT=3Dy
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
CONFIG_IP_NF_TARGET_REDIRECT=3Dy
CONFIG_IP_NF_TARGET_NETMAP=3Dy
CONFIG_IP_NF_TARGET_SAME=3Dy
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dy
CONFIG_IP_NF_NAT_IRC=3Dy
CONFIG_IP_NF_NAT_FTP=3Dy
CONFIG_IP_NF_NAT_TFTP=3Dy
CONFIG_IP_NF_NAT_AMANDA=3Dy
CONFIG_IP_NF_MANGLE=3Dy
CONFIG_IP_NF_TARGET_TOS=3Dy
CONFIG_IP_NF_TARGET_ECN=3Dy
CONFIG_IP_NF_TARGET_DSCP=3Dy
CONFIG_IP_NF_TARGET_MARK=3Dy
CONFIG_IP_NF_TARGET_CLASSIFY=3Dy
CONFIG_IP_NF_TARGET_CONNMARK=3Dy
CONFIG_IP_NF_TARGET_CLUSTERIP=3Dy
CONFIG_IP_NF_RAW=3Dy
CONFIG_IP_NF_TARGET_NOTRACK=3Dy
CONFIG_IP_NF_ARPTABLES=3Dy
CONFIG_IP_NF_ARPFILTER=3Dy
CONFIG_IP_NF_ARP_MANGLE=3Dy
CONFIG_IP6_NF_QUEUE=3Dy
CONFIG_IP6_NF_IPTABLES=3Dy
CONFIG_IP6_NF_MATCH_LIMIT=3Dy
CONFIG_IP6_NF_MATCH_MAC=3Dy
CONFIG_IP6_NF_MATCH_RT=3Dy
CONFIG_IP6_NF_MATCH_OPTS=3Dy
CONFIG_IP6_NF_MATCH_FRAG=3Dy
CONFIG_IP6_NF_MATCH_HL=3Dy
CONFIG_IP6_NF_MATCH_MULTIPORT=3Dy
CONFIG_IP6_NF_MATCH_OWNER=3Dy
CONFIG_IP6_NF_MATCH_MARK=3Dy
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dy
CONFIG_IP6_NF_MATCH_AHESP=3Dy
CONFIG_IP6_NF_MATCH_LENGTH=3Dy
CONFIG_IP6_NF_MATCH_EUI64=3Dy
CONFIG_IP6_NF_FILTER=3Dy
CONFIG_IP6_NF_TARGET_LOG=3Dy
CONFIG_IP6_NF_MANGLE=3Dy
CONFIG_IP6_NF_TARGET_MARK=3Dy
CONFIG_IP6_NF_RAW=3Dy
CONFIG_XFRM=3Dy
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NETPOLL=3Dy
CONFIG_NET_POLL_CONTROLLER=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_DUMMY=3Dy
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_EL3=3Dy
CONFIG_NET_TULIP=3Dy
CONFIG_NET_PCI=3Dy
CONFIG_E100=3Dy
CONFIG_8139CP=3Dy
CONFIG_8139TOO=3Dy
CONFIG_8139TOO_PIO=3Dy
CONFIG_NETCONSOLE=3Dy
CONFIG_INPUT=3Dy
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_LIBPS2=3Dy
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_CORE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
CONFIG_HW_RANDOM=3Dy
CONFIG_NVRAM=3Dy
CONFIG_RTC=3Dy
CONFIG_HPET=3Dy
CONFIG_HPET_RTC_IRQ=3Dy
CONFIG_HPET_MMAP=3Dy
CONFIG_HANGCHECK_TIMER=3Dy
CONFIG_VGA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_EXT2_FS=3Dy
CONFIG_REISERFS_FS=3Dy
CONFIG_REISERFS_PROC_INFO=3Dy
CONFIG_REISERFS_FS_XATTR=3Dy
CONFIG_REISERFS_FS_POSIX_ACL=3Dy
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dy
CONFIG_UDF_FS=3Dy
CONFIG_UDF_NLS=3Dy
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
CONFIG_DEVFS_FS=3Dy
CONFIG_DEVFS_MOUNT=3Dy
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_CIFS=3Dy
CONFIG_CIFS_STATS=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_860=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_DEBUG_PREEMPT=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_4KSTACKS=3Dy
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dy
CONFIG_CRYPTO_MD4=3Dy
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA256=3Dy
CONFIG_CRYPTO_SHA512=3Dy
CONFIG_CRYPTO_WP512=3Dy
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_BLOWFISH=3Dy
CONFIG_CRYPTO_TWOFISH=3Dy
CONFIG_CRYPTO_SERPENT=3Dy
CONFIG_CRYPTO_AES_586=3Dy
CONFIG_CRYPTO_CAST5=3Dy
CONFIG_CRYPTO_CAST6=3Dy
CONFIG_CRYPTO_TEA=3Dy
CONFIG_CRYPTO_ARC4=3Dy
CONFIG_CRYPTO_KHAZAD=3Dy
CONFIG_CRYPTO_ANUBIS=3Dy
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dy
CONFIG_CRYPTO_CRC32C=3Dy
CONFIG_CRYPTO_TEST=3Dy
CONFIG_CRC_CCITT=3Dy
CONFIG_CRC32=3Dy
CONFIG_LIBCRC32C=3Dy
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_PC=3Dy

=2D-=20

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administra=E7=E3o de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior T=E9cnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt

--Boundary-01=_+vjbCdh8Usdghds
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="ftp.crashdump.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ftp.crashdump.log"

=2D-----------[ cut here ]------------
kernel BUG at kernel/sched.c:2634!
invalid operand: 0000 [#1]
PREEMPT=20
CPU:    0
EIP:    0060:[<c0112938>]    Not tainted VLI
EFLAGS: 00010082   (2.6.11.7)=20
EIP is at add_preempt_count+0x28/0x40
eax: b8a4168c   ebx: c33f217c   ecx: 00000001   edx: c33f2000
esi: c03cda55   edi: c0103480   ebp: c33f2070   esp: c33f2070
ds: 007b   es: 007b   ss: 0068
Recursive die() failure, output suppressed
 <1>Unable to handle kernel paging request at virtual address 322f2e9a
 printing eip:
c010dc01
*pde =3D 00000000
Oops: 0000 [#2]
PREEMPT=20
CPU:    0
EIP:    0060:[<c010dc01>]    Not tainted VLI
EFLAGS: 00010002   (2.6.11.7)=20
EIP is at do_page_fault+0xa1/0x5d5
eax: c04db000   ebx: 0000000b   ecx: 0000000d   edx: 00030001
esi: 0000000e   edi: c03cea74   ebp: 322f2e2e   esp: c04db0fc
ds: 007b   es: 007b   ss: 0068
Process pure-ftpd (pid: 2792, threadinfo=3Dc04da000 task=3Dcc8c2520)
Stack: c04d804c 0000000d c04db11c 00000000 00000000 322f2e9a 00000000 c04db=
1d0=20
       c04db1d0 c03cea74 00000000 0000000e 0000000b 00000000 00000000 00000=
000=20
       00000000 00000000 00030001 00000000 00000000 00000000 00000000 00000=
000=20
Call Trace:
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c0111c78>] recalc_task_prio+0x88/0x150
 [<c0111e7a>] try_to_wake_up+0x8a/0xc0
 [<c0111c78>] recalc_task_prio+0x88/0x150
 [<c0111c78>] recalc_task_prio+0x88/0x150
 [<c0111da2>] activate_task+0x62/0x80
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c012007b>] __exit_signal+0xfb/0x160
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c022efd2>] __delay+0x12/0x20
 [<c02bd7d0>] ide_dma_intr+0x0/0xb0
 [<c02b7bef>] ide_execute_command+0xaf/0xe0
 [<c02bdea3>] ide_dma_exec_cmd+0x33/0x40
 [<c02bdee5>] ide_dma_start+0x35/0x50
 [<c02bfcd1>] __ide_do_rw_disk+0x311/0x5d0
 [<c022efd2>] __delay+0x12/0x20
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c012ab3f>] autoremove_wake_function+0x2f/0x60
 [<c01129f1>] __wake_up_common+0x41/0x70
 [<c0111c78>] recalc_task_prio+0x88/0x150
 [<c0111da2>] activate_task+0x62/0x80
 [<c0111e7a>] try_to_wake_up+0x8a/0xc0
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c010dc01>] do_page_fault+0xa1/0x5d5
 [<c0135f3d>] mempool_free+0xbd/0xe0
 [<c029468c>] as_put_request+0x7c/0xd0
 [<c028ceac>] __freed_request+0x9c/0xb0
 [<c028cee9>] freed_request+0x29/0xa0
 [<c028ecd1>] end_that_request_last+0x61/0xd0
 [<c010db60>] do_page_fault+0x0/0x5d5
 [<c01028f7>] error_code+0x2b/0x30
 [<c0112515>] account_system_time+0x15/0xf0
 [<c011f13a>] update_process_times+0x10a/0x110
 [<c0106c85>] timer_interrupt+0x45/0x110
 [<c0130dd0>] handle_IRQ_event+0x30/0x70
 [<c0130eec>] __do_IRQ+0xdc/0x160
 [<c01042f7>] do_IRQ+0x47/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c0103480>] do_invalid_op+0x0/0xd0
 [<c01028be>] common_interrupt+0x1a/0x20
 [<c0103480>] do_invalid_op+0x0/0xd0
 [<c0103030>] die+0x110/0x190
 [<c010e696>] fixup_exception+0x16/0x40
 [<c0112938>] add_preempt_count+0x28/0x40
 [<c0103193>] do_trap+0xe3/0x120
 [<c0103532>] do_invalid_op+0xb2/0xd0
 [<c0112938>] add_preempt_count+0x28/0x40
 [<c01028f7>] error_code+0x2b/0x30
 [<c0103480>] do_invalid_op+0x0/0xd0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Unable to handle kernel paging request at virtual address 312d6572
 printing eip:
c0102b8e
*pde =3D 00000000
Oops: 0000 [#3]
PREEMPT=20
CPU:    0
EIP:    0060:[<c0102b8e>]    Not tainted VLI
EFLAGS: 00010093   (2.6.11.7)=20
EIP is at show_trace+0x2e/0x90
eax: 312d6ffd   ebx: 312d6572   ecx: 00000000   edx: 00000001
esi: 312d6572   edi: 312d6000   ebp: 00000001   esp: c04daf58
ds: 007b   es: 007b   ss: 0068
Process pure-ftpd (pid: 2792, threadinfo=3Dc04da000 task=3Dcc8c2520)
Stack: c03cd965 c0103480 c04db15c 00000018 00000000 c0102c70 00000000 c04db=
0fc=20
       c04db0fc c04db0c8 00000000 c0102df8 00000000 c04db0fc 00000ae8 c04da=
000=20
       cc8c2520 00010002 c0414402 c04db0c8 c03cead6 c03cea74 cc8c2520 c0103=
014=20
Call Trace:
 [<c0103480>] do_invalid_op+0x0/0xd0
 [<c0102c70>] show_stack+0x80/0xa0
 [<c0102df8>] show_registers+0x148/0x1b0
 [<c0103014>] die+0xf4/0x190
 [<c01162d7>] printk+0x17/0x20
 [<c010de3a>] do_page_fault+0x2da/0x5d5
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c013229d>] add_to_page_cache+0xad/0xd0
 [<c0177ae1>] mpage_readpages+0x131/0x160
 [<c0193f30>] reiserfs_get_block+0x0/0x14e0
 [<c0136bf1>] __rmqueue+0xb1/0xf0
 [<c0136c5e>] rmqueue_bulk+0x2e/0x90
 [<c0136b30>] prep_new_page+0x60/0x70
 [<c01399f2>] read_pages+0x132/0x140
 [<c0193f30>] reiserfs_get_block+0x0/0x14e0
 [<c0137573>] __alloc_pages+0x2e3/0x420
 [<c0139b07>] __do_page_cache_readahead+0x107/0x190
 [<c0133a2f>] filemap_nopage+0x2ff/0x3e0
 [<c01427ef>](chunking)=20

--Boundary-01=_+vjbCdh8Usdghds
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ftp.ver_linux.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ftp.ver_linux.out"

ftp scripts # ./ver_linux=20
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
 Linux ftp 2.6.11.7 #4 Tue Apr 26 10:53:58 WEST 2005 i686 Intel(R) Pentium(=
R) 4 CPU 2.00GHz GenuineIntel GNU/Linux
 =20
  Gnu C                  3.3.5-20050130
  Gnu make               3.80
  binutils               2.15.92.0.2
  util-linux             2.12i
  mount                  2.12i
  module-init-tools      3.0
  e2fsprogs              1.35
  reiserfsprogs          3.6.19
  reiser4progs           line
  Linux C Library        2.3.4
  Dynamic linker (ldd)   2.3.4
  Procps                 3.2.4
  Net-tools              1.60
  Kbd                    1.12
  Sh-utils               5.2.1
  udev                   045
ftp scripts #=20

--Boundary-01=_+vjbCdh8Usdghds
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ftp.kernelconfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ftp.kernelconfig"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11.7
# Tue Apr 26 10:44:39 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID5=y
# CONFIG_MD_RAID6 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=y

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IP_TCPDIAG=y
CONFIG_IP_TCPDIAG_IPV6=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_IPCOMP=y
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_TUNNEL=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_CT_PROTO_SCTP=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_AMANDA=y
CONFIG_IP_NF_QUEUE=y
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
CONFIG_IP_NF_MATCH_ADDRTYPE=y
CONFIG_IP_NF_MATCH_REALM=y
CONFIG_IP_NF_MATCH_SCTP=y
CONFIG_IP_NF_MATCH_COMMENT=y
CONFIG_IP_NF_MATCH_CONNMARK=y
CONFIG_IP_NF_MATCH_HASHLIMIT=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_NAT_AMANDA=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_CONNMARK=y
CONFIG_IP_NF_TARGET_CLUSTERIP=y
CONFIG_IP_NF_RAW=y
CONFIG_IP_NF_TARGET_NOTRACK=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_MATCH_MAC=y
CONFIG_IP6_NF_MATCH_RT=y
CONFIG_IP6_NF_MATCH_OPTS=y
CONFIG_IP6_NF_MATCH_FRAG=y
CONFIG_IP6_NF_MATCH_HL=y
CONFIG_IP6_NF_MATCH_MULTIPORT=y
CONFIG_IP6_NF_MATCH_OWNER=y
CONFIG_IP6_NF_MATCH_MARK=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_MATCH_AHESP=y
CONFIG_IP6_NF_MATCH_LENGTH=y
CONFIG_IP6_NF_MATCH_EUI64=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_TARGET_MARK=y
CONFIG_IP6_NF_RAW=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=y
# CONFIG_3C515 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_E100_NAPI is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=y

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_RTC_IRQ=y
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=y

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
CONFIG_CIFS=y
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
CONFIG_4KSTACKS=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_TEST=y

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--Boundary-01=_+vjbCdh8Usdghds--

--nextPart1152416.Be1h076jPO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCbjwBeRy7HWZxjWERAo+jAKDTDSw4Bef/Onkwe8J1d1DSVR4zmwCfYGNt
tiHjTB6P0ZqUUT6AnUc4djQ=
=3CoF
-----END PGP SIGNATURE-----

--nextPart1152416.Be1h076jPO--
