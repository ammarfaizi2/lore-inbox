Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266521AbUHWSd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266521AbUHWSd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUHWScw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:32:52 -0400
Received: from serwer.tvgawex.pl ([212.122.214.2]:13573 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S266521AbUHWSVO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:21:14 -0400
Date: Mon, 23 Aug 2004 20:21:13 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-ID: <20040823182113.GA30882@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20040822013402.5917b991.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>- This kernel has an x86 patch which alters the copy_*_user() functions so
>  they will return -EFAULT on a fault rather than the number of bytes which
>  remain to be copied.  This is a bit of an experiment, because this seems to
>  be the preferred API for those functions.   It's a see-what-breaks thing.
>

 Things appear to broke. Sometimes kernel starts to spit page allocation
failures into log for few minutes, despite memory beeing available:

             total       used       free     shared    buffers
cached
Mem:        255244     251436       3808          0      16812
44068
-/+ buffers/cache:     190556      64688
Swap:       262136     148924     113212

 Previously I've used -mm2 which worked fine. The failures seem network
related, I have e1000 and few rules in iptables. 

>  And things will break.  If weird behaviour is observed, please revert
>  usercopy-return-EFAULT.patch and send a report.

 I am unable to reboot now, so I won't check it. :(
My config attached just in case. Here what's now in my dmesg:


>] __do_softirq+0x40/0x90
 [<c011e817>] do_softirq+0x27/0x30
 [<c01060e6>] do_IRQ+0x106/0x130
 [<c0104168>] common_interrupt+0x18/0x20
mplayer: page allocation failure. order:3, mode:0x20
 [<c013b5d9>] __alloc_pages+0x359/0x380
 [<c013b618>] __get_free_pages+0x18/0x40
 [<c013ea39>] kmem_getpages+0x19/0xb0
 [<c013f6f6>] cache_grow+0xb6/0x190
 [<c027571d>] ide_build_sglist+0x2d/0xa0
 [<c013f9e3>] cache_alloc_refill+0x213/0x250
 [<c013fe1c>] __kmalloc+0x5c/0x60
 [<c02d3511>] alloc_skb+0x41/0xf0
 [<c02d3b08>] skb_copy+0x28/0xc0
 [<c02d85b6>] skb_checksum_help+0x56/0x170
 [<c0326607>] ip_nat_fn+0x177/0x2a0
 [<c032684e>] ip_nat_local_fn+0x6e/0xb0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1755>] nf_iterate+0x55/0xa0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1b88>] nf_hook_slow+0x78/0x120
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f116d>] ip_queue_xmit+0x30d/0x530
 [<c02f0870>] dst_output+0x0/0x20
 [<c0389935>] preempt_schedule+0x25/0x40
 [<c01f2fc4>] copy_from_user+0x34/0x70
 [<c02ba145>] snd_pcm_lib_write_transfer+0x95/0xa0
 [<c02ba442>] snd_pcm_lib_write1+0x2f2/0x520
 [<c0300913>] tcp_cwnd_restart+0x23/0x100
 [<c0300dc8>] tcp_transmit_skb+0x3d8/0x6e0
 [<c03037db>] tcp_write_wakeup+0x13b/0x250
 [<c03048b0>] tcp_write_timer+0x0/0xf0
 [<c0303908>] tcp_send_probe0+0x18/0x100
 [<c030497f>] tcp_write_timer+0xcf/0xf0
 [<c01224ec>] run_timer_softirq+0xcc/0x1b0
 [<c012263f>] do_timer+0x5f/0xe0
 [<c011e7a0>] __do_softirq+0x40/0x90
 [<c011e817>] do_softirq+0x27/0x30
 [<c01060e6>] do_IRQ+0x106/0x130
 [<c0104168>] common_interrupt+0x18/0x20
colorize.pl: page allocation failure. order:3, mode:0x20
 [<c013b5d9>] __alloc_pages+0x359/0x380
 [<c013b618>] __get_free_pages+0x18/0x40
 [<c013ea39>] kmem_getpages+0x19/0xb0
 [<c013f6f6>] cache_grow+0xb6/0x190
 [<c0146178>] do_no_page+0x68/0x370
 [<c013f9e3>] cache_alloc_refill+0x213/0x250
 [<c013fe1c>] __kmalloc+0x5c/0x60
 [<c02d3511>] alloc_skb+0x41/0xf0
 [<c02d3b08>] skb_copy+0x28/0xc0
 [<c02d85b6>] skb_checksum_help+0x56/0x170
 [<c0326607>] ip_nat_fn+0x177/0x2a0
 [<c032684e>] ip_nat_local_fn+0x6e/0xb0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1755>] nf_iterate+0x55/0xa0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1b88>] nf_hook_slow+0x78/0x120
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f116d>] ip_queue_xmit+0x30d/0x530
 [<c02f0870>] dst_output+0x0/0x20
 [<c01370ff>] do_generic_mapping_read+0x2cf/0x450
 [<c0116789>] activate_task+0xb9/0xe0
 [<c011687c>] try_to_wake_up+0xac/0xb0
 [<c0300913>] tcp_cwnd_restart+0x23/0x100
 [<c0300dc8>] tcp_transmit_skb+0x3d8/0x6e0
 [<c03037db>] tcp_write_wakeup+0x13b/0x250
 [<c0238fbd>] rtc_interrupt+0xad/0x120
 [<c03048b0>] tcp_write_timer+0x0/0xf0
 [<c0303908>] tcp_send_probe0+0x18/0x100
 [<c030497f>] tcp_write_timer+0xcf/0xf0
 [<c01224ec>] run_timer_softirq+0xcc/0x1b0
 [<c012007b>] do_proc_dointvec+0x13b/0x320
 [<c011e7a0>] __do_softirq+0x40/0x90
 [<c011e817>] do_softirq+0x27/0x30
 [<c01060e6>] do_IRQ+0x106/0x130
 [<c0104168>] common_interrupt+0x18/0x20
mplayer: page allocation failure. order:3, mode:0x20
 [<c013b5d9>] __alloc_pages+0x359/0x380
 [<c013b618>] __get_free_pages+0x18/0x40
 [<c013ea39>] kmem_getpages+0x19/0xb0
 [<c013f6f6>] cache_grow+0xb6/0x190
 [<c013f9e3>] cache_alloc_refill+0x213/0x250
 [<c013fe1c>] __kmalloc+0x5c/0x60
 [<c02d3511>] alloc_skb+0x41/0xf0
 [<c02d3b08>] skb_copy+0x28/0xc0
 [<c02d85b6>] skb_checksum_help+0x56/0x170
 [<c0326607>] ip_nat_fn+0x177/0x2a0
 [<c032684e>] ip_nat_local_fn+0x6e/0xb0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1755>] nf_iterate+0x55/0xa0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1b88>] nf_hook_slow+0x78/0x120
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f116d>] ip_queue_xmit+0x30d/0x530
 [<c02f0870>] dst_output+0x0/0x20
 [<c0103f45>] need_resched+0x27/0x32
 [<c01f2fc4>] copy_from_user+0x34/0x70
 [<c02ba145>] snd_pcm_lib_write_transfer+0x95/0xa0
 [<c02ba442>] snd_pcm_lib_write1+0x2f2/0x520
 [<c0300913>] tcp_cwnd_restart+0x23/0x100
 [<c0300dc8>] tcp_transmit_skb+0x3d8/0x6e0
 [<c03037db>] tcp_write_wakeup+0x13b/0x250
 [<c03048b0>] tcp_write_timer+0x0/0xf0
 [<c0303908>] tcp_send_probe0+0x18/0x100
 [<c030497f>] tcp_write_timer+0xcf/0xf0
 [<c01224ec>] run_timer_softirq+0xcc/0x1b0
 [<c012263f>] do_timer+0x5f/0xe0
 [<c011e7a0>] __do_softirq+0x40/0x90
 [<c011e817>] do_softirq+0x27/0x30
 [<c01060e6>] do_IRQ+0x106/0x130
 [<c0104168>] common_interrupt+0x18/0x20
colorize.pl: page allocation failure. order:3, mode:0x20
 [<c013b5d9>] __alloc_pages+0x359/0x380
 [<c013b618>] __get_free_pages+0x18/0x40
 [<c013ea39>] kmem_getpages+0x19/0xb0
 [<c013f6f6>] cache_grow+0xb6/0x190
 [<c0146178>] do_no_page+0x68/0x370
 [<c013f9e3>] cache_alloc_refill+0x213/0x250
 [<c013fe1c>] __kmalloc+0x5c/0x60
 [<c02d3511>] alloc_skb+0x41/0xf0
 [<c02d3b08>] skb_copy+0x28/0xc0
 [<c02d85b6>] skb_checksum_help+0x56/0x170
 [<c0326607>] ip_nat_fn+0x177/0x2a0
 [<c032684e>] ip_nat_local_fn+0x6e/0xb0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1755>] nf_iterate+0x55/0xa0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1b88>] nf_hook_slow+0x78/0x120
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f116d>] ip_queue_xmit+0x30d/0x530
 [<c02f0870>] dst_output+0x0/0x20
 [<c01370ff>] do_generic_mapping_read+0x2cf/0x450
 [<c0137522>] __generic_file_aio_read+0x1b2/0x230
 [<c0137280>] file_read_actor+0x0/0xf0
 [<c016ba39>] dput+0x89/0x290
 [<c0300913>] tcp_cwnd_restart+0x23/0x100
 [<c0300dc8>] tcp_transmit_skb+0x3d8/0x6e0
 [<c03037db>] tcp_write_wakeup+0x13b/0x250
 [<c03048b0>] tcp_write_timer+0x0/0xf0
 [<c0303908>] tcp_send_probe0+0x18/0x100
 [<c030497f>] tcp_write_timer+0xcf/0xf0
 [<c01224ec>] run_timer_softirq+0xcc/0x1b0
 [<c012263f>] do_timer+0x5f/0xe0
 [<c011e7a0>] __do_softirq+0x40/0x90
 [<c011e817>] do_softirq+0x27/0x30
 [<c01060e6>] do_IRQ+0x106/0x130
 [<c0104168>] common_interrupt+0x18/0x20
swapper: page allocation failure. order:3, mode:0x20
 [<c013b5d9>] __alloc_pages+0x359/0x380
 [<c013b618>] __get_free_pages+0x18/0x40
 [<c013ea39>] kmem_getpages+0x19/0xb0
 [<c013f6f6>] cache_grow+0xb6/0x190
 [<c013f9e3>] cache_alloc_refill+0x213/0x250
 [<c013fe1c>] __kmalloc+0x5c/0x60
 [<c02d3511>] alloc_skb+0x41/0xf0
 [<c02d3b08>] skb_copy+0x28/0xc0
 [<c02d85b6>] skb_checksum_help+0x56/0x170
 [<c0326607>] ip_nat_fn+0x177/0x2a0
 [<c032684e>] ip_nat_local_fn+0x6e/0xb0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1755>] nf_iterate+0x55/0xa0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1b88>] nf_hook_slow+0x78/0x120
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f116d>] ip_queue_xmit+0x30d/0x530
 [<c02f0870>] dst_output+0x0/0x20
 [<c011687c>] try_to_wake_up+0xac/0xb0
 [<c01180cb>] autoremove_wake_function+0x1b/0x50
 [<c0116f17>] __wake_up_common+0x37/0x70
 [<c0158f20>] end_bio_bh_io_sync+0x0/0x50
 [<c0139d5c>] mempool_free+0x4c/0xb0
 [<c0158f20>] end_bio_bh_io_sync+0x0/0x50
 [<c0300913>] tcp_cwnd_restart+0x23/0x100
 [<c0300dc8>] tcp_transmit_skb+0x3d8/0x6e0
 [<c03037db>] tcp_write_wakeup+0x13b/0x250
 [<c03048b0>] tcp_write_timer+0x0/0xf0
 [<c0303908>] tcp_send_probe0+0x18/0x100
 [<c030497f>] tcp_write_timer+0xcf/0xf0
 [<c01224ec>] run_timer_softirq+0xcc/0x1b0
 [<c012263f>] do_timer+0x5f/0xe0
 [<c011e7a0>] __do_softirq+0x40/0x90
 [<c011e817>] do_softirq+0x27/0x30
 [<c01060e6>] do_IRQ+0x106/0x130
 [<c0104168>] common_interrupt+0x18/0x20
 [<c021a2f6>] acpi_processor_idle+0xd0/0x1bf
 [<c021a226>] acpi_processor_idle+0x0/0x1bf
 [<c021007b>] acpi_ps_is_prefix_char+0x3/0x12
 [<c01020dd>] cpu_idle+0x2d/0x40
 [<c0480713>] start_kernel+0x143/0x160
 [<c0480330>] unknown_bootoption+0x0/0x170
swapper: page allocation failure. order:3, mode:0x20
 [<c013b5d9>] __alloc_pages+0x359/0x380
 [<c02d379b>] __kfree_skb+0xab/0x150
 [<c013b618>] __get_free_pages+0x18/0x40
 [<c013ea39>] kmem_getpages+0x19/0xb0
 [<c013f6f6>] cache_grow+0xb6/0x190
 [<c013f9e3>] cache_alloc_refill+0x213/0x250
 [<c013fe1c>] __kmalloc+0x5c/0x60
 [<c02d3511>] alloc_skb+0x41/0xf0
 [<c02d3b08>] skb_copy+0x28/0xc0
 [<c02d85b6>] skb_checksum_help+0x56/0x170
 [<c0326607>] ip_nat_fn+0x177/0x2a0
 [<c032684e>] ip_nat_local_fn+0x6e/0xb0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1755>] nf_iterate+0x55/0xa0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1b88>] nf_hook_slow+0x78/0x120
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f116d>] ip_queue_xmit+0x30d/0x530
 [<c02f0870>] dst_output+0x0/0x20
 [<c0238fbd>] rtc_interrupt+0xad/0x120
 [<c0105ca0>] handle_IRQ_event+0x30/0x60
 [<c0106090>] do_IRQ+0xb0/0x130
 [<c0104168>] common_interrupt+0x18/0x20
 [<c0301b46>] __tcp_select_window+0xb6/0x160
 [<c0300913>] tcp_cwnd_restart+0x23/0x100
 [<c0300dc8>] tcp_transmit_skb+0x3d8/0x6e0
 [<c03037db>] tcp_write_wakeup+0x13b/0x250
 [<c03048b0>] tcp_write_timer+0x0/0xf0
 [<c0303908>] tcp_send_probe0+0x18/0x100
 [<c030497f>] tcp_write_timer+0xcf/0xf0
 [<c01224ec>] run_timer_softirq+0xcc/0x1b0
 [<c012263f>] do_timer+0x5f/0xe0
 [<c011e7a0>] __do_softirq+0x40/0x90
 [<c011e817>] do_softirq+0x27/0x30
 [<c01060e6>] do_IRQ+0x106/0x130
 [<c0104168>] common_interrupt+0x18/0x20
 [<c021a2f6>] acpi_processor_idle+0xd0/0x1bf
 [<c021a3e0>] acpi_processor_idle+0x1ba/0x1bf
 [<c01020dd>] cpu_idle+0x2d/0x40
 [<c0480713>] start_kernel+0x143/0x160
 [<c0480330>] unknown_bootoption+0x0/0x170
swapper: page allocation failure. order:3, mode:0x20
 [<c013b5d9>] __alloc_pages+0x359/0x380
 [<c013b618>] __get_free_pages+0x18/0x40
 [<c013ea39>] kmem_getpages+0x19/0xb0
 [<c013f6f6>] cache_grow+0xb6/0x190
 [<c013f9e3>] cache_alloc_refill+0x213/0x250
 [<c013fe1c>] __kmalloc+0x5c/0x60
 [<c02d3511>] alloc_skb+0x41/0xf0
 [<c02d3b08>] skb_copy+0x28/0xc0
 [<c02d85b6>] skb_checksum_help+0x56/0x170
 [<c0326607>] ip_nat_fn+0x177/0x2a0
 [<c032684e>] ip_nat_local_fn+0x6e/0xb0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1755>] nf_iterate+0x55/0xa0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1b88>] nf_hook_slow+0x78/0x120
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f116d>] ip_queue_xmit+0x30d/0x530
 [<c02f0870>] dst_output+0x0/0x20
 [<c0116789>] activate_task+0xb9/0xe0
 [<c011687c>] try_to_wake_up+0xac/0xb0
 [<c0116789>] activate_task+0xb9/0xe0
 [<c0300913>] tcp_cwnd_restart+0x23/0x100
 [<c0300dc8>] tcp_transmit_skb+0x3d8/0x6e0
 [<c0116789>] activate_task+0xb9/0xe0
 [<c03037db>] tcp_write_wakeup+0x13b/0x250
 [<c03048b0>] tcp_write_timer+0x0/0xf0
 [<c0303908>] tcp_send_probe0+0x18/0x100
 [<c030497f>] tcp_write_timer+0xcf/0xf0
 [<c01224ec>] run_timer_softirq+0xcc/0x1b0
 [<c012263f>] do_timer+0x5f/0xe0
 [<c011e7a0>] __do_softirq+0x40/0x90
 [<c011e817>] do_softirq+0x27/0x30
 [<c01060e6>] do_IRQ+0x106/0x130
 [<c0104168>] common_interrupt+0x18/0x20
 [<c021a2d5>] acpi_processor_idle+0xaf/0x1bf
 [<c01020dd>] cpu_idle+0x2d/0x40
 [<c0480713>] start_kernel+0x143/0x160
 [<c0480330>] unknown_bootoption+0x0/0x170
fetchmail: page allocation failure. order:3, mode:0x20
 [<c013b5d9>] __alloc_pages+0x359/0x380
 [<c013b618>] __get_free_pages+0x18/0x40
 [<c013ea39>] kmem_getpages+0x19/0xb0
 [<c013f6f6>] cache_grow+0xb6/0x190
 [<c0104168>] common_interrupt+0x18/0x20
 [<c013f9e3>] cache_alloc_refill+0x213/0x250
 [<c013fe1c>] __kmalloc+0x5c/0x60
 [<c02d3511>] alloc_skb+0x41/0xf0
 [<c02d3b08>] skb_copy+0x28/0xc0
 [<c02d85b6>] skb_checksum_help+0x56/0x170
 [<c0326607>] ip_nat_fn+0x177/0x2a0
 [<c032684e>] ip_nat_local_fn+0x6e/0xb0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1755>] nf_iterate+0x55/0xa0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1b88>] nf_hook_slow+0x78/0x120
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f116d>] ip_queue_xmit+0x30d/0x530
 [<c02f0870>] dst_output+0x0/0x20
 [<c0300dc8>] tcp_transmit_skb+0x3d8/0x6e0
 [<c0301916>] tcp_write_xmit+0x146/0x2c0
 [<c02d2e37>] sock_def_readable+0x67/0x70
 [<c02fe5b9>] tcp_data_queue+0x939/0xa50
 [<c02fee0e>] __tcp_data_snd_check+0x4e/0xf0
 [<c02ff695>] tcp_rcv_established+0x405/0x7b0
 [<c0308450>] tcp_v4_do_rcv+0xf0/0x100
 [<c0308c0d>] tcp_v4_rcv+0x7ad/0x8c0
 [<c0326518>] ip_nat_fn+0x88/0x2a0
 [<c02ed920>] ip_local_deliver_finish+0x0/0x1c0
 [<c02ed99c>] ip_local_deliver_finish+0x7c/0x1c0
 [<c02e1c0f>] nf_hook_slow+0xff/0x120
 [<c02ed920>] ip_local_deliver_finish+0x0/0x1c0
 [<c02ed878>] ip_local_deliver+0x1a8/0x250
 [<c02ed920>] ip_local_deliver_finish+0x0/0x1c0
 [<c02ee168>] ip_rcv_finish+0x1f8/0x2b0
 [<c02e1755>] nf_iterate+0x55/0xa0
 [<c02edf70>] ip_rcv_finish+0x0/0x2b0
 [<c02edf70>] ip_rcv_finish+0x0/0x2b0
 [<c02e1c0f>] nf_hook_slow+0xff/0x120
 [<c02edf70>] ip_rcv_finish+0x0/0x2b0
 [<c02edf70>] ip_rcv_finish+0x0/0x2b0
 [<c02ede6f>] ip_rcv+0x38f/0x490
 [<c02edf70>] ip_rcv_finish+0x0/0x2b0
 [<c0300dc8>] tcp_transmit_skb+0x3d8/0x6e0
 [<c02d8fad>] netif_receive_skb+0x1cd/0x200
 [<c02d905e>] process_backlog+0x7e/0x120
 [<c02d9161>] net_rx_action+0x61/0x100
 [<c011e7a0>] __do_softirq+0x40/0x90
 [<c011e817>] do_softirq+0x27/0x30
 [<c011e899>] local_bh_enable+0x79/0x90
 [<c02f7da5>] tcp_close+0x115/0x580
 [<c0316a74>] inet_release+0x34/0x60
 [<c02cf76b>] sock_release+0x8b/0xe0
 [<c02d01de>] sock_close+0x1e/0x40
 [<c0155776>] __fput+0x116/0x150
 [<c0153ee8>] filp_close+0x48/0x90
 [<c0103ffb>] syscall_call+0x7/0xb
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
fetchmail: page allocation failure. order:3, mode:0x20
 [<c013b5d9>] __alloc_pages+0x359/0x380
 [<c013b618>] __get_free_pages+0x18/0x40
 [<c013ea39>] kmem_getpages+0x19/0xb0
 [<c013f6f6>] cache_grow+0xb6/0x190
 [<c013f9e3>] cache_alloc_refill+0x213/0x250
 [<c013fe1c>] __kmalloc+0x5c/0x60
 [<c02d3511>] alloc_skb+0x41/0xf0
 [<c02d3b08>] skb_copy+0x28/0xc0
 [<c02d85b6>] skb_checksum_help+0x56/0x170
 [<c0326607>] ip_nat_fn+0x177/0x2a0
 [<c032684e>] ip_nat_local_fn+0x6e/0xb0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1755>] nf_iterate+0x55/0xa0
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f0870>] dst_output+0x0/0x20
 [<c02e1b88>] nf_hook_slow+0x78/0x120
 [<c02f0870>] dst_output+0x0/0x20
 [<c02f116d>] ip_queue_xmit+0x30d/0x530
 [<c02f0870>] dst_output+0x0/0x20
 [<c02ed920>] ip_local_deliver_finish+0x0/0x1c0
 [<c02eda6e>] ip_local_deliver_finish+0x14e/0x1c0
 [<c02ed920>] ip_local_deliver_finish+0x0/0x1c0
 [<c02e1c1a>] nf_hook_slow+0x10a/0x120
 [<c02ed920>] ip_local_deliver_finish+0x0/0x1c0
 [<c02ed878>] ip_local_deliver+0x1a8/0x250
 [<c02ed920>] ip_local_deliver_finish+0x0/0x1c0
 [<c0307224>] tcp_v4_send_check+0x54/0x110
 [<c0300dc8>] tcp_transmit_skb+0x3d8/0x6e0
 [<c03021e9>] tcp_retransmit_skb+0x1b9/0x300
 [<c030457d>] tcp_retransmit_timer+0xed/0x420
 [<c0116789>] activate_task+0xb9/0xe0
 [<c03048b0>] tcp_write_timer+0x0/0xf0
 [<c0304976>] tcp_write_timer+0xc6/0xf0
 [<c01224ec>] run_timer_softirq+0xcc/0x1b0
 [<c02d9161>] net_rx_action+0x61/0x100
 [<c011e7a0>] __do_softirq+0x40/0x90
 [<c011e817>] do_softirq+0x27/0x30
 [<c011e899>] local_bh_enable+0x79/0x90
 [<c02f7da5>] tcp_close+0x115/0x580
 [<c0316a74>] inet_release+0x34/0x60
 [<c02cf76b>] sock_release+0x8b/0xe0
 [<c02d01de>] sock_close+0x1e/0x40
 [<c0155776>] __fput+0x116/0x150
 [<c0153ee8>] filp_close+0x48/0x90
 [<c0103ffb>] syscall_call+0x7/0xb
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.

-- 
Tomasz Torcz               "Never underestimate the bandwidth of a station 
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray 


--YZ5djTAD1cGYuMQK
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
0IRkkIoAAA==

--YZ5djTAD1cGYuMQK--
