Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWF0Uxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWF0Uxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWF0Uxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:53:36 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:37250 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030359AbWF0Uxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:53:35 -0400
Date: Wed, 28 Jun 2006 01:31:05 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-rt1 : x86_64 oops
Message-ID: <20060627200105.GA13966@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used the attached patch below to work around the already known
compilation problem and a bunch of warnings in slab.c. In my
4-way x86_64 box, I get a few oops and then the machine panics.

Starting udevd
Creating devices
BUG: scheduling while atomic: udevd/0x00000001/1875
BUG: scheduling while atomic: swapper/0x00000001/0

Call Trace:
       <ffffffff804fcd76>{__schedule+158}
       <ffffffff804ffcdf>{_raw_spin_unlock_irqrestore+48}
       <ffffffff8024998b>{task_blocks_on_rt_mutex+518}
       <ffffffff80502986>{kprobe_flush_task+21}
       <ffffffff80502986>{kprobe_flush_task+21}
       <ffffffff804fdf0d>{schedule+236}
       <ffffffff804fedb3>{rt_lock_slowlock+327}
       <ffffffff80502986>{kprobe_flush_task+21}
       <ffffffff804fdc57>{thread_return+177}
       <ffffffff80208968>{mwait_idle+0}
       <ffffffff80208958>{cpu_idle+232}
       <ffffffff80217108>{start_secondary+1102}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff804fcd8e>] .... __schedule+0xb6/0xece
.....[<00000000>] ..   ( <= 0x0)

BUG: scheduling from the idle thread!

Call Trace:
       <ffffffff804fcde5>{__schedule+269}
       <ffffffff804ffcdf>{_raw_spin_unlock_irqrestore+48}
       <ffffffff8024998b>{task_blocks_on_rt_mutex+518}
       <ffffffff80502986>{kprobe_flush_task+21}
       <ffffffff80502986>{kprobe_flush_task+21}
       <ffffffff804fdf0d>{schedule+236}
       <ffffffff804fedb3>{rt_lock_slowlock+327}
       <ffffffff80502986>{kprobe_flush_task+21}
       <ffffffff804fdc57>{thread_return+177}
       <ffffffff80208968>{mwait_idle+0}
       <ffffffff80208958>{cpu_idle+232}
       <ffffffff80217108>{start_secondary+1102}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8022739c>{dequeue_task+13}
PGD 21dfe2067 PUD 21d036067 PMD 0
Oops: 0002 [1] PREEMPT SMP
CPU 3
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.17-rt1 #2
RIP: 0010:[<ffffffff8022739c>] <ffffffff8022739c>{dequeue_task+13}
RSP: 0000:ffff81022083bc30  EFLAGS: 00010086
RAX: ffff810084af6000 RBX: ffff810220834580 RCX: ffff8102208345b8
RDX: ffffffff807b1718 RSI: 0000000000000000 RDI: ffff810220834580
RBP: ffff81022083bc40 R08: 00000000ffffffff R09: ffff81022083b8a0
R10: 0000000000000001 R11: ffffffff8024aec4 R12: 0000000000000000
R13: ffffffff80502986 R14: ffff8100052a5600 R15: 0000000000000020
FS:  0000000000000000(0000) GS:ffff81022080cc40(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000021dbad000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff81022083a000, task ffff810220834580)
Stack: ffff81022083bd30 ffff810220834580 ffff81022083bc60 ffffffff80227433
       ffff81022083bd30 0000000010000040 ffff81022083bd30 ffffffff804fcf09
       ffffffff806c1036 ffffffff806c1020
Call Trace:
       <ffffffff80227433>{deactivate_task+25}
       <ffffffff804fcf09>{__schedule+561}
       <ffffffff804ffcdf>{_raw_spin_unlock_irqrestore+48}
       <ffffffff8024998b>{task_blocks_on_rt_mutex+518}
       <ffffffff80502986>{kprobe_flush_task+21}
       <ffffffff80502986>{kprobe_flush_task+21}
       <ffffffff804fdf0d>{schedule+236}
       <ffffffff804fedb3>{rt_lock_slowlock+327}
       <ffffffff80502986>{kprobe_flush_task+21}
       <ffffffff804fdc57>{thread_return+177}
       <ffffffff80208968>{mwait_idle+0}
       <ffffffff80208958>{cpu_idle+232}
       <ffffffff80217108>{start_secondary+1102}
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------


I am digging to see what is causing this, just a heads up.
The compilation and warning fix patch is below.

Thanks
Dipankar



Fix a compilation error in numa slab code. Also fixes warnings
due to slab_irq_disable().

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---



diff -puN mm/slab.c~fix-slab-numa mm/slab.c
--- linux-2.6.17-rt1-rcu/mm/slab.c~fix-slab-numa	2006-06-27 15:26:38.000000000 +0530
+++ linux-2.6.17-rt1-rcu-dipankar/mm/slab.c	2006-06-27 18:45:32.000000000 +0530
@@ -149,7 +149,8 @@
  	do { spin_unlock_irqrestore(lock, flags); } while (0)
 #else
 DEFINE_PER_CPU_LOCKED(int, slab_irq_locks) = { 0, };
-# define slab_irq_disable(cpu)		get_cpu_var_locked(slab_irq_locks, &(cpu))
+# define slab_irq_disable(cpu)	({get_cpu_var_locked(slab_irq_locks, &(cpu));})
+
 # define slab_irq_enable(cpu)		put_cpu_var_locked(slab_irq_locks, cpu)
 # define slab_irq_save(flags, cpu) \
 	do { slab_irq_disable(cpu); (void) (flags); } while (0)
@@ -3243,14 +3244,15 @@ __cache_free(struct kmem_cache *cachep, 
 				if (unlikely(alien->avail == alien->limit)) {
 					STATS_INC_ACOVERFLOW(cachep);
 					__drain_alien_cache(cachep,
-							    alien, nodeid);
+							    alien, nodeid,
+							    this_cpu);
 				}
 				alien->entry[alien->avail++] = objp;
 				spin_unlock(&alien->lock);
 			} else {
 				spin_lock(&(cachep->nodelists[nodeid])->
 					  list_lock);
-				free_block(cachep, &objp, 1, nodeid);
+				free_block(cachep, &objp, 1, nodeid, this_cpu);
 				spin_unlock(&(cachep->nodelists[nodeid])->
 					    list_lock);
 			}
diff -puN include/linux/spinlock_api_smp.h~fix-slab-numa include/linux/spinlock_api_smp.h
--- linux-2.6.17-rt1-rcu/include/linux/spinlock_api_smp.h~fix-slab-numa	2006-06-27 16:37:39.000000000 +0530
+++ linux-2.6.17-rt1-rcu-dipankar/include/linux/spinlock_api_smp.h	2006-06-27 16:38:46.000000000 +0530
@@ -37,6 +37,7 @@ unsigned long __lockfunc _raw_write_lock
 int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock);
 int __lockfunc _raw_read_trylock(raw_rwlock_t *lock);
 int __lockfunc _raw_write_trylock(raw_rwlock_t *lock);
+int __lockfunc _raw_spin_trylock_irq(raw_spinlock_t *lock);
 int __lockfunc _raw_spin_trylock_irqsave(raw_spinlock_t *lock,
 					 unsigned long *flags);
 int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock);

_
