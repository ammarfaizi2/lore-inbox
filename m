Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVDCGAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVDCGAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 01:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVDCGAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 01:00:12 -0500
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:13110
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261512AbVDCF7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 00:59:50 -0500
Subject: Re: linux-2.6.12-rc1-mm4-RT-V0.7.42-08
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1112433149.13131.8.camel@twins>
References: <1112433149.13131.8.camel@twins>
Content-Type: multipart/mixed; boundary="=-aHVj18zH9tJZYut2mZqT"
Date: Sun, 03 Apr 2005 07:59:48 +0200
Message-Id: <1112507988.10235.3.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aHVj18zH9tJZYut2mZqT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ingo,

I need the following two patches to keep my system alive and avoid
the BUGs in the log send to you earlier (private mail).

------------------- example BUG ------------------------

BUG: using smp_processor_id() in preemptible [00000001] code: java/16460
caller is icmp_send+0x9b/0x3d0
 [<c020b1db>] smp_processor_id+0x9b/0xb0 (8)
 [<c032246b>] icmp_send+0x9b/0x3d0 (28)
 [<c013ae67>] check_wakeup_timing+0x47/0x160 (8)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (40)
 [<c014d159>] kmem_cache_free+0x39/0x120 (8)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (12)
 [<c014d159>] kmem_cache_free+0x39/0x120 (8)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (24)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (28)
 [<c0276066>] rtl8139_start_xmit+0x86/0x1d0 (8)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (40)
 [<c02f3259>] qdisc_restart+0x1b9/0x230 (8)
 [<c02f3259>] qdisc_restart+0x1b9/0x230 (36)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (8)
 [<c02760ae>] rtl8139_start_xmit+0xce/0x1d0 (16)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (32)
 [<c02ffe33>] ip_fragment+0x663/0x7f0 (60)
 [<c013138f>] rcu_read_unlock+0x5f/0x70 (32)
 [<c02f9d2a>] __ip_route_output_key+0xba/0xe0 (8)
 [<c02fe950>] ip_finish_output+0x0/0x2f0 (16)
 [<c02ff383>] ip_queue_xmit+0x263/0x590 (24)
 [<c02ff383>] ip_queue_xmit+0x263/0x590 (20)
 [<c03102eb>] tcp_transmit_skb+0x38b/0x750 (196)
 [<c031113e>] tcp_write_xmit+0x10e/0x2f0 (56)
 [<c03054ab>] tcp_sendmsg+0xffb/0x1050 (52)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (12)
 [<c013b9c5>] unqueue_me+0x25/0x130 (8)
 [<c0325f4a>] inet_sendmsg+0x4a/0x70 (92)
 [<c02dd795>] sock_aio_write+0x135/0x150 (24)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (88)
 [<c0163c69>] do_sync_write+0xb9/0x110 (20)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (44)
 [<c0164d52>] fget_light+0x62/0x90 (8)
 [<c034269d>] _raw_spin_unlock+0xd/0x30 (44)
 [<c0134c50>] autoremove_wake_function+0x0/0x50 (8)
 [<c0163d9b>] vfs_write+0xdb/0x170 (52)
 [<c0163ee1>] sys_write+0x41/0x70 (24)
 [<c0102f0b>] sysenter_past_esp+0x54/0x75 (28)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c03422e6>] .... _raw_spin_lock+0x16/0x90
.....[<00000000>] ..   ( <= 0x0)
.. [<c03422e6>] .... _raw_spin_lock+0x16/0x90
.....[<00000000>] ..   ( <= 0x0)


-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

--=-aHVj18zH9tJZYut2mZqT
Content-Disposition: attachment; filename=2.6.12-rc1-icmp.patch
Content-Type: text/x-patch; name=2.6.12-rc1-icmp.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



Since there is no lock held yet we are still preemptable; and since 
icmp_socket is a per cpu variable switching cpus gives weird results.


Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>


--- /usr/src/linux-2.6.12-rc1-mm4-RT-V0.7.42-08/net/ipv4/icmp.c~	2005-03-25 10:14:32.000000000 +0100
+++ /usr/src/linux-2.6.12-rc1-mm4-RT-V0.7.42-08/net/ipv4/icmp.c	2005-04-02 18:58:19.000000000 +0200
@@ -376,8 +376,8 @@
 
 static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 {
-	struct sock *sk = icmp_socket->sk;
-	struct inet_sock *inet = inet_sk(sk);
+	struct sock *sk;
+	struct inet_sock *inet;
 	struct ipcm_cookie ipc;
 	struct rtable *rt = (struct rtable *)skb->dst;
 	u32 daddr;
@@ -388,6 +388,9 @@
 	if (icmp_xmit_lock())
 		return;
 
+	sk = icmp_socket->sk;
+	inet = inet_sk(sk);
+
 	icmp_param->data.icmph.checksum = 0;
 	icmp_out_count(icmp_param->data.icmph.type);
 

--=-aHVj18zH9tJZYut2mZqT
Content-Disposition: attachment; filename=2.6.12-rc1-icmp-rt.patch
Content-Type: text/x-patch; name=2.6.12-rc1-icmp-rt.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Since on PREEMPT_RT spinlocks allow preemption, it's possible to
change cpu at (almost) any point in time. Make sure we stick to
the per cpu variable we started with.


Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>


--- /usr/src/linux-2.6.12-rc1-mm4-RT-V0.7.42-08/net/ipv4/icmp_orig.c	2005-04-03 00:09:08.000000000 +0200
+++ /usr/src/linux-2.6.12-rc1-mm4-RT-V0.7.42-08/net/ipv4/icmp.c	2005-04-03 00:20:22.000000000 +0200
@@ -228,27 +228,32 @@
  *
  *	On SMP we have one ICMP socket per-cpu.
  */
-static DEFINE_PER_CPU(struct socket *, __icmp_socket) = NULL;
-#define icmp_socket	__get_cpu_var(__icmp_socket)
+static DEFINE_PER_CPU_LOCKED(struct socket *, __icmp_socket) = NULL;
 
 static __inline__ struct socket * icmp_xmit_lock(int cpu)
 {
+	struct socket *icmp_socket;
+
 	local_bh_disable();
+	icmp_socket = get_cpu_var_locked(__icmp_socket, cpu);
 
 	if (unlikely(!spin_trylock(&icmp_socket->sk->sk_lock.slock))) {
 		/* This can happen if the output path signals a
 		 * dst_link_failure() for an outgoing ICMP packet.
 		 */
+		put_cpu_var_locked(__icmp_socket, cpu);
 		local_bh_enable();
-		return 1;
+		return NULL;
 	}
 
-	return 0;
+	return icmp_socket;
 }
 
 static void icmp_xmit_unlock(int cpu)
 {
+	struct socket *icmp_socket = __get_cpu_var_locked(__icmp_socket, cpu);
 	spin_unlock_bh(&icmp_socket->sk->sk_lock.slock);
+	put_cpu_var_locked(__icmp_socket, cpu);
 }
 
 /*
@@ -345,7 +350,8 @@
 }
 
 static void icmp_push_reply(struct icmp_bxm *icmp_param,
-			    struct ipcm_cookie *ipc, struct rtable *rt)
+			    struct ipcm_cookie *ipc, struct rtable *rt,
+				struct socket *icmp_socket)
 {
 	struct sk_buff *skb;
 
@@ -377,16 +383,19 @@
 
 static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 {
+	struct socket *icmp_socket;
 	struct sock *sk;
 	struct inet_sock *inet;
 	struct ipcm_cookie ipc;
 	struct rtable *rt = (struct rtable *)skb->dst;
 	u32 daddr;
+	int cpu;
 
 	if (ip_options_echo(&icmp_param->replyopts, skb))
 		goto out;
 
-	if (icmp_xmit_lock())
+	cpu = _smp_processor_id();
+	if (!(icmp_socket = icmp_xmit_lock(cpu)))
 		return;
 
 	sk = icmp_socket->sk;
@@ -414,10 +423,10 @@
 	}
 	if (icmpv4_xrlim_allow(rt, icmp_param->data.icmph.type,
 			       icmp_param->data.icmph.code))
-		icmp_push_reply(icmp_param, &ipc, rt);
+		icmp_push_reply(icmp_param, &ipc, rt, icmp_socket);
 	ip_rt_put(rt);
 out_unlock:
-	icmp_xmit_unlock();
+	icmp_xmit_unlock(cpu);
 out:;
 }
 
@@ -435,8 +444,9 @@
 
 void icmp_send(struct sk_buff *skb_in, int type, int code, u32 info)
 {
+	struct socket *icmp_socket;
 	struct iphdr *iph;
-	int room;
+	int room, cpu;
 	struct icmp_bxm icmp_param;
 	struct rtable *rt = (struct rtable *)skb_in->dst;
 	struct ipcm_cookie ipc;
@@ -507,7 +517,8 @@
 		}
 	}
 
-	if (icmp_xmit_lock())
+	cpu = _smp_processor_id();
+	if (!(icmp_socket = icmp_xmit_lock(cpu)))
 		return;
 
 	/*
@@ -580,11 +591,11 @@
 		icmp_param.data_len = room;
 	icmp_param.head_len = sizeof(struct icmphdr);
 
-	icmp_push_reply(&icmp_param, &ipc, rt);
+	icmp_push_reply(&icmp_param, &ipc, rt, icmp_socket);
 ende:
 	ip_rt_put(rt);
 out_unlock:
-	icmp_xmit_unlock();
+	icmp_xmit_unlock(cpu);
 out:;
 }
 
@@ -1116,20 +1127,20 @@
 			continue;
 
 		err = sock_create_kern(PF_INET, SOCK_RAW, IPPROTO_ICMP,
-				       &per_cpu(__icmp_socket, i));
+				       &__get_cpu_var_locked(__icmp_socket, i));
 
 		if (err < 0)
 			panic("Failed to create the ICMP control socket.\n");
 
-		per_cpu(__icmp_socket, i)->sk->sk_allocation = GFP_ATOMIC;
+		__get_cpu_var_locked(__icmp_socket, i)->sk->sk_allocation = GFP_ATOMIC;
 
 		/* Enough space for 2 64K ICMP packets, including
 		 * sk_buff struct overhead.
 		 */
-		per_cpu(__icmp_socket, i)->sk->sk_sndbuf =
+		__get_cpu_var_locked(__icmp_socket, i)->sk->sk_sndbuf =
 			(2 * ((64 * 1024) + sizeof(struct sk_buff)));
 
-		inet = inet_sk(per_cpu(__icmp_socket, i)->sk);
+		inet = inet_sk(__get_cpu_var_locked(__icmp_socket, i)->sk);
 		inet->uc_ttl = -1;
 		inet->pmtudisc = IP_PMTUDISC_DONT;
 
@@ -1137,7 +1148,7 @@
 		 * see it, we do not wish this socket to see incoming
 		 * packets.
 		 */
-		per_cpu(__icmp_socket, i)->sk->sk_prot->unhash(per_cpu(__icmp_socket, i)->sk);
+		__get_cpu_var_locked(__icmp_socket, i)->sk->sk_prot->unhash(__get_cpu_var_locked(__icmp_socket, i)->sk);
 	}
 }
 

--=-aHVj18zH9tJZYut2mZqT--

