Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVB1Nbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVB1Nbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVB1Nbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:31:40 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:42855 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261588AbVB1Nai convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:30:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OobdCGAIYEXjwboNjxu6pC2DQB/wSvDUQ+HqoDMmNnmQIEv9n2XBDxKXMoEomjm42As0a6NWQLcsOdDr2Gv3COWXthuR88CuHxpfT9WLzI8vyTq4BkrzEnJTurGd5xF4buPodiX22psK4qABnO7x4oQYRmusrRgG98ZDWoBz3ME=
Message-ID: <eb4dce4e05022805301dd032c@mail.gmail.com>
Date: Mon, 28 Feb 2005 14:30:32 +0100
From: Marcel Smeets <mpgsmeets@gmail.com>
Reply-To: Marcel Smeets <mpgsmeets@gmail.com>
To: Bernd Schubert <bernd-schubert@gmx.de>
Subject: Re: swapper: page allocation failure. order:1, mode:0x20
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200502281307.13629.bernd-schubert@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <200502281307.13629.bernd-schubert@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello had the same sort of messages, posted it two days ago.

I am using SuSE 9.2 Pro with kernel uname -a:

Linux 2.6.8-24.11-smp #1 SMP Fri Jan 14 13:01:26 UTC 2005 x86_64
x86_64 x86_64 GNU/Linux

Intel(R) Xeon(TM) CPU 2.80GHz

2 GB RAM
1 GB SWAP

and these strange kernel messages keep appearing::

it is a high load machine with iptables running. The
/proc/net/ip_conntrack number keeps running higher and does not get
less. After a while the maximum is reached. th e only way to solve
this is stop iptables, unload the ip modules from the kernel, load
them again and start iptables again. Then the messages will not come
again. Could it be a kernel bug???

dmesg:

swapper: page allocation failure. order:1, mode:0x20

Call Trace:<IRQ> <ffffffff8015ecef>{__alloc_pages+1135}
<ffffffff8015e830>{__get_free_pages+16}
      <ffffffff80162676>{kmem_getpages+38}
<ffffffff8031e3ea>{tcp_v4_route_req+250}
      <ffffffff80162a99>{cache_alloc_refill+665}
<ffffffff80162c46>{kmem_cache_alloc+54}
      <ffffffff802e2f0a>{sk_alloc+58}
<ffffffff80323d99>{tcp_create_openreq_child+41}
      <ffffffff803229e7>{tcp_v4_syn_recv_sock+87}
<ffffffff80323b7e>{tcp_check_req+606}
      <ffffffff8030b4dc>{ip_finish_output+508}
<ffffffff80308b90>{ip_dst_output+0}
      <ffffffff8030b668>{ip_output+216} <ffffffff80308bc8>{ip_dst_output+56}
      <ffffffff80132f9b>{recalc_task_prio+635}
<ffffffff80308b90>{ip_dst_output+0}
      <ffffffff80132f9b>{recalc_task_prio+635}
<ffffffff80133c91>{activate_task+129}
      <ffffffff80137a89>{autoremove_wake_function+9}
<ffffffff80132633>{__wake_up_common+67}
      <ffffffff80132c13>{__wake_up+67} <ffffffff802e2344>{sock_def_readable+68}
      <ffffffff80320b79>{tcp_v4_do_rcv+233}
<ffffffffa017b034>{:ipt_state:match+36}
      <ffffffff803214cb>{tcp_v4_rcv+1835}
<ffffffff80305fb9>{ip_local_deliver_finish+297}
      <ffffffff80305e90>{ip_local_deliver_finish+0}
<ffffffff802f3a43>{nf_hook_slow+195}
      <ffffffff80305e90>{ip_local_deliver_finish+0}
<ffffffff803062fe>{ip_local_deliver+622}
      <ffffffff8030592e>{ip_rcv_finish+574} <ffffffff803056f0>{ip_rcv_finish+0}
      <ffffffff803056f0>{ip_rcv_finish+0} <ffffffff802f3a43>{nf_hook_slow+195}
      <ffffffff803056f0>{ip_rcv_finish+0} <ffffffff80305e34>{ip_rcv+1188}
      <ffffffff802e9749>{netif_receive_skb+729}
<ffffffffa00e9c9c>{:e1000:e1000_clean+1820}
      <ffffffff802e85b4>{net_rx_action+132}
<ffffffff8013dca1>{__do_softirq+113}
      <ffffffff8013dd55>{do_softirq+53} <ffffffff80113e3f>{do_IRQ+335}
      <ffffffff8010f540>{mwait_idle+0} <ffffffff80110cf5>{ret_from_intr+0}
       <EOI> <ffffffff8010f596>{mwait_idle+86} <ffffffff8010f9ea>{cpu_idle+26}
      <ffffffff804e971a>{start_kernel+490} <ffffffff804e91e0>{_sinittext+480}

swapper: page allocation failure. order:1, mode:0x20

Call Trace:<IRQ> <ffffffff8015ecef>{__alloc_pages+1135}
<ffffffff8015e830>{__get_free_pages+16}
      <ffffffff80162676>{kmem_getpages+38}
<ffffffff8031e3ea>{tcp_v4_route_req+250}
      <ffffffff80162a99>{cache_alloc_refill+665}
<ffffffff80162c46>{kmem_cache_alloc+54}
      <ffffffff802e2f0a>{sk_alloc+58}
<ffffffff80323d99>{tcp_create_openreq_child+41}
      <ffffffff803229e7>{tcp_v4_syn_recv_sock+87}
<ffffffff80323b7e>{tcp_check_req+606}
      <ffffffff8030b4dc>{ip_finish_output+508}
<ffffffff80308b90>{ip_dst_output+0}
      <ffffffff8030b668>{ip_output+216} <ffffffff80308bc8>{ip_dst_output+56}
      <ffffffff802f3a43>{nf_hook_slow+195} <ffffffff80308b90>{ip_dst_output+0}
      <ffffffff8013340a>{task_rq_lock+74}
<ffffffff80133f9b>{try_to_wake_up+747}
      <ffffffff8030ad6b>{ip_queue_xmit+1211}
<ffffffff8013340a>{task_rq_lock+74}
      <ffffffff8013340a>{task_rq_lock+74}
<ffffffff80132633>{__wake_up_common+67}
      <ffffffff80132c13>{__wake_up+67}
<ffffffff80312996>{tcp_ack_saw_tstamp+22}
      <ffffffff80314d90>{tcp_ack+1040} <ffffffff80320b79>{tcp_v4_do_rcv+233}
      <ffffffffa017b034>{:ipt_state:match+36}
<ffffffff803214cb>{tcp_v4_rcv+1835}
      <ffffffff80305fb9>{ip_local_deliver_finish+297}
<ffffffff80305e90>{ip_local_deliver_finish+0}
      <ffffffff802f3a43>{nf_hook_slow+195}
<ffffffff80305e90>{ip_local_deliver_finish+0}
      <ffffffff803062fe>{ip_local_deliver+622}
<ffffffff8030592e>{ip_rcv_finish+574}
      <ffffffff803056f0>{ip_rcv_finish+0} <ffffffff803056f0>{ip_rcv_finish+0}
      <ffffffff802f3a43>{nf_hook_slow+195} <ffffffff803056f0>{ip_rcv_finish+0}
      <ffffffff80305e34>{ip_rcv+1188} <ffffffff802e9749>{netif_receive_skb+729}
      <ffffffffa00e9c9c>{:e1000:e1000_clean+1820}
<ffffffff80133c91>{activate_task+129}
      <ffffffff80133f9b>{try_to_wake_up+747}
<ffffffff802e85b4>{net_rx_action+132}
      <ffffffff8013dca1>{__do_softirq+113} <ffffffff8013dd55>{do_softirq+53}
      <ffffffff80113e3f>{do_IRQ+335} <ffffffff8010f540>{mwait_idle+0}
      <ffffffff80110cf5>{ret_from_intr+0}  <EOI>
<ffffffff8010f596>{mwait_idle+86}
      <ffffffff8010f9ea>{cpu_idle+26} <ffffffff804e971a>{start_kernel+490}
      <ffffffff804e91e0>{_sinittext+480}
swapper: page allocation failure. order:1, mode:0x20

Call Trace:<IRQ> <ffffffff8015ecef>{__alloc_pages+1135}
<ffffffff8015e830>{__get_free_pages+16}
      <ffffffff80162676>{kmem_getpages+38}
<ffffffff8031e3ea>{tcp_v4_route_req+250}
      <ffffffff80162a99>{cache_alloc_refill+665}
<ffffffff80162c46>{kmem_cache_alloc+54}
      <ffffffff802e2f0a>{sk_alloc+58}
<ffffffff80323d99>{tcp_create_openreq_child+41}
      <ffffffff803229e7>{tcp_v4_syn_recv_sock+87}
<ffffffff80323b7e>{tcp_check_req+606}
      <ffffffff8030b4dc>{ip_finish_output+508}
<ffffffff80308b90>{ip_dst_output+0}
      <ffffffff8030b668>{ip_output+216} <ffffffff80308bc8>{ip_dst_output+56}
      <ffffffff802f3a43>{nf_hook_slow+195} <ffffffff80308b90>{ip_dst_output+0}
      <ffffffff80132f9b>{recalc_task_prio+635}
<ffffffff80133c91>{activate_task+129}
      <ffffffff8013340a>{task_rq_lock+74}
<ffffffff80132633>{__wake_up_common+67}
      <ffffffff80313e1b>{tcp_fastretrans_alert+859}
<ffffffff8031536d>{tcp_ack+2541}
      <ffffffff80320b79>{tcp_v4_do_rcv+233}
<ffffffffa017b034>{:ipt_state:match+36}
      <ffffffff803214cb>{tcp_v4_rcv+1835}
<ffffffff80305fb9>{ip_local_deliver_finish+297}
      <ffffffff80305e90>{ip_local_deliver_finish+0}
<ffffffff802f3a43>{nf_hook_slow+195}
      <ffffffff80305e90>{ip_local_deliver_finish+0}
<ffffffff803062fe>{ip_local_deliver+622}
      <ffffffff8030592e>{ip_rcv_finish+574} <ffffffff803056f0>{ip_rcv_finish+0}
      <ffffffff803056f0>{ip_rcv_finish+0} <ffffffff802f3a43>{nf_hook_slow+195}
      <ffffffff803056f0>{ip_rcv_finish+0} <ffffffff80305e34>{ip_rcv+1188}
      <ffffffff802e9749>{netif_receive_skb+729}
<ffffffffa00e9c9c>{:e1000:e1000_clean+1820}
      <ffffffff80132c13>{__wake_up+67} <ffffffff802e85b4>{net_rx_action+132}
      <ffffffff8013dca1>{__do_softirq+113} <ffffffff8013dd55>{do_softirq+53}
      <ffffffff80113e3f>{do_IRQ+335} <ffffffff8010f540>{mwait_idle+0}
      <ffffffff80110cf5>{ret_from_intr+0}  <EOI>
<ffffffff8010f596>{mwait_idle+86}
      <ffffffff8010f9ea>{cpu_idle+26} <ffffffff804e971a>{start_kernel+490}
      <ffffffff804e91e0>{_sinittext+480}


On Mon, 28 Feb 2005 13:07:13 +0100, Bernd Schubert
<bernd-schubert@gmx.de> wrote:
> Oh no, not this page allocation problems again. In summer I already posted
> problems with page allocation errors with 2.6.7, but to me it seemed that
> nobody cared. That time we got those problems every morning during the cron
> jobs and our main file server always completely crashed.
> This time its our cluster master system and first happend after an uptime
> of 89 days, kernel is 2.6.9. Besides of those messages, the system still
> seems to run stable
> 
> I really beg for help here, so please please please help me solving this
> probem. What can I do to solve it?
> 
> First a (dumb) question, what does 'page allocation failure' really mean?
> Is it some out of memory case?
> 
> Thanks a lot in advance for any help,
>  Bernd
> 
> Feb 28 10:04:45 hitchcock kernel: swapper: page allocation failure. order:1, mode:0x20
> Feb 28 10:04:45 hitchcock kernel:
> Feb 28 10:04:45 hitchcock kernel: Call Trace:<IRQ> <ffffffff8015b0de>{__alloc_pages+878} <ffffffff8015b10e>{__get_free_pages+14}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff8015edc6>{kmem_getpages+38} <ffffffff803d064a>{ip_frag_create+26}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff8016061e>{cache_grow+190} <ffffffff80160e80>{cache_alloc_refill+560}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff801617e3>{__kmalloc+195} <ffffffff803b5680>{alloc_skb+64}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff8031727e>{tg3_alloc_rx_skb+222} <ffffffff80317553>{tg3_rx+371}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff80317977>{tg3_poll+183} <ffffffff803bc306>{net_rx_action+134}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff8013d0ab>{__do_softirq+123} <ffffffff8013d162>{do_softirq+50}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff801140ab>{do_IRQ+347} <ffffffff801114eb>{ret_from_intr+0}
> Feb 28 10:04:45 hitchcock kernel:         <EOI> <ffffffff8010f070>{default_idle+0} <ffffffff8010f094>{default_idle+36}
> Feb 28 10:04:45 hitchcock kernel:        <ffffffff8010f147>{cpu_idle+39}
> Feb 28 10:05:41 hitchcock rpc.mountd: authenticated unmount request from beo-04:666 for /lib64 (/lib64)
> Feb 28 10:04:45 hitchcock kernel: swapper: page allocation failure. order:1, mode:0x20
> Feb 28 10:07:36 hitchcock kernel:
> Feb 28 10:07:36 hitchcock kernel: Call Trace:<IRQ> <ffffffff8015b0de>{__alloc_pages+878} <ffffffff8015b10e>{__get_free_pages+14}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff8015edc6>{kmem_getpages+38} <ffffffff8016061e>{cache_grow+190}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff80160e80>{cache_alloc_refill+560} <ffffffff801617e3>{__kmalloc+195}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff803b5680>{alloc_skb+64} <ffffffff8031727e>{tg3_alloc_rx_skb+222}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff80317553>{tg3_rx+371} <ffffffff80317977>{tg3_poll+183}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff803bc306>{net_rx_action+134} <ffffffff8013d0ab>{__do_softirq+123}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff8013d162>{do_softirq+50} <ffffffff801140ab>{do_IRQ+347}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff801114eb>{ret_from_intr+0}  <EOI> <ffffffff8010f070>{default_idle+0}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff8010f094>{default_idle+36} <ffffffff8010f147>{cpu_idle+39}
> Feb 28 10:07:36 hitchcock kernel:
> Feb 28 10:07:36 hitchcock kernel: swapper: page allocation failure. order:1, mode:0x20
> Feb 28 10:07:36 hitchcock kernel:
> Feb 28 10:07:36 hitchcock kernel: Call Trace:<IRQ> <ffffffff8015b0de>{__alloc_pages+878} <ffffffff8015b10e>{__get_free_pages+14}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff8015edc6>{kmem_getpages+38} <ffffffff8016061e>{cache_grow+190}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff80160e80>{cache_alloc_refill+560} <ffffffff801617e3>{__kmalloc+195}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff803b5680>{alloc_skb+64} <ffffffff8031727e>{tg3_alloc_rx_skb+222}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff80317553>{tg3_rx+371} <ffffffff80317977>{tg3_poll+183}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff803bc306>{net_rx_action+134} <ffffffff8013d0ab>{__do_softirq+123}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff8013d162>{do_softirq+50} <ffffffff801140ab>{do_IRQ+347}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff801114eb>{ret_from_intr+0}  <EOI> <ffffffff8010f070>{default_idle+0}
> Feb 28 10:07:36 hitchcock kernel:        <ffffffff8010f094>{default_idle+36} <ffffffff8010f147>{cpu_idle+39}
> 
> --
> Bernd Schubert
> Physikalisch Chemisches Institut / Theoretische Chemie
> Universität Heidelberg
> INF 229
> 69120 Heidelberg
> e-mail: bernd.schubert@pci.uni-heidelberg.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
