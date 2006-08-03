Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWHCRQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWHCRQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWHCRQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:16:32 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:13803 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932585AbWHCRQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:16:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V10CCQ1zpEU1hO6CNQmAEMFykg7H40iZM+TxirMLyc+xO1G1n2rDIlDKGcg26mcLRPl1J37i82q3i2Of19NouFf4az3Q/JckvNQzMhjlnbesYHsuGhdPNhv1Hc9YtNDNdXBuYFnbRj22jC/rAdY9UhOsbRyQfhN9g0hRHfRVpgk=
Message-ID: <e6babb600608031016q274de74audc1157523c845bd3@mail.gmail.com>
Date: Thu, 3 Aug 2006 10:16:29 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: Problems with 2.6.17-rt8
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Bill Huey" <billh@gnuppy.monkey.org>
In-Reply-To: <1154621059.32264.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
	 <1154541079.25723.8.camel@localhost.localdomain>
	 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
	 <1154615261.32264.6.camel@localhost.localdomain>
	 <e6babb600608030808x632bd5e8y7dcb991fe229467d@mail.gmail.com>
	 <1154618859.32264.19.camel@localhost.localdomain>
	 <e6babb600608030848p4446cb8emff58519d62deb9d8@mail.gmail.com>
	 <1154621059.32264.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/06, Steven Rostedt <rostedt@goodmis.org> wrote:

> Are you also getting any warnings or BUG reports before this.  In your
> other dmesg, it should a bug being reported. This could cause problems
> later on.

Well, I'm getting a "nobody cared" on the tg3 (there's a separate
email about that to the list since it seemed sorta unrelated).  This
is straight from the console:

*****************************************************************************
Time: acpi_pm clocksource has been installed.
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_RT_MUTEXES                                             *
*        CONFIG_DEBUG_PREEMPT                                               *
*        CONFIG_CRITICAL_PREEMPT_TIMING                                     *
*        CONFIG_CRITICAL_IRQSOFF_TIMING                                     *
*        CONFIG_LATENCY_TRACE                                               *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 240k freed
Write protecting the kernel read-only data: 1036k
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
md: md0: raid array is not clean -- starting background reconstruction
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwidth (but not more than
200000 KB/sec) for reconstruction.
md: using 128k window, over a total of 287836480 blocks.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
irq 106: nobody cared (try booting with the "irqpoll" option)

Call Trace:
       <ffffffff802562ad>{__report_bad_irq+61}
       <ffffffff80485568>{thread_return+230}
       <ffffffff802564e3>{note_interrupt+487}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff8025588f>{thread_simple_irq+137}
       <ffffffff80255cb3>{do_irqd+0}
       <ffffffff80255d8f>{do_irqd+220}
       <ffffffff80255cb3>{do_irqd+0}
       <ffffffff8023fe5a>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff8023fd7a>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80487485>] .... _raw_spin_lock_irq+0x21/0x2e
.....[<ffffffff80255876>] ..   ( <= thread_simple_irq+0x70/0x98)

handlers:
[<ffffffff88003868>] (tg3_interrupt_tagged+0x0/0xa7 [tg3])
turning off IO-APIC fast mode.
irq 106: nobody cared (try booting with the "irqpoll" option)

Call Trace:
       <ffffffff802562ad>{__report_bad_irq+61}
       <ffffffff802564e3>{note_interrupt+487}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff8025588f>{thread_simple_irq+137}
       <ffffffff80255cb3>{do_irqd+0}
       <ffffffff80255d8f>{do_irqd+220}
       <ffffffff80255cb3>{do_irqd+0}
       <ffffffff8023fe5a>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff8023fd7a>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80487485>] .... _raw_spin_lock_irq+0x21/0x2e
.....[<ffffffff80255876>] ..   ( <= thread_simple_irq+0x70/0x98)

handlers:
[<ffffffff88003868>] (tg3_interrupt_tagged+0x0/0xa7 [tg3])
md0_raid1/1118[CPU#3]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:471

Call Trace:
       <ffffffff80487453>{_raw_spin_lock_irqsave+34}
       <ffffffff8022cc03>{__WARN_ON+105}
       <ffffffff8022cbbe>{__WARN_ON+36}
       <ffffffff8024880b>{debug_rt_mutex_unlock+204}
       <ffffffff80486621>{rt_lock_slowunlock+30}
       <ffffffff80487196>{__lock_text_start+14}
       <ffffffff802792f9>{kmem_cache_alloc+207}
       <ffffffff8025b394>{mempool_alloc_slab+22}
       <ffffffff8025b783>{mempool_alloc+80}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80487960>{_raw_spin_unlock+51}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff802fde74>{get_request+375}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff802fe04c>{get_request_wait+45}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff803023c5>{as_merge+0}
       <ffffffff803023db>{as_merge+22}
       <ffffffff802fe425>{__make_request+750}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff802fba78>{generic_make_request+380}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80487960>{_raw_spin_unlock+51}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff803ea43c>{raid1d+246}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80487960>{_raw_spin_unlock+51}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80487196>{__lock_text_start+14}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff803fc3cf>{md_thread+280}
       <ffffffff8023ff97>{autoremove_wake_function+0}
       <ffffffff8023fe5a>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff8023fd7a>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8048736f>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff80486619>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff80487453>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022cbbe>] ..   ( <= __WARN_ON+0x24/0x8a)

md0_raid1/1118[CPU#3]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:472

Call Trace:
       <ffffffff80487453>{_raw_spin_lock_irqsave+34}
       <ffffffff8022cc03>{__WARN_ON+105}
       <ffffffff8022cbbe>{__WARN_ON+36}
       <ffffffff802488ad>{debug_rt_mutex_unlock+366}
       <ffffffff80486621>{rt_lock_slowunlock+30}
       <ffffffff80487196>{__lock_text_start+14}
       <ffffffff802792f9>{kmem_cache_alloc+207}
       <ffffffff8025b394>{mempool_alloc_slab+22}
       <ffffffff8025b783>{mempool_alloc+80}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80487960>{_raw_spin_unlock+51}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff802fde74>{get_request+375}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff802fe04c>{get_request_wait+45}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff803023c5>{as_merge+0}
       <ffffffff803023db>{as_merge+22}
       <ffffffff802fe425>{__make_request+750}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff802fba78>{generic_make_request+380}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80487960>{_raw_spin_unlock+51}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff803ea43c>{raid1d+246}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80487960>{_raw_spin_unlock+51}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80487196>{__lock_text_start+14}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff803fc3cf>{md_thread+280}
       <ffffffff8023ff97>{autoremove_wake_function+0}
       <ffffffff8023fe5a>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff8023fd7a>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8048736f>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff80486619>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff80487453>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022cbbe>] ..   ( <= __WARN_ON+0x24/0x8a)

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at kernel/rtmutex.c:639
invalid opcode: 0000 [1] PREEMPT SMP
CPU 3
Modules linked in: nfsd exportfs lockd sunrpc ohci1394 ieee1394 tg3
Pid: 1118, comm: md0_raid1 Not tainted 2.6.17-rt8_local_00 #3
RIP: 0010:[<ffffffff8048679a>] <ffffffff8048679a>{rt_lock_slowlock+186}
RSP: 0018:ffff8101ea5bd9e8  EFLAGS: 00010246
RAX: ffff8107eac1e340 RBX: 0000000000000010 RCX: 0000000000240180
RDX: ffff8107eac1e340 RSI: ffffffff8027927e RDI: ffff810600115ca0
RBP: ffff8101ea5bdaa8 R08: ffff8104000d7f38 R09: ffff8101ea5bd9e8
R10: ffff8104000d7f38 R11: 0000000000000023 R12: ffff810600115ca0
R13: ffff8103ead2a080 R14: ffffffff8027927e R15: ffff8103eadbe0e0
FS:  00002afcbce1c770(0000) GS:ffff810600211340(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 000000334d703088 CR3: 00000007e8ffa000 CR4: 00000000000006e0
Process md0_raid1 (pid: 1118, threadinfo ffff8101ea5bc000, task
ffff8107eac1e340)
Stack: 111111110000008c ffff8101ea5bd9f0 ffff8101ea5bd9f0 ffff8101ea5bda00
       ffff8101ea5bda00 0000000000000000 111111110000008c ffff8101ea5bda20
       ffff8101ea5bda20 ffff8101ea5bda30
Call Trace:
       <ffffffff804871aa>{rt_lock+18}
       <ffffffff8027927e>{kmem_cache_alloc+84}
       <ffffffff8025b394>{mempool_alloc_slab+22}
       <ffffffff8025b783>{mempool_alloc+80}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80302648>{as_set_request+0}
       <ffffffff8030266d>{as_set_request+37}
       <ffffffff802f8fac>{elv_set_request+27}
       <ffffffff802fde98>{get_request+411}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff802fe04c>{get_request_wait+45}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff803023c5>{as_merge+0}
       <ffffffff803023db>{as_merge+22}
       <ffffffff802fe425>{__make_request+750}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff802fba78>{generic_make_request+380}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80487960>{_raw_spin_unlock+51}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff803ea43c>{raid1d+246}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80487960>{_raw_spin_unlock+51}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80487196>{__lock_text_start+14}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff803fc3cf>{md_thread+280}
       <ffffffff8023ff97>{autoremove_wake_function+0}
       <ffffffff8023fe5a>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff8023fd7a>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8048736f>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff8048671b>] ..   ( <= rt_lock_slowlock+0x3b/0x213)
.. [<ffffffff80487728>] .... _raw_spin_trylock+0x1b/0x5f
.....[<ffffffff804881d6>] ..   ( <= oops_begin+0x28/0x77)


Code: 0f 0b 68 70 44 4c 80 c2 7f 02 65 48 8b 04 25 00 00 00 00 41
RIP <ffffffff8048679a>{rt_lock_slowlock+186} RSP <ffff8101ea5bd9e8>




etc. and so forth.  Oh wait, here's one that happens straight off after boot:







*****************************************************************************
Time: acpi_pm clocksource has been installed.
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_RT_MUTEXES                                             *
*        CONFIG_DEBUG_PREEMPT                                               *
*        CONFIG_CRITICAL_PREEMPT_TIMING                                     *
*        CONFIG_CRITICAL_IRQSOFF_TIMING                                     *
*        CONFIG_LATENCY_TRACE                                               *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 240k freed
Write protecting the kernel read-only data: 1036k
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
md: md0: raid array is not clean -- starting background reconstruction
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwidth (but not more than
200000 KB/sec) for reconstruction.
md: using 128k window, over a total of 287836480 blocks.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
md0_resync/1119[CPU#1]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:471

Call Trace:
       <ffffffff80487453>{_raw_spin_lock_irqsave+34}
       <ffffffff8022cc03>{__WARN_ON+105}
       <ffffffff8022cbbe>{__WARN_ON+36}
       <ffffffff8024880b>{debug_rt_mutex_unlock+204}
       <ffffffff80486621>{rt_lock_slowunlock+30}
       <ffffffff80487196>{__lock_text_start+14}
       <ffffffff802792f9>{kmem_cache_alloc+207}
       <ffffffff80304e45>{kobject_get+31}
       <ffffffff80374eb7>{scsi_get_command+77}
       <ffffffff8037a2a8>{scsi_prep_fn+339}
       <ffffffff802f9a3a>{elv_next_request+149}
       <ffffffff80304e45>{kobject_get+31}
       <ffffffff80379e81>{scsi_request_fn+128}
       <ffffffff802fc854>{__generic_unplug_device+45}
       <ffffffff802fca71>{generic_unplug_device+37}
       <ffffffff803e8cc7>{unplug_slaves+132}
       <ffffffff803e8d31>{raid1_unplug+29}
       <ffffffff803fbe92>{md_do_sync+1303}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff803fc3cf>{md_thread+280}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff8023fe5a>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff8023fd7a>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8048736f>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff80486619>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff80487453>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022cbbe>] ..   ( <= __WARN_ON+0x24/0x8a)

md0_resync/1119[CPU#1]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:472

Call Trace:
       <ffffffff80487453>{_raw_spin_lock_irqsave+34}
       <ffffffff8022cc03>{__WARN_ON+105}
       <ffffffff8022cbbe>{__WARN_ON+36}
       <ffffffff802488ad>{debug_rt_mutex_unlock+366}
       <ffffffff80486621>{rt_lock_slowunlock+30}
       <ffffffff80487196>{__lock_text_start+14}
       <ffffffff802792f9>{kmem_cache_alloc+207}
       <ffffffff80304e45>{kobject_get+31}
       <ffffffff80374eb7>{scsi_get_command+77}
       <ffffffff8037a2a8>{scsi_prep_fn+339}
       <ffffffff802f9a3a>{elv_next_request+149}
       <ffffffff80304e45>{kobject_get+31}
       <ffffffff80379e81>{scsi_request_fn+128}
       <ffffffff802fc854>{__generic_unplug_device+45}
       <ffffffff802fca71>{generic_unplug_device+37}
       <ffffffff803e8cc7>{unplug_slaves+132}
       <ffffffff803e8d31>{raid1_unplug+29}
       <ffffffff803fbe92>{md_do_sync+1303}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff803fc3cf>{md_thread+280}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff8023fe5a>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff8023fd7a>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8048736f>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff80486619>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff80487453>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022cbbe>] ..   ( <= __WARN_ON+0x24/0x8a)

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at kernel/rtmutex.c:639
invalid opcode: 0000 [1] PREEMPT SMP
CPU 1
Modules linked in:
Pid: 1119, comm: md0_resync Not tainted 2.6.17-rt8_local_00 #3
RIP: 0010:[<ffffffff8048679a>] <ffffffff8048679a>{rt_lock_slowlock+186}
RSP: 0018:ffff8105eac63a58  EFLAGS: 00010246
RAX: ffff8102002b2db0 RBX: 0000000000000020 RCX: 00000000000c0080
RDX: ffff8102002b2db0 RSI: ffffffff8027927e RDI: ffff810200115ca0
RBP: ffff8105eac63b18 R08: ffff8104000d7650 R09: ffff8105eac63a58
R10: ffff8104000d7650 R11: ffff8104000d7650 R12: ffff810200115ca0
R13: ffff8107eac3f600 R14: ffffffff8027927e R15: ffff81020033a0c0
FS:  00002adbe7c426d0(0000) GS:ffff8102001e3340(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aed3bd60770 CR3: 0000000000201000 CR4: 00000000000006e0
Process md0_resync (pid: 1119, threadinfo ffff8105eac62000, task
ffff8102002b2db0)
Stack: 111111110000008c ffff8105eac63a60 ffff8105eac63a60 ffff8105eac63a70
       ffff8105eac63a70 0000000000000000 111111110000008c ffff8105eac63a90
       ffff8105eac63a90 ffff8105eac63aa0
Call Trace:
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff804871aa>{rt_lock+18}
       <ffffffff8027927e>{kmem_cache_alloc+84}
       <ffffffff8025b394>{mempool_alloc_slab+22}
       <ffffffff8025b783>{mempool_alloc+80}
       <ffffffff80487196>{__lock_text_start+14}
       <ffffffff80374f67>{scsi_get_command+253}
       <ffffffff8037a3cf>{scsi_prep_fn+634}
       <ffffffff802f9a3a>{elv_next_request+149}
       <ffffffff80304e45>{kobject_get+31}
       <ffffffff80379e81>{scsi_request_fn+128}
       <ffffffff802fc854>{__generic_unplug_device+45}
       <ffffffff802fca71>{generic_unplug_device+37}
       <ffffffff803e8cc7>{unplug_slaves+132}
       <ffffffff803e8d31>{raid1_unplug+29}
       <ffffffff803fbe92>{md_do_sync+1303}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff80248e35>{constant_test_bit+9}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80486649>{rt_lock_slowunlock+70}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff803fc3cf>{md_thread+280}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff803fc2b7>{md_thread+0}
       <ffffffff8023fe5a>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fb55>{keventd_create_kthread+0}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff80485568>{thread_return+230}
       <ffffffff8023fd7a>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8048736f>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff8048671b>] ..   ( <= rt_lock_slowlock+0x3b/0x213)
.. [<ffffffff80487728>] .... _raw_spin_trylock+0x1b/0x5f
.....[<ffffffff804881d6>] ..   ( <= oops_begin+0x28/0x77)


Code: 0f 0b 68 70 44 4c 80 c2 7f 02 65 48 8b 04 25 00 00 00 00 41
RIP <ffffffff8048679a>{rt_lock_slowlock+186} RSP <ffff8105eac63a58>


> ??
>
> Are you sure that vmlinux is the one created with the given config file?
> There's been times when I added some configs and either forgot to
> compile, or the compile failed, and I didn't notice, so the old binary
> was being used.

I think so.  I just rebuilt the thing and still no love:

rcrocomb@spanky:compressed$ cd ~/kernel/2.6.17-rt8
rcrocomb@spanky:2.6.17-rt8$ make clean
  CLEAN   arch/x86_64/boot/compressed/
  CLEAN   arch/x86_64/boot
  CLEAN   /home/rcrocomb/kernel/2.6.17-rt8
  CLEAN   arch/x86_64/ia32
  CLEAN   arch/x86_64/kernel
  CLEAN   drivers/char
  CLEAN   drivers/ieee1394
  CLEAN   drivers/md
  CLEAN   drivers/scsi/aic7xxx
  CLEAN   init
  CLEAN   kernel
  CLEAN   lib
  CLEAN   usr
  CLEAN   .tmp_versions
  CLEAN   vmlinux System.map .tmp_kallsyms1.o .tmp_kallsyms1.S
.tmp_kallsyms2.o .tmp_kallsyms2.S .tmp_vmli
nux1 .tmp_vmlinux2 .tmp_System.map
rcrocomb@spanky:2.6.17-rt8$ make -j4
.
.
.
buildy buildy buildy
.
.
.
LD [M]  fs/lockd/lockd.ko
  LD [M]  fs/nfs/nfs.ko
  LD [M]  fs/nfsd/nfsd.ko
  LD [M]  net/sunrpc/sunrpc.ko
rcrocomb@spanky:2.6.17-rt8$ cd arch/x86_64/boot/compressed/
rcrocomb@spanky:compressed$ gdb vmlinux
GNU gdb Red Hat Linux (6.3.0.0-1.122rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu"...(no debugging
symbols found)
Using host libthread_db library "/lib64/libthread_db.so.1".

(gdb) li *0xffffffff802792f9
No symbol table is loaded.  Use the "file" command.
(gdb)

I am at [even more of] a loss.

-- 
Robert Crocombe
rcrocomb@gmail.com

I hope warnings like this (one for each and every file, it seems):

scripts/mod/empty.c:1: warning: -ffunction-sections disabled; it makes
profiling impossible

and

ld: warning: i386:x86-64 architecture of input file
`arch/x86_64/boot/compressed/head.o' is incompatible with i386 output

don't indicate anything particularly maleficent.
