Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUGFXNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUGFXNT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUGFXNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:13:19 -0400
Received: from holomorphy.com ([207.189.100.168]:6106 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264692AbUGFXNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:13:04 -0400
Date: Tue, 6 Jul 2004 16:12:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm6
Message-ID: <20040706231256.GV21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <200407061251.18702.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407061251.18702.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 July 2004 07:54 am, William Lee Irwin III wrote:
>> Uneventful on alpha, needed a make rpm compilefix Andi's got queued for
>> the next merge on x86-64 and otherwise uneventful there.
>> OTOH, various things made sparc64 a living Hell that took about 9
>> hours of solid compile/boot/crash drudgery to carry out bisection
>> search on to find the offending patches.
>> First, I had to back out bk-input because it has a sysfsification patch
>> that deadlocks sunzilog.c at boot.

On Tue, Jul 06, 2004 at 12:51:16PM -0500, Dmitry Torokhov wrote:
> Ok, I think I know what the problem is - it should be an oops rather than a
> deadlock though - serial drivers are initialized before serio core when serio
> bus structure is not registered with driver core yet. Could you please try
> the patch below - I do not have hardware to test it:

Unfortunately this didn't repair it. Bootlog attached. The failure to
respond to "send brk" indicates deadlock with interrupts disabled.


-- wli

Script started on Tue Jul  6 15:58:03 2004
$ screen -x
# cp /mnt/dm0/mm6-2.6.7/System.map /boot/System.map-2.6.7-mm6-dmitry-1
# cp /mnt/dm0/mm6-2.6.7/.config /boot/config-2.6.7-mm6-dmitry-1
# shutdown -h now

INIT: # Sending processes the TERM signal
INIStopping internet superserver: inetd.
Stopping irc server daemon: ircd.
Stopping rsync daemon: rsync.
Stopping OpenBSD Secure Shell server: sshd.
Saving the System Clock time to the Hardware Clock...
Hardware Clock updated to Tue Jul  6 15:58:05 PDT 2004.
Stopping NFS common utilities: statd.
Stopping kernel log daemon: klogd.
Stopping system log daemon: syslogd.
Sending all processes the TERM signal...done.
Sending all processes the KILL signal...done.
Saving random seed...done.
Unmounting remote and non-toplevel virtual filesystems...done.
NOT deconfiguring network interfaces: / is an NFS mount
Deactivating swap...done.
Unmounting local filesystems...done.
RPC: sendmsg returned error 51
RPC: sendmsg returned error 51
nfs: RPC call returned error 51
Cnfs: RPC call returned error 51
md: stopping all md devices.
Cmd: stopping all md devices.
md: md0 switched to read-only mode.
Cmd: md0 switched to read-only mode.
Power down.
CPower down.
Button XIR
Software Power ON
4-slot Sun Enterprise 3000, No Keyboard
OpenBoot 3.2.30, 3840 MB memory installed, Serial #9039287.
Copyright 2002 Sun Microsystems, Inc.  All rights reserved
Ethernet address 8:0:20:89:ed:b7, Host ID: 8089edb7.



{6} ok boot net:dhcp -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
Boot device: /sbus@3,0/SUNW,hme@3,8c00000:dhcp  File and args: -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
PROMLIB: Sun IEEE Boot Prom 3.2.30 2002/10/25 14:03
Linux version 2.6.7-mm6-dmitry-1 (wli@analyticity) (gcc version 3.3.4 (Debian)) #1 SMP Tue Jul 6 15:51:40 PDT 2004
ARCH: SUN4U
Remapping the kernel... done.
Booting Linux...
Ethernet address: 08:00:20:89:ed:b7
On node 0 totalpages: 490170
  DMA zone: 490170 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
CENTRAL: Detected 4 slot Enterprise system. cfreg[a8] cver[fc]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 7): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
Built 1 zonelists
Kernel command line: -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
kernel profiling enabled
PID hash table entries: 4096 (order 12: 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 3881600k available (2504k kernel code, 976k data, 144k init) [fffff80000000000,00000000efd18000]
Calibrating delay loop... 667.64 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
Calibrating delay loop... 667.64 BogoMIPS
CPU 7: synchronized TICK with master CPU (last diff -9 cycles,maxerr 668 cycles)
Calibrating delay loop... 667.64 BogoMIPS
CPU 10: synchronized TICK with master CPU (last diff -14 cycles,maxerr 686 cycles)
Calibrating delay loop... 667.64 BogoMIPS
CPU 11: synchronized TICK with master CPU (last diff -10 cycles,maxerr 679 cycles)
Calibrating delay loop... 667.64 BogoMIPS
CPU 14: synchronized TICK with master CPU (last diff -13 cycles,maxerr 686 cycles)
Calibrating delay loop... 667.64 BogoMIPS
CPU 15: synchronized TICK with master CPU (last diff -5 cycles,maxerr 664 cycles)
Brought up 6 CPUs
Total of 6 processors activated (4005.88 BogoMIPS).
SMP: Calibrating ecache flush... Using heuristic of 1195476 cycles, 3 ticks.
CPU6:  online
 domain 0: span 0000ccc0
  groups: 00000040 00000080 00000400 00000800 00004000 00008000
CPU7:  online
 domain 0: span 0000ccc0
  groups: 00000080 00000400 00000800 00004000 00008000 00000040
CPU10:  online
 domain 0: span 0000ccc0
  groups: 00000400 00000800 00004000 00008000 00000040 00000080
CPU11:  online
 domain 0: span 0000ccc0
  groups: 00000800 00004000 00008000 00000040 00000080 00000400
CPU14:  online
 domain 0: span 0000ccc0
  groups: 00004000 00008000 00000040 00000080 00000400 00000800
CPU15:  online
 domain 0: span 0000ccc0
  groups: 00008000 00000040 00000080 00000400 00000800 00004000
Calling initcall 0x00000000007776e0: init_elf32_binfmt+0x0/0x20()
Calling initcall 0x0000000000779240: usermodehelper_init+0x0/0x40()
Calling initcall 0x000000000077bca0: init_misc_binfmt+0x0/0x60()
Calling initcall 0x000000000077bd00: init_script_binfmt+0x0/0x20()
Calling initcall 0x000000000077bd20: init_elf_binfmt+0x0/0x20()
Calling initcall 0x0000000000786980: netlink_proto_init+0x0/0x60()
NET: Registered protocol family 16
Calling initcall 0x000000000077e780: tty_class_init+0x0/0x40()
Calling initcall 0x0000000000775780: topology_init+0x0/0xa0()
Calling initcall 0x000000000077b1a0: init_bio+0x0/0xc0()
Calling initcall 0x000000000077ec00: misc_init+0x0/0xc0()
Calling initcall 0x00000000007807c0: device_init+0x0/0x40()
Calling initcall 0x0000000000780800: deadline_slab_setup+0x0/0x60()
Calling initcall 0x0000000000780860: cfq_slab_setup+0x0/0xc0()
Calling initcall 0x00000000007832e0: init_scsi+0x0/0x140()
SCSI subsystem initialized
Calling initcall 0x00000000007851c0: sbus_init+0x0/0x340()
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array 
Calling initcall 0x0000000000785ac0: input_init+0x0/0xc0()
Calling initcall 0x0000000000786700: net_dev_init+0x0/0x1a0()
Calling initcall 0x000000000077e4c0: chr_dev_init+0x0/0xc0()
Calling initcall 0x0000000000776f60: chmc_init+0x0/0x60()
Calling initcall 0x0000000000778a00: abi_register_sysctl+0x0/0x40()
Calling initcall 0x0000000000778f80: ioresources_init+0x0/0x60()
Calling initcall 0x0000000000779140: uid_cache_init+0x0/0xc0()
Calling initcall 0x00000000007794c0: init_posix_timers+0x0/0xe0()
Calling initcall 0x00000000007795a0: init+0x0/0x60()
Calling initcall 0x0000000000779600: proc_dma_init+0x0/0x40()
Calling initcall 0x000000000045b9e0: percpu_modinit+0x0/0xa0()
Calling initcall 0x0000000000779640: modules_init+0x0/0x20()
Calling initcall 0x0000000000779660: kallsyms_init+0x0/0x40()
Calling initcall 0x00000000007796a0: ikconfig_init+0x0/0x60()
Calling initcall 0x000000000077a7a0: init_per_zone_pages_min+0x0/0x60()
Calling initcall 0x000000000077aa40: pdflush_init+0x0/0x20()
Calling initcall 0x000000000077ad20: cpucache_init+0x0/0x80()
Calling initcall 0x000000000077ade0: kswapd_init+0x0/0x80()
Calling initcall 0x000000000077aea0: init_tmpfs+0x0/0xe0()
Calling initcall 0x000000000077af80: procswaps_init+0x0/0x40()
Calling initcall 0x000000000077b380: init_pipe_fs+0x0/0x60()
Calling initcall 0x000000000077b3e0: fasync_init+0x0/0x40()
Calling initcall 0x000000000077b420: filelock_init+0x0/0x40()
Calling initcall 0x000000000077b7e0: dnotify_init+0x0/0x40()
Calling initcall 0x000000000077baa0: aio_setup+0x0/0x80()
Calling initcall 0x000000000077bb20: eventpoll_init+0x0/0x100()
Calling initcall 0x000000000077bc20: init_sys32_ioctl+0x0/0x80()
Calling initcall 0x000000000077bd40: init_mbcache+0x0/0x40()
Calling initcall 0x000000000077c2a0: init_devpts_fs+0x0/0x80()
Calling initcall 0x000000000077c340: init_ext3_fs+0x0/0x60()
Calling initcall 0x000000000077c5c0: journal_init+0x0/0x40()
Calling initcall 0x000000000077c600: init_ext2_fs+0x0/0x60()
Calling initcall 0x000000000077c720: init_ramfs_fs+0x0/0x20()
Calling initcall 0x000000000077c760: init_minix_fs+0x0/0x60()
Calling initcall 0x000000000077c7c0: init_iso9660_fs+0x0/0x60()
Calling initcall 0x000000000077c820: init_nfs_fs+0x0/0x140()
Calling initcall 0x000000000077d220: init_nlm+0x0/0x40()
Calling initcall 0x000000000077d260: init_udf_fs+0x0/0x60()
udf: registering filesystem
Calling initcall 0x000000000077d760: init_openprom_fs+0x0/0xa0()
Calling initcall 0x000000000077d800: ipc_init+0x0/0x40()
Calling initcall 0x000000000077da20: init_mqueue_fs+0x0/0x100()
Calling initcall 0x000000000077db20: init_crypto+0x0/0x40()
Initializing Cryptographic API
Calling initcall 0x000000000077dba0: init+0x0/0x20()
Calling initcall 0x000000000077dbc0: init+0x0/0x20()
Calling initcall 0x000000000077dbe0: init+0x0/0x60()
Calling initcall 0x000000000077dc40: init+0x0/0x20()
Calling initcall 0x000000000077e620: rand_initialize+0x0/0x100()
Calling initcall 0x000000000077e7c0: tty_init+0x0/0x1e0()
HConsole: switching to mono PROM 80x34
Calling initcall 0x000000000077e9a0: pty_init+0x0/0x260()
Calling initcall 0x000000000077f2a0: serio_init+0x0/0x60()
Calling initcall 0x000000000077f300: serport_init+0x0/0x40()
Calling initcall 0x000000000077f600: suncore_init+0x0/0x60()
Calling initcall 0x00000000007803a0: sunzilog_init+0x0/0x40()
SunZilog: 2 chips.
zs2 at 0x000001fff8904004 (irq = 12,b9) is a SunZilog

telnet> send brk
[detached]
$ 

Script done on Tue Jul  6 16:05:01 2004
