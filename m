Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSFTFzo>; Thu, 20 Jun 2002 01:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSFTFzn>; Thu, 20 Jun 2002 01:55:43 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:40924 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S314529AbSFTFzf>;
	Thu, 20 Jun 2002 01:55:35 -0400
Date: Thu, 20 Jun 2002 15:51:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>, davem@redhat.com,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi
Subject: [PATCH] ipv6 statics
Message-Id: <20020620155126.1bf955f3.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch make some things in the ipv6 code static.  Some of them
may be wrong (or for futures) bu it looks pretty OK to me (and it builds).
Please check and apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.23/include/net/ip6_route.h
2.5.23-sfr.4/include/net/ip6_route.h
--- 2.5.23/include/net/ip6_route.h	Wed Feb 20 14:13:24 2002
+++ 2.5.23-sfr.4/include/net/ip6_route.h	Thu Jun 20 15:41:34 2002
@@ -23,9 +23,6 @@
 
 extern struct rt6_info	ip6_null_entry;
 
-extern int ip6_rt_max_size;
-extern int ip6_rt_gc_min;
-extern int ip6_rt_gc_timeout;
 extern int ip6_rt_gc_interval;
 
 extern void			ip6_route_input(struct sk_buff *skb);
diff -ruN 2.5.23/net/ipv6/addrconf.c 2.5.23-sfr.4/net/ipv6/addrconf.c
--- 2.5.23/net/ipv6/addrconf.c	Fri May  3 11:12:24 2002
+++ 2.5.23-sfr.4/net/ipv6/addrconf.c	Thu Jun 20 14:20:28 2002
@@ -90,7 +90,7 @@
 /* Protects inet6 devices */
 rwlock_t addrconf_lock = RW_LOCK_UNLOCKED;
 
-void addrconf_verify(unsigned long);
+static void addrconf_verify(unsigned long);
 
 static struct timer_list addr_chk_timer = { function: addrconf_verify };
 
@@ -588,7 +588,7 @@
 	return err;
 }
 
-int ipv6_count_addresses(struct inet6_dev *idev)
+static int ipv6_count_addresses(struct inet6_dev *idev)
 {
 	int cnt = 0;
 	struct inet6_ifaddr *ifp;
@@ -1613,7 +1613,7 @@
  *	Periodic address status verification
  */
 
-void addrconf_verify(unsigned long foo)
+static void addrconf_verify(unsigned long foo)
 {
 	struct inet6_ifaddr *ifp;
 	unsigned long now = jiffies;
diff -ruN 2.5.23/net/ipv6/af_inet6.c 2.5.23-sfr.4/net/ipv6/af_inet6.c
--- 2.5.23/net/ipv6/af_inet6.c	Tue Mar 19 08:13:09 2002
+++ 2.5.23-sfr.4/net/ipv6/af_inet6.c	Thu Jun 20 15:02:14 2002
@@ -547,7 +547,7 @@
 	sendpage:	sock_no_sendpage,
 };
 
-struct net_proto_family inet6_family_ops = {
+static struct net_proto_family inet6_family_ops = {
 	family:	PF_INET6,
 	create:	inet6_create,
 };
diff -ruN 2.5.23/net/ipv6/exthdrs.c 2.5.23-sfr.4/net/ipv6/exthdrs.c
--- 2.5.23/net/ipv6/exthdrs.c	Thu Jun 21 14:00:55 2001
+++ 2.5.23-sfr.4/net/ipv6/exthdrs.c	Thu Jun 20 15:21:47 2002
@@ -77,7 +77,7 @@
 
 /* An unknown option is detected, decide what to do */
 
-int ip6_tlvopt_unknown(struct sk_buff *skb, int optoff)
+static int ip6_tlvopt_unknown(struct sk_buff *skb, int optoff)
 {
 	switch ((skb->nh.raw[optoff] & 0xC0) >> 6) {
 	case 0: /* ignore */
@@ -159,7 +159,7 @@
   Destination options header.
  *****************************/
 
-struct tlvtype_proc tlvprocdestopt_lst[] = {
+static struct tlvtype_proc tlvprocdestopt_lst[] = {
 	/* No destination options are defined now */
 	{-1,			NULL}
 };
@@ -425,7 +425,7 @@
    generate error.
  */
 
-struct hdrtype_proc hdrproc_lst[] = {
+static struct hdrtype_proc hdrproc_lst[] = {
 	{NEXTHDR_FRAGMENT,	ipv6_reassembly},
 	{NEXTHDR_ROUTING,	ipv6_routing_header},
 	{NEXTHDR_DEST,		ipv6_dest_opt},
@@ -512,7 +512,7 @@
 	return 0;
 }
 
-struct tlvtype_proc tlvprochopopt_lst[] = {
+static struct tlvtype_proc tlvprochopopt_lst[] = {
 	{IPV6_TLV_ROUTERALERT,	ipv6_hop_ra},
 	{IPV6_TLV_JUMBO,	ipv6_hop_jumbo},
 	{-1,			NULL}
@@ -536,7 +536,7 @@
  *	for headers.
  */
 
-u8 *ipv6_build_rthdr(struct sk_buff *skb, u8 *prev_hdr,
+static u8 *ipv6_build_rthdr(struct sk_buff *skb, u8 *prev_hdr,
 		     struct ipv6_rt_hdr *opt, struct in6_addr *addr)
 {
 	struct rt0_hdr *phdr, *ihdr;
diff -ruN 2.5.23/net/ipv6/icmp.c 2.5.23-sfr.4/net/ipv6/icmp.c
--- 2.5.23/net/ipv6/icmp.c	Wed Feb 20 14:13:27 2002
+++ 2.5.23-sfr.4/net/ipv6/icmp.c	Thu Jun 20 14:56:59 2002
@@ -68,7 +68,7 @@
 
 struct socket *icmpv6_socket;
 
-int icmpv6_rcv(struct sk_buff *skb);
+static int icmpv6_rcv(struct sk_buff *skb);
 
 static struct inet6_protocol icmpv6_protocol = 
 {
@@ -204,7 +204,7 @@
 	return 0;
 }
 
-int sysctl_icmpv6_time = 1*HZ; 
+static int sysctl_icmpv6_time = 1*HZ; 
 
 /* 
  * Check the ICMP output rate limit 
@@ -491,7 +491,7 @@
  *	Handle icmp messages
  */
 
-int icmpv6_rcv(struct sk_buff *skb)
+static int icmpv6_rcv(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
 	struct in6_addr *saddr, *daddr;
diff -ruN 2.5.23/net/ipv6/ipv6_sockglue.c
2.5.23-sfr.4/net/ipv6/ipv6_sockglue.c
--- 2.5.23/net/ipv6/ipv6_sockglue.c	Tue Mar 19 08:13:09 2002
+++ 2.5.23-sfr.4/net/ipv6/ipv6_sockglue.c	Thu Jun 20 15:23:39 2002
@@ -53,7 +53,7 @@
 
 struct ipv6_mib ipv6_statistics[NR_CPUS*2];
 
-struct packet_type ipv6_packet_type =
+static struct packet_type ipv6_packet_type =
 {
 	__constant_htons(ETH_P_IPV6), 
 	NULL,					/* All devices */
diff -ruN 2.5.23/net/ipv6/mcast.c 2.5.23-sfr.4/net/ipv6/mcast.c
--- 2.5.23/net/ipv6/mcast.c	Sat May 25 21:20:19 2002
+++ 2.5.23-sfr.4/net/ipv6/mcast.c	Thu Jun 20 14:26:25 2002
@@ -65,7 +65,7 @@
 
 static void igmp6_join_group(struct ifmcaddr6 *ma);
 static void igmp6_leave_group(struct ifmcaddr6 *ma);
-void igmp6_timer_handler(unsigned long data);
+static void igmp6_timer_handler(unsigned long data);
 
 #define IGMP6_UNSOLICITED_IVAL	(10*HZ)
 
@@ -492,7 +492,7 @@
 	return 0;
 }
 
-void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
+static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int
type)
 {
 	struct sock *sk = igmp6_socket->sk;
         struct sk_buff *skb;
@@ -608,7 +608,7 @@
 	spin_unlock_bh(&ma->mca_lock);
 }
 
-void igmp6_timer_handler(unsigned long data)
+static void igmp6_timer_handler(unsigned long data)
 {
 	struct ifmcaddr6 *ma = (struct ifmcaddr6 *) data;
 
diff -ruN 2.5.23/net/ipv6/ndisc.c 2.5.23-sfr.4/net/ipv6/ndisc.c
--- 2.5.23/net/ipv6/ndisc.c	Mon Apr 15 06:13:31 2002
+++ 2.5.23-sfr.4/net/ipv6/ndisc.c	Thu Jun 20 14:27:56 2002
@@ -312,7 +312,7 @@
  *	Send a Neighbour Advertisement
  */
 
-void ndisc_send_na(struct net_device *dev, struct neighbour *neigh,
+static void ndisc_send_na(struct net_device *dev, struct neighbour
*neigh,
 		   struct in6_addr *daddr, struct in6_addr *solicited_addr,
 		   int router, int solicited, int override, int inc_opt) 
 {
diff -ruN 2.5.23/net/ipv6/proc.c 2.5.23-sfr.4/net/ipv6/proc.c
--- 2.5.23/net/ipv6/proc.c	Wed Jun 19 12:41:51 2002
+++ 2.5.23-sfr.4/net/ipv6/proc.c	Thu Jun 20 15:10:58 2002
@@ -56,7 +56,7 @@
 }
 
 
-struct snmp6_item
+static struct snmp6_item
 {
 	char *name;
 	unsigned long *ptr;
diff -ruN 2.5.23/net/ipv6/raw.c 2.5.23-sfr.4/net/ipv6/raw.c
--- 2.5.23/net/ipv6/raw.c	Sun Jun  9 16:12:34 2002
+++ 2.5.23-sfr.4/net/ipv6/raw.c	Thu Jun 20 15:08:20 2002
@@ -354,7 +354,7 @@
  *	we return it, otherwise we block.
  */
 
-int rawv6_recvmsg(struct sock *sk, struct msghdr *msg, int len,
+static int rawv6_recvmsg(struct sock *sk, struct msghdr *msg, int len,
 		  int noblock, int flags, int *addr_len)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
diff -ruN 2.5.23/net/ipv6/reassembly.c 2.5.23-sfr.4/net/ipv6/reassembly.c
--- 2.5.23/net/ipv6/reassembly.c	Sat May 25 21:20:20 2002
+++ 2.5.23-sfr.4/net/ipv6/reassembly.c	Thu Jun 20 15:17:01 2002
@@ -46,10 +46,10 @@
 #include <net/ndisc.h>
 #include <net/addrconf.h>
 
-int sysctl_ip6frag_high_thresh = 256*1024;
-int sysctl_ip6frag_low_thresh = 192*1024;
+static int sysctl_ip6frag_high_thresh = 256*1024;
+static int sysctl_ip6frag_low_thresh = 192*1024;
 
-int sysctl_ip6frag_time = IPV6_FRAG_TIMEOUT;
+static int sysctl_ip6frag_time = IPV6_FRAG_TIMEOUT;
 
 struct ip6frag_skb_cb
 {
diff -ruN 2.5.23/net/ipv6/route.c 2.5.23-sfr.4/net/ipv6/route.c
--- 2.5.23/net/ipv6/route.c	Thu Jan 31 07:12:51 2002
+++ 2.5.23-sfr.4/net/ipv6/route.c	Thu Jun 20 14:36:34 2002
@@ -59,13 +59,13 @@
 #endif
 
 
-int ip6_rt_max_size = 4096;
-int ip6_rt_gc_min_interval = 5*HZ;
-int ip6_rt_gc_timeout = 60*HZ;
+static int ip6_rt_max_size = 4096;
+static int ip6_rt_gc_min_interval = 5*HZ;
+static int ip6_rt_gc_timeout = 60*HZ;
 int ip6_rt_gc_interval = 30*HZ;
-int ip6_rt_gc_elasticity = 9;
-int ip6_rt_mtu_expires = 10*60*HZ;
-int ip6_rt_min_advmss = IPV6_MIN_MTU - 20 - 40;
+static int ip6_rt_gc_elasticity = 9;
+static int ip6_rt_mtu_expires = 10*60*HZ;
+static int ip6_rt_min_advmss = IPV6_MIN_MTU - 20 - 40;
 
 static struct rt6_info * ip6_rt_copy(struct rt6_info *ort);
 static struct dst_entry	*ip6_dst_check(struct dst_entry *dst, u32 cookie);
@@ -77,7 +77,7 @@
 static int		ip6_pkt_discard(struct sk_buff *skb);
 static void		ip6_link_failure(struct sk_buff *skb);
 
-struct dst_ops ip6_dst_ops = {
+static struct dst_ops ip6_dst_ops = {
 	AF_INET6,
 	__constant_htons(ETH_P_IPV6),
 	1024,
@@ -820,7 +820,7 @@
 	return err;
 }
 
-int ip6_route_del(struct in6_rtmsg *rtmsg)
+static int ip6_route_del(struct in6_rtmsg *rtmsg)
 {
 	struct fib6_node *fn;
 	struct rt6_info *rt;
diff -ruN 2.5.23/net/ipv6/sit.c 2.5.23-sfr.4/net/ipv6/sit.c
--- 2.5.23/net/ipv6/sit.c	Fri May  3 11:12:24 2002
+++ 2.5.23-sfr.4/net/ipv6/sit.c	Thu Jun 20 14:23:30 2002
@@ -146,7 +146,7 @@
 	*tp = t;
 }
 
-struct ip_tunnel * ipip6_tunnel_locate(struct ip_tunnel_parm *parms, int
create)
+static struct ip_tunnel * ipip6_tunnel_locate(struct ip_tunnel_parm
*parms, int create)
 {
 	u32 remote = parms->iph.daddr;
 	u32 local = parms->iph.saddr;
@@ -231,7 +231,7 @@
 }
 
 
-void ipip6_err(struct sk_buff *skb, u32 info)
+static void ipip6_err(struct sk_buff *skb, u32 info)
 {
 #ifndef I_WISH_WORLD_WERE_PERFECT
 
@@ -381,7 +381,7 @@
 		IP6_ECN_set_ce(skb->nh.ipv6h);
 }
 
-int ipip6_rcv(struct sk_buff *skb)
+static int ipip6_rcv(struct sk_buff *skb)
 {
 	struct iphdr *iph;
 	struct ip_tunnel *tunnel;
diff -ruN 2.5.23/net/ipv6/sysctl_net_ipv6.c
2.5.23-sfr.4/net/ipv6/sysctl_net_ipv6.c
--- 2.5.23/net/ipv6/sysctl_net_ipv6.c	Mon Mar  2 09:40:42 1998
+++ 2.5.23-sfr.4/net/ipv6/sysctl_net_ipv6.c	Thu Jun 20 14:41:36 2002
@@ -22,17 +22,14 @@
 
 #ifdef MODULE
 static struct ctl_table_header *ipv6_sysctl_header;
-static struct ctl_table ipv6_root_table[];
-static struct ctl_table ipv6_net_table[];
 
-
-ctl_table ipv6_root_table[] = {
-	{CTL_NET, "net", NULL, 0, 0555, ipv6_net_table},
+static ctl_table ipv6_net_table[] = {
+	{NET_IPV6, "ipv6", NULL, 0, 0555, ipv6_table},
         {0}
 };
 
-ctl_table ipv6_net_table[] = {
-	{NET_IPV6, "ipv6", NULL, 0, 0555, ipv6_table},
+static ctl_table ipv6_root_table[] = {
+	{CTL_NET, "net", NULL, 0, 0555, ipv6_net_table},
         {0}
 };
 
diff -ruN 2.5.23/net/ipv6/tcp_ipv6.c 2.5.23-sfr.4/net/ipv6/tcp_ipv6.c
--- 2.5.23/net/ipv6/tcp_ipv6.c	Wed Jun 19 12:41:52 2002
+++ 2.5.23-sfr.4/net/ipv6/tcp_ipv6.c	Thu Jun 20 14:11:05 2002
@@ -712,7 +712,7 @@
 	return err;
 }
 
-void tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
+static void tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		int type, int code, int offset, __u32 info)
 {
 	struct ipv6hdr *hdr = (struct ipv6hdr*)skb->data;
@@ -1576,7 +1576,7 @@
 	return 0;
 }
 
-int tcp_v6_rcv(struct sk_buff *skb)
+static int tcp_v6_rcv(struct sk_buff *skb)
 {
 	struct tcphdr *th;	
 	struct sock *sk;
diff -ruN 2.5.23/net/ipv6/udp.c 2.5.23-sfr.4/net/ipv6/udp.c
--- 2.5.23/net/ipv6/udp.c	Fri May  3 11:12:24 2002
+++ 2.5.23-sfr.4/net/ipv6/udp.c	Thu Jun 20 14:48:10 2002
@@ -371,7 +371,7 @@
  * 	return it, otherwise we block.
  */
 
-int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, int len,
+static int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, int len,
 		  int noblock, int flags, int *addr_len)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -470,7 +470,7 @@
 	goto out_free;
 }
 
-void udpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
+static void udpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	       int type, int code, int offset, __u32 info)
 {
 	struct ipv6_pinfo *np;
@@ -603,7 +603,7 @@
 	read_unlock(&udp_hash_lock);
 }
 
-int udpv6_rcv(struct sk_buff *skb)
+static int udpv6_rcv(struct sk_buff *skb)
 {
 	struct sock *sk;
   	struct udphdr *uh;
