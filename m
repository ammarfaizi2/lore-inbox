Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWGFAFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWGFAFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWGFAFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:05:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:30556 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965080AbWGFAFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:05:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJoKhvdHdaWV4jMnLoIgz2a83rPKP0G/ifBvs+KghHaZTXenW7VpZm3+ksUGQssJuuOFL+OatrhhzP9NEO/hO8kWZ5AslYN8/93iWK2RqWA9d+m97kS5hMKETD9qSy5Q7i3hpXGAVr9TGSoIoyFJZ39MgGrjdfYX2CzCsNMeLsY=
Message-ID: <a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com>
Date: Wed, 5 Jul 2006 17:05:49 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060705164820.379a69ba.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060703030355.420c7155.akpm@osdl.org>
	 <a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
	 <20060705155037.7228aa48.akpm@osdl.org>
	 <a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
	 <20060705164457.60e6dbc2.akpm@osdl.org>
	 <20060705164820.379a69ba.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 5 Jul 2006 16:44:57 -0700
> Andrew Morton <akpm@osdl.org> wrote:
>
> > I guess a medium-term fix would be to add a boot parameter to override
> > PERCPU_ENOUGH_ROOM - it's hard to justify increasing it permanently just
> > for the benefit of the tiny minority of kernels which are hand-built with
> > lots of drivers in vmlinux.

I am not really loading alot of drivers.  I am building with a ton of driver.
>
> That's not right, is it.  PERCPU_ENOUGH_ROOM covers vmlinux and all loaded
> modules, so if vmlinux blows it all then `modprobe the-same-stuff' will
> blow it as well.
>
> > But first let's find out where it all went.
>
> I agree with that person.
:)

This is what I get it is diffrent that yours for sure. I am a little
confused by the large offset change near the start.....?

elm3a153:/home/keith/linux-2.6.17-mm6-orig # nm -n vmlinux | grep per_cpu
000000000c5ef91b A __crc_per_cpu__vm_event_states
0000000023898563 A __crc_per_cpu__softnet_data
0000000026d8eb30 A __crc_per_cpu__kstat
ffffffff802645ae t lru_add_drain_per_cpu
ffffffff80386818 t flow_cache_flush_per_cpu
ffffffff8041e010 r __ksymtab_per_cpu__kstat
ffffffff8041f6f0 r __ksymtab_per_cpu__vm_event_states
ffffffff80424e80 r __ksymtab_per_cpu__softnet_data
ffffffff804288f0 r __kcrctab_per_cpu__kstat
ffffffff80429460 r __kcrctab_per_cpu__vm_event_states
ffffffff8042c028 r __kcrctab_per_cpu__softnet_data
ffffffff8042e550 r __kstrtab_per_cpu__kstat
ffffffff80430f10 r __kstrtab_per_cpu__vm_event_states
ffffffff8043a3b0 r __kstrtab_per_cpu__softnet_data
ffffffff8062b91c T setup_per_cpu_areas
ffffffff80636921 T setup_per_cpu_pageset
ffffffff80658000 A __per_cpu_start
ffffffff80658000 D per_cpu__init_tss
ffffffff8065a080 d per_cpu__idle_state
ffffffff8065a084 d per_cpu__cpu_idle_state
ffffffff8065a0a0 D per_cpu__vector_irq
ffffffff8065a4a0 D per_cpu__device_mce
ffffffff8065a518 d per_cpu__next_check
ffffffff8065a520 d per_cpu__threshold_banks
ffffffff8065a550 d per_cpu__bank_map
ffffffff8065a580 d per_cpu__flush_state
ffffffff8065a600 D per_cpu__cpu_state
ffffffff8065a620 d per_cpu__perfctr_nmi_owner
ffffffff8065a624 d per_cpu__evntsel_nmi_owner
ffffffff8065a640 d per_cpu__nmi_watchdog_ctlblk
ffffffff8065a660 d per_cpu__last_irq_sum
ffffffff8065a668 d per_cpu__alert_counter
ffffffff8065a670 d per_cpu__nmi_touch
ffffffff8065a680 D per_cpu__current_kprobe
ffffffff8065a6a0 D per_cpu__kprobe_ctlblk
ffffffff8065a7e0 D per_cpu__mmu_gathers
ffffffff8065b7e0 d per_cpu__runqueues
ffffffff8065ca60 d per_cpu__cpu_domains
ffffffff8065cae0 d per_cpu__core_domains
ffffffff8065cb60 d per_cpu__phys_domains
ffffffff8065cbe0 d per_cpu__node_domains
ffffffff8065cc60 d per_cpu__allnodes_domains
ffffffff8065cce0 D per_cpu__kstat
ffffffff80661120 D per_cpu__process_counts
ffffffff80661130 d per_cpu__cpu_profile_hits
ffffffff80661140 d per_cpu__cpu_profile_flip
ffffffff80661148 d per_cpu__tasklet_vec
ffffffff80661150 d per_cpu__tasklet_hi_vec
ffffffff80661158 d per_cpu__ksoftirqd
ffffffff80661160 d per_cpu__tvec_bases
ffffffff80661180 D per_cpu__rcu_data
ffffffff80661200 D per_cpu__rcu_bh_data
ffffffff80661280 d per_cpu__rcu_tasklet
ffffffff806612c0 d per_cpu__hrtimer_bases
ffffffff80661340 d per_cpu__kprobe_instance
ffffffff80661348 d per_cpu__taskstats_seqnum
ffffffff80661360 d per_cpu__ratelimits.18857
ffffffff80661380 d per_cpu__committed_space
ffffffff806613a0 d per_cpu__lru_add_pvecs
ffffffff80661420 d per_cpu__lru_add_active_pvecs
ffffffff806614a0 d per_cpu__lru_add_tail_pvecs
ffffffff80661520 D per_cpu__vm_event_states
ffffffff80661640 d per_cpu__reap_work
ffffffff806616a0 d per_cpu__reap_node
ffffffff806616c0 d per_cpu__bh_lrus
ffffffff80661700 d per_cpu__bh_accounting
ffffffff80661720 d per_cpu__fdtable_defer_list
ffffffff806617c0 d per_cpu__blk_cpu_done
ffffffff806617e0 D per_cpu__radix_tree_preloads
ffffffff80661860 d per_cpu__trickle_count
ffffffff80661864 d per_cpu__proc_event_counts
ffffffff80661880 d per_cpu__loopback_stats
ffffffff80661980 d per_cpu__sockets_in_use
ffffffff80661a00 D per_cpu__softnet_data
ffffffff80662000 D per_cpu__netdev_rx_stat
ffffffff80662010 d per_cpu__net_rand_state
ffffffff80662080 d per_cpu__flow_tables
ffffffff80662100 d per_cpu__flow_hash_info
ffffffff80662180 d per_cpu__flow_flush_tasklets
ffffffff806621c0 d per_cpu__rt_cache_stat
ffffffff80662200 d per_cpu____icmp_socket
ffffffff80662208 A __per_cpu_end

Thanks,
  Keith
