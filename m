Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753244AbWKGVwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbWKGVwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbWKGVwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:52:07 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:18640 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1753242AbWKGVwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:52:04 -0500
Message-ID: <4550FFFB.3000602@garzik.org>
Date: Tue, 07 Nov 2006 16:51:55 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: slow UML on x86-64, soft lockups
Content-Type: multipart/mixed;
 boundary="------------010108020304090901070701"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010108020304090901070701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Recent 2.6.18 / 2.6.19-rc kernels run at the expected speed, on 32-bit 
x86, with a Fedora Core 5 or 6 UML userland.  However, on 64-bit x86-64 
with a 64-bit UML userland, the kernel is achingly slow.  It works, 
but...  Login takes several minutes (via ssh from host or xterm 
console), and soft lockup traces continually print to the screen (see 
output below).  Once logged into, programs work, but again, very slowly. 
  Commands which complete in under a second normally often takes minutes.

Any ideas?  I guess there is a bug in the 64-bit UML timer code?

	Jeff




BUG: soft lockup detected on CPU#0!
Call Trace:
61347c18:  [<6004a5be>] update_process_times+0x45/0x6d
61347c48:  [<60017d89>] timer_handler+0x31/0x58
61347c78:  [<600399f2>] sig_handler_common_skas+0xe6/0xfc
61347cb8:  [<60036d8e>] alarm_handler+0x4d/0x59
61347dc8:  [<6013da36>] __up_read+0x15/0x81
61347dd8:  [<6003705d>] set_signals+0x1a/0x2d
61347de8:  [<600188b6>] handle_page_fault+0x212/0x243
61347e48:  [<600189ef>] segv+0xa7/0x2ac
61347e88:  [<600196e2>] switch_to_skas+0x46/0x68
61347f28:  [<60018943>] segv_handler+0x5c/0x61
61347f48:  [<600384b4>] move_registers+0x33/0x4a
61347f68:  [<6003850e>] restore_registers+0x16/0x2e
61347f78:  [<6003925f>] userspace+0x5c/0x178
61347fd8:  [<60019808>] fork_handler+0x74/0x79

BUG: soft lockup detected on CPU#0!
Call Trace:
61347a98:  [<6004a5be>] update_process_times+0x45/0x6d
61347ac8:  [<60017d89>] timer_handler+0x31/0x58
61347af8:  [<600399f2>] sig_handler_common_skas+0xe6/0xfc
61347b28:  [<60019ad4>] do_ops+0x0/0x112
61347b38:  [<60036d8e>] alarm_handler+0x4d/0x59
61347bb8:  [<60019ad4>] do_ops+0x0/0x112
61347c08:  [<60018270>] fix_range_common+0x172/0x318
61347cc0:  [<60015c53>] find_phys_mapping+0x5/0x9
61347cf8:  [<600679ad>] free_hot_cold_page+0xe6/0x108
61347d18:  [<6003705d>] set_signals+0x1a/0x2d
61347d28:  [<6006dfd5>] zap_pte_range+0x197/0x225
61347d98:  [<60018333>] fix_range_common+0x235/0x318
61347da8:  [<60019ad4>] do_ops+0x0/0x112
61347e18:  [<6006d845>] free_pgtables+0x87/0x98
61347e58:  [<60072aa9>] unmap_region+0xe1/0xf0
61347ea8:  [<60072d29>] do_munmap+0xfc/0x11d
61347eb8:  [<60091e99>] mntput_no_expire+0x17/0x64
61347ee8:  [<60072d8f>] sys_munmap+0x45/0x61
61347ef8:  [<6007ecf0>] sys_close+0x7c/0xb1
61347f28:  [<60019abb>] handle_syscall+0x63/0x7c
61347f48:  [<60038ec4>] handle_trap+0xcb/0xd2
61347f78:  [<60039334>] userspace+0x131/0x178
61347fd8:  [<60019808>] fork_handler+0x74/0x79

BUG: soft lockup detected on CPU#0!
Call Trace:
60263bb8:  [<6004a5be>] update_process_times+0x45/0x6d
60263be8:  [<60017d89>] timer_handler+0x31/0x58
60263c18:  [<600399f2>] sig_handler_common_skas+0xe6/0xfc
60263c58:  [<60036d30>] real_alarm_handler+0x1e/0x2f
60263c68:  [<60036d8e>] alarm_handler+0x4d/0x59
60263cb8:  [<600169b5>] copy_to_user_proc+0x0/0x5
60263d98:  [<6003775a>] switch_timers+0x92/0xb2
60263e18:  [<600196fd>] switch_to_skas+0x61/0x68
60263e48:  [<60016588>] _switch_to+0x47/0x8d
60263e78:  [<601f35a2>] schedule+0x428/0x488
60263ec8:  [<600377bf>] idle_sleep+0x1e/0x23
60263ee8:  [<6001676d>] default_idle+0x2a/0x2c
60263ef8:  [<60036227>] os_getpid+0x10/0x12
60263f08:  [<60019934>] init_idle_skas+0x2c/0x30
60263f28:  [<6000153b>] start_kernel+0x1c7/0x1cc
60263f38:  [<60036227>] os_getpid+0x10/0x12
60263f48:  [<6001996b>] start_kernel_proc+0x33/0x3a
60263f68:  [<6003663b>] run_kernel_thread+0x42/0x4b
60263f78:  [<60019938>] start_kernel_proc+0x0/0x3a
60263fb8:  [<60036620>] run_kernel_thread+0x27/0x4b
60263fd8:  [<6001976b>] new_thread_handler+0x67/0x8f

BUG: soft lockup detected on CPU#0!
Call Trace:
61347788:  [<6004a5be>] update_process_times+0x45/0x6d
613477b8:  [<60017d89>] timer_handler+0x31/0x58
613477e8:  [<600399f2>] sig_handler_common_skas+0xe6/0xfc
61347828:  [<60036d8e>] alarm_handler+0x4d/0x59
61347890:  [<601620b3>] dev_queue_xmit+0x0/0x1cf
613478f8:  [<601620b5>] dev_queue_xmit+0x2/0x1cf
61347938:  [<601f35a2>] schedule+0x428/0x488
613479a8:  [<60053e20>] remove_wait_queue+0x15/0x45
613479b8:  [<6003705d>] set_signals+0x1a/0x2d
613479c8:  [<6008a46b>] free_poll_entry+0x11/0x1a
613479d8:  [<6008a49d>] poll_freewait+0x29/0x6a
613479e8:  [<60019cd0>] maybe_map+0x30/0x9e
61347a20:  [<6001a018>] copy_chunk_from_user+0x0/0x18
61347a28:  [<60019d51>] do_op_one_page+0x13/0x61
61347a48:  [<600470e1>] local_bh_enable+0x9/0x8b
61347a68:  [<60167006>] neigh_resolve_output+0x121/0x167
61347a98:  [<60176be2>] ip_output+0x16a/0x1ae
61347ad8:  [<60176f97>] ip_queue_xmit+0x371/0x3b9
61347b08:  [<60037ecd>] setjmp_wrapper+0x82/0xd5
61347b18:  [<60185e0f>] tcp_cwnd_restart+0x1e/0xcc
61347b68:  [<6018659b>] tcp_transmit_skb+0x40d/0x437
61347b98:  [<6007cbfb>] cache_alloc_refill+0xc4/0x1a2
61347bd8:  [<60187bab>] tcp_write_xmit+0x1d1/0x241
61347c18:  [<60187c3a>] __tcp_push_pending_frames+0x1f/0x7b
61347c38:  [<6017d7ac>] tcp_sendmsg+0x9f8/0xb05
61347c40:  [<6001a0ad>] copy_chunk_to_user+0x0/0x12
61347c78:  [<6003e244>] __activate_task+0x27/0x38
61347c88:  [<60019cd0>] maybe_map+0x30/0x9e
61347cc8:  [<601589cd>] do_sock_write+0x9f/0xa4
61347cd8:  [<60158a25>] sock_aio_write+0x53/0x62
61347ce8:  [<60019f03>] do_buffer_op+0x164/0x21e
61347d58:  [<60037f13>] setjmp_wrapper+0xc8/0xd5
61347d78:  [<6007f420>] do_sync_write+0xdd/0x120
61347de8:  [<60053fa7>] autoremove_wake_function+0x0/0x2e
61347ea8:  [<6007f53c>] vfs_write+0xd9/0x182
61347ee8:  [<6007f698>] sys_write+0x45/0x6e
61347f28:  [<60019abb>] handle_syscall+0x63/0x7c
61347f48:  [<60038ec4>] handle_trap+0xcb/0xd2
61347f78:  [<60039334>] userspace+0x131/0x178
61347fd8:  [<60019808>] fork_handler+0x74/0x79


--------------010108020304090901070701
Content-Type: text/plain;
 name="config-2.6-uml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.6-uml"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.19-rc4
# Tue Nov  7 16:33:54 2006
#
CONFIG_DEFCONFIG_LIST="arch/$ARCH/defconfig"
CONFIG_GENERIC_HARDIRQS=y
CONFIG_UML=y
CONFIG_MMU=y
# CONFIG_TRACE_IRQFLAGS_SUPPORT is not set
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_IRQ_RELEASE_METHOD=y

#
# UML-specific options
#
# CONFIG_STATIC_LINK is not set
CONFIG_MODE_SKAS=y
CONFIG_UML_X86=y
CONFIG_64BIT=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_TOP_ADDR=0x80000000
CONFIG_3_LEVEL_PGTABLES=y
CONFIG_STUB_CODE=0x7fbfffe000
CONFIG_STUB_DATA=0x7fbffff000
CONFIG_STUB_START=0x7fbfffe000
# CONFIG_ARCH_HAS_SC_SIGNALS is not set
# CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA is not set
CONFIG_SMP_BROKEN=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_LD_SCRIPT_DYN=y
CONFIG_NET=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_HOSTFS=y
# CONFIG_HPPFS is not set
CONFIG_MCONSOLE=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_NEST_LEVEL=0
CONFIG_KERNEL_STACK_ORDER=2
CONFIG_UML_REAL_TIME_CLOCK=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=128

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_RELAY=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Block layer
#
CONFIG_BLOCK=y
# CONFIG_LBD is not set
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Block devices
#
CONFIG_BLK_DEV_UBD=y
CONFIG_BLK_DEV_UBD_SYNC=y
CONFIG_BLK_DEV_COW_COMMON=y
# CONFIG_MMAPPER is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
# CONFIG_ATA_OVER_ETH is not set

#
# Character Devices
#
CONFIG_STDERR_CONSOLE=y
CONFIG_STDIO_CONSOLE=y
CONFIG_SSL=y
CONFIG_NULL_CHAN=y
CONFIG_PORT_CHAN=y
CONFIG_PTY_CHAN=y
CONFIG_TTY_CHAN=y
CONFIG_XTERM_CHAN=y
# CONFIG_NOCONFIG_CHAN is not set
CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
CONFIG_CON_CHAN="xterm"
CONFIG_SSL_CHAN="pty"
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_WATCHDOG is not set
# CONFIG_UML_SOUND is not set
# CONFIG_SOUND is not set
# CONFIG_HOSTAUDIO is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_UML_RANDOM is not set

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Networking
#

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_IPCOMP=y
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_TUNNEL=y
CONFIG_INET6_TUNNEL=y
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# UML Network Devices
#
CONFIG_UML_NET=y
# CONFIG_UML_NET_ETHERTAP is not set
CONFIG_UML_NET_TUNTAP=y
# CONFIG_UML_NET_SLIP is not set
CONFIG_UML_NET_DAEMON=y
CONFIG_UML_NET_MCAST=y
CONFIG_UML_NET_PCAP=y
# CONFIG_UML_NET_SLIRP is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y

#
# PHY device support
#

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4DEV_FS=y
CONFIG_EXT4DEV_FS_XATTR=y
CONFIG_EXT4DEV_FS_POSIX_ACL=y
# CONFIG_EXT4DEV_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
CONFIG_GENERIC_ACL=y

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

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
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
# CONFIG_NFSD is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_RPCSEC_GSS_SPKM3=y
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
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
CONFIG_NLS_ASCII=y
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
CONFIG_NLS_UTF8=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=y
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_AUDIT_GENERIC=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_PLIST=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_INPUT is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHEDSTATS=y
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_UNWIND_INFO=y
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set

--------------010108020304090901070701--
