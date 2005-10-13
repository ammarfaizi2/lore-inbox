Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbVJMTWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbVJMTWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbVJMTWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:22:54 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:31856 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751620AbVJMTWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:22:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=eHFJJELM8JXYc4ThPyOp/SHy5sIyiSaz3M1c4ezIPn+icVZtEMLHMXEQF5IHrULoOwGq6vWprTuxfu4fOl5UtOY1l+7fm5l02lpEMJ97B5tv0PF1Rt8UT4q+41xlQd6/nA0BZT22olokZ7+QhJMWFw+0c4+hEmmhlFlj7sTZoPo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/14] Big kfree NULL check cleanup - net
Date: Thu, 13 Oct 2005 21:25:43 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
       "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>,
       Ralf Baechle <ralf@linux-mips.org>,
       "Greg Kroah-Hartman" <greg@kroah.com>, dccp@vger.kernel.org,
       Patrick Caulfield <patrick@tykepenguin.com>,
       Jean Tourrilhes <jt@hpl.hp.com>, Sridhar Samudrala <sri@us.ibm.com>,
       Andy Adamson <andros@umich.edu>, "J. Bruce Fields" <bfields@umich.edu>,
       Nenad Corbic <ncorbic@sangoma.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132125.44470.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the net/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in net/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 net/802/p8023.c                        |    3 +--
 net/ax25/af_ax25.c                     |    6 ++----
 net/ax25/ax25_in.c                     |    6 ++----
 net/ax25/ax25_route.c                  |   19 ++++++-------------
 net/bluetooth/hidp/core.c              |    4 +---
 net/core/dev_mcast.c                   |    3 +--
 net/core/sock.c                        |    3 +--
 net/dccp/ipv4.c                        |    6 ++----
 net/dccp/proto.c                       |    3 +--
 net/decnet/dn_table.c                  |   16 +++++++---------
 net/ethernet/pe2.c                     |    3 +--
 net/ipv4/af_inet.c                     |    3 +--
 net/ipv4/fib_frontend.c                |    3 +--
 net/ipv4/ip_options.c                  |    3 +--
 net/ipv4/ip_output.c                   |   12 ++++--------
 net/ipv4/ip_sockglue.c                 |   12 ++++--------
 net/ipv4/ipvs/ip_vs_app.c              |    6 ++----
 net/ipv4/multipath_wrandom.c           |   10 +++-------
 net/ipv4/netfilter/ip_nat_snmp_basic.c |    3 +--
 net/ipv4/tcp_ipv4.c                    |    3 +--
 net/ipv6/addrconf.c                    |    3 +--
 net/ipv6/ip6_output.c                  |   15 +++++----------
 net/ipv6/ip6_tunnel.c                  |    6 ++----
 net/ipv6/ipcomp6.c                     |    3 +--
 net/ipv6/ipv6_sockglue.c               |    3 +--
 net/irda/discovery.c                   |    3 +--
 net/irda/irias_object.c                |   16 ++++++----------
 net/rose/rose_route.c                  |    6 ++----
 net/sched/cls_fw.c                     |    3 +--
 net/sched/cls_route.c                  |    3 +--
 net/sched/cls_rsvp.h                   |    3 +--
 net/sched/cls_tcindex.c                |    9 +++------
 net/sched/cls_u32.c                    |    4 ++--
 net/sched/em_meta.c                    |    3 +--
 net/sched/sch_gred.c                   |    9 +++------
 net/sctp/associola.c                   |    4 +---
 net/sctp/sm_make_chunk.c               |    6 ++----
 net/sunrpc/auth_gss/gss_krb5_seal.c    |    2 +-
 net/sunrpc/auth_gss/gss_krb5_unseal.c  |    2 +-
 net/sunrpc/auth_gss/gss_mech_switch.c  |    3 +--
 net/sunrpc/auth_gss/gss_spkm3_seal.c   |    3 +--
 net/sunrpc/auth_gss/gss_spkm3_token.c  |    3 +--
 net/sunrpc/auth_gss/gss_spkm3_unseal.c |    6 ++----
 net/sunrpc/svc.c                       |    9 +++------
 net/sunrpc/xdr.c                       |    3 +--
 net/wanrouter/af_wanpipe.c             |   20 +++++++-------------
 net/wanrouter/wanmain.c                |   12 ++++--------
 net/xfrm/xfrm_state.c                  |   12 ++++--------
 48 files changed, 103 insertions(+), 198 deletions(-)

--- linux-2.6.14-rc4-orig/net/802/p8023.c	2005-10-11 22:41:32.000000000 +0200
+++ linux-2.6.14-rc4/net/802/p8023.c	2005-10-13 11:24:33.000000000 +0200
@@ -54,8 +54,7 @@ struct datalink_proto *make_8023_client(
  */
 void destroy_8023_client(struct datalink_proto *dl)
 {
-	if (dl)
-		kfree(dl);
+	kfree(dl);
 }
 
 EXPORT_SYMBOL(destroy_8023_client);
--- linux-2.6.14-rc4-orig/net/ax25/ax25_in.c	2005-10-11 22:41:32.000000000 +0200
+++ linux-2.6.14-rc4/net/ax25/ax25_in.c	2005-10-13 11:25:12.000000000 +0200
@@ -401,10 +401,8 @@ static int ax25_rcv(struct sk_buff *skb,
 	}
 
 	if (dp.ndigi == 0) {
-		if (ax25->digipeat != NULL) {
-			kfree(ax25->digipeat);
-			ax25->digipeat = NULL;
-		}
+		kfree(ax25->digipeat);
+		ax25->digipeat = NULL;
 	} else {
 		/* Reverse the source SABM's path */
 		memcpy(ax25->digipeat, &reverse_dp, sizeof(ax25_digi));
--- linux-2.6.14-rc4-orig/net/ax25/af_ax25.c	2005-10-11 22:41:32.000000000 +0200
+++ linux-2.6.14-rc4/net/ax25/af_ax25.c	2005-10-13 11:25:40.000000000 +0200
@@ -1138,10 +1138,8 @@ static int ax25_connect(struct socket *s
 	sk->sk_state   = TCP_CLOSE;
 	sock->state = SS_UNCONNECTED;
 
-	if (ax25->digipeat != NULL) {
-		kfree(ax25->digipeat);
-		ax25->digipeat = NULL;
-	}
+	kfree(ax25->digipeat);
+	ax25->digipeat = NULL;
 
 	/*
 	 *	Handle digi-peaters to be used.
--- linux-2.6.14-rc4-orig/net/ax25/ax25_route.c	2005-10-11 22:41:32.000000000 +0200
+++ linux-2.6.14-rc4/net/ax25/ax25_route.c	2005-10-13 11:26:29.000000000 +0200
@@ -54,15 +54,13 @@ void ax25_rt_device_down(struct net_devi
 		if (s->dev == dev) {
 			if (ax25_route_list == s) {
 				ax25_route_list = s->next;
-				if (s->digipeat != NULL)
-					kfree(s->digipeat);
+				kfree(s->digipeat);
 				kfree(s);
 			} else {
 				for (t = ax25_route_list; t != NULL; t = t->next) {
 					if (t->next == s) {
 						t->next = s->next;
-						if (s->digipeat != NULL)
-							kfree(s->digipeat);
+						kfree(s->digipeat);
 						kfree(s);
 						break;
 					}
@@ -90,10 +88,8 @@ static int ax25_rt_add(struct ax25_route
 	while (ax25_rt != NULL) {
 		if (ax25cmp(&ax25_rt->callsign, &route->dest_addr) == 0 &&
 		            ax25_rt->dev == ax25_dev->dev) {
-			if (ax25_rt->digipeat != NULL) {
-				kfree(ax25_rt->digipeat);
-				ax25_rt->digipeat = NULL;
-			}
+			kfree(ax25_rt->digipeat);
+			ax25_rt->digipeat = NULL;
 			if (route->digi_count != 0) {
 				if ((ax25_rt->digipeat = kmalloc(sizeof(ax25_digi), GFP_ATOMIC)) == NULL) {
 					write_unlock(&ax25_route_lock);
@@ -145,8 +141,7 @@ static int ax25_rt_add(struct ax25_route
 static void ax25_rt_destroy(ax25_route *ax25_rt)
 {
 	if (atomic_read(&ax25_rt->ref) == 0) {
-		if (ax25_rt->digipeat != NULL)
-			kfree(ax25_rt->digipeat);
+		kfree(ax25_rt->digipeat);
 		kfree(ax25_rt);
 		return;
 	}
@@ -530,9 +525,7 @@ void __exit ax25_rt_free(void)
 		s       = ax25_rt;
 		ax25_rt = ax25_rt->next;
 
-		if (s->digipeat != NULL)
-			kfree(s->digipeat);
-
+		kfree(s->digipeat);
 		kfree(s);
 	}
 	write_unlock(&ax25_route_lock);
--- linux-2.6.14-rc4-orig/net/dccp/ipv4.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/dccp/ipv4.c	2005-10-13 11:26:46.000000000 +0200
@@ -1287,10 +1287,8 @@ static int dccp_v4_destroy_sock(struct s
 	if (inet_csk(sk)->icsk_bind_hash != NULL)
 		inet_put_port(&dccp_hashinfo, sk);
 
-	if (dp->dccps_service_list != NULL) {
-		kfree(dp->dccps_service_list);
-		dp->dccps_service_list = NULL;
-	}
+	kfree(dp->dccps_service_list);
+	dp->dccps_service_list = NULL;
 
 	ccid_hc_rx_exit(dp->dccps_hc_rx_ccid, sk);
 	ccid_hc_tx_exit(dp->dccps_hc_tx_ccid, sk);
--- linux-2.6.14-rc4-orig/net/dccp/proto.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/dccp/proto.c	2005-10-13 11:27:02.000000000 +0200
@@ -238,8 +238,7 @@ static int dccp_setsockopt_service(struc
 	lock_sock(sk);
 	dp->dccps_service = service;
 
-	if (dp->dccps_service_list != NULL)
-		kfree(dp->dccps_service_list);
+	kfree(dp->dccps_service_list);
 
 	dp->dccps_service_list = sl;
 	release_sock(sk);
--- linux-2.6.14-rc4-orig/net/core/sock.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/core/sock.c	2005-10-13 11:27:43.000000000 +0200
@@ -1242,8 +1242,7 @@ static void sock_def_write_space(struct 
 
 static void sock_def_destruct(struct sock *sk)
 {
-	if (sk->sk_protinfo)
-		kfree(sk->sk_protinfo);
+	kfree(sk->sk_protinfo);
 }
 
 void sk_send_sigurg(struct sock *sk)
--- linux-2.6.14-rc4-orig/net/core/dev_mcast.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/core/dev_mcast.c	2005-10-13 11:27:54.000000000 +0200
@@ -194,8 +194,7 @@ int dev_mc_add(struct net_device *dev, v
 
 done:
 	spin_unlock_bh(&dev->xmit_lock);
-	if (dmi1)
-		kfree(dmi1);
+	kfree(dmi1);
 	return err;
 }
 
--- linux-2.6.14-rc4-orig/net/ipv4/ipvs/ip_vs_app.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv4/ipvs/ip_vs_app.c	2005-10-13 11:28:10.000000000 +0200
@@ -110,8 +110,7 @@ ip_vs_app_inc_new(struct ip_vs_app *app,
 	return 0;
 
   out:
-	if (inc->timeout_table)
-		kfree(inc->timeout_table);
+	kfree(inc->timeout_table);
 	kfree(inc);
 	return ret;
 }
@@ -136,8 +135,7 @@ ip_vs_app_inc_release(struct ip_vs_app *
 
 	list_del(&inc->a_list);
 
-	if (inc->timeout_table != NULL)
-		kfree(inc->timeout_table);
+	kfree(inc->timeout_table);
 	kfree(inc);
 }
 
--- linux-2.6.14-rc4-orig/net/ipv4/ip_output.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv4/ip_output.c	2005-10-13 11:28:50.000000000 +0200
@@ -1189,10 +1189,8 @@ int ip_push_pending_frames(struct sock *
 
 out:
 	inet->cork.flags &= ~IPCORK_OPT;
-	if (inet->cork.opt) {
-		kfree(inet->cork.opt);
-		inet->cork.opt = NULL;
-	}
+	kfree(inet->cork.opt);
+	inet->cork.opt = NULL;
 	if (inet->cork.rt) {
 		ip_rt_put(inet->cork.rt);
 		inet->cork.rt = NULL;
@@ -1216,10 +1214,8 @@ void ip_flush_pending_frames(struct sock
 		kfree_skb(skb);
 
 	inet->cork.flags &= ~IPCORK_OPT;
-	if (inet->cork.opt) {
-		kfree(inet->cork.opt);
-		inet->cork.opt = NULL;
-	}
+	kfree(inet->cork.opt);
+	inet->cork.opt = NULL;
 	if (inet->cork.rt) {
 		ip_rt_put(inet->cork.rt);
 		inet->cork.rt = NULL;
--- linux-2.6.14-rc4-orig/net/ipv4/tcp_ipv4.c	2005-10-11 22:41:34.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv4/tcp_ipv4.c	2005-10-13 11:29:19.000000000 +0200
@@ -825,8 +825,7 @@ out:
  */
 static void tcp_v4_reqsk_destructor(struct request_sock *req)
 {
-	if (inet_rsk(req)->opt)
-		kfree(inet_rsk(req)->opt);
+	kfree(inet_rsk(req)->opt);
 }
 
 static inline void syn_flood_warning(struct sk_buff *skb)
--- linux-2.6.14-rc4-orig/net/ipv4/ip_sockglue.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv4/ip_sockglue.c	2005-10-13 11:29:53.000000000 +0200
@@ -202,8 +202,7 @@ int ip_ra_control(struct sock *sk, unsig
 		if (ra->sk == sk) {
 			if (on) {
 				write_unlock_bh(&ip_ra_lock);
-				if (new_ra)
-					kfree(new_ra);
+				kfree(new_ra);
 				return -EADDRINUSE;
 			}
 			*rap = ra->next;
@@ -446,8 +445,7 @@ int ip_setsockopt(struct sock *sk, int l
 #endif
 			}
 			opt = xchg(&inet->opt, opt);
-			if (opt)
-				kfree(opt);
+			kfree(opt);
 			break;
 		}
 		case IP_PKTINFO:
@@ -828,10 +826,8 @@ int ip_setsockopt(struct sock *sk, int l
 
 			err = ip_mc_msfilter(sk, msf, ifindex);
 mc_msf_out:
-			if (msf)
-				kfree(msf);
-			if (gsf)
-				kfree(gsf);
+			kfree(msf);
+			kfree(gsf);
 			break;
 		}
 		case IP_ROUTER_ALERT:	
--- linux-2.6.14-rc4-orig/net/ipv4/netfilter/ip_nat_snmp_basic.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv4/netfilter/ip_nat_snmp_basic.c	2005-10-13 11:31:09.000000000 +0200
@@ -1161,8 +1161,7 @@ static int snmp_parse_mangle(unsigned ch
 		
 		if (!snmp_object_decode(&ctx, obj)) {
 			if (*obj) {
-				if ((*obj)->id)
-					kfree((*obj)->id);
+				kfree((*obj)->id);
 				kfree(*obj);
 			}	
 			kfree(obj);
--- linux-2.6.14-rc4-orig/net/ipv4/multipath_wrandom.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv4/multipath_wrandom.c	2005-10-13 11:31:46.000000000 +0200
@@ -207,16 +207,12 @@ static void wrandom_select_route(const s
 			decision = mpc->rt;
 
 		last_power = mpc->power;
-		if (last_mpc)
-			kfree(last_mpc);
-
+		kfree(last_mpc);
 		last_mpc = mpc;
 	}
 
-	if (last_mpc) {
-		/* concurrent __multipath_flush may lead to !last_mpc */
-		kfree(last_mpc);
-	}
+	/* concurrent __multipath_flush may lead to !last_mpc */
+	kfree(last_mpc);
 
 	decision->u.dst.__use++;
 	*rp = decision;
--- linux-2.6.14-rc4-orig/net/ipv4/af_inet.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv4/af_inet.c	2005-10-13 11:31:54.000000000 +0200
@@ -147,8 +147,7 @@ void inet_sock_destruct(struct sock *sk)
 	BUG_TRAP(!sk->sk_wmem_queued);
 	BUG_TRAP(!sk->sk_forward_alloc);
 
-	if (inet->opt)
-		kfree(inet->opt);
+	kfree(inet->opt);
 	dst_release(sk->sk_dst_cache);
 	sk_refcnt_debug_dec(sk);
 }
--- linux-2.6.14-rc4-orig/net/ipv4/ip_options.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv4/ip_options.c	2005-10-13 11:32:07.000000000 +0200
@@ -510,8 +510,7 @@ static int ip_options_get_finish(struct 
 		kfree(opt);
 		return -EINVAL;
 	}
-	if (*optp)
-		kfree(*optp);
+	kfree(*optp);
 	*optp = opt;
 	return 0;
 }
--- linux-2.6.14-rc4-orig/net/ipv4/fib_frontend.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv4/fib_frontend.c	2005-10-13 11:32:16.000000000 +0200
@@ -266,8 +266,7 @@ int ip_rt_ioctl(unsigned int cmd, void _
 				if (tb)
 					err = tb->tb_insert(tb, &req.rtm, &rta, &req.nlh, NULL);
 			}
-			if (rta.rta_mx)
-				kfree(rta.rta_mx);
+			kfree(rta.rta_mx);
 		}
 		rtnl_unlock();
 		return err;
--- linux-2.6.14-rc4-orig/net/ipv6/ipv6_sockglue.c	2005-10-11 22:41:34.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv6/ipv6_sockglue.c	2005-10-13 11:32:36.000000000 +0200
@@ -80,8 +80,7 @@ int ip6_ra_control(struct sock *sk, int 
 		if (ra->sk == sk) {
 			if (sel>=0) {
 				write_unlock_bh(&ip6_ra_lock);
-				if (new_ra)
-					kfree(new_ra);
+				kfree(new_ra);
 				return -EADDRINUSE;
 			}
 
--- linux-2.6.14-rc4-orig/net/ipv6/addrconf.c	2005-10-11 22:41:34.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv6/addrconf.c	2005-10-13 11:33:03.000000000 +0200
@@ -2954,8 +2954,7 @@ static int inet6_fill_ifinfo(struct sk_b
 
 nlmsg_failure:
 rtattr_failure:
-	if (array)
-		kfree(array);
+	kfree(array);
 	skb_trim(skb, b - skb->data);
 	return -1;
 }
--- linux-2.6.14-rc4-orig/net/ipv6/ipcomp6.c	2005-10-11 22:41:34.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv6/ipcomp6.c	2005-10-13 11:33:13.000000000 +0200
@@ -130,8 +130,7 @@ static int ipcomp6_input(struct xfrm_sta
 out_put_cpu:
 	put_cpu();
 out:
-	if (tmp_hdr)
-		kfree(tmp_hdr);
+	kfree(tmp_hdr);
 	if (err)
 		goto error_out;
 	return nexthdr;
--- linux-2.6.14-rc4-orig/net/ipv6/ip6_output.c	2005-10-11 22:41:34.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv6/ip6_output.c	2005-10-13 11:33:50.000000000 +0200
@@ -586,8 +586,7 @@ static int ip6_fragment(struct sk_buff *
 			skb->next = NULL;
 		}
 
-		if (tmp_hdr)
-			kfree(tmp_hdr);
+		kfree(tmp_hdr);
 
 		if (err == 0) {
 			IP6_INC_STATS(IPSTATS_MIB_FRAGOKS);
@@ -1117,10 +1116,8 @@ int ip6_push_pending_frames(struct sock 
 
 out:
 	inet->cork.flags &= ~IPCORK_OPT;
-	if (np->cork.opt) {
-		kfree(np->cork.opt);
-		np->cork.opt = NULL;
-	}
+	kfree(np->cork.opt);
+	np->cork.opt = NULL;
 	if (np->cork.rt) {
 		dst_release(&np->cork.rt->u.dst);
 		np->cork.rt = NULL;
@@ -1145,10 +1142,8 @@ void ip6_flush_pending_frames(struct soc
 
 	inet->cork.flags &= ~IPCORK_OPT;
 
-	if (np->cork.opt) {
-		kfree(np->cork.opt);
-		np->cork.opt = NULL;
-	}
+	kfree(np->cork.opt);
+	np->cork.opt = NULL;
 	if (np->cork.rt) {
 		dst_release(&np->cork.rt->u.dst);
 		np->cork.rt = NULL;
--- linux-2.6.14-rc4-orig/net/ipv6/ip6_tunnel.c	2005-10-11 22:41:34.000000000 +0200
+++ linux-2.6.14-rc4/net/ipv6/ip6_tunnel.c	2005-10-13 11:34:06.000000000 +0200
@@ -756,8 +756,7 @@ ip6ip6_tnl_xmit(struct sk_buff *skb, str
 	}
 	ip6_tnl_dst_store(t, dst);
 
-	if (opt)
-		kfree(opt);
+	kfree(opt);
 
 	t->recursion--;
 	return 0;
@@ -766,8 +765,7 @@ tx_err_link_failure:
 	dst_link_failure(skb);
 tx_err_dst_release:
 	dst_release(dst);
-	if (opt)
-		kfree(opt);
+	kfree(opt);
 tx_err:
 	stats->tx_errors++;
 	stats->tx_dropped++;
--- linux-2.6.14-rc4-orig/net/irda/discovery.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/irda/discovery.c	2005-10-13 11:34:26.000000000 +0200
@@ -194,8 +194,7 @@ void irlmp_expire_discoveries(hashbin_t 
 
 			/* Remove it from the log */
 			curr = hashbin_remove_this(log, (irda_queue_t *) curr);
-			if (curr)
-				kfree(curr);
+			kfree(curr);
 		}
 	}
 
--- linux-2.6.14-rc4-orig/net/irda/irias_object.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/irda/irias_object.c	2005-10-13 11:35:29.000000000 +0200
@@ -122,8 +122,7 @@ static void __irias_delete_attrib(struct
 	IRDA_ASSERT(attrib != NULL, return;);
 	IRDA_ASSERT(attrib->magic == IAS_ATTRIB_MAGIC, return;);
 
-	if (attrib->name)
-		kfree(attrib->name);
+	kfree(attrib->name);
 
 	irias_delete_value(attrib->value);
 	attrib->magic = ~IAS_ATTRIB_MAGIC;
@@ -136,8 +135,7 @@ void __irias_delete_object(struct ias_ob
 	IRDA_ASSERT(obj != NULL, return;);
 	IRDA_ASSERT(obj->magic == IAS_OBJECT_MAGIC, return;);
 
-	if (obj->name)
-		kfree(obj->name);
+	kfree(obj->name);
 
 	hashbin_delete(obj->attribs, (FREE_FUNC) __irias_delete_attrib);
 
@@ -562,14 +560,12 @@ void irias_delete_value(struct ias_value
 		/* No need to deallocate */
 		break;
 	case IAS_STRING:
-		/* If string, deallocate string */
-		if (value->t.string != NULL)
-			kfree(value->t.string);
+		/* Deallocate string */
+		kfree(value->t.string);
 		break;
 	case IAS_OCT_SEQ:
-		/* If byte stream, deallocate byte stream */
-		 if (value->t.oct_seq != NULL)
-			 kfree(value->t.oct_seq);
+		/* Deallocate byte stream */
+		 kfree(value->t.oct_seq);
 		 break;
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown value type!\n", __FUNCTION__);
--- linux-2.6.14-rc4-orig/net/sctp/sm_make_chunk.c	2005-10-11 22:41:35.000000000 +0200
+++ linux-2.6.14-rc4/net/sctp/sm_make_chunk.c	2005-10-13 11:35:50.000000000 +0200
@@ -254,8 +254,7 @@ struct sctp_chunk *sctp_make_init(const 
 	aiparam.adaption_ind = htonl(sp->adaption_ind);
 	sctp_addto_chunk(retval, sizeof(aiparam), &aiparam);
 nodata:
-	if (addrs.v)
-		kfree(addrs.v);
+	kfree(addrs.v);
 	return retval;
 }
 
@@ -347,8 +346,7 @@ struct sctp_chunk *sctp_make_init_ack(co
 nomem_chunk:
 	kfree(cookie);
 nomem_cookie:
-	if (addrs.v)
-		kfree(addrs.v);
+	kfree(addrs.v);
 	return retval;
 }
 
--- linux-2.6.14-rc4-orig/net/sctp/associola.c	2005-10-11 22:41:35.000000000 +0200
+++ linux-2.6.14-rc4/net/sctp/associola.c	2005-10-13 11:36:05.000000000 +0200
@@ -344,9 +344,7 @@ void sctp_association_free(struct sctp_a
 	}
 
 	/* Free peer's cached cookie. */
-	if (asoc->peer.cookie) {
-		kfree(asoc->peer.cookie);
-	}
+	kfree(asoc->peer.cookie);
 
 	/* Release the transport structures. */
 	list_for_each_safe(pos, temp, &asoc->peer.transport_addr_list) {
--- linux-2.6.14-rc4-orig/net/rose/rose_route.c	2005-10-11 22:41:34.000000000 +0200
+++ linux-2.6.14-rc4/net/rose/rose_route.c	2005-10-13 11:36:35.000000000 +0200
@@ -240,8 +240,7 @@ static void rose_remove_neigh(struct ros
 	if ((s = rose_neigh_list) == rose_neigh) {
 		rose_neigh_list = rose_neigh->next;
 		spin_unlock_bh(&rose_neigh_list_lock);
-		if (rose_neigh->digipeat != NULL)
-			kfree(rose_neigh->digipeat);
+		kfree(rose_neigh->digipeat);
 		kfree(rose_neigh);
 		return;
 	}
@@ -250,8 +249,7 @@ static void rose_remove_neigh(struct ros
 		if (s->next == rose_neigh) {
 			s->next = rose_neigh->next;
 			spin_unlock_bh(&rose_neigh_list_lock);
-			if (rose_neigh->digipeat != NULL)
-				kfree(rose_neigh->digipeat);
+			kfree(rose_neigh->digipeat);
 			kfree(rose_neigh);
 			return;
 		}
--- linux-2.6.14-rc4-orig/net/xfrm/xfrm_state.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/xfrm/xfrm_state.c	2005-10-13 11:36:55.000000000 +0200
@@ -62,14 +62,10 @@ static void xfrm_state_gc_destroy(struct
 {
 	if (del_timer(&x->timer))
 		BUG();
-	if (x->aalg)
-		kfree(x->aalg);
-	if (x->ealg)
-		kfree(x->ealg);
-	if (x->calg)
-		kfree(x->calg);
-	if (x->encap)
-		kfree(x->encap);
+	kfree(x->aalg);
+	kfree(x->ealg);
+	kfree(x->calg);
+	kfree(x->encap);
 	if (x->type) {
 		x->type->destructor(x);
 		xfrm_put_type(x->type);
--- linux-2.6.14-rc4-orig/net/sched/cls_tcindex.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sched/cls_tcindex.c	2005-10-13 11:37:16.000000000 +0200
@@ -194,8 +194,7 @@ found:
 	}
 	tcf_unbind_filter(tp, &r->res);
 	tcf_exts_destroy(tp, &r->exts);
-	if (f)
-		kfree(f);
+	kfree(f);
 	return 0;
 }
 
@@ -442,10 +441,8 @@ static void tcindex_destroy(struct tcf_p
 	walker.skip = 0;
 	walker.fn = &tcindex_destroy_element;
 	tcindex_walk(tp,&walker);
-	if (p->perfect)
-		kfree(p->perfect);
-	if (p->h)
-		kfree(p->h);
+	kfree(p->perfect);
+	kfree(p->h);
 	kfree(p);
 	tp->root = NULL;
 }
--- linux-2.6.14-rc4-orig/net/sched/sch_gred.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sched/sch_gred.c	2005-10-13 11:37:41.000000000 +0200
@@ -580,8 +580,7 @@ static int gred_dump(struct Qdisc *sch, 
 	return skb->len;
 
 rtattr_failure:
-	if (opt)
-		kfree(opt);
+	kfree(opt);
 	DPRINTK("gred_dump: FAILURE!!!!\n");
 
 /* also free the opt struct here */
@@ -594,10 +593,8 @@ static void gred_destroy(struct Qdisc *s
 	struct gred_sched *table = qdisc_priv(sch);
 	int i;
 
-	for (i = 0;i < table->DPs; i++) {
-		if (table->tab[i])
-			kfree(table->tab[i]);
-	}
+	for (i = 0;i < table->DPs; i++)
+		kfree(table->tab[i]);
 }
 
 static struct Qdisc_ops gred_qdisc_ops = {
--- linux-2.6.14-rc4-orig/net/sched/em_meta.c	2005-10-11 22:41:34.000000000 +0200
+++ linux-2.6.14-rc4/net/sched/em_meta.c	2005-10-13 11:38:28.000000000 +0200
@@ -561,8 +561,7 @@ static int meta_var_change(struct meta_v
 
 static void meta_var_destroy(struct meta_value *v)
 {
-	if (v->val)
-		kfree((void *) v->val);
+	kfree((void *) v->val);
 }
 
 static void meta_var_apply_extras(struct meta_value *v,
--- linux-2.6.14-rc4-orig/net/sched/cls_u32.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sched/cls_u32.c	2005-10-13 11:39:35.000000000 +0200
@@ -347,7 +347,7 @@ static int u32_destroy_key(struct tcf_pr
 	if (n->ht_down)
 		n->ht_down->refcnt--;
 #ifdef CONFIG_CLS_U32_PERF
-	if (n && (NULL != n->pf))
+	if (n)
 		kfree(n->pf);
 #endif
 	kfree(n);
@@ -680,7 +680,7 @@ static int u32_change(struct tcf_proto *
 		return 0;
 	}
 #ifdef CONFIG_CLS_U32_PERF
-	if (n && (NULL != n->pf))
+	if (n)
 		kfree(n->pf);
 #endif
 	kfree(n);
--- linux-2.6.14-rc4-orig/net/sched/cls_fw.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sched/cls_fw.c	2005-10-13 11:39:47.000000000 +0200
@@ -298,8 +298,7 @@ static int fw_change(struct tcf_proto *t
 	return 0;
 
 errout:
-	if (f)
-		kfree(f);
+	kfree(f);
 	return err;
 }
 
--- linux-2.6.14-rc4-orig/net/sched/cls_rsvp.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sched/cls_rsvp.h	2005-10-13 11:39:57.000000000 +0200
@@ -555,8 +555,7 @@ insert:
 	goto insert;
 
 errout:
-	if (f)
-		kfree(f);
+	kfree(f);
 errout2:
 	tcf_exts_destroy(tp, &e);
 	return err;
--- linux-2.6.14-rc4-orig/net/sched/cls_route.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sched/cls_route.c	2005-10-13 11:40:07.000000000 +0200
@@ -525,8 +525,7 @@ reinsert:
 	return 0;
 
 errout:
-	if (f)
-		kfree(f);
+	kfree(f);
 	return err;
 }
 
--- linux-2.6.14-rc4-orig/net/ethernet/pe2.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/ethernet/pe2.c	2005-10-13 11:40:15.000000000 +0200
@@ -32,8 +32,7 @@ struct datalink_proto *make_EII_client(v
 
 void destroy_EII_client(struct datalink_proto *dl)
 {
-	if (dl)
-		kfree(dl);
+	kfree(dl);
 }
 
 EXPORT_SYMBOL(destroy_EII_client);
--- linux-2.6.14-rc4-orig/net/decnet/dn_table.c	2005-10-11 22:41:33.000000000 +0200
+++ linux-2.6.14-rc4/net/decnet/dn_table.c	2005-10-13 11:41:34.000000000 +0200
@@ -784,16 +784,14 @@ struct dn_fib_table *dn_fib_get_table(in
 
 static void dn_fib_del_tree(int n)
 {
-        struct dn_fib_table *t;
+	struct dn_fib_table *t;
 
-        write_lock(&dn_fib_tables_lock);
-        t = dn_fib_tables[n];
-        dn_fib_tables[n] = NULL;
-        write_unlock(&dn_fib_tables_lock);
-
-        if (t) {
-                kfree(t);
-        }
+	write_lock(&dn_fib_tables_lock);
+	t = dn_fib_tables[n];
+	dn_fib_tables[n] = NULL;
+	write_unlock(&dn_fib_tables_lock);
+
+	kfree(t);
 }
 
 struct dn_fib_table *dn_fib_empty_table(void)
--- linux-2.6.14-rc4-orig/net/wanrouter/wanmain.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/wanrouter/wanmain.c	2005-10-13 11:42:22.000000000 +0200
@@ -714,10 +714,8 @@ static int wanrouter_device_new_if(struc
 	}
 
 	/* This code has moved from del_if() function */
-	if (dev->priv) {
-		kfree(dev->priv);
-		dev->priv = NULL;
-	}
+	kfree(dev->priv);
+	dev->priv = NULL;
 
 #ifdef CONFIG_WANPIPE_MULTPPP
 	if (cnf->config_id == WANCONFIG_MPPP)
@@ -851,10 +849,8 @@ static int wanrouter_delete_interface(st
 
 	/* Due to new interface linking method using dev->priv,
 	 * this code has moved from del_if() function.*/
-	if (dev->priv){
-		kfree(dev->priv);
-		dev->priv=NULL;
-	}
+	kfree(dev->priv);
+	dev->priv=NULL;
 
 	unregister_netdev(dev);
 
--- linux-2.6.14-rc4-orig/net/wanrouter/af_wanpipe.c	2005-10-11 22:41:35.000000000 +0200
+++ linux-2.6.14-rc4/net/wanrouter/af_wanpipe.c	2005-10-13 11:43:14.000000000 +0200
@@ -1099,7 +1099,7 @@ static void release_driver(struct sock *
 	sock_reset_flag(sk, SOCK_ZAPPED);
 	wp = wp_sk(sk);
 
-	if (wp && wp->mbox) {
+	if (wp) {
 		kfree(wp->mbox);
 		wp->mbox = NULL;
 	}
@@ -1186,10 +1186,8 @@ static void wanpipe_kill_sock_timer (uns
 		return;
 	}
 
-	if (wp_sk(sk)) {
-		kfree(wp_sk(sk));
-		wp_sk(sk) = NULL;
-	}
+	kfree(wp_sk(sk));
+	wp_sk(sk) = NULL;
 
 	if (atomic_read(&sk->sk_refcnt) != 1) {
 		atomic_set(&sk->sk_refcnt, 1);
@@ -1219,10 +1217,8 @@ static void wanpipe_kill_sock_accept (st
 	sk->sk_socket = NULL;
 
 
-	if (wp_sk(sk)) {
-		kfree(wp_sk(sk));
-		wp_sk(sk) = NULL;
-	}
+	kfree(wp_sk(sk));
+	wp_sk(sk) = NULL;
 
 	if (atomic_read(&sk->sk_refcnt) != 1) {
 		atomic_set(&sk->sk_refcnt, 1);
@@ -1243,10 +1239,8 @@ static void wanpipe_kill_sock_irq (struc
 
 	sk->sk_socket = NULL;
 
-	if (wp_sk(sk)) {
-		kfree(wp_sk(sk));
-		wp_sk(sk) = NULL;
-	}
+	kfree(wp_sk(sk));
+	wp_sk(sk) = NULL;
 
 	if (atomic_read(&sk->sk_refcnt) != 1) {
 		atomic_set(&sk->sk_refcnt, 1);
--- linux-2.6.14-rc4-orig/net/sunrpc/svc.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sunrpc/svc.c	2005-10-13 11:45:43.000000000 +0200
@@ -196,12 +196,9 @@ svc_exit_thread(struct svc_rqst *rqstp)
 	struct svc_serv	*serv = rqstp->rq_server;
 
 	svc_release_buffer(rqstp);
-	if (rqstp->rq_resp)
-		kfree(rqstp->rq_resp);
-	if (rqstp->rq_argp)
-		kfree(rqstp->rq_argp);
-	if (rqstp->rq_auth_data)
-		kfree(rqstp->rq_auth_data);
+	kfree(rqstp->rq_resp);
+	kfree(rqstp->rq_argp);
+	kfree(rqstp->rq_auth_data);
 	kfree(rqstp);
 
 	/* Release the server */
--- linux-2.6.14-rc4-orig/net/sunrpc/xdr.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sunrpc/xdr.c	2005-10-13 11:46:15.000000000 +0200
@@ -1167,8 +1167,7 @@ xdr_xcode_array2(struct xdr_buf *buf, un
 	err = 0;
 
 out:
-	if (elem)
-		kfree(elem);
+	kfree(elem);
 	if (ppages)
 		kunmap(*ppages);
 	return err;
--- linux-2.6.14-rc4-orig/net/sunrpc/auth_gss/gss_mech_switch.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sunrpc/auth_gss/gss_mech_switch.c	2005-10-13 11:46:26.000000000 +0200
@@ -61,8 +61,7 @@ gss_mech_free(struct gss_api_mech *gm)
 
 	for (i = 0; i < gm->gm_pf_num; i++) {
 		pf = &gm->gm_pfs[i];
-		if (pf->auth_domain_name)
-			kfree(pf->auth_domain_name);
+		kfree(pf->auth_domain_name);
 		pf->auth_domain_name = NULL;
 	}
 }
--- linux-2.6.14-rc4-orig/net/sunrpc/auth_gss/gss_spkm3_seal.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sunrpc/auth_gss/gss_spkm3_seal.c	2005-10-13 11:46:33.000000000 +0200
@@ -124,8 +124,7 @@ spkm3_make_token(struct spkm3_ctx *ctx, 
 
 	return  GSS_S_COMPLETE;
 out_err:
-	if (md5cksum.data) 
-		kfree(md5cksum.data);
+	kfree(md5cksum.data);
 	token->data = NULL;
 	token->len = 0;
 	return GSS_S_FAILURE;
--- linux-2.6.14-rc4-orig/net/sunrpc/auth_gss/gss_krb5_seal.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sunrpc/auth_gss/gss_krb5_seal.c	2005-10-13 11:46:51.000000000 +0200
@@ -171,6 +171,6 @@ krb5_make_token(struct krb5_ctx *ctx, in
 
 	return ((ctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE);
 out_err:
-	if (md5cksum.data) kfree(md5cksum.data);
+	kfree(md5cksum.data);
 	return GSS_S_FAILURE;
 }
--- linux-2.6.14-rc4-orig/net/sunrpc/auth_gss/gss_spkm3_token.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sunrpc/auth_gss/gss_spkm3_token.c	2005-10-13 11:47:01.000000000 +0200
@@ -259,8 +259,7 @@ spkm3_verify_mic_token(unsigned char **t
 
 	ret = GSS_S_COMPLETE;
 out:
-	if (spkm3_ctx_id.data)
-		kfree(spkm3_ctx_id.data);
+	kfree(spkm3_ctx_id.data);
 	return ret;
 }
 
--- linux-2.6.14-rc4-orig/net/sunrpc/auth_gss/gss_spkm3_unseal.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sunrpc/auth_gss/gss_spkm3_unseal.c	2005-10-13 11:47:12.000000000 +0200
@@ -120,9 +120,7 @@ spkm3_read_token(struct spkm3_ctx *ctx,
 	/* XXX: need to add expiration and sequencing */
 	ret = GSS_S_COMPLETE;
 out:
-	if (md5cksum.data) 
-		kfree(md5cksum.data);
-	if (wire_cksum.data) 
-		kfree(wire_cksum.data);
+	kfree(md5cksum.data);
+	kfree(wire_cksum.data);
 	return ret;
 }
--- linux-2.6.14-rc4-orig/net/sunrpc/auth_gss/gss_krb5_unseal.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/sunrpc/auth_gss/gss_krb5_unseal.c	2005-10-13 11:47:19.000000000 +0200
@@ -197,6 +197,6 @@ krb5_read_token(struct krb5_ctx *ctx,
 
 	ret = GSS_S_COMPLETE;
 out:
-	if (md5cksum.data) kfree(md5cksum.data);
+	kfree(md5cksum.data);
 	return ret;
 }
--- linux-2.6.14-rc4-orig/net/bluetooth/hidp/core.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/net/bluetooth/hidp/core.c	2005-10-13 11:47:49.000000000 +0200
@@ -657,9 +657,7 @@ unlink:
 failed:
 	up_write(&hidp_session_sem);
 
-	if (session->input)
-		kfree(session->input);
-
+	kfree(session->input);
 	kfree(session);
 	return err;
 }


