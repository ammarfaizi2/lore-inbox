Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWHTHMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWHTHMc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 03:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWHTHMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 03:12:32 -0400
Received: from tornado.reub.net ([202.89.145.182]:3283 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751673AbWHTHMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 03:12:31 -0400
Message-ID: <44E80B5C.1070300@reub.net>
Date: Sun, 20 Aug 2006 19:12:28 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 2.0a1 (Windows/20060819)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2
References: <20060819220008.843d2f64.akpm@osdl.org>
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/08/2006 5:00 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
> 
> 
> - Various random stuff.
> 
> - I haven't been pulling Greg's post-2.6.18-rc4 tree due to various git woes
>   which I haven't gotten around to working out how to fix.  But most of it
>   will be here anyway.
> 
> - The automounter is known to be a bit broken.
> 
> - Alpha coredumps won't work right.

Two problems remain and seem to be continuing to be unfixed and unacknowledged 
in this release despite maintainers previously been cc'd on the problems.

1. Reliably pulling some similar looking oopses on x86_64 when booting up - I 
wasn't the only reporter of this.  All my traces have complaints about 
MAX_STACK_TRACE_ENTRIES too low but I'm not sure if that is the cause of the 
trace or happens as a result of the trace.

GRE over IPv4 tunneling driver
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.

Call Trace:
  [<ffffffff8026d0ee>] dump_trace+0xbe/0x3a0
  [<ffffffff8026d40c>] show_trace+0x3c/0x55
  [<ffffffff8026d43a>] dump_stack+0x15/0x1b
  [<ffffffff8029ca76>] save_trace+0xd6/0xe3
  [<ffffffff8029cb05>] add_lock_to_list+0x82/0xab
  [<ffffffff8029f330>] __lock_acquire+0xad0/0xc78
  [<ffffffff8029f527>] lock_acquire+0x4f/0x78
  [<ffffffff802688a8>] _spin_lock+0x25/0x34
  [<ffffffff80440e02>] md_seq_next+0x27/0x85
  [<ffffffff80242585>] seq_read+0x1d5/0x2c9
  [<ffffffff8020b90c>] vfs_read+0xcc/0x176
  [<ffffffff80211d4b>] sys_read+0x47/0x7c
  [<ffffffff802627ee>] system_call+0x7e/0x83
  [<0000003de9ac28d0>]
  [<ffffffff8029ca76>] save_trace+0xd6/0xe3
  [<ffffffff8029cb05>] add_lock_to_list+0x82/0xab
  [<ffffffff8029f330>] __lock_acquire+0xad0/0xc78
  [<ffffffff80441b96>] md_seq_show+0xb9/0x823
  [<ffffffff8029f527>] lock_acquire+0x4f/0x78
  [<ffffffff80440e02>] md_seq_next+0x27/0x85
  [<ffffffff802688a8>] _spin_lock+0x25/0x34
  [<ffffffff80440e02>] md_seq_next+0x27/0x85
  [<ffffffff80242585>] seq_read+0x1d5/0x2c9
  [<ffffffff8020b90c>] vfs_read+0xcc/0x176
  [<ffffffff80211d4b>] sys_read+0x47/0x7c
  [<ffffffff802627ee>] system_call+0x7e/0x83

eth0: no IPv6 routers present


another one:

GRE over IPv4 tunneling driver
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.

Call Trace:
  [<ffffffff8026995e>] dump_trace+0xbe/0x3a0
  [<ffffffff80269c7c>] show_trace+0x3c/0x55
  [<ffffffff80269caa>] dump_stack+0x15/0x1b
  [<ffffffff802992e6>] save_trace+0xd6/0xe3
  [<ffffffff80299375>] add_lock_to_list+0x82/0xab
  [<ffffffff8029bb75>] __lock_acquire+0xaa5/0xc78
  [<ffffffff8029bd97>] lock_acquire+0x4f/0x78
  [<ffffffff80265519>] _spin_lock_irqsave+0x2c/0x3c
  [<ffffffff8024aa57>] account+0x46/0xfb
  [<ffffffff8039c010>] extract_entropy+0x48/0xc4
  [<ffffffff8039c408>] xfer_secondary_pool+0xa8/0xf0
  [<ffffffff8039bfff>] extract_entropy+0x37/0xc4
  [<ffffffff8039c0a7>] get_random_bytes+0x1b/0x1d
  [<ffffffff80447c35>] neigh_create+0x395/0x4fa
  [<ffffffff88047b11>] :ipv6:ndisc_dst_alloc+0xcf/0x16f
  [<ffffffff8804d3bf>] :ipv6:ndisc_send_rs+0xb2/0x4fa
  [<ffffffff8803fb7f>] :ipv6:addrconf_dad_completed+0x9b/0x100
  [<ffffffff88042eee>] :ipv6:addrconf_dad_timer+0x83/0x13f
  [<ffffffff8028b827>] run_timer_softirq+0x157/0x1e0
  [<ffffffff80211773>] __do_softirq+0x78/0x105
  [<ffffffff802601fc>] call_softirq+0x1c/0x30
  [<ffffffff8026b529>] do_softirq+0x39/0xa4
  [<ffffffff80288378>] irq_exit+0x58/0x5a
  [<ffffffff80272d79>] smp_apic_timer_interrupt+0x5e/0x65
  [<ffffffff8025fcab>] apic_timer_interrupt+0x6b/0x70
  [<ffffffff8026549c>] _spin_unlock_irqrestore+0x42/0x47
  [<ffffffff8043179e>] bitmap_daemon_work+0x10e/0x30b
  [<ffffffff8042eac4>] md_check_recovery+0x34/0x4b0
  [<ffffffff80426104>] raid1d+0x44/0xfc0
  [<ffffffff8042e251>] md_thread+0x121/0x13d
  [<ffffffff80233253>] kthread+0xd3/0x100
  [<ffffffff8025fe88>] child_rip+0xa/0x12
  <IRQ>  [<ffffffff802992e6>] save_trace+0xd6/0xe3
  [<ffffffff80299375>] add_lock_to_list+0x82/0xab
  [<ffffffff8029bb75>] __lock_acquire+0xaa5/0xc78
  [<ffffffff8029bd97>] lock_acquire+0x4f/0x78
  [<ffffffff8024aa57>] account+0x46/0xfb
  [<ffffffff80265519>] _spin_lock_irqsave+0x2c/0x3c
  [<ffffffff8024aa57>] account+0x46/0xfb
  [<ffffffff8039c010>] extract_entropy+0x48/0xc4
  [<ffffffff8039c408>] xfer_secondary_pool+0xa8/0xf0
  [<ffffffff80207121>] check_poison_obj+0x31/0x1e0
  [<ffffffff8021201a>] poison_obj+0x3b/0x51
  [<ffffffff80221701>] dbg_redzone1+0x1d/0x27
  [<ffffffff804468d6>] neigh_hash_alloc+0x1d/0x47
  [<ffffffff8020c95e>] cache_alloc_debugcheck_after+0x176/0x1b1
  [<ffffffff8039bfff>] extract_entropy+0x37/0xc4
  [<ffffffff8039c0a7>] get_random_bytes+0x1b/0x1d
  [<ffffffff80447c35>] neigh_create+0x395/0x4fa
  [<ffffffff8029ad27>] trace_hardirqs_on+0xec/0x12c
  [<ffffffff88047b11>] :ipv6:ndisc_dst_alloc+0xcf/0x16f
  [<ffffffff8803b303>] :ipv6:ip6_output+0x0/0x88f
  [<ffffffff8804d3bf>] :ipv6:ndisc_send_rs+0xb2/0x4fa
  [<ffffffff80288317>] local_bh_enable_ip+0xe7/0xf0
  [<ffffffff88042e6b>] :ipv6:addrconf_dad_timer+0x0/0x13f
  [<ffffffff8803fb7f>] :ipv6:addrconf_dad_completed+0x9b/0x100
  [<ffffffff88042eee>] :ipv6:addrconf_dad_timer+0x83/0x13f
  [<ffffffff88042e6b>] :ipv6:addrconf_dad_timer+0x0/0x13f
  [<ffffffff8029ad27>] trace_hardirqs_on+0xec/0x12c
  [<ffffffff8028b827>] run_timer_softirq+0x157/0x1e0
  [<ffffffff80211773>] __do_softirq+0x78/0x105
  [<ffffffff802601fc>] call_softirq+0x1c/0x30
  [<ffffffff8026b529>] do_softirq+0x39/0xa4
  [<ffffffff80288378>] irq_exit+0x58/0x5a
  [<ffffffff80272d79>] smp_apic_timer_interrupt+0x5e/0x65
  [<ffffffff80265499>] _spin_unlock_irqrestore+0x3f/0x47
  [<ffffffff8025fcab>] apic_timer_interrupt+0x6b/0x70
  <EOI>  [<ffffffff80265499>] _spin_unlock_irqrestore+0x3f/0x47
  [<ffffffff8026549c>] _spin_unlock_irqrestore+0x42/0x47
  [<ffffffff8043179e>] bitmap_daemon_work+0x10e/0x30b
  [<ffffffff8042eac4>] md_check_recovery+0x34/0x4b0
  [<ffffffff80426104>] raid1d+0x44/0xfc0
  [<ffffffff802078ac>] _raw_spin_lock+0xb9/0x13d
  [<ffffffff80265499>] _spin_unlock_irqrestore+0x3f/0x47
  [<ffffffff8029ad42>] trace_hardirqs_on+0x107/0x12c
  [<ffffffff8042e251>] md_thread+0x121/0x13d
  [<ffffffff8029562e>] autoremove_wake_function+0x0/0x42
  [<ffffffff8042e130>] md_thread+0x0/0x13d
  [<ffffffff80233253>] kthread+0xd3/0x100
  [<ffffffff8025fe88>] child_rip+0xa/0x12
  [<ffffffff8026541f>] _spin_unlock_irq+0x2b/0x33
  [<ffffffff8025f60c>] restore_args+0x0/0x30
  [<ffffffff80233180>] kthread+0x0/0x100
  [<ffffffff8025fe7e>] child_rip+0x0/0x12

eth0: no IPv6 routers present

and more:

[root@tornado squid]#

e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
GRE over IPv4 tunneling driver
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.

Call Trace:
  [<ffffffff8026995e>] dump_trace+0xbe/0x3a0
  [<ffffffff80269c7c>] show_trace+0x3c/0x55
  [<ffffffff80269caa>] dump_stack+0x15/0x1b
  [<ffffffff802992e6>] save_trace+0xd6/0xe3
  [<ffffffff8029a5d2>] mark_lock+0x82/0x5ba
  [<ffffffff8029b5b3>] __lock_acquire+0x4e3/0xc78
  [<ffffffff8029bd97>] lock_acquire+0x4f/0x78
  [<ffffffff802652a7>] _read_lock+0x28/0x37
  [<ffffffff8025344a>] udp_rcv+0x1aa/0x5c0
  [<ffffffff80235359>] ip_local_deliver+0x199/0x270
  [<ffffffff80236393>] ip_rcv+0x4d3/0x52b
  [<ffffffff8021feab>] netif_receive_skb+0x1eb/0x27b
  [<ffffffff803cbe99>] e1000_clean_rx_irq_ps+0x5b9/0x6a0
  [<ffffffff803ca597>] e1000_clean+0x327/0x45b
  [<ffffffff8020ca9b>] net_rx_action+0x92/0x147
  [<ffffffff80211773>] __do_softirq+0x78/0x105
  [<ffffffff802601fc>] call_softirq+0x1c/0x30
  [<ffffffff8026b529>] do_softirq+0x39/0xa4
  [<ffffffff80288378>] irq_exit+0x58/0x5a
  [<ffffffff8026b648>] do_IRQ+0xb4/0xbe
  [<ffffffff8025f5b6>] ret_from_intr+0x0/0xf
  [<ffffffff80269038>] mwait_idle_hints+0x4d/0x4f
  [<ffffffff80258d16>] mwait_idle+0x15/0x2a
  [<ffffffff8024a275>] cpu_idle+0x6a/0x89
  [<ffffffff80268766>] rest_init+0x26/0x28
  [<ffffffff806607c5>] start_kernel+0x258/0x263
  [<ffffffff80660157>] _sinittext+0x157/0x160
  <IRQ>  [<ffffffff802992e6>] save_trace+0xd6/0xe3
  [<ffffffff8029a5d2>] mark_lock+0x82/0x5ba
  [<ffffffff8029b5b3>] __lock_acquire+0x4e3/0xc78
  [<ffffffff8801b239>] :ip_conntrack:ip_ct_deliver_cached_events+0x81/0x86
  [<ffffffff8029bd97>] lock_acquire+0x4f/0x78
  [<ffffffff8025344a>] udp_rcv+0x1aa/0x5c0
  [<ffffffff802652a7>] _read_lock+0x28/0x37
  [<ffffffff8025344a>] udp_rcv+0x1aa/0x5c0
  [<ffffffff80235359>] ip_local_deliver+0x199/0x270
  [<ffffffff80236393>] ip_rcv+0x4d3/0x52b
  [<ffffffff8021feab>] netif_receive_skb+0x1eb/0x27b
  [<ffffffff803cbe99>] e1000_clean_rx_irq_ps+0x5b9/0x6a0
  [<ffffffff803ca597>] e1000_clean+0x327/0x45b
  [<ffffffff8026541f>] _spin_unlock_irq+0x2b/0x33
  [<ffffffff8020ca9b>] net_rx_action+0x92/0x147
  [<ffffffff8021175f>] __do_softirq+0x64/0x105
  [<ffffffff80211773>] __do_softirq+0x78/0x105
  [<ffffffff802601fc>] call_softirq+0x1c/0x30
  [<ffffffff8026b529>] do_softirq+0x39/0xa4
  [<ffffffff80288378>] irq_exit+0x58/0x5a
  [<ffffffff8026b648>] do_IRQ+0xb4/0xbe
  [<ffffffff80258d01>] mwait_idle+0x0/0x2a
  [<ffffffff8025f5b6>] ret_from_intr+0x0/0xf
  <EOI>  [<ffffffff80269038>] mwait_idle_hints+0x4d/0x4f
  [<ffffffff80258d16>] mwait_idle+0x15/0x2a
  [<ffffffff8024a275>] cpu_idle+0x6a/0x89
  [<ffffffff80268766>] rest_init+0x26/0x28
  [<ffffffff806607c5>] start_kernel+0x258/0x263
  [<ffffffff80660157>] _sinittext+0x157/0x160

eth0: no IPv6 routers present
[root@tornado ~]#


2. Also still having no joy with ATA layer driving my ATAPI cdrom:

ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x30B0 irq 14
ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x30B8 irq 15
scsi4 : ata_piix
ata5.00: ATAPI, max UDMA/66
ata5.00: configured for UDMA/66
scsi5 : ata_piix
ata6: port disabled. ignoring.
ATA: abnormal status 0xFF on port 0x177
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: limiting speed to UDMA/44
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/44
ata5: EH complete

This too, seems to be going unacknowledged and unfixed.  Fair enough, it's new 
code but I've received no response as to whether it should work, or shouldn't, 
whether I should persist trying with it or if I can help with fixing/testing it 
... ?

I had a mysterious hard crash before, immediately preceded by a message about 
losing comms to my UPS (serial port) but don't have any further information on 
that one, unfortunately.

Reuben



