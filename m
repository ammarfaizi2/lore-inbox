Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUC2Mj3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUC2MjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:39:16 -0500
Received: from village.ehouse.ru ([193.111.92.18]:40460 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262870AbUC2Mgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:36:52 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.6.5-rc2-aa4
Date: Mon, 29 Mar 2004 15:36:38 +0300
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <20040326082100.GB9604@dualathlon.random>
In-Reply-To: <20040326082100.GB9604@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403291636.38698.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

On Friday 26 March 2004 11:21, Andrea Arcangeli wrote:
> Fixup an hugetlbfs prio-tree truncate bug.
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa4.gz
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa4/
> 
> Files 2.6.5-rc2-aa3/extraversion and 2.6.5-rc2-aa4/extraversion differ
> 
> 	Rediffed.
> 
> Files 2.6.5-rc2-aa3/prio-tree.gz and 2.6.5-rc2-aa4/prio-tree.gz differ
> 
> 	Avoid missing vmas starting at pg_off > truncate offset in
> 	hugetlbfs truncate. From Rajesh Venkatasubramanian.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Here is what I get after one day of uptime:

------------[ cut here ]------------
kernel BUG at mm/objrmap.c:111!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c0142ed7>]    Not tainted
EFLAGS: 00010282   (2.6.5-rc2-aa4)
EIP is at find_pte+0xa7/0xc0
eax: f47d8d20   ebx: dd0ae8c0   ecx: f3734700   edx: 40650000
esi: 40622000   edi: c176d900   ebp: 00000000   esp: c19abdc4
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 7, threadinfo=c19aa000 task=c19af140)
Stack: dd0ae8c0 00000000 00000000 c176d900 c0142f17 dd0ae8c0 e71f9e90 c0143119
       00000000 c176d900 c02c73f0 c19aa000 c01431a7 c176d910 c013a839 c1262760
       c15b7000 c02c7400 00000001 00000000 00000000 c19abf00 000000f4 c17b2b30
Call Trace:
 [<c0142f17>] page_referenced_one+0x27/0x70
 [<c0143119>] page_referenced_anon+0x39/0x80
 [<c01431a7>] page_referenced+0x47/0x60
 [<c013a839>] refill_inactive_zone+0x489/0x580
 [<c013991f>] shrink_slab+0x7f/0x180
 [<c013a9d4>] shrink_zone+0xa4/0xb0
 [<c013ad51>] balance_pgdat+0x1b1/0x210
 [<c013aeb8>] kswapd+0x108/0x120
 [<c0116580>] autoremove_wake_function+0x0/0x40
 [<c0106c82>] ret_from_fork+0x6/0x14
 [<c0116580>] autoremove_wake_function+0x0/0x40
 [<c013adb0>] kswapd+0x0/0x120
 [<c0104ddd>] kernel_thread_helper+0x5/0x18

Code: 0f 0b 6f 00 1d 42 29 c0 eb cf eb 0d 90 90 90 90 90 90 90 90
 <6>note: kswapd0[7] exited with preempt_count 3


rathamahata@dev rathamahata $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.130
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 989.18

rathamahata@dev rathamahata $ free -k
             total       used       free     shared    buffers     cached
Mem:       1037612    1034464       3148          0       7208     468728
-/+ buffers/cache:     558528     479084
Swap:      2939852      93128    2846724

rathamahata@dev linux-2.6.5-rc2-aa4 $ cat .config | egrep -v '^#' |  egrep -v '^$'
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
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
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_TSC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_SYN_COOKIES=y
CONFIG_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
CONFIG_NETPOLL_RX=y
CONFIG_NETPOLL_TRAP=y
CONFIG_NET_POLL_CONTROLLER=y
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
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_EXT2_FS=m
CONFIG_REISERFS_FS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_UDF_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="koi8-r"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_UTF8=m
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y
rathamahata@dev linux-2.6.5-rc2-aa4 $


-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
