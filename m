Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbTCMLPl>; Thu, 13 Mar 2003 06:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262236AbTCMLPl>; Thu, 13 Mar 2003 06:15:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:49097 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262230AbTCMLPf>;
	Thu, 13 Mar 2003 06:15:35 -0500
Date: Thu, 13 Mar 2003 03:26:15 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.64-mm6
Message-Id: <20030313032615.7ca491d6.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2003 11:26:15.0383 (UTC) FILETIME=[5BF05670:01C2E953]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm6/

. Added all of Russell King's PCMCIA changes.  If anyone tests this on
  cardbus/PCMCIA machines please let us know.

. Starting to concentrate a bit more on the nonlinear mapping and objrmap
  patches.  These conflict to various degrees, but we seem to be getting that
  sorted now.

  To test the nonlinear mapping code more thoroughly I have arranged for all
  executable file-backed mmaps to be treated as nonlinear.

  This means that when an executable is first mapped in, the kernel will
  slurp the whole thing off disk in one hit.  Some IO changes were made to
  speed this up.

  This means that large cache-cold executables start significantly faster.
  Launching X11+KDE+mozilla goes from 23 seconds to 16.  Starting OpenOffice
  seems to be 2x to 3x faster, and starting Konqueror maybe 3x faster too. 
  Interesting.

  This might cause weird thing to happen, especially on small-memory machines.




Changes since 2.5.64-mm5:


+ppc64-compat-flock.patch
+ppc64-eeh-fix.patch
+ppc64-socketcall-fix.patch

 Various ppc64 build fixes

+remap-file-pages-2.5.63-a1.patch

 Reworked to apply before objrmap,

+hugh-remap-fix.patch

 The remap_file_pages part of hugh-nonlinear-fixes.patch

+fremap-limit-offsets.patch

 Constrain remap_file_pages() input to fit inside the file-offset-in-pte
 representation.  29 bits on ia32.

+fremap-all-mappings.patch

 Make all PROT_EXEC file-backed mmappings use MAP_POPULATE treatment.

+filemap_populate-speedup.patch

 Use large IOs for prefaulting.

+file-offset-in-pte-x86_64.patch

 Reworked for remap_file_pages offset limiting.

+file-offset-in-pte-ppc64.patch

 PPC64 support.  Untested...

+objrmap-nonlinear-fixes.patch

 The other part of hugh-nonlinear-fixes.patch

-hugh-nonlinear-fixes.patch

 Split up.

-brlock-1.patch
-brlock-2.patch
-brlock-3.patch
-brlock-4.patch
-brlock-5.patch
-brlock-6.patch
-brlock-7.patch
-brlock-8.patch

 Dropped.  Stephen has a new patch, but it doesn't compile.

+early-writeback-init.patch

 Intialsie writeback early for rootfs population.

+posix-timers-update.patch

 Permit long sleeps.

+e100-memleak-fix.patch

 Plug another leak.

+pcmcia-1-kill-get_foo_map.patch
+pcmcia-2-remove-bus_foo-abstractions.patch
+pcmcia-3-add-SOCKET_CARDBUS_CONFIG.patch
+pcmcia-4-add-locking.patch
+pcmcia-5-add-CONFIG_PCMCIA_PROBE.patch
+pcmcia-6-remove-old-cardbus-clients.patch

 rmk's pcmcia rework

+oops-counters.patch

 Display the oops instance in the oops record

+io_apic-DO_ACTION-cleanup.patch

 Clean up the IO APIC code.

+ext2-ext3-noatime-fix.patch

 Ext2 and ext3 inode flags initialisation fixes.





All 86 patches:

linus.patch
  Latest from Linus

mm.patch
  add -mmN to EXTRAVERSION

kgdb.patch

noirqbalance-fix.patch
  Fix noirqbalance

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-64-bit-exec-fix.patch
  Pass the load address into ELF_PLAT_INIT()

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

ppc64-compat-flock.patch
  compat_sys_fcntl{,64} 2/9 ppc64 part

ppc64-eeh-fix.patch
  ppc64 build fix

ppc64-socketcall-fix.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

nfsd-disable-softirq.patch
  Fix race in svcsock.c in 2.5.61

report-lost-ticks.patch
  make lost-tick detection more informative

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

ptrace-flush.patch
  cache flushing in the ptrace code

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

reiserfs_file_write-5.patch

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

lockd-lockup-fix-2.patch
  Subject: Re: Fw: Re: 2.4.20 NFS server lock-up (SMP)

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

nfs-speedup.patch

nfs-oom-fix.patch
  nfs oom fix

sk-allocation.patch
  Subject: Re: nfs oom

nfs-more-oom-fix.patch

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations

linux-isp.patch

isp-update-1.patch

remove-unused-congestion-stuff.patch
  Subject: [PATCH] remove unused congestion stuff

as-iosched.patch
  anticipatory I/O scheduler

as-debug-BUG-fix.patch

cfq-2.patch
  CFQ scheduler, #2

smalldevfs.patch
  smalldevfs

remap-file-pages-2.5.63-a1.patch
  Subject: [patch] remap-file-pages-2.5.63-A1

hugh-remap-fix.patch
  hugh's file-offset-in-pte fix

fremap-limit-offsets.patch
  fremap: limit remap_file_pages() file offsets

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

filemap_populate-speedup.patch
  filemap_populate speedup

file-offset-in-pte-x86_64.patch
  x86_64: support for file offsets in pte's

file-offset-in-pte-ppc64.patch

objrmap-2.5.62-5.patch
  object-based rmap

objrmap-nonlinear-fixes.patch
  objrmap fix for nonlinear

scheduler-tunables.patch
  scheduler tunables

show_task-free-stack-fix.patch
  show_task() fix and cleanup

reiserfs-fix-memleaks.patch
  ReiserFS: fix memleaks on journal opening failures

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

update_atime-ng.patch
  inode a/c/mtime modification speedup

one-sec-times.patch
  Implement a/c/time speedup in ext2 & ext3

task_prio-fix.patch
  simple task_prio() fix

register-tty_devclass.patch
  Register tty_devclass before use

set_current_state-fs.patch
  use set_current_state in fs

set_current_state-mm.patch
  use set_current_state in mm

copy_thread-leak-fix.patch
  Fix memory leak in copy_thread

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

file_list_lock-contention-fix.patch
  file_list_lock contention fixes

tty_files-fixes.patch
  file->f_list locking in tty_io.c

file_list_cleanup.patch
  file_list cleanup

file_list-remove-free_list.patch
  file_table: remove the private freelist

file-list-less-locking.patch
  file_list: less locking

vt_ioctl-stack-use.patch
  stack reduction in drivers/char/vt_ioctl.c

fix-mem-equals.patch
  Fix mem= options

no-mmu-stubs.patch
  a few missing stubs for !CONFIG_MMU

nommu-slab.patch
  slab changes for !CONFIG_MMU

nfsd-memleak-fix.patch
  nfsd/export.c memleak.

nfs-memleak-fix.patch
  memleak in fs/nfs/inode.c::nfs_get_sb()

ufs-memleak-fix.patch
  Memleak in fs/ufs/util.c

hugetlb-unmap_vmas-fix.patch
  fix the fix for unmap_vmas & hugepages

early-writeback-init.patch
  Early writeback initialisation

posix-timers-update.patch
  posix timers update

e100-memleak-fix.patch
  Memleak in e100 driver

bsd-printk-limit.patch

pcmcia-1-kill-get_foo_map.patch
  pcmcia: 1/6 kill get_*_map

pcmcia-2-remove-bus_foo-abstractions.patch
  pcmcia: 2/6: Remove bus_* abstractions

pcmcia-3-add-SOCKET_CARDBUS_CONFIG.patch
  pcmcia: 3/6: add SOCKET_CARDBUS_CONFIG flag

pcmcia-4-add-locking.patch
  pcmcia: 4/6: Add some locking to rsrc_mgr.c

pcmcia-5-add-CONFIG_PCMCIA_PROBE.patch
  pcmcia 5/6: Introduce CONFIG_PCMCIA_PROBE

pcmcia-6-remove-old-cardbus-clients.patch
  pcmcia: 6/6: Remove support for old cardbus clients

oops-counters.patch
  OOPS instance counters

io_apic-DO_ACTION-cleanup.patch
  io-apic.c: DO_ACTION cleanup

ext2-ext3-noatime-fix.patch
  Ext2/3 noatime and dirsync sometimes ignored



