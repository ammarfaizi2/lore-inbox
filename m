Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVJXRvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVJXRvg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVJXRvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:51:36 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:13348 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751195AbVJXRve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:51:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=D24dM2FUD354ZyUZj7rvb5sKMBgUJHMWxzwOePV9jyglrZvYYjG5Y+1fdVhxk4ycxhK/zJGoVURezgXvM1rrSAri6dRScy6TeDHL6LBgTGfuKcFfupmzrh8p+tSm3/cl1pVK2dnRZ+zV3yLbFPrtrKwDBJqYvw+ur2CYjOD8/7A=
Message-ID: <435D1F04.8070502@gmail.com>
Date: Mon, 24 Oct 2005 18:51:00 +0100
User-Agent: Thunderbird 1.6a1 (Windows/20051023)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc5-mm1
References: <20051024014838.0dd491bb.akpm@osdl.org>
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Lexington Luthor <lexington.luthor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/
> 
> - At great personal cost I managed to coax most of the USB devel tree into
>   compiling and booting.  We're hoping that the changes in here will improve
>   USB-related power management (suspend and resume).  Please cc
>   linux-usb-devel@lists.sourceforge.net on any bug reports (or use bugzilla).
> 
> - Added git-blktrace.patch to the -mm lineup: Jens's block-layer tracing
>   infrastructure.   It appears to be undocumented...
> 
> - Added git-block.patch to the -mm lineup: Jens's block tree
>   (drivers/block/*.c, basically).
> 
> - Added git-mips.patch to the -mm lineup: Ralf's MIPS development tree.
> 
> - Lots more core MM changes from Hugh: mainly to address page_table_lock SMP
>   scalability issuse.  All this code is in place now (I think), so performance
>   testing time is here.
> 
> - Demand-paging for hugetlb pages.   Needs very careful testing.
> 
> - Added Thomas's ktimer patch.
> 
> - A number of tty drivers still won't compile.
> 

(Second try at sending this message. The first one got eaten by the 
gmane server. Apologies for the noise if you receive this twice.)

Hi,

This release has a number of build errors for me. I used the vanilla 
2.6.14-rc5 + 2.6.14-rc5-mm1 patch + CK's 1GB lowmem patch.

Here is the make output and the .config listing:
$ make
   CHK     include/linux/version.h
   UPD     include/linux/version.h
   SYMLINK include/asm -> include/asm-i386
   SPLIT   include/linux/autoconf.h -> include/config/*
   CC      arch/i386/kernel/asm-offsets.s
   GEN     include/asm-i386/asm-offsets.h
   CC      scripts/mod/empty.o
   HOSTCC  scripts/mod/mk_elfconfig
   MKELF   scripts/mod/elfconfig.h
   HOSTCC  scripts/mod/file2alias.o
   HOSTCC  scripts/mod/modpost.o
   HOSTCC  scripts/mod/sumversion.o
   HOSTLD  scripts/mod/modpost
   HOSTCC  scripts/conmakehash
   CC      init/main.o
In file included from init/main.c:50:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   CC      init/do_mounts.o
   LD      init/mounts.o
   CC      init/initramfs.o
   CC      init/calibrate.o
   LD      init/built-in.o
   HOSTCC  usr/gen_init_cpio
   CHK     usr/initramfs_list
   UPD     usr/initramfs_list
   CPIO    usr/initramfs_data.cpio
   GZIP    usr/initramfs_data.cpio.gz
   AS      usr/initramfs_data.o
   LD      usr/built-in.o
   CC      arch/i386/kernel/process.o
   CC      arch/i386/kernel/semaphore.o
   CC      arch/i386/kernel/signal.o
   AS      arch/i386/kernel/entry.o
   CC      arch/i386/kernel/traps.o
   CC      arch/i386/kernel/irq.o
   CC      arch/i386/kernel/vm86.o
   CC      arch/i386/kernel/ptrace.o
arch/i386/kernel/ptrace.c: In function `sys_ptrace':
arch/i386/kernel/ptrace.c:383: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      arch/i386/kernel/time.o
   CC      arch/i386/kernel/ioport.o
   CC      arch/i386/kernel/ldt.o
   CC      arch/i386/kernel/setup.o
   CC      arch/i386/kernel/i8259.o
   CC      arch/i386/kernel/sys_i386.o
   CC      arch/i386/kernel/pci-dma.o
   CC      arch/i386/kernel/i386_ksyms.o
   CC      arch/i386/kernel/i387.o
   CC      arch/i386/kernel/dmi_scan.o
   CC      arch/i386/kernel/bootflag.o
   CC      arch/i386/kernel/doublefault.o
   CC      arch/i386/kernel/quirks.o
   CC      arch/i386/kernel/i8237.o
   CC      arch/i386/kernel/cpu/common.o
   CC      arch/i386/kernel/cpu/proc.o
   CC      arch/i386/kernel/cpu/amd.o
   CC      arch/i386/kernel/cpu/cyrix.o
   CC      arch/i386/kernel/cpu/centaur.o
   CC      arch/i386/kernel/cpu/transmeta.o
   CC      arch/i386/kernel/cpu/intel.o
   CC      arch/i386/kernel/cpu/intel_cacheinfo.o
   CC      arch/i386/kernel/cpu/rise.o
   CC      arch/i386/kernel/cpu/nexgen.o
   CC      arch/i386/kernel/cpu/umc.o
   CC      arch/i386/kernel/cpu/mcheck/mce.o
   CC      arch/i386/kernel/cpu/mcheck/k7.o
   CC      arch/i386/kernel/cpu/mcheck/p4.o
   CC      arch/i386/kernel/cpu/mcheck/p5.o
   CC      arch/i386/kernel/cpu/mcheck/p6.o
   CC      arch/i386/kernel/cpu/mcheck/winchip.o
   CC      arch/i386/kernel/cpu/mcheck/non-fatal.o
   LD      arch/i386/kernel/cpu/mcheck/built-in.o
   CC      arch/i386/kernel/cpu/mtrr/main.o
   CC      arch/i386/kernel/cpu/mtrr/if.o
   CC      arch/i386/kernel/cpu/mtrr/generic.o
   CC      arch/i386/kernel/cpu/mtrr/state.o
   CC      arch/i386/kernel/cpu/mtrr/amd.o
   CC      arch/i386/kernel/cpu/mtrr/cyrix.o
   CC      arch/i386/kernel/cpu/mtrr/centaur.o
   LD      arch/i386/kernel/cpu/mtrr/built-in.o
   LD      arch/i386/kernel/cpu/built-in.o
   CC      arch/i386/kernel/timers/timer.o
   CC      arch/i386/kernel/timers/timer_none.o
   CC      arch/i386/kernel/timers/timer_tsc.o
   CC      arch/i386/kernel/timers/timer_pit.o
   CC      arch/i386/kernel/timers/common.o
   CC      arch/i386/kernel/timers/timer_hpet.o
   LD      arch/i386/kernel/timers/built-in.o
   CC      arch/i386/kernel/reboot.o
   CC      arch/i386/kernel/apm.o
arch/i386/kernel/apm.c: In function `suspend':
arch/i386/kernel/apm.c:1186: warning: `pm_send_all' is deprecated 
(declared at include/linux/pm.h:122)
arch/i386/kernel/apm.c:1240: warning: `pm_send_all' is deprecated 
(declared at include/linux/pm.h:122)
arch/i386/kernel/apm.c: In function `check_events':
arch/i386/kernel/apm.c:1361: warning: `pm_send_all' is deprecated 
(declared at include/linux/pm.h:122)
   CC      arch/i386/kernel/mpparse.o
   CC      arch/i386/kernel/apic.o
   CC      arch/i386/kernel/nmi.o
   CC      arch/i386/kernel/io_apic.o
   CC      arch/i386/kernel/module.o
   CC      arch/i386/kernel/sysenter.o
   LDS     arch/i386/kernel/vsyscall.lds
   AS      arch/i386/kernel/vsyscall-int80.o
   AS      arch/i386/kernel/vsyscall-note.o
   SYSCALL arch/i386/kernel/vsyscall-int80.so
   AS      arch/i386/kernel/vsyscall-sysenter.o
   SYSCALL arch/i386/kernel/vsyscall-sysenter.so
   AS      arch/i386/kernel/vsyscall.o
   CC      arch/i386/kernel/time_hpet.o
   CC      arch/i386/kernel/early_printk.o
   SYSCALL arch/i386/kernel/vsyscall-syms.o
   LD      arch/i386/kernel/built-in.o
   AS      arch/i386/kernel/head.o
   CC      arch/i386/kernel/init_task.o
   LDS     arch/i386/kernel/vmlinux.lds
   CC      arch/i386/mm/init.o
   CC      arch/i386/mm/pgtable.o
   CC      arch/i386/mm/fault.o
   CC      arch/i386/mm/ioremap.o
arch/i386/mm/ioremap.c: In function `iounmap':
arch/i386/mm/ioremap.c:257: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      arch/i386/mm/extable.o
   CC      arch/i386/mm/pageattr.o
   CC      arch/i386/mm/mmap.o
   LD      arch/i386/mm/built-in.o
   CC      arch/i386/mach-default/setup.o
   CC      arch/i386/mach-default/topology.o
   LD      arch/i386/mach-default/built-in.o
   LD      arch/i386/crypto/built-in.o
   CC      kernel/sched.o
kernel/sched.c: In function `do_sched_setscheduler':
kernel/sched.c:3805: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      kernel/fork.o
kernel/fork.c: In function `__copy_fs_struct':
kernel/fork.c:542: warning: implicit declaration of function 
`__raw_read_unlock'
kernel/fork.c: In function `copy_process':
kernel/fork.c:1070: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      kernel/exec_domain.o
kernel/exec_domain.c: In function `lookup_exec_domain':
kernel/exec_domain.c:70: warning: implicit declaration of function 
`__raw_read_unlock'
kernel/exec_domain.c: In function `register_exec_domain':
kernel/exec_domain.c:110: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      kernel/panic.o
   CC      kernel/printk.o
   CC      kernel/profile.o
   CC      kernel/exit.o
kernel/exit.c: In function `release_task':
kernel/exit.c:104: warning: implicit declaration of function 
`__raw_write_unlock'
kernel/exit.c: In function `session_of_pgrp':
kernel/exit.c:151: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      kernel/itimer.o
kernel/itimer.c: In function `do_getitimer':
kernel/itimer.c:78: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      kernel/time.o
   CC      kernel/softirq.o
   CC      kernel/resource.o
kernel/resource.c: In function `r_stop':
kernel/resource.c:73: warning: implicit declaration of function 
`__raw_read_unlock'
kernel/resource.c: In function `request_resource':
kernel/resource.c:207: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      kernel/sysctl.o
   CC      kernel/capability.o
kernel/capability.c: In function `sys_capget':
kernel/capability.c:81: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      kernel/ptrace.o
kernel/ptrace.c: In function `ptrace_check_attach':
kernel/ptrace.c:114: warning: implicit declaration of function 
`__raw_read_unlock'
kernel/ptrace.c: In function `ptrace_attach':
kernel/ptrace.c:176: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      kernel/timer.o
   CC      kernel/user.o
   CC      kernel/signal.o
kernel/signal.c: In function `exit_sighand':
kernel/signal.c:339: warning: implicit declaration of function 
`__raw_write_unlock'
kernel/signal.c: In function `kill_pg_info':
kernel/signal.c:1137: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      kernel/sys.o
kernel/sys.c: In function `notifier_chain_register':
kernel/sys.c:119: warning: implicit declaration of function 
`__raw_write_unlock'
kernel/sys.c: In function `sys_setpriority':
kernel/sys.c:298: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      kernel/kmod.o
   CC      kernel/workqueue.o
kernel/workqueue.c: In function `current_is_keventd':
kernel/workqueue.c:460: warning: unused variable `cpu'
   CC      kernel/pid.o
   CC      kernel/rcupdate.o
   CC      kernel/intermodule.o
kernel/intermodule.c:178: warning: `inter_module_register' is deprecated 
(declared at kernel/intermodule.c:38)
kernel/intermodule.c:179: warning: `inter_module_unregister' is 
deprecated (declared at kernel/intermodule.c:78)
kernel/intermodule.c:181: warning: `inter_module_put' is deprecated 
(declared at kernel/intermodule.c:159)
   CC      kernel/extable.o
   CC      kernel/params.o
   CC      kernel/posix-timers.o
kernel/posix-timers.c: In function `sys_timer_create':
kernel/posix-timers.c:546: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      kernel/kthread.o
   CC      kernel/wait.o
   CC      kernel/kfifo.o
   CC      kernel/sys_ni.o
   CC      kernel/posix-cpu-timers.o
kernel/posix-cpu-timers.c: In function `check_clock':
kernel/posix-cpu-timers.c:28: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      kernel/ktimers.o
   CC      kernel/futex.o
   CC      kernel/dma.o
   CC      kernel/uid16.o
   CC      kernel/module.o
   CC      kernel/irq/handle.o
   CC      kernel/irq/manage.o
   CC      kernel/irq/spurious.o
   CC      kernel/irq/autoprobe.o
   CC      kernel/irq/proc.o
   LD      kernel/irq/built-in.o
   CC      kernel/power/main.o
   CC      kernel/power/process.o
kernel/power/process.c: In function `freeze_processes':
kernel/power/process.c:82: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      kernel/power/console.o
   CC      kernel/power/pm.o
kernel/power/pm.c:258: warning: `pm_register' is deprecated (declared at 
kernel/power/pm.c:62)
kernel/power/pm.c:259: warning: `pm_unregister' is deprecated (declared 
at kernel/power/pm.c:85)
kernel/power/pm.c:260: warning: `pm_unregister_all' is deprecated 
(declared at kernel/power/pm.c:114)
kernel/power/pm.c:261: warning: `pm_send_all' is deprecated (declared at 
kernel/power/pm.c:233)
   LD      kernel/power/built-in.o
   CC      kernel/ksysfs.o
   CC      kernel/seccomp.o
   LD      kernel/built-in.o
   CC      mm/bootmem.o
   CC      mm/filemap.o
mm/filemap.c: In function `remove_from_page_cache':
mm/filemap.c:130: warning: implicit declaration of function 
`__raw_write_unlock'
mm/filemap.c: In function `find_get_page':
mm/filemap.c:532: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      mm/mempool.o
   CC      mm/oom_kill.o
mm/oom_kill.c: In function `out_of_memory':
mm/oom_kill.c:286: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      mm/fadvise.o
   CC      mm/page_alloc.o
   CC      mm/page-writeback.o
mm/page-writeback.c: In function `__set_page_dirty_nobuffers':
mm/page-writeback.c:633: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      mm/pdflush.o
   CC      mm/readahead.o
mm/readahead.c: In function `__do_page_cache_readahead':
mm/readahead.c:287: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      mm/slab.o
   CC      mm/swap.o
   CC      mm/truncate.o
mm/truncate.c: In function `invalidate_complete_page':
mm/truncate.c:79: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      mm/vmscan.o
mm/vmscan.c: In function `shrink_list':
mm/vmscan.c:532: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      mm/prio_tree.o
   CC      mm/fremap.o
   CC      mm/highmem.o
   CC      mm/madvise.o
   CC      mm/memory.o
   CC      mm/mincore.o
   CC      mm/mlock.o
   CC      mm/mmap.o
   CC      mm/mprotect.o
   CC      mm/mremap.o
   CC      mm/msync.o
   CC      mm/rmap.o
   CC      mm/vmalloc.o
mm/vmalloc.c: In function `__get_vm_area_node':
mm/vmalloc.c:221: warning: implicit declaration of function 
`__raw_write_unlock'
mm/vmalloc.c: In function `vread':
mm/vmalloc.c:594: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      mm/page_io.o
   CC      mm/swap_state.o
mm/swap_state.c: In function `__add_to_swap_cache':
mm/swap_state.c:90: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      mm/swapfile.o
mm/swapfile.c: In function `remove_exclusive_swap_page':
mm/swapfile.c:355: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      mm/thrash.o
   CC      mm/swap_prefetch.o
mm/swap_prefetch.c: In function `trickle_swap_cache_async':
mm/swap_prefetch.c:232: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      mm/shmem.o
   LD      mm/built-in.o
   CC      fs/open.o
   CC      fs/read_write.o
   CC      fs/file_table.o
   CC      fs/buffer.o
fs/buffer.c: In function `__set_page_dirty_buffers':
fs/buffer.c:871: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      fs/bio.o
   CC      fs/super.o
   CC      fs/block_dev.o
   CC      fs/char_dev.o
   CC      fs/stat.o
   CC      fs/exec.o
fs/exec.c: In function `register_binfmt':
fs/exec.c:80: warning: implicit declaration of function `__raw_write_unlock'
fs/exec.c: In function `sys_uselib':
fs/exec.c:156: warning: implicit declaration of function `__raw_read_unlock'
   CC      fs/pipe.o
   CC      fs/namei.o
fs/namei.c: In function `walk_init_root':
fs/namei.c:463: warning: implicit declaration of function 
`__raw_read_unlock'
fs/namei.c: In function `set_fs_altroot':
fs/namei.c:1026: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      fs/fcntl.o
fs/fcntl.c: In function `f_modown':
fs/fcntl.c:259: warning: implicit declaration of function 
`__raw_write_unlock'
fs/fcntl.c: In function `send_sigio':
fs/fcntl.c:489: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      fs/ioctl.o
   CC      fs/readdir.o
   CC      fs/select.o
   CC      fs/fifo.o
   CC      fs/locks.o
   CC      fs/dcache.o
fs/dcache.c: In function `d_path':
fs/dcache.c:1601: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      fs/inode.o
   CC      fs/attr.o
   CC      fs/bad_inode.o
   CC      fs/file.o
   CC      fs/filesystems.o
fs/filesystems.c: In function `register_filesystem':
fs/filesystems.c:83: warning: implicit declaration of function 
`__raw_write_unlock'
fs/filesystems.c: In function `fs_index':
fs/filesystems.c:141: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      fs/namespace.o
fs/namespace.c: In function `set_fs_root':
fs/namespace.c:1210: warning: implicit declaration of function 
`__raw_write_unlock'
fs/namespace.c: In function `chroot_fs_refs':
fs/namespace.c:1260: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      fs/aio.o
fs/aio.c: In function `ioctx_alloc':
fs/aio.c:244: warning: implicit declaration of function `__raw_write_unlock'
fs/aio.c: In function `lookup_ioctx':
fs/aio.c:545: warning: implicit declaration of function `__raw_read_unlock'
   CC      fs/seq_file.o
   CC      fs/xattr.o
   CC      fs/libfs.o
   CC      fs/fs-writeback.o
   CC      fs/mpage.o
   CC      fs/direct-io.o
   CC      fs/ioprio.o
fs/ioprio.c: In function `sys_ioprio_set':
fs/ioprio.c:116: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      fs/eventpoll.o
   CC      fs/nfsctl.o
   CC      fs/binfmt_script.o
   CC      fs/binfmt_elf.o
fs/binfmt_elf.c: In function `elf_core_dump':
fs/binfmt_elf.c:1459: warning: implicit declaration of function 
`__raw_read_unlock'
   LD      fs/cifs/built-in.o
   CC [M]  fs/cifs/cifsfs.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/cifsfs.c:36:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
fs/cifs/cifsfs.c: At top level:
fs/cifs/cifsfs.c:409: warning: 'cifs_umount_begin' defined but not used
   CC [M]  fs/cifs/cifssmb.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/cifssmb.c:35:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/cifs_debug.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/cifs_debug.c:28:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/connect.o
In file included from include/linux/tcp.h:180,
                  from include/linux/ipv6.h:177,
                  from fs/cifs/connect.c:26:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/dir.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/dir.c:28:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/file.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/file.c:35:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/inode.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/inode.c:27:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/link.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/link.c:25:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/misc.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/misc.c:25:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/netmisc.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/netmisc.c:34:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/smbdes.o
   CC [M]  fs/cifs/smbencrypt.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/smbencrypt.c:32:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/transport.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/transport.c:30:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/asn1.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/asn1.c:26:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/md4.o
   CC [M]  fs/cifs/md5.o
   CC [M]  fs/cifs/cifs_unicode.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/cifs_unicode.c:24:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/nterr.o
   CC [M]  fs/cifs/xattr.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/xattr.c:25:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/cifsencrypt.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/cifsencrypt.c:23:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/fcntl.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/cifsglob.h:56,
                  from fs/cifs/fcntl.c:26:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/readdir.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/readdir.c:26:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/cifs/ioctl.o
In file included from fs/cifs/cifspdu.h:25,
                  from fs/cifs/ioctl.c:26:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   LD [M]  fs/cifs/cifs.o
   CC      fs/devpts/inode.o
   LD      fs/devpts/devpts.o
   LD      fs/devpts/built-in.o
   LD      fs/exportfs/built-in.o
   CC [M]  fs/exportfs/expfs.o
   LD [M]  fs/exportfs/exportfs.o
   LD      fs/ext2/built-in.o
   CC [M]  fs/ext2/balloc.o
fs/ext2/balloc.c: In function `ext2_new_block':
fs/ext2/balloc.c:500: warning: implicit declaration of function 
`__raw_write_unlock'
   CC [M]  fs/ext2/bitmap.o
   CC [M]  fs/ext2/dir.o
   CC [M]  fs/ext2/file.o
   CC [M]  fs/ext2/fsync.o
   CC [M]  fs/ext2/ialloc.o
   CC [M]  fs/ext2/inode.o
fs/ext2/inode.c: In function `ext2_discard_prealloc':
fs/ext2/inode.c:102: warning: implicit declaration of function 
`__raw_write_unlock'
fs/ext2/inode.c: In function `ext2_get_branch':
fs/ext2/inode.c:287: warning: implicit declaration of function 
`__raw_read_unlock'
   CC [M]  fs/ext2/ioctl.o
   CC [M]  fs/ext2/namei.o
   CC [M]  fs/ext2/super.o
   CC [M]  fs/ext2/symlink.o
   LD [M]  fs/ext2/ext2.o
   LD      fs/fat/built-in.o
   CC [M]  fs/fat/cache.o
   CC [M]  fs/fat/dir.o
   CC [M]  fs/fat/fatent.o
   CC [M]  fs/fat/file.o
   CC [M]  fs/fat/inode.o
   CC [M]  fs/fat/misc.o
   LD [M]  fs/fat/fat.o
   LD      fs/fuse/built-in.o
   CC [M]  fs/fuse/dev.o
   CC [M]  fs/fuse/dir.o
   CC [M]  fs/fuse/file.o
   CC [M]  fs/fuse/inode.o
   LD [M]  fs/fuse/fuse.o
   LD      fs/isofs/built-in.o
   CC [M]  fs/isofs/namei.o
   CC [M]  fs/isofs/inode.o
   CC [M]  fs/isofs/dir.o
   CC [M]  fs/isofs/util.o
   CC [M]  fs/isofs/rock.o
   CC [M]  fs/isofs/export.o
   CC [M]  fs/isofs/joliet.o
   LD [M]  fs/isofs/isofs.o
   LD      fs/lockd/built-in.o
   CC [M]  fs/lockd/clntlock.o
   CC [M]  fs/lockd/clntproc.o
   CC [M]  fs/lockd/host.o
   CC [M]  fs/lockd/svc.o
   CC [M]  fs/lockd/svclock.o
   CC [M]  fs/lockd/svcshare.o
   CC [M]  fs/lockd/svcproc.o
   CC [M]  fs/lockd/svcsubs.o
   CC [M]  fs/lockd/mon.o
   CC [M]  fs/lockd/xdr.o
   CC [M]  fs/lockd/xdr4.o
   CC [M]  fs/lockd/svc4proc.o
   LD [M]  fs/lockd/lockd.o
   LD      fs/nfs/built-in.o
   CC [M]  fs/nfs/dir.o
   CC [M]  fs/nfs/file.o
   CC [M]  fs/nfs/inode.o
   CC [M]  fs/nfs/nfs2xdr.o
   CC [M]  fs/nfs/pagelist.o
   CC [M]  fs/nfs/proc.o
   CC [M]  fs/nfs/read.o
   CC [M]  fs/nfs/symlink.o
   CC [M]  fs/nfs/unlink.o
   CC [M]  fs/nfs/write.o
   CC [M]  fs/nfs/nfs3proc.o
   CC [M]  fs/nfs/nfs3xdr.o
   LD [M]  fs/nfs/nfs.o
   LD      fs/nfs_common/built-in.o
   LD      fs/nfsd/built-in.o
   CC [M]  fs/nfsd/nfssvc.o
   CC [M]  fs/nfsd/nfsctl.o
   CC [M]  fs/nfsd/nfsproc.o
   CC [M]  fs/nfsd/nfsfh.o
   CC [M]  fs/nfsd/vfs.o
   CC [M]  fs/nfsd/export.o
fs/nfsd/export.c: In function `svc_expkey_lookup':
fs/nfsd/export.c:259: warning: implicit declaration of function 
`__raw_write_unlock'
fs/nfsd/export.c:259: warning: implicit declaration of function 
`__raw_read_unlock'
   CC [M]  fs/nfsd/auth.o
   CC [M]  fs/nfsd/lockd.o
   CC [M]  fs/nfsd/nfscache.o
   CC [M]  fs/nfsd/nfsxdr.o
   CC [M]  fs/nfsd/stats.o
   CC [M]  fs/nfsd/nfs3proc.o
   CC [M]  fs/nfs/nfs3xdr.o
   LD [M]  fs/nfs/nfs.o
   LD      fs/nfs_common/built-in.o
   LD      fs/nfsd/built-in.o
   CC [M]  fs/nfsd/nfssvc.o
   CC [M]  fs/nfsd/nfsctl.o
   CC [M]  fs/nfsd/nfsproc.o
   CC [M]  fs/nfsd/nfsfh.o
   CC [M]  fs/nfsd/vfs.o
   CC [M]  fs/nfsd/export.o
fs/nfsd/export.c: In function `svc_expkey_lookup':
fs/nfsd/export.c:259: warning: implicit declaration of function 
`__raw_write_unlock'
fs/nfsd/export.c:259: warning: implicit declaration of function 
`__raw_read_unlock'
   CC [M]  fs/nfsd/auth.o
   CC [M]  fs/nfsd/lockd.o
   CC [M]  fs/nfsd/nfscache.o
   CC [M]  fs/nfsd/nfsxdr.o
   CC [M]  fs/nfsd/stats.o
   CC [M]  fs/nfsd/nfs3proc.o
   CC [M]  fs/nfsd/nfs3xdr.o
   LD [M]  fs/nfsd/nfsd.o
   LD      fs/nls/built-in.o
   CC [M]  fs/nls/nls_base.o
   CC      fs/partitions/check.o
   CC      fs/partitions/msdos.o
   LD      fs/partitions/built-in.o
   CC      fs/proc/mmu.o
fs/proc/mmu.c: In function `get_vmalloc_info':
fs/proc/mmu.c:75: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      fs/proc/task_mmu.o
   CC      fs/proc/inode.o
   CC      fs/proc/root.o
   CC      fs/proc/base.o
fs/proc/base.c: In function `proc_cwd_link':
fs/proc/base.c:329: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      fs/proc/generic.o
   CC      fs/proc/array.o
fs/proc/array.c: In function `task_state':
fs/proc/array.c:182: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      fs/proc/kmsg.o
   CC      fs/proc/proc_tty.o
   CC      fs/proc/proc_misc.o
   LD      fs/proc/proc.o
   LD      fs/proc/built-in.o
   CC      fs/ramfs/inode.o
   LD      fs/ramfs/ramfs.o
   LD      fs/ramfs/built-in.o
   CC      fs/reiserfs/bitmap.o
   CC      fs/reiserfs/do_balan.o
   CC      fs/reiserfs/namei.o
   CC      fs/reiserfs/inode.o
   CC      fs/reiserfs/file.o
   CC      fs/reiserfs/dir.o
   CC      fs/reiserfs/fix_node.o
   CC      fs/reiserfs/super.o
   CC      fs/reiserfs/prints.o
   CC      fs/reiserfs/objectid.o
   CC      fs/reiserfs/lbalance.o
   CC      fs/reiserfs/ibalance.o
   CC      fs/reiserfs/stree.o
   CC      fs/reiserfs/hashes.o
   CC      fs/reiserfs/tail_conversion.o
   CC      fs/reiserfs/journal.o
   CC      fs/reiserfs/resize.o
   CC      fs/reiserfs/item_ops.o
   CC      fs/reiserfs/ioctl.o
   CC      fs/reiserfs/procfs.o
   LD      fs/reiserfs/reiserfs.o
   LD      fs/reiserfs/built-in.o
   CC      fs/sysfs/inode.o
   CC      fs/sysfs/file.o
   CC      fs/sysfs/dir.o
   CC      fs/sysfs/symlink.o
   CC      fs/sysfs/mount.o
   CC      fs/sysfs/bin.o
   CC      fs/sysfs/group.o
   LD      fs/sysfs/built-in.o
   LD      fs/vfat/built-in.o
   CC [M]  fs/vfat/namei.o
   LD [M]  fs/vfat/vfat.o
   LD      fs/built-in.o
   CC      ipc/util.o
   CC      ipc/msgutil.o
   CC      ipc/msg.o
   CC      ipc/sem.o
   CC      ipc/shm.o
   LD      ipc/built-in.o
   CC      security/commoncap.o
   LD      security/built-in.o
   LD      crypto/built-in.o
   CC      drivers/base/core.o
   CC      drivers/base/sys.o
   CC      drivers/base/bus.o
   CC      drivers/base/dd.o
   CC      drivers/base/driver.o
   CC      drivers/base/class.o
   CC      drivers/base/platform.o
   CC      drivers/base/cpu.o
   CC      drivers/base/firmware.o
   CC      drivers/base/init.o
   CC      drivers/base/map.o
   CC      drivers/base/dmapool.o
   CC      drivers/base/attribute_container.o
   CC      drivers/base/transport_class.o
   CC      drivers/base/power/shutdown.o
   CC      drivers/base/power/main.o
   CC      drivers/base/power/suspend.o
   CC      drivers/base/power/resume.o
   CC      drivers/base/power/runtime.o
   CC      drivers/base/power/sysfs.o
   LD      drivers/base/power/built-in.o
   LD      drivers/base/built-in.o
   CC      drivers/block/elevator.o
drivers/block/elevator.c: In function `elv_unregister':
drivers/block/elevator.c:597: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      drivers/block/ll_rw_blk.o
   CC      drivers/block/ioctl.o
   CC      drivers/block/genhd.o
   CC      drivers/block/scsi_ioctl.o
   CC      drivers/block/noop-iosched.o
   CC      drivers/block/cfq-iosched.o
   LD      drivers/block/built-in.o
   CC [M]  drivers/block/floppy.o
   CC [M]  drivers/block/loop.o
   CC      drivers/cdrom/cdrom.o
   LD      drivers/cdrom/built-in.o
   CC      drivers/char/mem.o
   CC      drivers/char/random.o
   CC      drivers/char/tty_io.o
drivers/char/tty_io.c: In function `do_tty_hangup':
drivers/char/tty_io.c:1085: warning: implicit declaration of function 
`__raw_read_unlock'
   CC      drivers/char/n_tty.o
   CC      drivers/char/tty_ioctl.o
   CC      drivers/char/pty.o
   CC      drivers/char/misc.o
   CC      drivers/char/vt_ioctl.o
   CC      drivers/char/vc_screen.o
   CC      drivers/char/consolemap.o
   CONMK   drivers/char/consolemap_deftbl.c
   CC      drivers/char/consolemap_deftbl.o
   CC      drivers/char/selection.o
   CC      drivers/char/keyboard.o
   CC      drivers/char/vt.o
   SHIPPED drivers/char/defkeymap.c
   CC      drivers/char/defkeymap.o
   LD      drivers/char/built-in.o
   LD      drivers/firmware/built-in.o
   LD      drivers/ide/arm/built-in.o
   LD      drivers/ide/legacy/built-in.o
   CC      drivers/ide/pci/amd74xx.o
   LD      drivers/ide/pci/built-in.o
   CC      drivers/ide/ide.o
   CC      drivers/ide/ide-io.o
   CC      drivers/ide/ide-iops.o
   CC      drivers/ide/ide-lib.o
   CC      drivers/ide/ide-probe.o
   CC      drivers/ide/ide-taskfile.o
   CC      drivers/ide/setup-pci.o
   CC      drivers/ide/ide-dma.o
   CC      drivers/ide/ide-proc.o
   LD      drivers/ide/ide-core.o
   CC      drivers/ide/ide-disk.o
   CC      drivers/ide/ide-cd.o
   LD      drivers/ide/built-in.o
   CC      drivers/input/input.o
   CC      drivers/input/keyboard/atkbd.o
   LD      drivers/input/keyboard/built-in.o
   LD      drivers/input/built-in.o
   CC      drivers/input/serio/serio.o
   CC      drivers/input/serio/i8042.o
   CC      drivers/input/serio/libps2.o
   LD      drivers/input/serio/built-in.o
   LD      drivers/media/common/built-in.o
   LD      drivers/media/built-in.o
   LD      drivers/mfd/built-in.o
   LD      drivers/misc/built-in.o
   CC      drivers/net/Space.o
   CC      drivers/net/loopback.o
In file included from drivers/net/loopback.c:53:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   LD      drivers/net/built-in.o
   CC [M]  drivers/net/3c59x.o
   CC [M]  drivers/net/mii.o
   CC [M]  drivers/net/dummy.o
   CC      drivers/pci/access.o
   CC      drivers/pci/bus.o
   CC      drivers/pci/probe.o
   CC      drivers/pci/remove.o
   CC      drivers/pci/pci.o
   CC      drivers/pci/quirks.o
   CC      drivers/pci/pci-driver.o
   CC      drivers/pci/search.o
   CC      drivers/pci/pci-sysfs.o
   CC      drivers/pci/rom.o
   CC      drivers/pci/setup-res.o
   CC      drivers/pci/proc.o
   CC      drivers/pci/setup-bus.o
   CC      drivers/pci/msi.o
   LD      drivers/pci/built-in.o
   LD      drivers/serial/built-in.o
   CC      drivers/usb/host/pci-quirks.o
   LD      drivers/usb/host/built-in.o
   LD      drivers/usb/built-in.o
   LD      drivers/video/backlight/built-in.o
   CC      drivers/video/console/dummycon.o
   CC      drivers/video/console/vgacon.o
   LD      drivers/video/console/built-in.o
   LD      drivers/video/built-in.o
   LD      drivers/built-in.o
   LD      sound/built-in.o
   CC      arch/i386/pci/i386.o
   CC      arch/i386/pci/direct.o
   CC      arch/i386/pci/fixup.o
   CC      arch/i386/pci/legacy.o
   CC      arch/i386/pci/irq.o
   CC      arch/i386/pci/common.o
   LD      arch/i386/pci/built-in.o
   CC      arch/i386/power/cpu.o
   LD      arch/i386/power/built-in.o
   CC      net/socket.o
In file included from net/socket.c:97:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/802/p8023.o
   CC      net/802/sysctl_net_802.o
   LD      net/802/built-in.o
   CC      net/core/sock.o
In file included from include/linux/tcp.h:180,
                  from net/core/sock.c:112:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/request_sock.o
In file included from include/net/request_sock.h:22,
                  from net/core/request_sock.c:19:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/skbuff.o
In file included from net/core/skbuff.c:64:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/iovec.o
In file included from net/core/iovec.c:30:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/datagram.o
In file included from net/core/datagram.c:55:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/stream.o
In file included from include/linux/tcp.h:180,
                  from net/core/stream.c:18:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/scm.o
In file included from net/core/scm.c:32:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/gen_stats.o
   CC      net/core/gen_estimator.o
In file included from net/core/gen_estimator.c:34:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/sysctl_net_core.o
In file included from net/core/sysctl_net_core.c:13:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/dev.o
In file included from net/core/dev.c:94:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/ethtool.o
   CC      net/core/dev_mcast.o
In file included from include/net/request_sock.h:22,
                  from include/linux/ip.h:84,
                  from include/net/ip.h:28,
                  from net/core/dev_mcast.c:46:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/dst.o
   CC      net/core/neighbour.o
In file included from net/core/neighbour.c:32:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/rtnetlink.o
In file included from include/net/request_sock.h:22,
                  from include/linux/ip.h:84,
                  from include/net/ip.h:28,
                  from net/core/rtnetlink.c:45:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/utils.o
   CC      net/core/link_watch.o
In file included from net/core/link_watch.c:18:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/filter.o
In file included from include/net/request_sock.h:22,
                  from include/linux/ip.h:84,
                  from include/net/ip.h:28,
                  from net/core/filter.c:28:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/core/net-sysfs.o
In file included from net/core/net-sysfs.c:16:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   LD      net/core/built-in.o
   CC      net/ethernet/eth.o
In file included from include/net/request_sock.h:22,
                  from include/linux/ip.h:84,
                  from net/ethernet/eth.c:49:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
   CC      net/ethernet/sysctl_net_ether.o
   LD      net/ethernet/built-in.o
   CC      net/ipv4/route.o
In file included from include/linux/mroute.h:129,
                  from net/ipv4/route.c:89:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function 
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function 
`__raw_write_unlock'
net/ipv4/route.c: In function `rt_check_expire':
net/ipv4/route.c:663: warning: dereferencing `void *' pointer
net/ipv4/route.c:663: error: request for member `raw_lock' in something 
not a structure or union
make[2]: *** [net/ipv4/route.o] Error 1
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2


And the .config:
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.14-rc5-mm1
# Mon Oct 24 18:12:00 2005
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION="-minerva1"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SWAP_PREFETCH=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
# CONFIG_HOTPLUG is not set
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_EMBEDDED=y
# CONFIG_KALLSYMS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

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
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_1GLOWMEM=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

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
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

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
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_TCP_CONG_ADVANCED=y

#
# TCP congestion control
#
CONFIG_TCP_CONG_BIC=m
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
# CONFIG_TCP_CONG_VEGAS is not set
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

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
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

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

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
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
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

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
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
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
# CONFIG_HOSTAP is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

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
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

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
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

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
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
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
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

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
CONFIG_DUMMY_CONSOLE=y

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
# CONFIG_USB is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
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
# SN Devices
#

#
# EDAC - error detection and reporting (RAS)
#
# CONFIG_EDAC is not set

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# File systems
#
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_REISER4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_INOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_DNOTIFY is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ASFS_FS is not set
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
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
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
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
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
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
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
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_DEBUG_BUGVERBOSE is not set
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y


- LL
