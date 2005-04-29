Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVD2NAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVD2NAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVD2NAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:00:40 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:17646 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262539AbVD2M7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 08:59:45 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: ftp server crashes on heavy load: possible scheduler bug
From: Alexander Nyberg <alexn@dsv.su.se>
To: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org, rnl@rnl.ist.utl.pt
In-Reply-To: <200504261402.57375.pjvenda@rnl.ist.utl.pt>
References: <200504261402.57375.pjvenda@rnl.ist.utl.pt>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 14:59:38 +0200
Message-Id: <1114779578.497.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We've made some changes on our ftp server, and since that it's been crashing 
> frequently (everyday) with a kernel panic. 
> 
> We've configured the 5 IDE 160GB drives into md raid5 arrays with LVM on top 
> of that. All filesystems are reiserfs. The other change we made to the server 
> was changing from a patched 2.6.10-ac12 kernel into a newer 2.6.11.7.
> 
> Not being able to see the whole stacktrace on screen, we've started a 
> netconsole to investigate. Started the server and loaded it pretty bad with 
> rsyncs and such... until it crashed after just 20 minutes.
> 
> The netconsole log was surprising - "kernel BUG at kernel/sched.c:2634!"
> 
> Any help would be GREATLY appreciated.
> 


5 IDE disks into one MD raid5 into one LVM volume with reiserfs on top
of it? Could you give me some way to reproduce the specific load you put
on the machine plus your .config and I'll see what I can do.


> information is also attached:
> netconsole crashdump: ftp.crashdump.log
> ver_linux script output: ftp.ver_linux.out
> kernel configuration: ftp.kernelconfig
> 
> netconsole crashdump:
> ------------[ cut here ]------------
> kernel BUG at kernel/sched.c:2634!
> invalid operand: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c0112938>]    Not tainted VLI
> EFLAGS: 00010082   (2.6.11.7)
> EIP is at add_preempt_count+0x28/0x40
> eax: b8a4168c   ebx: c33f217c   ecx: 00000001   edx: c33f2000
> esi: c03cda55   edi: c0103480   ebp: c33f2070   esp: c33f2070
> ds: 007b   es: 007b   ss: 0068
> Recursive die() failure, output suppressed
>  <1>Unable to handle kernel paging request at virtual address 322f2e9a
>  printing eip:
> c010dc01
> *pde = 00000000
> Oops: 0000 [#2]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c010dc01>]    Not tainted VLI
> EFLAGS: 00010002   (2.6.11.7)
> EIP is at do_page_fault+0xa1/0x5d5
> eax: c04db000   ebx: 0000000b   ecx: 0000000d   edx: 00030001
> esi: 0000000e   edi: c03cea74   ebp: 322f2e2e   esp: c04db0fc
> ds: 007b   es: 007b   ss: 0068
> Process pure-ftpd (pid: 2792, threadinfo=c04da000 task=cc8c2520)
> Stack: c04d804c 0000000d c04db11c 00000000 00000000 322f2e9a 00000000 c04db1d0
>        c04db1d0 c03cea74 00000000 0000000e 0000000b 00000000 00000000 00000000
>        00000000 00000000 00030001 00000000 00000000 00000000 00000000 00000000
> Call Trace:
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c0111c78>] recalc_task_prio+0x88/0x150
>  [<c0111e7a>] try_to_wake_up+0x8a/0xc0
>  [<c0111c78>] recalc_task_prio+0x88/0x150
>  [<c0111c78>] recalc_task_prio+0x88/0x150
>  [<c0111da2>] activate_task+0x62/0x80
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c012007b>] __exit_signal+0xfb/0x160
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c022efd2>] __delay+0x12/0x20
>  [<c02bd7d0>] ide_dma_intr+0x0/0xb0
>  [<c02b7bef>] ide_execute_command+0xaf/0xe0
>  [<c02bdea3>] ide_dma_exec_cmd+0x33/0x40
>  [<c02bdee5>] ide_dma_start+0x35/0x50
>  [<c02bfcd1>] __ide_do_rw_disk+0x311/0x5d0
>  [<c022efd2>] __delay+0x12/0x20
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c012ab3f>] autoremove_wake_function+0x2f/0x60
>  [<c01129f1>] __wake_up_common+0x41/0x70
>  [<c0111c78>] recalc_task_prio+0x88/0x150
>  [<c0111da2>] activate_task+0x62/0x80
>  [<c0111e7a>] try_to_wake_up+0x8a/0xc0
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c010dc01>] do_page_fault+0xa1/0x5d5
>  [<c0135f3d>] mempool_free+0xbd/0xe0
>  [<c029468c>] as_put_request+0x7c/0xd0
>  [<c028ceac>] __freed_request+0x9c/0xb0
>  [<c028cee9>] freed_request+0x29/0xa0
>  [<c028ecd1>] end_that_request_last+0x61/0xd0
>  [<c010db60>] do_page_fault+0x0/0x5d5
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c0112515>] account_system_time+0x15/0xf0
>  [<c011f13a>] update_process_times+0x10a/0x110
>  [<c0106c85>] timer_interrupt+0x45/0x110
>  [<c0130dd0>] handle_IRQ_event+0x30/0x70
>  [<c0130eec>] __do_IRQ+0xdc/0x160
>  [<c01042f7>] do_IRQ+0x47/0x70
>  =======================
>  [<c0103480>] do_invalid_op+0x0/0xd0
>  [<c01028be>] common_interrupt+0x1a/0x20
>  [<c0103480>] do_invalid_op+0x0/0xd0
>  [<c0103030>] die+0x110/0x190
>  [<c010e696>] fixup_exception+0x16/0x40
>  [<c0112938>] add_preempt_count+0x28/0x40
>  [<c0103193>] do_trap+0xe3/0x120
>  [<c0103532>] do_invalid_op+0xb2/0xd0
>  [<c0112938>] add_preempt_count+0x28/0x40
>  [<c01028f7>] error_code+0x2b/0x30
>  [<c0103480>] do_invalid_op+0x0/0xd0
>  =======================
> Unable to handle kernel paging request at virtual address 312d6572
>  printing eip:
> c0102b8e
> *pde = 00000000
> Oops: 0000 [#3]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c0102b8e>]    Not tainted VLI
> EFLAGS: 00010093   (2.6.11.7)
> EIP is at show_trace+0x2e/0x90
> eax: 312d6ffd   ebx: 312d6572   ecx: 00000000   edx: 00000001
> esi: 312d6572   edi: 312d6000   ebp: 00000001   esp: c04daf58
> ds: 007b   es: 007b   ss: 0068
> Process pure-ftpd (pid: 2792, threadinfo=c04da000 task=cc8c2520)
> Stack: c03cd965 c0103480 c04db15c 00000018 00000000 c0102c70 00000000 c04db0fc
>        c04db0fc c04db0c8 00000000 c0102df8 00000000 c04db0fc 00000ae8 c04da000
>        cc8c2520 00010002 c0414402 c04db0c8 c03cead6 c03cea74 cc8c2520 c0103014
> Call Trace:
>  [<c0103480>] do_invalid_op+0x0/0xd0
>  [<c0102c70>] show_stack+0x80/0xa0
>  [<c0102df8>] show_registers+0x148/0x1b0
>  [<c0103014>] die+0xf4/0x190
>  [<c01162d7>] printk+0x17/0x20
>  [<c010de3a>] do_page_fault+0x2da/0x5d5
>  =======================
>  [<c013229d>] add_to_page_cache+0xad/0xd0
>  [<c0177ae1>] mpage_readpages+0x131/0x160
>  [<c0193f30>] reiserfs_get_block+0x0/0x14e0
>  [<c0136bf1>] __rmqueue+0xb1/0xf0
>  [<c0136c5e>] rmqueue_bulk+0x2e/0x90
>  [<c0136b30>] prep_new_page+0x60/0x70
>  [<c01399f2>] read_pages+0x132/0x140
>  [<c0193f30>] reiserfs_get_block+0x0/0x14e0
>  [<c0137573>] __alloc_pages+0x2e3/0x420
>  [<c0139b07>] __do_page_cache_readahead+0x107/0x190
>  [<c0133a2f>] filemap_nopage+0x2ff/0x3e0
>  [<c01427ef>](chunking)
> 
> ver_linux script output:
> ftp scripts # ./ver_linux 
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>  
> Linux ftp 2.6.11.7 #4 Tue Apr 26 10:53:58 WEST 2005 i686 Intel(R) Pentium(R) 4 
> CPU 2.00GHz GenuineIntel GNU/Linux
>  
> Gnu C                  3.3.5-20050130
> Gnu make               3.80
> binutils               2.15.92.0.2
> util-linux             2.12i
> mount                  2.12i
> module-init-tools      3.0
> e2fsprogs              1.35
> reiserfsprogs          3.6.19
> reiser4progs           line
> Linux C Library        2.3.4
> Dynamic linker (ldd)   2.3.4
> Procps                 3.2.4
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               5.2.1
> udev                   045
> ftp scripts # 
> 
> kernel configuration:
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_EXPERIMENTAL=y
> CONFIG_CLEAN_COMPILE=y
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_LOCK_KERNEL=y
> CONFIG_LOCALVERSION=""
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_SYSCTL=y
> CONFIG_AUDIT=y
> CONFIG_AUDITSYSCALL=y
> CONFIG_LOG_BUF_SHIFT=14
> CONFIG_HOTPLUG=y
> CONFIG_KOBJECT_UEVENT=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_KALLSYMS=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SHMEM=y
> CONFIG_CC_ALIGN_FUNCTIONS=0
> CONFIG_CC_ALIGN_LABELS=0
> CONFIG_CC_ALIGN_LOOPS=0
> CONFIG_CC_ALIGN_JUMPS=0
> CONFIG_X86_PC=y
> CONFIG_MPENTIUM4=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=7
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_BKL=y
> CONFIG_X86_TSC=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCE_NONFATAL=y
> CONFIG_NOHIGHMEM=y
> CONFIG_MTRR=y
> CONFIG_HAVE_DEC_LOCK=y
> CONFIG_PM=y
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_BLACKLIST_YEAR=0
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_PCI=y
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_LEGACY_PROC=y
> CONFIG_PCI_NAMES=y
> CONFIG_ISA=y
> CONFIG_PCMCIA_PROBE=y
> CONFIG_BINFMT_ELF=y
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> CONFIG_PNP=y
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV_FD=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_CRYPTOLOOP=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_LBD=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_IDE_GENERIC=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_PIIX=y
> CONFIG_BLK_DEV_PDC202XX_NEW=y
> CONFIG_BLK_DEV_SIS5513=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_RAID1=y
> CONFIG_MD_RAID5=y
> CONFIG_BLK_DEV_DM=y
> CONFIG_DM_CRYPT=y
> CONFIG_DM_SNAPSHOT=y
> CONFIG_DM_MIRROR=y
> CONFIG_DM_ZERO=y
> CONFIG_NET=y
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_TCPDIAG=y
> CONFIG_IP_TCPDIAG_IPV6=y
> CONFIG_IPV6=y
> CONFIG_IPV6_PRIVACY=y
> CONFIG_INET6_AH=y
> CONFIG_INET6_ESP=y
> CONFIG_INET6_IPCOMP=y
> CONFIG_INET6_TUNNEL=y
> CONFIG_IPV6_TUNNEL=y
> CONFIG_NETFILTER=y
> CONFIG_IP_NF_CONNTRACK=y
> CONFIG_IP_NF_CT_ACCT=y
> CONFIG_IP_NF_CONNTRACK_MARK=y
> CONFIG_IP_NF_CT_PROTO_SCTP=y
> CONFIG_IP_NF_FTP=y
> CONFIG_IP_NF_IRC=y
> CONFIG_IP_NF_TFTP=y
> CONFIG_IP_NF_AMANDA=y
> CONFIG_IP_NF_QUEUE=y
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_MATCH_LIMIT=y
> CONFIG_IP_NF_MATCH_IPRANGE=y
> CONFIG_IP_NF_MATCH_MAC=y
> CONFIG_IP_NF_MATCH_PKTTYPE=y
> CONFIG_IP_NF_MATCH_MARK=y
> CONFIG_IP_NF_MATCH_MULTIPORT=y
> CONFIG_IP_NF_MATCH_TOS=y
> CONFIG_IP_NF_MATCH_RECENT=y
> CONFIG_IP_NF_MATCH_ECN=y
> CONFIG_IP_NF_MATCH_DSCP=y
> CONFIG_IP_NF_MATCH_AH_ESP=y
> CONFIG_IP_NF_MATCH_LENGTH=y
> CONFIG_IP_NF_MATCH_TTL=y
> CONFIG_IP_NF_MATCH_TCPMSS=y
> CONFIG_IP_NF_MATCH_HELPER=y
> CONFIG_IP_NF_MATCH_STATE=y
> CONFIG_IP_NF_MATCH_CONNTRACK=y
> CONFIG_IP_NF_MATCH_OWNER=y
> CONFIG_IP_NF_MATCH_ADDRTYPE=y
> CONFIG_IP_NF_MATCH_REALM=y
> CONFIG_IP_NF_MATCH_SCTP=y
> CONFIG_IP_NF_MATCH_COMMENT=y
> CONFIG_IP_NF_MATCH_CONNMARK=y
> CONFIG_IP_NF_MATCH_HASHLIMIT=y
> CONFIG_IP_NF_FILTER=y
> CONFIG_IP_NF_TARGET_REJECT=y
> CONFIG_IP_NF_TARGET_LOG=y
> CONFIG_IP_NF_TARGET_ULOG=y
> CONFIG_IP_NF_TARGET_TCPMSS=y
> CONFIG_IP_NF_NAT=y
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=y
> CONFIG_IP_NF_TARGET_REDIRECT=y
> CONFIG_IP_NF_TARGET_NETMAP=y
> CONFIG_IP_NF_TARGET_SAME=y
> CONFIG_IP_NF_NAT_SNMP_BASIC=y
> CONFIG_IP_NF_NAT_IRC=y
> CONFIG_IP_NF_NAT_FTP=y
> CONFIG_IP_NF_NAT_TFTP=y
> CONFIG_IP_NF_NAT_AMANDA=y
> CONFIG_IP_NF_MANGLE=y
> CONFIG_IP_NF_TARGET_TOS=y
> CONFIG_IP_NF_TARGET_ECN=y
> CONFIG_IP_NF_TARGET_DSCP=y
> CONFIG_IP_NF_TARGET_MARK=y
> CONFIG_IP_NF_TARGET_CLASSIFY=y
> CONFIG_IP_NF_TARGET_CONNMARK=y
> CONFIG_IP_NF_TARGET_CLUSTERIP=y
> CONFIG_IP_NF_RAW=y
> CONFIG_IP_NF_TARGET_NOTRACK=y
> CONFIG_IP_NF_ARPTABLES=y
> CONFIG_IP_NF_ARPFILTER=y
> CONFIG_IP_NF_ARP_MANGLE=y
> CONFIG_IP6_NF_QUEUE=y
> CONFIG_IP6_NF_IPTABLES=y
> CONFIG_IP6_NF_MATCH_LIMIT=y
> CONFIG_IP6_NF_MATCH_MAC=y
> CONFIG_IP6_NF_MATCH_RT=y
> CONFIG_IP6_NF_MATCH_OPTS=y
> CONFIG_IP6_NF_MATCH_FRAG=y
> CONFIG_IP6_NF_MATCH_HL=y
> CONFIG_IP6_NF_MATCH_MULTIPORT=y
> CONFIG_IP6_NF_MATCH_OWNER=y
> CONFIG_IP6_NF_MATCH_MARK=y
> CONFIG_IP6_NF_MATCH_IPV6HEADER=y
> CONFIG_IP6_NF_MATCH_AHESP=y
> CONFIG_IP6_NF_MATCH_LENGTH=y
> CONFIG_IP6_NF_MATCH_EUI64=y
> CONFIG_IP6_NF_FILTER=y
> CONFIG_IP6_NF_TARGET_LOG=y
> CONFIG_IP6_NF_MANGLE=y
> CONFIG_IP6_NF_TARGET_MARK=y
> CONFIG_IP6_NF_RAW=y
> CONFIG_XFRM=y
> CONFIG_NET_CLS_ROUTE=y
> CONFIG_NETPOLL=y
> CONFIG_NET_POLL_CONTROLLER=y
> CONFIG_NETDEVICES=y
> CONFIG_DUMMY=y
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> CONFIG_NET_VENDOR_3COM=y
> CONFIG_EL3=y
> CONFIG_NET_TULIP=y
> CONFIG_NET_PCI=y
> CONFIG_E100=y
> CONFIG_8139CP=y
> CONFIG_8139TOO=y
> CONFIG_8139TOO_PIO=y
> CONFIG_NETCONSOLE=y
> CONFIG_INPUT=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_LIBPS2=y
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_CORE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_HW_RANDOM=y
> CONFIG_NVRAM=y
> CONFIG_RTC=y
> CONFIG_HPET=y
> CONFIG_HPET_RTC_IRQ=y
> CONFIG_HPET_MMAP=y
> CONFIG_HANGCHECK_TIMER=y
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB_ARCH_HAS_OHCI=y
> CONFIG_EXT2_FS=y
> CONFIG_REISERFS_FS=y
> CONFIG_REISERFS_PROC_INFO=y
> CONFIG_REISERFS_FS_XATTR=y
> CONFIG_REISERFS_FS_POSIX_ACL=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_DNOTIFY=y
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_ZISOFS_FS=y
> CONFIG_UDF_FS=y
> CONFIG_UDF_NLS=y
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> CONFIG_DEVFS_FS=y
> CONFIG_DEVFS_MOUNT=y
> CONFIG_TMPFS=y
> CONFIG_RAMFS=y
> CONFIG_CIFS=y
> CONFIG_CIFS_STATS=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_860=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_4KSTACKS=y
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_WP512=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_SERPENT=y
> CONFIG_CRYPTO_AES_586=y
> CONFIG_CRYPTO_CAST5=y
> CONFIG_CRYPTO_CAST6=y
> CONFIG_CRYPTO_TEA=y
> CONFIG_CRYPTO_ARC4=y
> CONFIG_CRYPTO_KHAZAD=y
> CONFIG_CRYPTO_ANUBIS=y
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_TEST=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC32=y
> CONFIG_LIBCRC32C=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_PC=y
> 
-- 
Alexander Nyberg <alexn@dsv.su.se>

