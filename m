Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277227AbRJDU5V>; Thu, 4 Oct 2001 16:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277226AbRJDU5O>; Thu, 4 Oct 2001 16:57:14 -0400
Received: from [195.223.140.107] ([195.223.140.107]:5881 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S277224AbRJDU5F>;
	Thu, 4 Oct 2001 16:57:05 -0400
Date: Thu, 4 Oct 2001 22:57:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.11pre3aa1
Message-ID: <20011004225708.A724@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI: the next things I will try to concentrate on the next days are:

1) get_swap_entry collecting exclusive swapcache pages
2) Hugh's locking cleanups
3) Marcelo's vm patches
4) rcu, Dipankar, could you send me your latest version, the design that we
   agreed that only adds a per-cpu sequence number inc (not a branch)
   in schedule?
5) listening to the softirq patches, still I'd be curious to see the raw
   number with only the deschedule logic, just too see the order of
   magnitude of overhead caused by the suprious rescheduling, yes when
   there's no softirq pending a ksoftirqd reschedule is _literally_ suprious

Thanks to all but especially to Linus and Al for fixing up the aliasing
issues introduced with the blkdev-pagecache during pre[123]! I wouldn't
been able to cover everything myself in such a short timeframe, so I
really appreciated that.

Only in 2.4.11pre3aa1: 00_backout-2.4.11pre1-1

	Resurrect some bit like O_DIRECT and drop the fragile vm_swap_full
	logic, the plan is to make get_swap_page able to collect exclusive swap
	cache pages. Hugh's patches are pending, they changes locking so they're
	not included until I'll check them in detail.

Only in 2.4.11pre3aa1: 00_binfmt-elf-checks-1

	Rest of the missing checks.

Only in 2.4.10aa1: 00_enable-apic-1

	Dropped.

Only in 2.4.11pre3aa1: 00_highmem-deadlock-1

	Finegrined highmem deadlock fix, now if we go creating bounce buffers
	while we locked down buffers that aren't in the I/O queue yet, we
	set the pending_io bitflag on those locked buffers to make sure we
	won't deadlock on them while allocating the bounce pages.

Only in 2.4.10aa1: 00_lvm-1.0.1-rc2-2.bz2
Only in 2.4.11pre3aa1: 00_lvm-1.0.1-rc4-1.bz2
Only in 2.4.11pre3aa1: 10_lvm-incremental-1

	Picked last update from www.sistina.com and extracted the incremental
	changes into a separate patch to make easier furture merging.

Only in 2.4.11pre3aa1: 00_netconsole-2.4.10-C2
Only in 2.4.10aa1: 00_netconsole-code-1
Only in 2.4.10aa1: 00_netconsole-misc-1

	Upgrade to -C2 from www.redhat.com/~mingo/ .

Only in 2.4.11pre3aa1: 00_o_direct-1

	O_DIRECT updates after the blkdev physical address space fixes.

Only in 2.4.10aa1: 00_rwsem-fair-20-recursive-2
Only in 2.4.11pre3aa1: 00_rwsem-fair-20-recursive-4

	Rediffed, and fixed ppc compilation.

Only in 2.4.11pre3aa1: 00_spinlock-cacheline-1

	Cacheline align a few critical spinlocks from Juergen Doelle.

Only in 2.4.11pre3aa1: 00_tcp-nagle-1

	nagle TCP/IP fixes extracted from the TUX patch downloadable at
	www.redhat.com/~mingo/ . 

Only in 2.4.10aa1: 00_vm-tweaks-1
Only in 2.4.11pre3aa1: 00_vm-tweaks-3

	Rest of the vm-tweaks not merged because of disagreement. I see
	Linus's point but without those swap behaviour sucks. For now
	I left them since they're well tested, I will look more into this
	shortly.

Only in 2.4.11pre3aa1: 10_compiler.h-1

	Move #include <linux/compiler.h> into include/linux/kernel.h to avoid
	all the present/future compilation troubles. Assume likely/unlikely
	are always available in all kernel code.

Only in 2.4.10aa1: 10_highmem-debug-3
Only in 2.4.11pre3aa1: 10_highmem-debug-4

	Rediffed.

Only in 2.4.11pre3aa1: 50_uml-patch-2.4.10-5.bz2
Only in 2.4.10aa1: 50_uml-patch-2.4.9-8-1.bz2
Only in 2.4.10aa1: 51_uml-ac-to-aa-4
Only in 2.4.11pre3aa1: 51_uml-ac-to-aa-5
Only in 2.4.10aa1: 52_uml-page-offset-raw-1
Only in 2.4.10aa1: 55_uml-sys_personality-1
Only in 2.4.10aa1: 56_uml-rb-mmap-1
Only in 2.4.10aa1: 57_ptrace_disable-1
Only in 2.4.10aa1: 58_uml-tlb-1

	Picked last update from user-mode-linux.sourceforge.net .

Only in 2.4.11pre3aa1: 60_tux-2.4.10-ac4-A4.bz2
Only in 2.4.10aa1: 60_tux-2.4.9-ac10-K7
Only in 2.4.10aa1: 60_tux-syscall-1
Only in 2.4.11pre3aa1: 60_tux-syscall-2
Only in 2.4.11pre3aa1: 60_tux-timer_t-1

	Picked last TUX update from www.redhat.com/~mingo/ .

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.11pre3aa1/
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.11pre3aa1.bz2

diffstat:

 CREDITS                                  |    2 
 Documentation/Configure.help             |  242 +++
 Documentation/networking/netlogging.txt  |   46 
 MAINTAINERS                              |    8 
 Makefile                                 |    9 
 arch/alpha/config.in                     |    5 
 arch/alpha/kernel/alpha_ksyms.c          |    4 
 arch/alpha/kernel/entry.S                |   18 
 arch/alpha/kernel/proto.h                |    5 
 arch/alpha/kernel/traps.c                |   17 
 arch/alpha/mm/fault.c                    |   10 
 arch/arm/config.in                       |    2 
 arch/arm/mm/fault-common.c               |    2 
 arch/cris/config.in                      |    2 
 arch/cris/mm/fault.c                     |    2 
 arch/i386/Makefile                       |    3 
 arch/i386/config.in                      |   15 
 arch/i386/kernel/entry.S                 |   16 
 arch/i386/kernel/i386_ksyms.c            |    2 
 arch/i386/kernel/irq.c                   |    8 
 arch/i386/kernel/setup.c                 |   12 
 arch/i386/kernel/smp.c                   |    2 
 arch/i386/lib/usercopy.c                 |    8 
 arch/i386/mm/fault.c                     |   22 
 arch/i386/vmlinux.lds.S                  |   83 +
 arch/ia64/config.in                      |    2 
 arch/ia64/mm/fault.c                     |   10 
 arch/m68k/config.in                      |    2 
 arch/m68k/mm/fault.c                     |    2 
 arch/mips/config.in                      |    2 
 arch/mips/mm/fault.c                     |    2 
 arch/mips64/config.in                    |    3 
 arch/mips64/mm/fault.c                   |    2 
 arch/parisc/config.in                    |    2 
 arch/ppc/config.in                       |    2 
 arch/ppc/mm/fault.c                      |   15 
 arch/s390/config.in                      |    2 
 arch/s390/mm/fault.c                     |    2 
 arch/s390x/config.in                     |    2 
 arch/s390x/mm/fault.c                    |    2 
 arch/sh/config.in                        |    2 
 arch/sh/mm/fault.c                       |    4 
 arch/sparc/config.in                     |    2 
 arch/sparc/mm/fault.c                    |    4 
 arch/sparc64/config.in                   |    2 
 arch/sparc64/mm/fault.c                  |    2 
 arch/um/Makefile                         |  103 +
 arch/um/Makefile-i386                    |    8 
 arch/um/Makefile-ia64                    |    1 
 arch/um/Makefile-ppc                     |    5 
 arch/um/boot/Makefile                    |    3 
 arch/um/config.in                        |  103 +
 arch/um/config.release                   |  288 ++++
 arch/um/defconfig                        |  293 ++++
 arch/um/drivers/Makefile                 |   50 
 arch/um/drivers/chan_kern.c              |  270 +++
 arch/um/drivers/chan_user.c              |  250 +++
 arch/um/drivers/daemon.h                 |   39 
 arch/um/drivers/daemon_kern.c            |  128 +
 arch/um/drivers/daemon_kern.h            |    8 
 arch/um/drivers/daemon_user.c            |  210 +++
 arch/um/drivers/etap.h                   |   34 
 arch/um/drivers/etap_kern.h              |   24 
 arch/um/drivers/ethertap_kern.c          |  139 ++
 arch/um/drivers/ethertap_user.c          |  231 +++
 arch/um/drivers/mcast.h                  |   36 
 arch/um/drivers/mcast_kern.c             |  168 ++
 arch/um/drivers/mcast_kern.h             |    8 
 arch/um/drivers/mcast_user.c             |  214 +++
 arch/um/drivers/mconsole_kern.c          |  235 +++
 arch/um/drivers/mconsole_user.c          |  168 ++
 arch/um/drivers/mmapper_kern.c           |  146 ++
 arch/um/drivers/net_kern.c               |  631 +++++++++
 arch/um/drivers/net_kern.h               |   66 
 arch/um/drivers/net_user.c               |   65 
 arch/um/drivers/net_user.h               |   43 
 arch/um/drivers/slip.h                   |   33 
 arch/um/drivers/slip_kern.c              |  106 +
 arch/um/drivers/slip_kern.h              |    8 
 arch/um/drivers/slip_user.c              |  284 ++++
 arch/um/drivers/ssl.c                    |  310 ++++
 arch/um/drivers/ssl.h                    |   23 
 arch/um/drivers/stdio_console.c          |  294 ++++
 arch/um/drivers/stdio_console.h          |   26 
 arch/um/drivers/stdio_console_user.c     |   53 
 arch/um/drivers/tuntap.h                 |   38 
 arch/um/drivers/tuntap_kern.c            |  130 +
 arch/um/drivers/tuntap_kern.h            |   24 
 arch/um/drivers/tuntap_user.c            |  264 +++
 arch/um/drivers/ubd.c                    |  799 +++++++++++
 arch/um/drivers/ubd_user.c               |  474 +++++++
 arch/um/fs/Makefile                      |   16 
 arch/um/fs/hostfs/Makefile               |   31 
 arch/um/fs/hostfs/hostfs.h               |   74 +
 arch/um/fs/hostfs/hostfs_kern.c          |  782 +++++++++++
 arch/um/fs/hostfs/hostfs_user.c          |  337 ++++
 arch/um/include/chan.h                   |  129 +
 arch/um/include/debug.h                  |    9 
 arch/um/include/kern.h                   |   42 
 arch/um/include/kern_util.h              |  130 +
 arch/um/include/mconsole.h               |   49 
 arch/um/include/mconsole_kern.h          |   47 
 arch/um/include/mem_user.h               |   60 
 arch/um/include/process.h                |   26 
 arch/um/include/signal_kern.h            |   27 
 arch/um/include/signal_user.h            |   29 
 arch/um/include/sysdep-i386/ptrace.h     |   63 
 arch/um/include/sysdep-i386/sigcontext.h |   26 
 arch/um/include/sysdep-i386/syscalls.h   |   55 
 arch/um/include/sysdep-ia64/ptrace.h     |   26 
 arch/um/include/sysdep-ia64/sigcontext.h |   20 
 arch/um/include/sysdep-ia64/syscalls.h   |   20 
 arch/um/include/sysdep-ppc/ptrace.h      |   96 +
 arch/um/include/sysdep-ppc/sigcontext.h  |   67 
 arch/um/include/sysdep-ppc/syscalls.h    |   50 
 arch/um/include/sysrq.h                  |    6 
 arch/um/include/ubd_user.h               |   72 +
 arch/um/include/umid.h                   |   18 
 arch/um/include/umn.h                    |   27 
 arch/um/include/user.h                   |   27 
 arch/um/include/user_util.h              |  139 ++
 arch/um/kernel/Makefile                  |   78 +
 arch/um/kernel/current.c                 |   24 
 arch/um/kernel/exec_kern.c               |  125 +
 arch/um/kernel/exec_user.c               |   46 
 arch/um/kernel/init_task.c               |   56 
 arch/um/kernel/irq.c                     |  812 ++++++++++++
 arch/um/kernel/irq_user.c                |  165 ++
 arch/um/kernel/ksyms.c                   |   23 
 arch/um/kernel/mem.c                     |  206 +++
 arch/um/kernel/mem_user.c                |  215 +++
 arch/um/kernel/mprot.h                   |    6 
 arch/um/kernel/process.c                 |  251 +++
 arch/um/kernel/process_kern.c            |  785 +++++++++++
 arch/um/kernel/ptrace.c                  |  247 +++
 arch/um/kernel/reboot.c                  |   54 
 arch/um/kernel/resource.c                |   23 
 arch/um/kernel/setup.c                   |   19 
 arch/um/kernel/signal_kern.c             |  393 +++++
 arch/um/kernel/signal_user.c             |  226 +++
 arch/um/kernel/smp.c                     |  141 ++
 arch/um/kernel/sys_call_table.c          |  437 ++++++
 arch/um/kernel/syscall_kern.c            |  351 +++++
 arch/um/kernel/syscall_user.c            |  175 ++
 arch/um/kernel/sysrq.c                   |   72 +
 arch/um/kernel/time.c                    |  120 +
 arch/um/kernel/time_kern.c               |  131 +
 arch/um/kernel/tlb.c                     |  194 ++
 arch/um/kernel/trap_kern.c               |  356 +++++
 arch/um/kernel/trap_user.c               |  398 +++++
 arch/um/kernel/uaccess_user.c            |  125 +
 arch/um/kernel/um_arch.c                 |  375 +++++
 arch/um/kernel/umid.c                    |  214 +++
 arch/um/kernel/unmap.c                   |   34 
 arch/um/kernel/user_syms.c               |  112 +
 arch/um/kernel/user_util.c               |  337 ++++
 arch/um/link.ld.in                       |  105 +
 arch/um/main.c                           |  204 +++
 arch/um/ptproxy/Makefile                 |   28 
 arch/um/ptproxy/proxy.c                  |  285 ++++
 arch/um/ptproxy/ptproxy.h                |   42 
 arch/um/ptproxy/ptrace.c                 |  209 +++
 arch/um/ptproxy/sysdep.c                 |   59 
 arch/um/ptproxy/sysdep.h                 |   13 
 arch/um/ptproxy/wait.c                   |   79 +
 arch/um/ptproxy/wait.h                   |   18 
 arch/um/sys-i386/Makefile                |   49 
 arch/um/sys-i386/ksyms.c                 |   16 
 arch/um/sys-i386/ldt.c                   |   22 
 arch/um/sys-i386/ptrace.c                |   76 +
 arch/um/sys-i386/ptrace_user.c           |   25 
 arch/um/sys-i386/sigcontext.c            |   46 
 arch/um/sys-i386/syscalls.c              |   68 +
 arch/um/sys-i386/sysrq.c                 |   22 
 arch/um/sys-ia64/Makefile                |   26 
 arch/um/sys-ppc/Makefile                 |   78 +
 arch/um/sys-ppc/misc.S                   |  116 +
 arch/um/sys-ppc/miscthings.c             |   56 
 arch/um/sys-ppc/ptrace.c                 |   28 
 arch/um/sys-ppc/ptrace_user.c            |   39 
 arch/um/sys-ppc/sigcontext.c             |   43 
 arch/um/tlb.h                            |    1 
 drivers/block/loop.c                     |    4 
 drivers/char/Makefile                    |    6 
 drivers/md/Makefile                      |    2 
 drivers/md/lvm-fs.c                      |  619 +++++++++
 drivers/md/lvm-internal.h                |  105 +
 drivers/md/lvm-snap.c                    |  451 ++++--
 drivers/md/lvm-snap.h                    |   47 
 drivers/md/lvm.c                         | 2097 +++++++++++++------------------
 drivers/net/Config.in                    |    2 
 drivers/net/Makefile                     |    2 
 drivers/net/eepro100.c                   |   21 
 drivers/net/netconsole.c                 |  331 ++++
 drivers/net/tulip/tulip_core.c           |   22 
 fs/binfmt_elf.c                          |   47 
 fs/block_dev.c                           |    6 
 fs/buffer.c                              |   56 
 fs/dcache.c                              |   25 
 fs/exec.c                                |    4 
 fs/ext2/inode.c                          |    5 
 fs/inode.c                               |    6 
 fs/namei.c                               |   14 
 fs/proc/proc_misc.c                      |   62 
 fs/select.c                              |    2 
 include/asm-alpha/fcntl.h                |    1 
 include/asm-alpha/mmzone.h               |    2 
 include/asm-alpha/module.h               |    4 
 include/asm-alpha/rwsem.h                |  208 ---
 include/asm-alpha/timex.h                |    4 
 include/asm-alpha/uaccess.h              |   40 
 include/asm-alpha/unistd.h               |    4 
 include/asm-arm/timex.h                  |    4 
 include/asm-cris/timex.h                 |    4 
 include/asm-i386/fcntl.h                 |    1 
 include/asm-i386/hw_irq.h                |   13 
 include/asm-i386/module.h                |    4 
 include/asm-i386/page.h                  |    4 
 include/asm-i386/page_offset.h           |    6 
 include/asm-i386/pgtable.h               |    4 
 include/asm-i386/processor.h             |    4 
 include/asm-i386/rwsem.h                 |  226 ---
 include/asm-i386/smplock.h               |    3 
 include/asm-i386/timex.h                 |    4 
 include/asm-i386/uaccess.h               |    5 
 include/asm-ia64/fcntl.h                 |    1 
 include/asm-ia64/timex.h                 |    4 
 include/asm-m68k/timex.h                 |    4 
 include/asm-mips/timex.h                 |    5 
 include/asm-mips64/timex.h               |    4 
 include/asm-parisc/timex.h               |    4 
 include/asm-ppc/fcntl.h                  |    1 
 include/asm-ppc/timex.h                  |    4 
 include/asm-s390/timex.h                 |    4 
 include/asm-s390x/timex.h                |    4 
 include/asm-sh/timex.h                   |    4 
 include/asm-sparc/fcntl.h                |    1 
 include/asm-sparc/timex.h                |    4 
 include/asm-sparc64/fcntl.h              |    1 
 include/asm-sparc64/timex.h              |    4 
 include/asm-um/a.out.h                   |   18 
 include/asm-um/archparam-i386.h          |   26 
 include/asm-um/archparam-ppc.h           |   41 
 include/asm-um/atomic.h                  |    6 
 include/asm-um/bitops.h                  |    6 
 include/asm-um/boot.h                    |    6 
 include/asm-um/bugs.h                    |    6 
 include/asm-um/byteorder.h               |    6 
 include/asm-um/cache.h                   |    6 
 include/asm-um/checksum.h                |    6 
 include/asm-um/cobalt.h                  |    6 
 include/asm-um/current.h                 |   26 
 include/asm-um/delay.h                   |    7 
 include/asm-um/desc.h                    |    6 
 include/asm-um/div64.h                   |    6 
 include/asm-um/dma.h                     |   10 
 include/asm-um/elf.h                     |   16 
 include/asm-um/errno.h                   |    6 
 include/asm-um/fcntl.h                   |    6 
 include/asm-um/fixmap.h                  |    6 
 include/asm-um/floppy.h                  |    6 
 include/asm-um/hardirq.h                 |    6 
 include/asm-um/hdreg.h                   |    6 
 include/asm-um/highmem.h                 |    6 
 include/asm-um/hw_irq.h                  |   10 
 include/asm-um/ide.h                     |    6 
 include/asm-um/init.h                    |   11 
 include/asm-um/io.h                      |    6 
 include/asm-um/ioctl.h                   |    6 
 include/asm-um/ioctls.h                  |    6 
 include/asm-um/ipc.h                     |    6 
 include/asm-um/ipcbuf.h                  |    6 
 include/asm-um/irq.h                     |   27 
 include/asm-um/keyboard.h                |    6 
 include/asm-um/linux_logo.h              |    6 
 include/asm-um/locks.h                   |    6 
 include/asm-um/mca_dma.h                 |    6 
 include/asm-um/mman.h                    |    6 
 include/asm-um/mmu.h                     |    6 
 include/asm-um/mmu_context.h             |   25 
 include/asm-um/module.h                  |    6 
 include/asm-um/msgbuf.h                  |    6 
 include/asm-um/mtrr.h                    |    6 
 include/asm-um/namei.h                   |    6 
 include/asm-um/page.h                    |   40 
 include/asm-um/page_offset.h             |    1 
 include/asm-um/param.h                   |   24 
 include/asm-um/pci.h                     |    6 
 include/asm-um/pgalloc.h                 |  144 ++
 include/asm-um/pgtable.h                 |  378 +++++
 include/asm-um/poll.h                    |    6 
 include/asm-um/posix_types.h             |    6 
 include/asm-um/processor-generic.h       |  190 ++
 include/asm-um/processor-i386.h          |    6 
 include/asm-um/processor-ppc.h           |   15 
 include/asm-um/ptrace.h                  |   32 
 include/asm-um/resource.h                |    6 
 include/asm-um/rwlock.h                  |    6 
 include/asm-um/rwsem-spin.h              |    6 
 include/asm-um/rwsem_xchgadd.h           |    6 
 include/asm-um/scatterlist.h             |    6 
 include/asm-um/segment.h                 |    4 
 include/asm-um/semaphore.h               |    6 
 include/asm-um/sembuf.h                  |    6 
 include/asm-um/serial.h                  |    6 
 include/asm-um/shmbuf.h                  |    6 
 include/asm-um/shmparam.h                |    6 
 include/asm-um/sigcontext-generic.h      |    6 
 include/asm-um/sigcontext-i386.h         |    6 
 include/asm-um/sigcontext-ppc.h          |   10 
 include/asm-um/siginfo.h                 |    6 
 include/asm-um/signal.h                  |   14 
 include/asm-um/smp.h                     |   18 
 include/asm-um/smplock.h                 |    6 
 include/asm-um/socket.h                  |    6 
 include/asm-um/sockios.h                 |    6 
 include/asm-um/softirq.h                 |   13 
 include/asm-um/spinlock.h                |   10 
 include/asm-um/stat.h                    |    6 
 include/asm-um/statfs.h                  |    6 
 include/asm-um/string.h                  |    7 
 include/asm-um/system-generic.h          |   49 
 include/asm-um/system-i386.h             |    6 
 include/asm-um/system-ppc.h              |   16 
 include/asm-um/termbits.h                |    6 
 include/asm-um/termios.h                 |    6 
 include/asm-um/timex.h                   |   19 
 include/asm-um/tlb.h                     |    1 
 include/asm-um/types.h                   |    6 
 include/asm-um/uaccess.h                 |  184 ++
 include/asm-um/unaligned.h               |    6 
 include/asm-um/unistd.h                  |  100 +
 include/asm-um/user.h                    |    6 
 include/asm-um/vga.h                     |    6 
 include/linux/blk.h                      |    9 
 include/linux/condsched.h                |   14 
 include/linux/dcache.h                   |    2 
 include/linux/errno.h                    |    3 
 include/linux/fs.h                       |   20 
 include/linux/hostfs_fs_i.h              |   21 
 include/linux/kernel.h                   |    3 
 include/linux/kernel_stat.h              |   49 
 include/linux/lvm.h                      |  331 +---
 include/linux/mm.h                       |   51 
 include/linux/netdevice.h                |    2 
 include/linux/numa_sched.h               |   53 
 include/linux/rwsem-spinlock.h           |   62 
 include/linux/rwsem.h                    |  168 +-
 include/linux/sched.h                    |  102 -
 include/linux/slab.h                     |    2 
 include/linux/socket.h                   |    5 
 include/linux/spinlock.h                 |   16 
 include/linux/swap.h                     |    8 
 include/linux/sysctl.h                   |   55 
 include/linux/time.h                     |   42 
 include/linux/timer.h                    |    2 
 include/linux/tty.h                      |    3 
 include/net/sock.h                       |    4 
 include/net/tcp.h                        |   13 
 include/net/tux.h                        |  753 +++++++++++
 include/net/tux_u.h                      |  164 ++
 init/main.c                              |    1 
 kernel/exit.c                            |   16 
 kernel/fork.c                            |   24 
 kernel/ksyms.c                           |   20 
 kernel/printk.c                          |    2 
 kernel/sched.c                           |  161 +-
 kernel/sysctl.c                          |    2 
 kernel/time.c                            |   11 
 kernel/timer.c                           |   14 
 lib/Makefile                             |    7 
 lib/rwsem-spinlock.c                     |  239 ---
 lib/rwsem.c                              |  233 ---
 lib/vsprintf.c                           |    7 
 mm/filemap.c                             |  170 ++
 mm/highmem.c                             |    3 
 mm/memory.c                              |   22 
 mm/mmap.c                                |   17 
 mm/page_alloc.c                          |   91 +
 mm/slab.c                                |    3 
 mm/swap.c                                |    2 
 mm/swapfile.c                            |    1 
 mm/vmalloc.c                             |    4 
 mm/vmscan.c                              |   23 
 net/Config.in                            |    1 
 net/Makefile                             |    1 
 net/ipv4/tcp.c                           |    2 
 net/ipv4/tcp_minisocks.c                 |    2 
 net/netsyms.c                            |   19 
 net/socket.c                             |  120 +
 net/tux/Config.in                        |    7 
 net/tux/Makefile                         |   16 
 net/tux/abuf.c                           |  177 ++
 net/tux/accept.c                         |  842 ++++++++++++
 net/tux/cachemiss.c                      |  258 +++
 net/tux/cgi.c                            |  211 +++
 net/tux/extcgi.c                         |  325 ++++
 net/tux/input.c                          |  783 +++++++++++
 net/tux/logger.c                         |  785 +++++++++++
 net/tux/main.c                           | 1252 ++++++++++++++++++
 net/tux/mod.c                            |  243 +++
 net/tux/output.c                         |  267 +++
 net/tux/parser.h                         |   92 +
 net/tux/postpone.c                       |   77 +
 net/tux/proc.c                           |  806 +++++++++++
 net/tux/proto_ftp.c                      | 1662 ++++++++++++++++++++++++
 net/tux/proto_http.c                     | 1320 +++++++++++++++++++
 net/tux/redirect.c                       |  153 ++
 net/tux/times.c                          |  176 ++
 net/tux/times.h                          |   26 
 net/tux/userspace.c                      |   27 
 411 files changed, 35205 insertions(+), 2888 deletions(-)

Andrea
