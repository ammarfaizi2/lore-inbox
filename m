Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbWGFFm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWGFFm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 01:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWGFFm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 01:42:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44497 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965168AbWGFFm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 01:42:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: "Keith Mannthey" <kmannth@gmail.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>
	<a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
	<20060705155037.7228aa48.akpm@osdl.org>
	<a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
	<20060705164457.60e6dbc2.akpm@osdl.org>
	<20060705164820.379a69ba.akpm@osdl.org>
	<a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com>
	<20060705172545.815872b6.akpm@osdl.org>
Date: Wed, 05 Jul 2006 23:42:00 -0600
In-Reply-To: <20060705172545.815872b6.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 5 Jul 2006 17:25:45 -0700")
Message-ID: <m1u05v2st3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 5 Jul 2006 17:05:49 -0700
> "Keith Mannthey" <kmannth@gmail.com> wrote:
>
>> On 7/5/06, Andrew Morton <akpm@osdl.org> wrote:
>> > On Wed, 5 Jul 2006 16:44:57 -0700
>> > Andrew Morton <akpm@osdl.org> wrote:
>> >
>> > > I guess a medium-term fix would be to add a boot parameter to override
>> > > PERCPU_ENOUGH_ROOM - it's hard to justify increasing it permanently just
>> > > for the benefit of the tiny minority of kernels which are hand-built with
>> > > lots of drivers in vmlinux.
>> 
>> I am not really loading alot of drivers.  I am building with a ton of driver.
>> >
>> > That's not right, is it.  PERCPU_ENOUGH_ROOM covers vmlinux and all loaded
>> > modules, so if vmlinux blows it all then `modprobe the-same-stuff' will
>> > blow it as well.
>> >
>> > > But first let's find out where it all went.
>> >
>> > I agree with that person.
>> :)
>> 
>> This is what I get it is diffrent that yours for sure. I am a little
>> confused by the large offset change near the start.....?
>
> Yes, I had an unexplained 8k hole.  That was i386.  Your x86_64 output
> looks OK though.
>
>> elm3a153:/home/keith/linux-2.6.17-mm6-orig # nm -n vmlinux | grep per_cpu
>>...
>> ffffffff80658000 A __per_cpu_start			It starts here
>> ffffffff80658000 D per_cpu__init_tss			8k
>> ffffffff8065a080 d per_cpu__idle_state		
>> ffffffff8065a084 d per_cpu__cpu_idle_state
>> ffffffff8065a0a0 D per_cpu__vector_irq
>> ffffffff8065a4a0 D per_cpu__device_mce
>> ffffffff8065a518 d per_cpu__next_check
>> ffffffff8065a520 d per_cpu__threshold_banks
>> ffffffff8065a550 d per_cpu__bank_map
>> ffffffff8065a580 d per_cpu__flush_state
>> ffffffff8065a600 D per_cpu__cpu_state
>> ffffffff8065a620 d per_cpu__perfctr_nmi_owner
>> ffffffff8065a624 d per_cpu__evntsel_nmi_owner
>> ffffffff8065a640 d per_cpu__nmi_watchdog_ctlblk
>> ffffffff8065a660 d per_cpu__last_irq_sum
>> ffffffff8065a668 d per_cpu__alert_counter
>> ffffffff8065a670 d per_cpu__nmi_touch
>> ffffffff8065a680 D per_cpu__current_kprobe
>> ffffffff8065a6a0 D per_cpu__kprobe_ctlblk
>> ffffffff8065a7e0 D per_cpu__mmu_gathers		4k
>> ffffffff8065b7e0 d per_cpu__runqueues			5k
>> ffffffff8065ca60 d per_cpu__cpu_domains
>> ffffffff8065cae0 d per_cpu__core_domains
>> ffffffff8065cb60 d per_cpu__phys_domains
>> ffffffff8065cbe0 d per_cpu__node_domains
>> ffffffff8065cc60 d per_cpu__allnodes_domains
>> ffffffff8065cce0 D per_cpu__kstat			wham - 17.5k
>> ffffffff80661120 D per_cpu__process_counts
>> ffffffff80661130 d per_cpu__cpu_profile_hits
>> ffffffff80661140 d per_cpu__cpu_profile_flip
>> ffffffff80661148 d per_cpu__tasklet_vec
>> ffffffff80661150 d per_cpu__tasklet_hi_vec
>> ffffffff80661158 d per_cpu__ksoftirqd
>> ffffffff80661160 d per_cpu__tvec_bases
>> ffffffff80661180 D per_cpu__rcu_data
>> ffffffff80661200 D per_cpu__rcu_bh_data
>> ffffffff80661280 d per_cpu__rcu_tasklet
>> ffffffff806612c0 d per_cpu__hrtimer_bases
>> ffffffff80661340 d per_cpu__kprobe_instance
>> ffffffff80661348 d per_cpu__taskstats_seqnum
>> ffffffff80661360 d per_cpu__ratelimits.18857
>> ffffffff80661380 d per_cpu__committed_space
>> ffffffff806613a0 d per_cpu__lru_add_pvecs
>> ffffffff80661420 d per_cpu__lru_add_active_pvecs
>> ffffffff806614a0 d per_cpu__lru_add_tail_pvecs
>> ffffffff80661520 D per_cpu__vm_event_states
>> ffffffff80661640 d per_cpu__reap_work
>> ffffffff806616a0 d per_cpu__reap_node
>> ffffffff806616c0 d per_cpu__bh_lrus
>> ffffffff80661700 d per_cpu__bh_accounting
>> ffffffff80661720 d per_cpu__fdtable_defer_list
>> ffffffff806617c0 d per_cpu__blk_cpu_done
>> ffffffff806617e0 D per_cpu__radix_tree_preloads
>> ffffffff80661860 d per_cpu__trickle_count
>> ffffffff80661864 d per_cpu__proc_event_counts
>> ffffffff80661880 d per_cpu__loopback_stats
>> ffffffff80661980 d per_cpu__sockets_in_use
>> ffffffff80661a00 D per_cpu__softnet_data
>> ffffffff80662000 D per_cpu__netdev_rx_stat
>> ffffffff80662010 d per_cpu__net_rand_state
>> ffffffff80662080 d per_cpu__flow_tables
>> ffffffff80662100 d per_cpu__flow_hash_info
>> ffffffff80662180 d per_cpu__flow_flush_tasklets
>> ffffffff806621c0 d per_cpu__rt_cache_stat
>> ffffffff80662200 d per_cpu____icmp_socket
>> ffffffff80662208 A __per_cpu_end
>
> So you've been hit by the expansion of NR_IRQS which bloats kernel_stat
> which gobbles per-cpu data.
>
> In 2.6.17 NR_IRQS is 244.  In -mm (due to the x86_64 genirq conversion)
> NR_IRQS became (256 + 32 * NR_CPUS).  Hence the kstat "array" became
> two-dimensional.  It's now O(NR_CPUS^2).

Hmm.  Perhaps it is a good thing I didn't push it to it's limit
of 244*NR_CPUS.

> I don't know what's a sane max for NR_CPUS on x86_64, but that'll sure be a
> showstopper if the ia64 guys try the same trick.

I think the unisys boxes are about 128 sockets.  So 128 or 256 is the
max at the moment.  I'm not certain where things are heading.  Big
specialized boxes seem to be giving way to smaller systems.  Yet the
amount that you can do with commodity hardware is getting larger,
so I suspect it will likely be a wash.  The worst case scenario
is that sgi will build a chipset supporting 32K cpus that works with
both Xeons and Itaniums.

> I guess one fix would be to de-percpuify kernel_stat.irqs[].  Or
> dynamically allocate it with alloc_percpu().

Hmm.  It might make sense to have a NR_CPUS array in each irq_desc.
We already have a per cpu bit map so that should only make the irq
array about 32 times bigger, but it would take it out of the
per_cpu area.

To get to 17k that took a 128 cpu build.  128 cpus looks reasonable
for a build for the maximum number of cpus.

On x86_64 when we have more than 8 cpus (aka cores) all of the
moving between cpus is done is software which means we are
not too likely to move between cpus.  In any sane configuration
an irq will stay on the same cpu or the same couple of cpus
so we get good locality effects (especially NUMA locality),
so there might be something we can take advantage of there.

Possibly we might want to just live with this for now.
But a data structure that ultimately consumes 244*NR_CPUS*NR_CPUS*4
bytes looks excessive.

32*NR_CPUS has been the expected number of irq sources for a long time
but previously we forced sharing of the irq number after a point.
So I think that is a fairly reasonable number.  Although 8*NR_CPUS may
be more reasonable.  But the bottom line is that the more cpus we have
the interrupts we can handle and quite likely the more interrupts we
will need to handle to keep the system busy.

So NR_IRQS should scale with the number of cpus.

So I suspect that we need to de-percpuify kernel_stat.irqs.

Possibly setup a set of counters that hold the count on the current
cpu and the total count across also cpus, and we update the count
whenever we migrate the cpu.  Possibly we could hold counts for the last
2 or 3 cpus.

I don't know how realistic it is to assume that an irq will be bound
to a cpu on all architectures.  So we might have to do it dynamically.

I'm tempted to suggest adding the following to irq_desc.
unsigned int last_cpu_count;
unsigned int last_cpu;

And just rely on those and the total irq count we already seem
to have in the irq_count field of struct irq_desc, for the statistics.

That would allow us to see where an irq is occurring and how frequently
without bloating things up.  Of course that is lossy.  

> (cc's people, runs away)

(throws out ideas, runs after Andrew)

Eric

