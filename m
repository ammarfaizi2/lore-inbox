Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261618AbTC1APk>; Thu, 27 Mar 2003 19:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261654AbTC1APk>; Thu, 27 Mar 2003 19:15:40 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:6581 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261618AbTC1AP3>;
	Thu, 27 Mar 2003 19:15:29 -0500
Subject: Re: [Lse-tech] 2.5.64-mjb2 (scalability / NUMA patchset)
From: Keith Mannthey <kmannth@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <68610000.1048492678@[10.10.2.4]>
References: <169550000.1046895443@[10.10.2.4]> 
	<68610000.1048492678@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Mar 2003 16:29:27 -0800
Message-Id: <1048811368.1076.22.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,
  I seem be having problems booting this on a UP box with you patch.  It
dies very early (with and without early printk turned on) with no output
the the screen.  What config options should not be turned on with your
tree? Have you ever booted mjb trees on non-SMP systems?  if so please
send .config.

Thanks,
	Keith   

On Sun, 2003-03-23 at 23:57, Martin J. Bligh wrote:
> The patchset contains mainly scalability and NUMA stuff, and anything 
> else that stops things from irritating me. It's meant to be pretty stable, 
> not so much a testing ground for new stuff.
> 
> I'd be very interested in feedback from anyone willing to test on any 
> platform, however large or small.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.65/patch-2.5.65-mjb
> 2.bz2
> 
> additional:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.65/400-shpte
> http://www.aracnet.com/~fletch/linux/2.5.59/pidmaps_nodepages
> 
> Since 2.5.65-mjb1 (~ = changed, + = added, - = dropped)
> 
> Notes: Broke shpte out separately, it seems a little fragile under certain
> 	workloads at the moment. 
> 
> Now in Linus' tree:
> 
> New:
> + 3c509_fix					Martin J. Bligh
> + acenic_fix					Martin J. Bligh
> + sisfix					Martin J. Bligh
> + vm_enough_memory				Andrew Morton
> + scsi_sysfs_fix				Martin J. Bligh
> + local_balance_exec				Martin J. Bligh
> 
> Pending:
> Hyperthreaded scheduler (Ingo Molnar)
> objrmap bugfixes for nonlinear vma's (Dave McCracken)
> Seperate kernel PMDs per process (Dave Hansen)
> Non-PAE aligned kernel splits (Dave Hansen)
> scheduler callers profiling (Anton or Bill Hartner)
> PPC64 NUMA patches (Anton)
> Child runs first (akpm)
> Kexec
> e1000 fixes
> Update the lost timer ticks code
> 
> Present in this patch:
> 
> doaction					Martin J. Bligh
> 	Fix cruel torture of macros and small furry animals in io_apic.c
> 
> early_printk					Dave Hansen et al.
> 	Allow printk before console_init
> 
> confighz					Andrew Morton / Dave Hansen
> 	Make HZ a config option of 100 Hz or 1000 Hz
> 
> config_page_offset				Dave Hansen / Andrea
> 	Make PAGE_OFFSET a config option
> 
> vmalloc_stats					Dave Hansen
> 	Expose useful vmalloc statistics
> 
> numameminfo					Martin Bligh / Keith Mannthey
> 	Expose NUMA meminfo information under /proc/meminfo.numa
> 
> schedstat					Rick Lindsley
> 	Provide stats about the scheduler under /proc/schedstat
> 
> schedstat2					Rick Lindsley
> 	Provide more stats about the scheduler under /proc/schedstat
> 
> schedstat-scripts				Rick Lindsley
> 	Provide some scripts for schedstat analysis under scripts/
> 
> sched_tunables					Robert Love
> 	Provide tunable parameters for the scheduler (+ NUMA scheduler)
> 
> irq_affinity					Martin J. Bligh
> 	Workaround for irq_affinity on clustered apic mode systems (eg x440)
> 
> cleaner_inodes					Andrew Morton
> 	Make noatime filesystems more efficient
> 
> partial_objrmap					Dave McCracken
> 	Object based rmap for filebacked pages.
> 
> objrmap_fix					Dave McCracken
> 	Fix detection of anon pages
> 
> objrmap_fixes					Dave McCracken / Hugh Dickins
> 	Fix up some mapped sizing bugs in objrmap
> 
> objrmap_mapcount				Dave McCracken
> 	Fix up some mapped sizing bugs in objrmap
> 
> kgdb						Andrew Morton / Various People
> 	The older version of kgdb, synched with 2.5.54-mm1
> 
> kprobes						Vamsi Krishna S
> 	Add kernel probes hooks to the kernel
> 
> thread_info_cleanup (4K stacks pt 1)		Dave Hansen / Ben LaHaise
> 	Prep work to reduce kernel stacks to 4K
> 	
> interrupt_stacks    (4K stacks pt 2)		Dave Hansen / Ben LaHaise
> 	Create a per-cpu interrupt stack.
> 
> stack_usage_check   (4K stacks pt 3)		Dave Hansen / Ben LaHaise
> 	Check for kernel stack overflows.
> 
> 4k_stack            (4K stacks pt 4)		Dave Hansen
> 	Config option to reduce kernel stacks to 4K
> 
> fix_kgdb					Dave Hansen
> 	Fix interaction between kgdb and 4K stacks
> 
> stacks_from_slab				William Lee Irwin
> 	Take kernel stacks from the slab cache, not page allocation.
> 
> thread_under_page				William Lee Irwin
> 	Fix THREAD_SIZE < PAGE_SIZE case
> 
> lkcd						LKCD team
> 	Linux kernel crash dump support
> 
> percpu_loadavg					Martin J. Bligh
> 	Provide per-cpu loadaverages, and real load averages
> 
> get_empty_filp					Manfred Spraul
> 	Kill the lock contention on files_lock from get_empty_filp ...
> 
> files_lock_goodness				Andrew Morton
> 	... and drive a silver stake through it's heart.
> 
> spinlock_inlining				Andrew Morton
> 	Inline spinlocks for profiling. Made into a ugly config option by me.
> 
> summit_pcimap					Matt Dobson
> 	Provide pci bus -> node mapping for x440
> 
> # shpte						Dave McCracken
> 	Shared pagetables
> 
> reiserfs_dio					Mingming Cao
> 	DIO for Reiserfs
> 
> concurrent_balloc				Alex Tomas
> 	Concurrent ext2 block allocation - makes SDET & dbench go whizzy fast.
> 
> concurrent_inode				Alex Tomas
> 	Concurrent ext2 inode allocation - makes SDET & dbench go whizzy fast.
> 
> debkl_ext2_readdir				Alex Tomas
> 	Don't take the BKL in ext2_readdir
> 
> sched_interactive				Ingo Molnar
> 	Bugfix for interactive scheduler
> 
> kgdb_cleanup					Martin J. Bligh
> 	Stop kgdb renaming schedule to do_schedule when it's not even enabled
> 
> numa_protector					Martin J. Bligh / Dave Hansen
> 	Stop people shooting themselves in the foot with CONFIG_NUMA
> 
> 3c509_fix					Martin J. Bligh
> 	Fix warning in 3c509 driver.
> 
> acenic_fix					Martin J. Bligh
> 	Fix warning in acenic driver
> 
> sisfix						Martin J. Bligh
> 	Fix warning & bug in sis900 driver
> 
> vm_enough_memory				Andrew Morton
> 	Give vm_enough_memory cpu local pools for virtual accounting
> 
> scsi_sysfs_fix					Martin J. Bligh
> 	Fix error in scsi_sysfs.
> 
> local_balance_exec				Martin J. Bligh
> 	Modify balance_exec to use node-local queues when idle
> 
> -mjb						Martin J. Bligh
> 	Add a tag to the makefile
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by:Crypto Challenge is now open! 
> Get cracking and register here for some mind boggling fun and 
> the chance of winning an Apple iPod:
> http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 


