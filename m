Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTJCAFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 20:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTJCAFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 20:05:53 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:23176 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S263552AbTJCAFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 20:05:24 -0400
Message-ID: <3F7CBE38.8000908@lemur.sytes.net>
Date: Thu, 02 Oct 2003 20:09:28 -0400
From: Mathias Kretschmer <mathias@lemur.sytes.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030731
X-Accept-Language: en-us, en, zh-tw
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1
References: <20031002152648.GB1240@velociraptor.random>
In-Reply-To: <20031002152648.GB1240@velociraptor.random>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.198.166.215] at Thu, 2 Oct 2003 19:05:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the below errors compiling the bttv module.

Also, the commercial OSS sound driver fails to compile against it.
It compiled under -pre6.

Otherwise, it seems to work fine for me.

Let me know, if you need any further info.

Cheers,

Mathias


make[4]: Entering directory `/usr/src/linux-2.4/drivers/media/video'
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes 
-Wno-trigraphs           -O4 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -msoft-float -mprefer 
red-stack-boundary=2 -march=pentium3   -nostdinc -iwithprefix include 
-DKBUILD_BASENAM          E=bttv_cards  -c -o bttv-cards.o bttv-cards.c
bttv-cards.c: In function `pvr_boot':
bttv-cards.c:2552: structure has no member named `dev'
bttv-cards.c:2555: warning: implicit declaration of function 
`request_firmware'
bttv-cards.c:2559: `rc' undeclared (first use in this function)
bttv-cards.c:2559: (Each undeclared identifier is reported only once
bttv-cards.c:2559: for each function it appears in.)
bttv-cards.c:2561: dereferencing pointer to incomplete type
bttv-cards.c:2561: dereferencing pointer to incomplete type
bttv-cards.c:2562: warning: implicit declaration of function 
`release_firmware'

Andrea Arcangeli wrote:
> URL:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa1.gz
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa1/
> 
> Probably the most notable new feature is that you can now pass 'desktop'
> as parameter to the kernel in lilo to ask the kernel to behave optimally
> for a desktop machine. No need of compile time options anymore. For more
> experienced users HZ=500/HZ=50/HZ=200 should work fine too, then you can
> tune the timeslices by hand but you must know what you're doing.
> 
> You can verify everything went well after boot with:
> 
> 	cat /proc/sys/kernel/{*timeslice,HZ}
> 
> This kernel seems to boot fine again on x86-64 too. The merges in pre6
> were helpful.
> 
> Due the amount of changes you may not want to run this on any production
> box (note: not because of the dynamic-hz feature, but because of
> everything else, the dynamic-hz is the only one that has no way to break
> anything, modulo stuff that would break anyways on ia64 and alpha
> already and that you can workaround trivially with HZ=100 if needed).
> 
> Only in 2.4.22aa1: 00_config-smp-1
> Only in 2.4.22aa1: 00_copy-namespace-1
> Only in 2.4.22aa1: 00_panic-console-switch-1
> Only in 2.4.22aa1: 00_pgt-cache-leak-2
> Only in 2.4.22aa1: 00_read_full_page-get_block-err-2
> Only in 2.4.22aa1: 00_sk98lin_2.4.22-20030902-1.gz
> Only in 2.4.22aa1: 05_vm_03_vm_tunables-4
> Only in 2.4.22aa1: 05_vm_05_zone_accounting-2
> Only in 2.4.22aa1: 05_vm_06_swap_out-3
> Only in 2.4.22aa1: 05_vm_07_local_pages-4
> Only in 2.4.22aa1: 05_vm_09_misc_junk-3
> Only in 2.4.22aa1: 05_vm_16_active_free_zone_bhs-1
> Only in 2.4.22aa1: 05_vm_20_cleanups-3
> Only in 2.4.22aa1: 9999900_request-firmware-1
> 
> 	Merged in mainline.
> 
> Only in 2.4.22aa1: 00_cpu-affinity-syscall-rml-4
> Only in 2.4.23pre6aa1: 00_cpu-affinity-syscall-rml-5
> Only in 2.4.22aa1: 00_extraversion-29
> Only in 2.4.23pre6aa1: 00_extraversion-30
> Only in 2.4.22aa1: 00_global-irq-race-1
> Only in 2.4.23pre6aa1: 00_global-irq-race-2
> Only in 2.4.22aa1: 00_rwsem-fair-38
> Only in 2.4.22aa1: 00_rwsem-fair-38-recursive-8
> Only in 2.4.23pre6aa1: 00_rwsem-fair-39
> Only in 2.4.23pre6aa1: 00_rwsem-fair-39-recursive-8
> Only in 2.4.22aa1: 00_silent-stack-overflow-18
> Only in 2.4.23pre6aa1: 00_silent-stack-overflow-19
> Only in 2.4.22aa1: 00_x86-optimize-apic-irq-and-cacheline-2
> Only in 2.4.23pre6aa1: 00_x86-optimize-apic-irq-and-cacheline-3
> Only in 2.4.22aa1: 05_vm_22_vm-anon-lru-1
> Only in 2.4.23pre6aa1: 05_vm_22_vm-anon-lru-2
> Only in 2.4.22aa1: 05_vm_17_rest-10
> Only in 2.4.23pre6aa1: 05_vm_26-rest-1
> Only in 2.4.22aa1: 05_vm_23_per-cpu-pages-3
> Only in 2.4.23pre6aa1: 05_vm_23_per-cpu-pages-4
> Only in 2.4.22aa1: 05_vm_24_accessed-ipi-only-smp-1
> Only in 2.4.22aa1: 10_lvm-snapshot-check-3
> Only in 2.4.23pre6aa1: 10_lvm-snapshot-check-4
> Only in 2.4.23pre6aa1: 20_rcu-poll-10
> Only in 2.4.22aa1: 20_rcu-poll-9
> Only in 2.4.22aa1: 30_irq-balance-15
> Only in 2.4.23pre6aa1: 30_irq-balance-16
> Only in 2.4.22aa1: 60_net-exports-3
> Only in 2.4.23pre6aa1: 60_net-exports-4
> Only in 2.4.22aa1: 60_tux-syscall-5
> Only in 2.4.23pre6aa1: 60_tux-syscall-6
> Only in 2.4.22aa1: 60_tux-sysctl-3
> Only in 2.4.23pre6aa1: 60_tux-sysctl-4
> Only in 2.4.22aa1: 90_proc-mapped-base-5
> Only in 2.4.23pre6aa1: 90_proc-mapped-base-6
> Only in 2.4.22aa1: 93_NUMAQ-13
> Only in 2.4.23pre6aa1: 93_NUMAQ-14
> Only in 2.4.22aa1: 96_inode_read_write-atomic-8
> Only in 2.4.23pre6aa1: 96_inode_read_write-atomic-9
> Only in 2.4.22aa1: 9900_aio-23.gz
> Only in 2.4.23pre6aa1: 9900_aio-24.gz
> Only in 2.4.22aa1: 9903_aio-22-ppc-1
> Only in 2.4.23pre6aa1: 9903_aio-22-ppc-2
> Only in 2.4.22aa1: 9910_shm-largepage-16.gz
> Only in 2.4.23pre6aa1: 9910_shm-largepage-17.gz
> Only in 2.4.22aa1: 9920_kgdb-11.gz
> Only in 2.4.23pre6aa1: 9920_kgdb-12.gz
> Only in 2.4.22aa1: 9925_kmsgdump-0.4.4-3.gz
> Only in 2.4.23pre6aa1: 9925_kmsgdump-0.4.4-4.gz
> Only in 2.4.22aa1: 9950_futex-5.gz
> Only in 2.4.23pre6aa1: 9950_futex-6.gz
> Only in 2.4.22aa1: 9999_sched_yield_scale-6
> Only in 2.4.23pre6aa1: 9999_sched_yield_scale-8
> Only in 2.4.22aa1: 9999901_scsi-softirq-2
> Only in 2.4.23pre6aa1: 9999901_scsi-softirq-3
> Only in 2.4.22aa1: 9999900_ecc-20030225-1.gz
> Only in 2.4.23pre6aa1: 9999900_ecc-20030225-2.gz
> Only in 2.4.22aa1: 9999900_ikd-2.gz
> Only in 2.4.23pre6aa1: 9999900_ikd-4.gz
> Only in 2.4.22aa1: 9999900_ipc-rcu-1
> Only in 2.4.23pre6aa1: 9999900_ipc-rcu-2
> Only in 2.4.22aa1: 9999900_monitor-mwait-1
> Only in 2.4.23pre6aa1: 9999900_monitor-mwait-2
> 
> 	Rediffed.
> 
> Only in 2.4.23pre6aa1: 00_do_brk-1
> 
> 	glitch fixup from Andrew.
> 
> Only in 2.4.23pre6aa1: 00_e-nodev-1
> 
> 	s/NODEV/ENODEV/ fixes from Vojtech.
> 
> Only in 2.4.23pre6aa1: 00_get_request_wait-race-1
> 
> 	Add missing smb_mb().
> 
> Only in 2.4.22aa1: 00_log-buf-len-1
> Only in 2.4.23pre6aa1: 00_log-buf-len-dynamic-1
> 
> 	Ported to 2.4.23pre6 to allow the configuration of the
> 	buffer size at compile time too.
> 
> Only in 2.4.23pre6aa1: 00_proc-readlink-1
> 
> 	Remeber to free tmp buffer (from spender)
> 
> Only in 2.4.22aa1: 00_sched-O1-aa-2.4.19rc3-17.gz
> Only in 2.4.23pre6aa1: 00_sched-O1-aa-2.4.19rc3-18.gz
> 
> 	Let the idle load_balance pass to pick any task it find,
> 	if we go idle it means we've no task left. This fix speeds up number
> 	crunching up to 100% in some arch. The very same fix incidentally is
> 	also present in current 2.6.
> 
> Only in 2.4.23pre6aa1: 00_sk98lin-char-fix-1
> 
> 	Count the right number of bytes (not ints).
> 
> Only in 2.4.23pre6aa1: 00_sync-buffer-scale-1
> 
> 	Don't take the bkl (the same paths runs w/o the bkl elsewhere), from
> 	Chris Mason.
> 
> Only in 2.4.23pre6aa1: 01_softirq-nowait-1
> 
> 	We must really keep executing softirqs or it may take
> 	a too long time before ksoftirqd gets some cpu time.
> 	For an embedded device you may want to remove this,
> 	on a server we need this still.
> 
> Only in 2.4.23pre6aa1: 05_vm_27-pte-dirty-bit-in-hardware-1
> 
> 	This fixes a longstanding bug for a number of archs that haven't the
> 	dirty bit updated in hardware. For those archs we can't mark the pte
> 	writeable when it's still in swap cache, unless we don't mark it dirty
> 	too at the same time. Otherwise the cpu will go ahead writing to the
> 	page, no fault will happen and the swapcache will be still clean, and
> 	the data will be lost at the next zeroIO swapout leading to userspace
> 	data corruption and segfaults during swap. Affected archs are
> 	alpha/s390/s390x for example.
> 
> 	This bug was specific to the -aa VM, it couldn't happen
> 	in mainline. In my tree I optimized the code to exploited
> 	properties of archs that updates the bit in hardware for the
> 	first time. Hence the first need of a #define to differentiate the
> 	two code paths. The logic in the software-dirty-bit case will
> 	be less efficient of course (that's why there's a difference
> 	in the first place).
> 
> 	This is an obvious noop for x86 and x86-64 for example.
> 
> 	NOTE: the software-dirty-bit code is safe for all archs, the other way
> 	around not.
> 
> Only in 2.4.23pre6aa1: 30_18-busy-inodes-1
> 
> 	Try to avoid to leave busy inodes in autofs unmount. From Olaf Kirch.
> 	(original from Trond).
> 
> Only in 2.4.23pre6aa1: 30_19-nfs-kill-unlock-1
> 
> 	Ignore errors on exiting lock cleanups. From Trond.
> 
> Only in 2.4.22aa1: 70_xfs-1.3-2.gz
> Only in 2.4.23pre6aa1: 70_xfs-1.3-3.gz
> Only in 2.4.22aa1: 70_xfs-sysctl-3
> Only in 2.4.23pre6aa1: 70_xfs13pre-final-1.gz
> Only in 2.4.23pre6aa1: 71_qsort-1
> Only in 2.4.22aa1: 71_xfs-VM_IO-1
> Only in 2.4.22aa1: 71_xfs-aa-4
> Only in 2.4.23pre6aa1: 71_xfs-aa-5
> Only in 2.4.23pre6aa1: 71_xfs-mmap-1
> Only in 2.4.22aa1: 71_xfs-tuning-1
> 
> 	XFS 13pre-final merged.
> 
> Only in 2.4.23pre6aa1: 9999900_BH_Sync-remove-1
> 
> 	To really be able to help and not just waste some
> 	seek and cpu, wait_on_buffer should honour the
> 	BH_Sync, but this is late in 2.4, and so I prefer
> 	to get rid of it instead of giving it the full power
> 	it should have.
> 
> Only in 2.4.23pre6aa1: 9999900_soft-float-1
> 
> 	Trap any usage of the FPU in kernel (needed
> 	to trap things like schedule_timeout(HZ*0.1)).
> 
> Only in 2.4.22aa1: 9999901_aio-network-poll-pipe-1
> Only in 2.4.23pre6aa1: 9999901_aio-poll-2
> 
> 	Leave only the aio-poll functionality because
> 	the network aio is still unfinished and nobody
> 	needs the pipe one (AFIK).
> 
> Only in 2.4.23pre6aa1: 9999_00_x86_64-suse-1
> Only in 2.4.23pre6aa1: 9999_00_x86_64-sys-1
> Only in 2.4.23pre6aa1: 9999_00_x86_64-tsc-c0-bandaid-1
> Only in 2.4.23pre6aa1: 9999_00_x86_64-warning-1
> Only in 2.4.23pre6aa1: 9999_00_x86_64-zone-startpfn-1
> Only in 2.4.23pre6aa1: 9999_01_x86_64-aio-bigpages-1
> Only in 2.4.23pre6aa1: 9999_01_x86_64-aio-export-1
> Only in 2.4.23pre6aa1: 9999_01_x86_64-bitops-1
> Only in 2.4.23pre6aa1: 9999_01_x86_64-discontig-pmd-1
> Only in 2.4.23pre6aa1: 9999_01_x86_64-epoll-1
> Only in 2.4.23pre6aa1: 9999_01_x86_64-fault32-wrap-1
> Only in 2.4.23pre6aa1: 9999_01_x86_64-kgdb-1
> Only in 2.4.23pre6aa1: 9999_01_x86_64-lvm32-no-checks-1
> 
> 	Merge x86-64 updates from Andi Kleen.
> 
> Only in 2.4.23pre6aa1: 9999_athlon-errata-prefetch-1
> 
> 	Fix athlon prefetch invalid faults from userspace.
> 	From Andi Kleen.
> 
> Only in 2.4.23pre6aa1: 9999_z-execve-race-1
> 
> 	Fix race in exit_mmap.
> 
> Only in 2.4.23pre6aa1: 9999_z-laptopmode-1
> 
> 	Allow the first read hitting the disk to flush all the dirty buffers.
> 	From Jens Axboe.
> 
> Only in 2.4.22aa1: 9999900_desktop-4
> Only in 2.4.23pre6aa1: 9999_zz-dynamic-timeslice-1
> Only in 2.4.23pre6aa1: 9999_zzz-dynamic-hz-1
> 
> 	HZ is now dynamic, you can boot with HZ=50 HZ=100 HZ=500
> 	or HZ=1000. However only HZ=100 and HZ=1000 are supported.
> 	Anything different from HZ=100 can trigger device driver
> 	bugs (those would already trigger on ia64 and alpha but
> 	on x86 the amount of drivers in use is larger).
> 
> 	But wait, you shouldn't use HZ=, you should only pass 'desktop' if you
> 	want to use the machine to behave as a better desktop and the kernel
> 	will just do the right thing.
> 
> 	max-timeslice/min-timeslice tunables are also provided
> 	as sysctl. Again no need to tune those, just pass
> 	'desktop' if your machine is a desktop.
> 
> 	The scheduler has internal heuristics (the avg_sleep for
> 	example in the o1 scheduler) to try to identify the interactive
> 	tasks. Since those are heuristics there's also the chance
> 	of failing. By rescheduling taks at around 100hz even if
> 	the heuristic fails there's quite a good margin before your
> 	eye can see it. This should help with video players and games.
> 
> Only in 2.4.23pre6aa1: 9999_zzzz-stackoverflow-1
> 
> 	Prevent overflows from happening on top of softirq. From
> 	Hugh Dickins.
> 
> Andrea - If you prefer relying on open source software, check these links:
> 	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
> 	    http://www.cobite.com/cvsps/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


