Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264926AbUGGGib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbUGGGib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 02:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUGGGib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 02:38:31 -0400
Received: from holomorphy.com ([207.189.100.168]:65499 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264926AbUGGGhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 02:37:45 -0400
Date: Tue, 6 Jul 2004 23:37:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm6
Message-ID: <20040707063733.GD21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org> <200407061251.18702.dtor_core@ameritech.net> <20040706231256.GV21066@holomorphy.com> <200407070015.39507.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407070015.39507.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 12:15:37AM -0500, Dmitry Torokhov wrote:
> The only suspicious thing that I see is that sunzilog tries to register its
> serio ports with spinlock held and interrupts off. I wonder if that is what
> causing a deadlock. Could you please try applying this patch on top of the
> changes to the drivers/Makefile that I sent earlier.

This suspicion is correct. It boots normally with the patch you posted
to do that registration outside the interrupts-off critical section
applied. Bootlog below.

Thanks.


-- wli


Script started on Tue Jul  6 23:21:59 2004
$ screen -x
[1]   Done swapon -p 1 $f
[2]   Done swapon -p 1 $f
[3]   Done swapon -p 1 $f
[4]   Done swapon -p 1 $f
[5]   Done swapon -p 1 $f
[6]   Done swapon -p 1 $f
[7]   Done swapon -p 1 $f
[8]   Done swapon -p 1 $f
[9]   Done swapon -p 1 $f
[10]   Done swapon -p 1 $f
[11]   Done swapon -p 1 $f
[12]   Done swapon -p 1 $f
[13]   Done swapon -p 1 $f
[14]   Done swapon -p 1 $f
[15]-  Done swapon -p 1 $f
[16]+  Done swapon -p 1 $f
# cp /mnt/dm0/mm6-2.6.7/System.map /boot/System.map-2.6.7-mm6-dmitry-1
# shutdown -h now

INIT: # Sending processes the TERM signalJu
INStopping internet superserver: inetd.
Stopping irc server daemon: ircd.
Stopping rsync daemon: rsync.
Stopping OpenBSD Secure Shell server: sshd.
Saving the System Clock time to the Hardware Clock...
Hardware Clock updated to Tue Jul  6 23:22:04 PDT 2004.
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
nfs: RPC call returned error 51
md: stopping all md devices.
md: stopping all md devices.
md: md0 switched to read-only mode.
md: md0 switched to read-only mode.
Power down.
Power down.
Button XIR
Software Power ON
4-slot Sun Enterprise 3000, No Keyboard
OpenBoot 3.2.30, 3840 MB memory installed, Serial #9039287.
Copyright 2002 Sun Microsystems, Inc.  All rights reserved
Ethernet address 8:0:20:89:ed:b7, Host ID: 8089edb7.



{6} ok boot net:dhcp -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
Boot device: /sbus@3,0/SUNW,hme@3,8c00000:dhcp  File and args: -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
PROMLIB: Sun IEEE Boot Prom 3.2.30 2002/10/25 14:03
Linux version 2.6.7-mm6-dmitry-1 (wli@analyticity) (gcc version 3.3.4 (Debian)) #1 SMP Tue Jul 6 23:16:01 PDT 2004
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
CPU 7: synchronized TICK with master CPU (last diff -16 cycles,maxerr 684 cycles)
Calibrating delay loop... 667.64 BogoMIPS
CPU 10: synchronized TICK with master CPU (last diff -14 cycles,maxerr 686 cycles)
Calibrating delay loop... 667.64 BogoMIPS
CPU 11: synchronized TICK with master CPU (last diff -12 cycles,maxerr 686 cycles)
Calibrating delay loop... 667.64 BogoMIPS
CPU 14: synchronized TICK with master CPU (last diff -14 cycles,maxerr 684 cycles)
Calibrating delay loop... 667.64 BogoMIPS
CPU 15: synchronized TICK with master CPU (last diff -12 cycles,maxerr 686 cycles)
Brought up 6 CPUs
Total of 6 processors activated (4005.88 BogoMIPS).
SMP: Calibrating ecache flush... Using heuristic of 1195818 cycles, 3 ticks.
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
Calling initcall 0x00000000007869a0: netlink_proto_init+0x0/0x60()
NET: Registered protocol family 16
Calling initcall 0x000000000077e780: tty_class_init+0x0/0x40()
Calling initcall 0x0000000000775780: topology_init+0x0/0xa0()
Calling initcall 0x000000000077b1a0: init_bio+0x0/0xc0()
Calling initcall 0x000000000077ec00: misc_init+0x0/0xc0()
Calling initcall 0x00000000007807e0: device_init+0x0/0x40()
Calling initcall 0x0000000000780820: deadline_slab_setup+0x0/0x60()
Calling initcall 0x0000000000780880: cfq_slab_setup+0x0/0xc0()
Calling initcall 0x0000000000783300: init_scsi+0x0/0x140()
SCSI subsystem initialized
Calling initcall 0x00000000007851e0: sbus_init+0x0/0x340()
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array 
Calling initcall 0x0000000000785ae0: input_init+0x0/0xc0()
Calling initcall 0x0000000000786720: net_dev_init+0x0/0x1a0()
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
Console: switching to mono PROM 80x34
Calling initcall 0x000000000077e9a0: pty_init+0x0/0x260()
Calling initcall 0x000000000077f2a0: serio_init+0x0/0x60()
Calling initcall 0x000000000077f300: serport_init+0x0/0x40()
Calling initcall 0x000000000077f600: suncore_init+0x0/0x60()
Calling initcall 0x00000000007803c0: sunzilog_init+0x0/0x40()
SunZilog: 2 chips.
zs2 at 0x000001fff8904004 (irq = 12,b9) is a SunZilog
zs3 at 0x000001fff8904000 (irq = 12,b9) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 7964192) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 7964192) is a SunZilog
Console: ttyS0 (SunZilog zs0)
PROMLIB: Sun IEEE Boot Prom 3.2.30 2002/10/25 14:03
PROMLIB: Sun IEEE Boot Prom 3.2.30 2002/10/25 14:03
Linux version 2.6.7-mm6-dmitry-1 (wli@analyticity) (gcc version 3.3.4 (Debian)) #1 SMP Tue Jul 6 23:16:01 PDT 2004
Linux version 2.6.7-mm6-dmitry-1 (wli@analyticity) (gcc version 3.3.4 (Debian)) #1 SMP Tue Jul 6 23:16:01 PDT 2004
ARCH: SUN4U
ARCH: SUN4U
Ethernet address: 08:00:20:89:ed:b7
Ethernet address: 08:00:20:89:ed:b7
On node 0 totalpages: 490170
On node 0 totalpages: 490170
  DMA zone: 490170 pages, LIFO batch:8
  DMA zone: 490170 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
CENTRAL: Detected 4 slot Enterprise system. cfreg[a8] cver[fc]
CENTRAL: Detected 4 slot Enterprise system. cfreg[a8] cver[fc]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 7): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 7): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
Built 1 zonelists
Built 1 zonelists
Kernel command line: -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
Kernel command line: -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
kernel profiling enabled
kernel profiling enabled
PID hash table entries: 4096 (order 12: 65536 bytes)
PID hash table entries: 4096 (order 12: 65536 bytes)
Console: colour dummy device 80x25
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 3881600k available (2504k kernel code, 976k data, 144k init) [fffff80000000000,00000000efd18000]
Memory: 3881600k available (2504k kernel code, 976k data, 144k init) [fffff80000000000,00000000efd18000]
Calibrating delay loop... 667.64 BogoMIPS
Calibrating delay loop... 667.64 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
Calibrating delay loop... 667.64 BogoMIPS
Calibrating delay loop... 667.64 BogoMIPS
CPU 7: synchronized TICK with master CPU (last diff -16 cycles,maxerr 684 cycles)
 CPU 7: synchronized TICK with master CPU (last diff -16 cycles,maxerr 684 cycles)
Calibrating delay loop... 667.64 BogoMIPS
Calibrating delay loop... 667.64 BogoMIPS
CPU 10: synchronized TICK with master CPU (last diff -14 cycles,maxerr 686 cycles)
  CPU 10: synchronized TICK with master CPU (last diff -14 cycles,maxerr 686 cycles)
Calibrating delay loop... 667.64 BogoMIPS
Calibrating delay loop... 667.64 BogoMIPS
CPU 11: synchronized TICK with master CPU (last diff -12 cycles,maxerr 686 cycles)
  CPU 11: synchronized TICK with master CPU (last diff -12 cycles,maxerr 686 cycles)
Calibrating delay loop... 667.64 BogoMIPS
Calibrating delay loop... 667.64 BogoMIPS
CPU 14: synchronized TICK with master CPU (last diff -14 cycles,maxerr 684 cycles)
  CPU 14: synchronized TICK with master CPU (last diff -14 cycles,maxerr 684 cycles)
Calibrating delay loop... 667.64 BogoMIPS
Calibrating delay loop... 667.64 BogoMIPS
CPU 15: synchronized TICK with master CPU (last diff -12 cycles,maxerr 686 cycles)
  CPU 15: synchronized TICK with master CPU (last diff -12 cycles,maxerr 686 cycles)
Brought up 6 CPUs
Brought up 6 CPUs
Total of 6 processors activated (4005.88 BogoMIPS).
Total of 6 processors activated (4005.88 BogoMIPS).
SMP: Calibrating ecache flush... Using heuristic of 1195818 cycles, 3 ticks.
SMP: Calibrating ecache flush... Using heuristic of 1195818 cycles, 3 ticks.
CPU6:  online
CPU6:  online
 domain 0: span 0000ccc0
 domain 0: span 0000ccc0
  groups: 00000040 00000080 00000400 00000800 00004000 00008000
  groups: 00000040 00000080 00000400 00000800 00004000 00008000
CPU7:  online
CPU7:  online
 domain 0: span 0000ccc0
 domain 0: span 0000ccc0
  groups: 00000080 00000400 00000800 00004000 00008000 00000040
  groups: 00000080 00000400 00000800 00004000 00008000 00000040
CPU10:  online
CPU10:  online
 domain 0: span 0000ccc0
 domain 0: span 0000ccc0
  groups: 00000400 00000800 00004000 00008000 00000040 00000080
  groups: 00000400 00000800 00004000 00008000 00000040 00000080
CPU11:  online
CPU11:  online
 domain 0: span 0000ccc0
 domain 0: span 0000ccc0
  groups: 00000800 00004000 00008000 00000040 00000080 00000400
  groups: 00000800 00004000 00008000 00000040 00000080 00000400
CPU14:  online
CPU14:  online
 domain 0: span 0000ccc0
 domain 0: span 0000ccc0
  groups: 00004000 00008000 00000040 00000080 00000400 00000800
  groups: 00004000 00008000 00000040 00000080 00000400 00000800
CPU15:  online
CPU15:  online
 domain 0: span 0000ccc0
 domain 0: span 0000ccc0
  groups: 00008000 00000040 00000080 00000400 00000800 00004000
  groups: 00008000 00000040 00000080 00000400 00000800 00004000
Calling initcall 0x00000000007776e0: init_elf32_binfmt+0x0/0x20()
Calling initcall 0x00000000007776e0: init_elf32_binfmt+0x0/0x20()
Calling initcall 0x0000000000779240: usermodehelper_init+0x0/0x40()
Calling initcall 0x0000000000779240: usermodehelper_init+0x0/0x40()
Calling initcall 0x000000000077bca0: init_misc_binfmt+0x0/0x60()
Calling initcall 0x000000000077bca0: init_misc_binfmt+0x0/0x60()
Calling initcall 0x000000000077bd00: init_script_binfmt+0x0/0x20()
Calling initcall 0x000000000077bd00: init_script_binfmt+0x0/0x20()
Calling initcall 0x000000000077bd20: init_elf_binfmt+0x0/0x20()
Calling initcall 0x000000000077bd20: init_elf_binfmt+0x0/0x20()
Calling initcall 0x00000000007869a0: netlink_proto_init+0x0/0x60()
Calling initcall 0x00000000007869a0: netlink_proto_init+0x0/0x60()
NET: Registered protocol family 16
NET: Registered protocol family 16
Calling initcall 0x000000000077e780: tty_class_init+0x0/0x40()
Calling initcall 0x000000000077e780: tty_class_init+0x0/0x40()
Calling initcall 0x0000000000775780: topology_init+0x0/0xa0()
Calling initcall 0x0000000000775780: topology_init+0x0/0xa0()
Calling initcall 0x000000000077b1a0: init_bio+0x0/0xc0()
Calling initcall 0x000000000077b1a0: init_bio+0x0/0xc0()
Calling initcall 0x000000000077ec00: misc_init+0x0/0xc0()
Calling initcall 0x000000000077ec00: misc_init+0x0/0xc0()
Calling initcall 0x00000000007807e0: device_init+0x0/0x40()
Calling initcall 0x00000000007807e0: device_init+0x0/0x40()
Calling initcall 0x0000000000780820: deadline_slab_setup+0x0/0x60()
Calling initcall 0x0000000000780820: deadline_slab_setup+0x0/0x60()
Calling initcall 0x0000000000780880: cfq_slab_setup+0x0/0xc0()
Calling initcall 0x0000000000780880: cfq_slab_setup+0x0/0xc0()
Calling initcall 0x0000000000783300: init_scsi+0x0/0x140()
Calling initcall 0x0000000000783300: init_scsi+0x0/0x140()
SCSI subsystem initialized
SCSI subsystem initialized
Calling initcall 0x00000000007851e0: sbus_init+0x0/0x340()
Calling initcall 0x00000000007851e0: sbus_init+0x0/0x340()
SYSIO: UPA portID 2, at 000001c400000000
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array 
dma0: HME DVMA gate array 
Calling initcall 0x0000000000785ae0: input_init+0x0/0xc0()
Calling initcall 0x0000000000785ae0: input_init+0x0/0xc0()
Calling initcall 0x0000000000786720: net_dev_init+0x0/0x1a0()
Calling initcall 0x0000000000786720: net_dev_init+0x0/0x1a0()
Calling initcall 0x000000000077e4c0: chr_dev_init+0x0/0xc0()
Calling initcall 0x000000000077e4c0: chr_dev_init+0x0/0xc0()
Calling initcall 0x0000000000776f60: chmc_init+0x0/0x60()
Calling initcall 0x0000000000776f60: chmc_init+0x0/0x60()
Calling initcall 0x0000000000778a00: abi_register_sysctl+0x0/0x40()
Calling initcall 0x0000000000778a00: abi_register_sysctl+0x0/0x40()
Calling initcall 0x0000000000778f80: ioresources_init+0x0/0x60()
Calling initcall 0x0000000000778f80: ioresources_init+0x0/0x60()
Calling initcall 0x0000000000779140: uid_cache_init+0x0/0xc0()
Calling initcall 0x0000000000779140: uid_cache_init+0x0/0xc0()
Calling initcall 0x00000000007794c0: init_posix_timers+0x0/0xe0()
Calling initcall 0x00000000007794c0: init_posix_timers+0x0/0xe0()
Calling initcall 0x00000000007795a0: init+0x0/0x60()
Calling initcall 0x00000000007795a0: init+0x0/0x60()
Calling initcall 0x0000000000779600: proc_dma_init+0x0/0x40()
Calling initcall 0x0000000000779600: proc_dma_init+0x0/0x40()
Calling initcall 0x000000000045b9e0: percpu_modinit+0x0/0xa0()
Calling initcall 0x000000000045b9e0: percpu_modinit+0x0/0xa0()
Calling initcall 0x0000000000779640: modules_init+0x0/0x20()
Calling initcall 0x0000000000779640: modules_init+0x0/0x20()
Calling initcall 0x0000000000779660: kallsyms_init+0x0/0x40()
Calling initcall 0x0000000000779660: kallsyms_init+0x0/0x40()
Calling initcall 0x00000000007796a0: ikconfig_init+0x0/0x60()
Calling initcall 0x00000000007796a0: ikconfig_init+0x0/0x60()
Calling initcall 0x000000000077a7a0: init_per_zone_pages_min+0x0/0x60()
Calling initcall 0x000000000077a7a0: init_per_zone_pages_min+0x0/0x60()
Calling initcall 0x000000000077aa40: pdflush_init+0x0/0x20()
Calling initcall 0x000000000077aa40: pdflush_init+0x0/0x20()
Calling initcall 0x000000000077ad20: cpucache_init+0x0/0x80()
Calling initcall 0x000000000077ad20: cpucache_init+0x0/0x80()
Calling initcall 0x000000000077ade0: kswapd_init+0x0/0x80()
Calling initcall 0x000000000077ade0: kswapd_init+0x0/0x80()
Calling initcall 0x000000000077aea0: init_tmpfs+0x0/0xe0()
Calling initcall 0x000000000077aea0: init_tmpfs+0x0/0xe0()
Calling initcall 0x000000000077af80: procswaps_init+0x0/0x40()
Calling initcall 0x000000000077af80: procswaps_init+0x0/0x40()
Calling initcall 0x000000000077b380: init_pipe_fs+0x0/0x60()
Calling initcall 0x000000000077b380: init_pipe_fs+0x0/0x60()
Calling initcall 0x000000000077b3e0: fasync_init+0x0/0x40()
Calling initcall 0x000000000077b3e0: fasync_init+0x0/0x40()
Calling initcall 0x000000000077b420: filelock_init+0x0/0x40()
Calling initcall 0x000000000077b420: filelock_init+0x0/0x40()
Calling initcall 0x000000000077b7e0: dnotify_init+0x0/0x40()
Calling initcall 0x000000000077b7e0: dnotify_init+0x0/0x40()
Calling initcall 0x000000000077baa0: aio_setup+0x0/0x80()
Calling initcall 0x000000000077baa0: aio_setup+0x0/0x80()
Calling initcall 0x000000000077bb20: eventpoll_init+0x0/0x100()
Calling initcall 0x000000000077bb20: eventpoll_init+0x0/0x100()
Calling initcall 0x000000000077bc20: init_sys32_ioctl+0x0/0x80()
Calling initcall 0x000000000077bc20: init_sys32_ioctl+0x0/0x80()
Calling initcall 0x000000000077bd40: init_mbcache+0x0/0x40()
Calling initcall 0x000000000077bd40: init_mbcache+0x0/0x40()
Calling initcall 0x000000000077c2a0: init_devpts_fs+0x0/0x80()
Calling initcall 0x000000000077c2a0: init_devpts_fs+0x0/0x80()
Calling initcall 0x000000000077c340: init_ext3_fs+0x0/0x60()
Calling initcall 0x000000000077c340: init_ext3_fs+0x0/0x60()
Calling initcall 0x000000000077c5c0: journal_init+0x0/0x40()
Calling initcall 0x000000000077c5c0: journal_init+0x0/0x40()
Calling initcall 0x000000000077c600: init_ext2_fs+0x0/0x60()
Calling initcall 0x000000000077c600: init_ext2_fs+0x0/0x60()
Calling initcall 0x000000000077c720: init_ramfs_fs+0x0/0x20()
Calling initcall 0x000000000077c720: init_ramfs_fs+0x0/0x20()
Calling initcall 0x000000000077c760: init_minix_fs+0x0/0x60()
Calling initcall 0x000000000077c760: init_minix_fs+0x0/0x60()
Calling initcall 0x000000000077c7c0: init_iso9660_fs+0x0/0x60()
Calling initcall 0x000000000077c7c0: init_iso9660_fs+0x0/0x60()
Calling initcall 0x000000000077c820: init_nfs_fs+0x0/0x140()
Calling initcall 0x000000000077c820: init_nfs_fs+0x0/0x140()
Calling initcall 0x000000000077d220: init_nlm+0x0/0x40()
Calling initcall 0x000000000077d220: init_nlm+0x0/0x40()
Calling initcall 0x000000000077d260: init_udf_fs+0x0/0x60()
Calling initcall 0x000000000077d260: init_udf_fs+0x0/0x60()
udf: registering filesystem
udf: registering filesystem
Calling initcall 0x000000000077d760: init_openprom_fs+0x0/0xa0()
Calling initcall 0x000000000077d760: init_openprom_fs+0x0/0xa0()
Calling initcall 0x000000000077d800: ipc_init+0x0/0x40()
Calling initcall 0x000000000077d800: ipc_init+0x0/0x40()
Calling initcall 0x000000000077da20: init_mqueue_fs+0x0/0x100()
Calling initcall 0x000000000077da20: init_mqueue_fs+0x0/0x100()
Calling initcall 0x000000000077db20: init_crypto+0x0/0x40()
Calling initcall 0x000000000077db20: init_crypto+0x0/0x40()
Initializing Cryptographic API
Initializing Cryptographic API
Calling initcall 0x000000000077dba0: init+0x0/0x20()
Calling initcall 0x000000000077dba0: init+0x0/0x20()
Calling initcall 0x000000000077dbc0: init+0x0/0x20()
Calling initcall 0x000000000077dbc0: init+0x0/0x20()
Calling initcall 0x000000000077dbe0: init+0x0/0x60()
Calling initcall 0x000000000077dbe0: init+0x0/0x60()
Calling initcall 0x000000000077dc40: init+0x0/0x20()
Calling initcall 0x000000000077dc40: init+0x0/0x20()
Calling initcall 0x000000000077e620: rand_initialize+0x0/0x100()
Calling initcall 0x000000000077e620: rand_initialize+0x0/0x100()
Calling initcall 0x000000000077e7c0: tty_init+0x0/0x1e0()
Calling initcall 0x000000000077e7c0: tty_init+0x0/0x1e0()
Console: switching to mono PROM 80x34
Console: switching to mono PROM 80x34
Calling initcall 0x000000000077e9a0: pty_init+0x0/0x260()
Calling initcall 0x000000000077e9a0: pty_init+0x0/0x260()
Calling initcall 0x000000000077f2a0: serio_init+0x0/0x60()
Calling initcall 0x000000000077f2a0: serio_init+0x0/0x60()
Calling initcall 0x000000000077f300: serport_init+0x0/0x40()
Calling initcall 0x000000000077f300: serport_init+0x0/0x40()
Calling initcall 0x000000000077f600: suncore_init+0x0/0x60()
Calling initcall 0x000000000077f600: suncore_init+0x0/0x60()
Calling initcall 0x00000000007803c0: sunzilog_init+0x0/0x40()
Calling initcall 0x00000000007803c0: sunzilog_init+0x0/0x40()
SunZilog: 2 chips.
SunZilog: 2 chips.
zs2 at 0x000001fff8904004 (irq = 12,b9) is a SunZilog
zs2 at 0x000001fff8904004 (irq = 12,b9) is a SunZilog
zs3 at 0x000001fff8904000 (irq = 12,b9) is a SunZilog
zs3 at 0x000001fff8904000 (irq = 12,b9) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 7964192) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 7964192) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 7964192) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 7964192) is a SunZilog
Console: ttyS0 (SunZilog zs0)
Console: ttyS0 (SunZilog zs0)
Calling initcall 0x0000000000780600Calling initcall 0x0000000000780600: firmware_class_init+0x0/0x80(): firmware_class_init+0x0/0x80()

Calling initcall 0x000000000058d120Calling initcall 0x000000000058d120: elevator_global_init+0x0/0x20(): elevator_global_init+0x0/0x20()

Calling initcall 0x0000000000780940Calling initcall 0x0000000000780940: loop_init+0x0/0x320(): loop_init+0x0/0x320()

loop: loaded (max 8 devices)
loop: loaded (max 8 devices)
Calling initcall 0x0000000000780ca0Calling initcall 0x0000000000780ca0: nbd_init+0x0/0x240(): nbd_init+0x0/0x240()

Using deadline io scheduler
Using deadline io scheduler
nbd: registered device at major 43
nbd: registered device at major 43
Calling initcall 0x00000000007818c0Calling initcall 0x00000000007818c0: happy_meal_probe+0x0/0x60(): happy_meal_probe+0x0/0x60()

sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:08:00:00:20:20:89:89:ed:ed:b7 b7 

Calling initcall 0x0000000000781e80Calling initcall 0x0000000000781e80: sparc_lance_probe+0x0/0x160(): sparc_lance_probe+0x0/0x160()

Calling initcall 0x0000000000782980Calling initcall 0x0000000000782980: qec_probe+0x0/0xc0(): qec_probe+0x0/0xc0()

Calling initcall 0x0000000000783000Calling initcall 0x0000000000783000: bigmac_probe+0x0/0xc0(): bigmac_probe+0x0/0xc0()

Calling initcall 0x0000000000783240Calling initcall 0x0000000000783240: net_olddevs_init+0x0/0x60(): net_olddevs_init+0x0/0x60()

Calling initcall 0x0000000000784520Calling initcall 0x0000000000784520: init_this_scsi_driver+0x0/0xe0(): init_this_scsi_driver+0x0/0xe0()

esp0: IRQ 7,db esp0: IRQ 7,db SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
NCR53C9XF(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP366-HME
scsi0 : Sparc ESP366-HME
  Vendor:   Vendor: SSEEAAGGAATTEE    Model:   Model: SSXX111188220022LLSS              Rev:   Rev: BB880088

  Type:   Direct-Access       Type:   Direct-Access                      ANSI SCSI revision: 02                 ANSI SCSI revision: 02

  Vendor:   Vendor: SSEEAAGGAATTEE    Model:   Model: SSXX111188220022LLSS              Rev:   Rev: BB880088

  Type:   Direct-Access       Type:   Direct-Access                      ANSI SCSI revision: 02                 ANSI SCSI revision: 02

  Vendor:   Vendor: SSEEAAGGAATTEE    Model:   Model: SSXX111188220022LLSS              Rev:   Rev: BB880088

  Type:   Direct-Access       Type:   Direct-Access                      ANSI SCSI revision: 02                 ANSI SCSI revision: 02

  Vendor:   Vendor: SSEEAAGGAATTEE    Model:   Model: SSXX111188220022LLSS              Rev:   Rev: BB880088

  Type:   Direct-Access       Type:   Direct-Access                      ANSI SCSI revision: 02                 ANSI SCSI revision: 02

  Vendor:   Vendor: TTOOSSHHIIBBAA    Model:   Model: XXMM55770011TTAASSUUNN1122XXCCDD  Rev:   Rev: 22339955

  Type:   CD-ROM              Type:   CD-ROM                             ANSI SCSI revision: 02                 ANSI SCSI revision: 02

  Vendor:   Vendor: SSEEAAGGAATTEE    Model:   Model: SSXX111188220022LLSS              Rev:   Rev: BB880077

  Type:   Direct-Access       Type:   Direct-Access                      ANSI SCSI revision: 02                 ANSI SCSI revision: 02

  Vendor:   Vendor: SSEEAAGGAATTEE    Model:   Model: SSXX111188220022LLSS              Rev:   Rev: BB880077

  Type:   Direct-Access       Type:   Direct-Access                      ANSI SCSI revision: 02                 ANSI SCSI revision: 02

  Vendor:   Vendor: SSEEAAGGAATTEE    Model:   Model: SSXX111188220022LLSS              Rev:   Rev: BB880077

  Type:   Direct-Access       Type:   Direct-Access                      ANSI SCSI revision: 02                 ANSI SCSI revision: 02

  Vendor:   Vendor: SSEEAAGGAATTEE    Model:   Model: SSXX111188220022LLSS              Rev:   Rev: BB880077

  Type:   Direct-Access       Type:   Direct-Access                      ANSI SCSI revision: 02                 ANSI SCSI revision: 02

  Vendor:   Vendor: SSEEAAGGAATTEE    Model:   Model: SSXX111188220022LLSS              Rev:   Rev: BB880077

  Type:   Direct-Access       Type:   Direct-Access                      ANSI SCSI revision: 02                 ANSI SCSI revision: 02

  Vendor:   Vendor: SSEEAAGGAATTEE    Model:   Model: SSXX111188220022LLSS              Rev:   Rev: BB880088

  Type:   Direct-Access       Type:   Direct-Access                      ANSI SCSI revision: 02                 ANSI SCSI revision: 02

Calling initcall 0x00000000007847a0Calling initcall 0x00000000007847a0: init_st+0x0/0x100(): init_st+0x0/0x100()

st: Version 20040403, fixed bufsize 32768, s/g segs 256
st: Version 20040403, fixed bufsize 32768, s/g segs 256
Calling initcall 0x00000000007848a0Calling initcall 0x00000000007848a0: init_sd+0x0/0x60(): init_sd+0x0/0x60()

esp0: target 0 esp0: target 0 [period 100ns offset 15 20.00MHz [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
FAST-WIDE SCSI-II]
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sda: drive cache: write through
SCSI device sda: drive cache: write through
 sda: sda: unknown partition table
 unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
esp0: target 1 esp0: target 1 [period 100ns offset 15 20.00MHz [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
FAST-WIDE SCSI-II]
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: drive cache: write through
 sdb: sdb: unknown partition table
 unknown partition table
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
esp0: target 2 esp0: target 2 [period 100ns offset 15 20.00MHz [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
FAST-WIDE SCSI-II]
SCSI device sdc: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdc: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdc: drive cache: write through
SCSI device sdc: drive cache: write through
 sdc: sdc: unknown partition table
 unknown partition table
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
esp0: target 3 esp0: target 3 [period 100ns offset 15 20.00MHz [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
FAST-WIDE SCSI-II]
SCSI device sdd: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdd: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdd: drive cache: write through
SCSI device sdd: drive cache: write through
 sdd: sdd: unknown partition table
 unknown partition table
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
esp0: target 10 esp0: target 10 [period 100ns offset 15 20.00MHz [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
FAST-WIDE SCSI-II]
SCSI device sde: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sde: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sde: drive cache: write through
SCSI device sde: drive cache: write through
 sde: sde: unknown partition table
 unknown partition table
Attached scsi disk sde at scsi0, channel 0, id 10, lun 0
Attached scsi disk sde at scsi0, channel 0, id 10, lun 0
esp0: target 11 esp0: target 11 [period 100ns offset 15 20.00MHz [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
FAST-WIDE SCSI-II]
SCSI device sdf: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdf: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdf: drive cache: write through
SCSI device sdf: drive cache: write through
 sdf: sdf: unknown partition table
 unknown partition table
Attached scsi disk sdf at scsi0, channel 0, id 11, lun 0
Attached scsi disk sdf at scsi0, channel 0, id 11, lun 0
esp0: target 12 esp0: target 12 [period 100ns offset 15 20.00MHz [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
FAST-WIDE SCSI-II]
SCSI device sdg: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdg: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdg: drive cache: write through
SCSI device sdg: drive cache: write through
 sdg: sdg: unknown partition table
 unknown partition table
Attached scsi disk sdg at scsi0, channel 0, id 12, lun 0
Attached scsi disk sdg at scsi0, channel 0, id 12, lun 0
esp0: target 13 esp0: target 13 [period 100ns offset 15 20.00MHz [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
FAST-WIDE SCSI-II]
SCSI device sdh: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdh: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdh: drive cache: write through
SCSI device sdh: drive cache: write through
 sdh: sdh: unknown partition table
 unknown partition table
Attached scsi disk sdh at scsi0, channel 0, id 13, lun 0
Attached scsi disk sdh at scsi0, channel 0, id 13, lun 0
esp0: target 14 esp0: target 14 [period 100ns offset 15 20.00MHz [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
FAST-WIDE SCSI-II]
SCSI device sdi: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdi: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdi: drive cache: write through
SCSI device sdi: drive cache: write through
 sdi: sdi: unknown partition table
 unknown partition table
Attached scsi disk sdi at scsi0, channel 0, id 14, lun 0
Attached scsi disk sdi at scsi0, channel 0, id 14, lun 0
esp0: target 15 esp0: target 15 [period 100ns offset 15 20.00MHz [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
FAST-WIDE SCSI-II]
SCSI device sdj: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdj: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdj: drive cache: write through
SCSI device sdj: drive cache: write through
 sdj: sdj: unknown partition table
 unknown partition table
Attached scsi disk sdj at scsi0, channel 0, id 15, lun 0
Attached scsi disk sdj at scsi0, channel 0, id 15, lun 0
Calling initcall 0x0000000000784900Calling initcall 0x0000000000784900: init_sr+0x0/0x40(): init_sr+0x0/0x40()

esp0: target 6 asynchronous
esp0: target 6 asynchronous
sr0: scsi-1 drive
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
Calling initcall 0x0000000000784940Calling initcall 0x0000000000784940: init_sg+0x0/0xe0(): init_sg+0x0/0xe0()

Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg3 at scsi0, channel 0, id 3, lun 0,  type 0
Attached scsi generic sg3 at scsi0, channel 0, id 3, lun 0,  type 0
Attached scsi generic sg4 at scsi0, channel 0, id 6, lun 0,  type 5
Attached scsi generic sg4 at scsi0, channel 0, id 6, lun 0,  type 5
Attached scsi generic sg5 at scsi0, channel 0, id 10, lun 0,  type 0
Attached scsi generic sg5 at scsi0, channel 0, id 10, lun 0,  type 0
Attached scsi generic sg6 at scsi0, channel 0, id 11, lun 0,  type 0
Attached scsi generic sg6 at scsi0, channel 0, id 11, lun 0,  type 0
Attached scsi generic sg7 at scsi0, channel 0, id 12, lun 0,  type 0
Attached scsi generic sg7 at scsi0, channel 0, id 12, lun 0,  type 0
Attached scsi generic sg8 at scsi0, channel 0, id 13, lun 0,  type 0
Attached scsi generic sg8 at scsi0, channel 0, id 13, lun 0,  type 0
Attached scsi generic sg9 at scsi0, channel 0, id 14, lun 0,  type 0
Attached scsi generic sg9 at scsi0, channel 0, id 14, lun 0,  type 0
Attached scsi generic sg10 at scsi0, channel 0, id 15, lun 0,  type 0
Attached scsi generic sg10 at scsi0, channel 0, id 15, lun 0,  type 0
Calling initcall 0x0000000000784a20Calling initcall 0x0000000000784a20: cdrom_init+0x0/0x20(): cdrom_init+0x0/0x20()

Calling initcall 0x00000000007857c0Calling initcall 0x00000000007857c0: flash_init+0x0/0x140(): flash_init+0x0/0x140()

Calling initcall 0x0000000000785900Calling initcall 0x0000000000785900: openprom_init+0x0/0xa0(): openprom_init+0x0/0xa0()

Calling initcall 0x00000000007859a0Calling initcall 0x00000000007859a0: rtc_sun_init+0x0/0x60(): rtc_sun_init+0x0/0x60()

Calling initcall 0x0000000000785ba0Calling initcall 0x0000000000785ba0: atkbd_init+0x0/0x20(): atkbd_init+0x0/0x20()

Calling initcall 0x0000000000785bc0Calling initcall 0x0000000000785bc0: psmouse_init+0x0/0xc0(): psmouse_init+0x0/0xc0()

Calling initcall 0x0000000000785c80Calling initcall 0x0000000000785c80: linear_init+0x0/0x20(): linear_init+0x0/0x20()

md: linear personality registered as nr 1
md: linear personality registered as nr 1
Calling initcall 0x0000000000785ca0Calling initcall 0x0000000000785ca0: raid0_init+0x0/0x20(): raid0_init+0x0/0x20()

md: raid0 personality registered as nr 2
md: raid0 personality registered as nr 2
Calling initcall 0x0000000000785cc0Calling initcall 0x0000000000785cc0: raid_init+0x0/0x20(): raid_init+0x0/0x20()

md: raid1 personality registered as nr 3
md: raid1 personality registered as nr 3
Calling initcall 0x0000000000785ce0Calling initcall 0x0000000000785ce0: raid5_init+0x0/0x20(): raid5_init+0x0/0x20()

md: raid5 personality registered as nr 4
md: raid5 personality registered as nr 4
Calling initcall 0x00000000005daa80Calling initcall 0x00000000005daa80: calibrate_xor_block+0x0/0x100(): calibrate_xor_block+0x0/0x100()

raid5: measuring checksumming speed
raid5: measuring checksumming speed
   VIS       :   136.000 MB/sec
   VIS       :   136.000 MB/sec
raid5: using function: VIS (136.000 MB/sec)
raid5: using function: VIS (136.000 MB/sec)
Calling initcall 0x0000000000785d00Calling initcall 0x0000000000785d00: raid6_init+0x0/0x40(): raid6_init+0x0/0x40()

raid6: int64x1    164 MB/s
raid6: int64x1    164 MB/s
raid6: int64x2    277 MB/s
raid6: int64x2    277 MB/s
raid6: int64x4    277 MB/s
raid6: int64x4    277 MB/s
raid6: int64x8    171 MB/s
raid6: int64x8    171 MB/s
raid6: using algorithm int64x2 (277 MB/s)
raid6: using algorithm int64x2 (277 MB/s)
md: raid6 personality registered as nr 8
md: raid6 personality registered as nr 8
Calling initcall 0x0000000000785f80Calling initcall 0x0000000000785f80: multipath_init+0x0/0x20(): multipath_init+0x0/0x20()

md: multipath personality registered as nr 7
md: multipath personality registered as nr 7
Calling initcall 0x0000000000785fa0Calling initcall 0x0000000000785fa0: md_init+0x0/0x120(): md_init+0x0/0x120()

md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Calling initcall 0x0000000000786180Calling initcall 0x0000000000786180: dm_init+0x0/0xa0(): dm_init+0x0/0xa0()

device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Calling initcall 0x00000000007864e0Calling initcall 0x00000000007864e0: flow_cache_init+0x0/0x120(): flow_cache_init+0x0/0x120()

Calling initcall 0x0000000000786a00Calling initcall 0x0000000000786a00: init_netlink+0x0/0x120(): init_netlink+0x0/0x120()

Calling initcall 0x0000000000787980Calling initcall 0x0000000000787980: inet_init+0x0/0x240(): inet_init+0x0/0x240()

NET: Registered protocol family 2
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 512Kbytes
IP: routing cache hash table of 32768 buckets, 512Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
TCP: Hash tables configured (established 524288 bind 65536)
Calling initcall 0x0000000000787f20Calling initcall 0x0000000000787f20: ah4_init+0x0/0x80(): ah4_init+0x0/0x80()

Calling initcall 0x0000000000787fa0Calling initcall 0x0000000000787fa0: esp4_init+0x0/0x80(): esp4_init+0x0/0x80()

Calling initcall 0x0000000000788020Calling initcall 0x0000000000788020: ipcomp4_init+0x0/0x160(): ipcomp4_init+0x0/0x160()

Calling initcall 0x000000000078a2c0Calling initcall 0x000000000078a2c0: ipip_init+0x0/0x80(): ipip_init+0x0/0x80()

Calling initcall 0x000000000078a520Calling initcall 0x000000000078a520: af_unix_init+0x0/0xa0(): af_unix_init+0x0/0xa0()

NET: Registered protocol family 1
NET: Registered protocol family 1
Calling initcall 0x000000000078a5c0Calling initcall 0x000000000078a5c0: packet_init+0x0/0x60(): packet_init+0x0/0x60()

NET: Registered protocol family 17
NET: Registered protocol family 17
Calling initcall 0x000000000078a620Calling initcall 0x000000000078a620: ipsec_pfkey_init+0x0/0x60(): ipsec_pfkey_init+0x0/0x60()

NET: Registered protocol family 15
NET: Registered protocol family 15
Calling initcall 0x000000000078a680Calling initcall 0x000000000078a680: init_sunrpc+0x0/0x80(): init_sunrpc+0x0/0x80()

Calling initcall 0x000000000078a700Calling initcall 0x000000000078a700: init_rpcsec_gss+0x0/0x60(): init_rpcsec_gss+0x0/0x60()

Calling initcall 0x000000000078a760Calling initcall 0x000000000078a760: init_kerberos_module+0x0/0x40(): init_kerberos_module+0x0/0x40()

Calling initcall 0x0000000000789be0Calling initcall 0x0000000000789be0: ip_auto_config+0x0/0x320(): ip_auto_config+0x0/0x320()

Sending DHCP requests .Sending DHCP requests ...,, OK
 OK
IP-Config: Got DHCP answer from 192.168.1.1, IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.16
my address is 192.168.1.16
IP-Config: Complete:IP-Config: Complete:

      device=eth0      device=eth0, addr=192.168.1.16, addr=192.168.1.16, mask=255.255.255.0, mask=255.255.255.0, gw=192.168.1.1, gw=192.168.1.1,
,
     host=analyticity, domain=holomorphy.com, nis-domain=(none)     host=analyticity, domain=holomorphy.com, nis-domain=(none)<6>eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
<6>eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
,
 ,
     bootserver=192.168.1.1     bootserver=192.168.1.1, rootserver=192.168.1.1, rootserver=192.168.1.1, rootpath=/mnt/f/e3k/debian, rootpath=/mnt/f/e3k/debian

md: Autodetecting RAID arrays.
md: Autodetecting RAID arrays.
md: autorun ...
md: autorun ...
md: ... autorun DONE.
md: ... autorun DONE.
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1
VFS: Mounted root (nfs filesystem) readonly.
VFS: Mounted root (nfs filesystem) readonly.
INIT: version 2.85 booting
Activating swap.
System time was Wed Jul  7 06:26:44 UTC 2004.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Wed Jul  7 06:26:46 UTC 2004.
Not running depmod because /lib/modules/2.6.7-mm6-dmitry-1/ is not writeable.
Loading modules...
All modules loaded.
FATAL: Could not load /lib/modules/2.6.7-mm6-dmitry-1/modules.dep: No such file or directory
Creating device-mapper devices...done.
Checking all file systems...
fsck 1.35 (28-Feb-2004)
Setting kernel variables ...
... done.
Mounting local filesystems...
none on /tmp type tmpfs (rw)
Cleaning /tmp /var/run /var/lock.
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...done.
Starting portmap daemon: portmap.
Starting portmapper...Mounting remote filesystems...
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel

Setting the System Clock using the Hardware Clock as reference...
System Clock set. Local time: Tue Jul  6 23:26:51 PDT 2004

Running ntpdate to synchronize clockmodprobe: FATAL: Could not load /lib/modules/2.6.7-mm6-dmitry-1/modules.dep: No such file or directory

.
Initializing random number generator...done.
Recovering nvi editor sessions... done.
Setting up X server socket directory /tmp/.X11-unix...done.
Setting up ICE socket directory /tmp/.ICE-unix...done.
SettingINIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting portmap daemon: portmap.
Starting internet superserver: inetd.
Starting irc server daemon: ircd.
rsync daemon not enabled in /etc/default/rsync
Starting OpenBSD Secure Shell server: sshdDisabling protocol version 2. Could not load host key
.
Starting the system activity data collector: sadc.
Starting NFS common utilities: statd.

Debian GNU/Linux testing/unstable analyticity ttyS0

analyticity login: root
Password: 
Last login: Tue Jul  6 16:29:20 2004 on ttyS0
Linux analyticity 2.6.7-mm6-dmitry-1 #1 SMP Tue Jul 6 23:16:01 PDT 2004 sparc64 GNU/Linux
# mount
192.168.1.1:/mnt/f/e3k/debian on / type nfs (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
none on /tmp type tmpfs (rw)
192.168.1.1:/home on /home type nfs (rw,tcp,addr=192.168.1.1)
# ls /sys/class
firmware  mem   net scsi_device   scsi_host  tty
input     misc  netlink  scsi_generic  scsi_tape  vc
# ls /sys/class/input/
# ls /sys/class/tty
console  tty12  tty19  tty25  tty31  tty38  tty44  tty50  tty57  tty63
ptmx tty13  tty2   tty26  tty32  tty39  tty45  tty51  tty58  tty7
tty tty14  tty20  tty27  tty33  tty4   tty46  tty52  tty59  tty8
tty0 tty15  tty21  tty28  tty34  tty40  tty47  tty53  tty6   tty9
tty1 tty16  tty22  tty29  tty35  tty41  tty48  tty54  tty60  ttyS0
tty10    tty17  tty23  tty3   tty36  tty42  tty49  tty55  tty61  ttyS1
tty11    tty18  tty24  tty30  tty37  tty43  tty5   tty56  tty62
# ls /sys/class/tty/ss  ttyS0
dev
#
[detached]
$ 

Script done on Tue Jul  6 23:27:39 2004
