Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVBYLzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVBYLzh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 06:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVBYLzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 06:55:35 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:63360 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262679AbVBYLzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 06:55:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XLRhFzuRofprkB8YctwBLBSIgWK85fv4Zkk9niRpr4lD0mI56GhJJP3lJSPmOr7eceUUI/o+PFrDUO9FbyYXHm0TviLVEg6ipB0Qxvp/ai4A8en5KFexYN7GqHdtH9yY88/YN3H1X/TbQSa/FQDFmFErbY/Rs3fVqVKWyyzWDss=
Message-ID: <eb4dce4e050225035565a771f2@mail.gmail.com>
Date: Fri, 25 Feb 2005 12:55:11 +0100
From: Marcel Smeets <mpgsmeets@gmail.com>
Reply-To: Marcel Smeets <mpgsmeets@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.8-24.11-smp errors
In-Reply-To: <20050225034316.0e0c994e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41BF1983.mailP9C1B91GB@suse.de.suse.lists.linux.kernel>
	 <p73acsg1za1.fsf@bragg.suse.de>
	 <20050225034316.0e0c994e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

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
again if I repeat this frequently. Could it be a kernel bug??? Or
maybe something misconfigured???

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
