Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbTIFBsg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbTIFBsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:48:36 -0400
Received: from DSL022.LABridge.com ([206.117.136.22]:12560 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S265717AbTIFBrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:47:11 -0400
Subject: [PATCH] 2.6.0-test4 SEQ_START_TOKEN net/* (2/6)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Content-Type: text/plain
Message-Id: <1062812834.16845.165.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 18:47:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.6.0-test4/net/8021q/vlanproc.c SEQ_START_TOKEN/net/8021q/vlanproc.c
-- linux-2.6.0-test4/net/8021q/vlanproc.c	2003-08-22 16:53:55.000000000 -0700
+++ SEQ_START_TOKEN/net/8021q/vlanproc.c	2003-09-04 20:26:49.000000000 -0700
@@ -46,10 +46,6 @@
 static void vlan_seq_stop(struct seq_file *seq, void *);
 static int vlandev_seq_show(struct seq_file *seq, void *v);
 
-/* Miscellaneous */
-#define SEQ_START_TOKEN		((void *) 1)
-
-
 /*
  *	Global Data
  */
diff -urN linux-2.6.0-test4/net/appletalk/aarp.c SEQ_START_TOKEN/net/appletalk/aarp.c
-- linux-2.6.0-test4/net/appletalk/aarp.c	2003-09-02 12:52:45.000000000 -0700
+++ SEQ_START_TOKEN/net/appletalk/aarp.c	2003-09-04 20:27:42.000000000 -0700
@@ -941,7 +941,7 @@
 	iter->table     = resolved;
 	iter->bucket    = 0;
 
-	return *pos ? iter_next(iter, pos) : ((void *)1);
+	return *pos ? iter_next(iter, pos) : SEQ_START_TOKEN;
 }
 
 static void *aarp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -952,7 +952,7 @@
 	++*pos;
 
 	/* first line after header */
-	if (v == ((void *)1)) 
+	if (v == SEQ_START_TOKEN) 
 		entry = iter_next(iter, NULL);
 		
 	/* next entry in current bucket */
@@ -987,7 +987,7 @@
 	struct aarp_entry *entry = v;
 	unsigned long now = jiffies;
 
-	if (v == ((void *)1))
+	if (v == SEQ_START_TOKEN)
 		seq_puts(seq, 
 			 "Address  Interface   Hardware Address"
 			 "   Expires LastSend  Retry Status\n");
diff -urN linux-2.6.0-test4/net/appletalk/atalk_proc.c SEQ_START_TOKEN/net/appletalk/atalk_proc.c
-- linux-2.6.0-test4/net/appletalk/atalk_proc.c	2003-09-02 12:52:45.000000000 -0700
+++ SEQ_START_TOKEN/net/appletalk/atalk_proc.c	2003-09-04 20:27:44.000000000 -0700
@@ -33,7 +33,7 @@
 	loff_t l = *pos;
 
 	read_lock_bh(&atalk_interfaces_lock);
-	return l ? atalk_get_interface_idx(--l) : (void *)1;
+	return l ? atalk_get_interface_idx(--l) : SEQ_START_TOKEN;
 }
 
 static void *atalk_seq_interface_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -41,7 +41,7 @@
 	struct atalk_iface *i;
 
 	++*pos;
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		i = NULL;
 		if (atalk_interfaces)
 			i = atalk_interfaces;
@@ -62,7 +62,7 @@
 {
 	struct atalk_iface *iface;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Interface        Address   Networks  "
 			      "Status\n");
 		goto out;
@@ -92,7 +92,7 @@
 	loff_t l = *pos;
 
 	read_lock_bh(&atalk_routes_lock);
-	return l ? atalk_get_route_idx(--l) : (void *)1;
+	return l ? atalk_get_route_idx(--l) : SEQ_START_TOKEN;
 }
 
 static void *atalk_seq_route_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -100,7 +100,7 @@
 	struct atalk_route *r;
 
 	++*pos;
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		r = NULL;
 		if (atalk_routes)
 			r = atalk_routes;
@@ -121,7 +121,7 @@
 {
 	struct atalk_route *rt;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Target        Router  Flags Dev\n");
 		goto out;
 	}
@@ -160,7 +160,7 @@
 	loff_t l = *pos;
 
 	read_lock_bh(&atalk_sockets_lock);
-	return l ? atalk_get_socket_idx(--l) : (void *)1;
+	return l ? atalk_get_socket_idx(--l) : SEQ_START_TOKEN;
 }
 
 static void *atalk_seq_socket_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -168,7 +168,7 @@
 	struct sock *i;
 
 	++*pos;
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		i = sk_head(&atalk_sockets);
 		goto out;
 	}
@@ -187,7 +187,7 @@
 	struct sock *s;
 	struct atalk_sock *at;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq, "Type Local_addr  Remote_addr Tx_queue "
 				"Rx_queue St UID\n");
 		goto out;
diff -urN linux-2.6.0-test4/net/core/dev.c SEQ_START_TOKEN/net/core/dev.c
-- linux-2.6.0-test4/net/core/dev.c	2003-09-02 12:52:45.000000000 -0700
+++ SEQ_START_TOKEN/net/core/dev.c	2003-09-04 20:06:43.000000000 -0700
@@ -1844,13 +1844,13 @@
 void *dev_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock(&dev_base_lock);
-	return *pos ? dev_get_idx(*pos - 1) : (void *)1;
+	return *pos ? dev_get_idx(*pos - 1) : SEQ_START_TOKEN;
 }
 
 void *dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	++*pos;
-	return v == (void *)1 ? dev_base : ((struct net_device *)v)->next;
+	return v == SEQ_START_TOKEN ? dev_base : ((struct net_device *)v)->next;
 }
 
 void dev_seq_stop(struct seq_file *seq, void *v)
@@ -1890,7 +1890,7 @@
  */
 static int dev_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		seq_puts(seq, "Inter-|   Receive                            "
 			      "                    |  Transmit\n"
 			      " face |bytes    packets errs drop fifo frame "
diff -urN linux-2.6.0-test4/net/core/wireless.c SEQ_START_TOKEN/net/core/wireless.c
-- linux-2.6.0-test4/net/core/wireless.c	2003-08-22 16:58:39.000000000 -0700
+++ SEQ_START_TOKEN/net/core/wireless.c	2003-09-04 19:55:08.000000000 -0700
@@ -458,7 +458,7 @@
  */
 static int wireless_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		seq_printf(seq, "Inter-| sta-|   Quality        |   Discarded "
 				"packets               | Missed | WE\n"
 				" face | tus | link level noise |  nwid  "
diff -urN linux-2.6.0-test4/net/decnet/af_decnet.c SEQ_START_TOKEN/net/decnet/af_decnet.c
-- linux-2.6.0-test4/net/decnet/af_decnet.c	2003-08-22 16:56:22.000000000 -0700
+++ SEQ_START_TOKEN/net/decnet/af_decnet.c	2003-09-04 20:27:37.000000000 -0700
@@ -2146,14 +2146,14 @@
 
 static void *dn_socket_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return *pos ? dn_socket_get_idx(seq, *pos - 1) : (void*)1;
+	return *pos ? dn_socket_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 
 static void *dn_socket_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	void *rc;
 
-	if (v == (void*)1) {
+	if (v == SEQ_START_TOKEN) {
 		rc = dn_socket_get_idx(seq, 0);
 		goto out;
 	}
@@ -2169,7 +2169,7 @@
 
 static void dn_socket_seq_stop(struct seq_file *seq, void *v)
 {
-	if (v && v != (void*)1)
+	if (v && v != SEQ_START_TOKEN)
 		read_unlock_bh(&dn_hash_lock);
 }
 
@@ -2269,7 +2269,7 @@
 
 static int dn_socket_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void*)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Local                                              Remote\n");
 	} else {
 		dn_socket_format_entry(seq, v);
diff -urN linux-2.6.0-test4/net/decnet/dn_dev.c SEQ_START_TOKEN/net/decnet/dn_dev.c
-- linux-2.6.0-test4/net/decnet/dn_dev.c	2003-08-22 16:54:17.000000000 -0700
+++ SEQ_START_TOKEN/net/decnet/dn_dev.c	2003-09-04 20:27:39.000000000 -0700
@@ -1366,7 +1366,7 @@
 			read_unlock(&dev_base_lock);
 		return dev;
 	}
-	return (void*)1;
+	return SEQ_START_TOKEN;
 }
 
 static void *dn_dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -1374,7 +1374,7 @@
 	struct net_device *dev = v;
 	loff_t one = 1;
 
-	if (v == (void*)1) {
+	if (v == SEQ_START_TOKEN) {
 		dev = dn_dev_seq_start(seq, &one);
 	} else {
 		dev = dn_dev_get_next(seq, dev);
@@ -1387,7 +1387,7 @@
 
 static void dn_dev_seq_stop(struct seq_file *seq, void *v)
 {
-	if (v && v != (void*)1)
+	if (v && v != SEQ_START_TOKEN)
 		read_unlock(&dev_base_lock);
 }
 
@@ -1407,7 +1407,7 @@
 
 static int dn_dev_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void*)1)
+	if (v == SEQ_START_TOKEN)
         	seq_puts(seq, "Name     Flags T1   Timer1 T3   Timer3 BlkSize Pri State DevType    Router Peer\n");
 	else {
 		struct net_device *dev = v;
diff -urN linux-2.6.0-test4/net/decnet/dn_neigh.c SEQ_START_TOKEN/net/decnet/dn_neigh.c
-- linux-2.6.0-test4/net/decnet/dn_neigh.c	2003-08-22 16:57:50.000000000 -0700
+++ SEQ_START_TOKEN/net/decnet/dn_neigh.c	2003-09-04 20:27:34.000000000 -0700
@@ -604,7 +604,7 @@
 
 static void *dn_neigh_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return *pos ? dn_neigh_get_idx(seq, *pos - 1) : (void*)1;
+	return *pos ? dn_neigh_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 
 static void *dn_neigh_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -612,7 +612,7 @@
 	void *rc;
 

-	if (v == (void*)1) {
+	if (v == SEQ_START_TOKEN) {
 		rc = dn_neigh_get_idx(seq, 0);
 		goto out;
 	}
@@ -628,7 +628,7 @@
 
 static void dn_neigh_seq_stop(struct seq_file *seq, void *v)
 {
-	if (v && v != (void*)1)
+	if (v && v != SEQ_START_TOKEN)
 		read_unlock_bh(&dn_neigh_table.lock);
 }
 
@@ -653,7 +653,7 @@
 
 static int dn_neigh_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void*)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Addr    Flags State Use Blksize Dev\n");
 	} else {
 		dn_neigh_format_entry(seq, v);
diff -urN linux-2.6.0-test4/net/ipv4/arp.c SEQ_START_TOKEN/net/ipv4/arp.c
-- linux-2.6.0-test4/net/ipv4/arp.c	2003-08-22 16:58:59.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv4/arp.c	2003-09-04 20:06:32.000000000 -0700
@@ -1275,7 +1275,7 @@
 
 static void *arp_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return *pos ? arp_get_idx(seq, *pos - 1) : (void *)1;
+	return *pos ? arp_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 
 static void *arp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -1283,7 +1283,7 @@
 	void *rc;
 	struct arp_iter_state* state;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		rc = arp_get_idx(seq, 0);
 		goto out;
 	}
@@ -1306,7 +1306,7 @@
 {
 	struct arp_iter_state* state = seq->private;
 
-	if (!state->is_pneigh && v != (void *)1)
+	if (!state->is_pneigh && v != SEQ_START_TOKEN)
 		read_unlock_bh(&arp_tbl.lock);
 }
 
@@ -1359,7 +1359,7 @@
 
 static int arp_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		seq_puts(seq, "IP address       HW type     Flags       "
 			      "HW address            Mask     Device\n");
 	else {
diff -urN linux-2.6.0-test4/net/ipv4/fib_hash.c SEQ_START_TOKEN/net/ipv4/fib_hash.c
-- linux-2.6.0-test4/net/ipv4/fib_hash.c	2003-08-22 16:55:42.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv4/fib_hash.c	2003-09-04 20:06:39.000000000 -0700
@@ -979,14 +979,14 @@
 
 	read_lock(&fib_hash_lock);
 	if (ip_fib_main_table)
-		v = *pos ? fib_get_next(seq) : (void *)1;
+		v = *pos ? fib_get_next(seq) : SEQ_START_TOKEN;
 	return v;
 }
 
 static void *fib_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	++*pos;
-	return v == (void *)1 ? fib_get_first(seq) : fib_get_next(seq);
+	return v == SEQ_START_TOKEN ? fib_get_first(seq) : fib_get_next(seq);
 }
 
 static void fib_seq_stop(struct seq_file *seq, void *v)
@@ -1025,7 +1025,7 @@
 	struct fib_node *f;
 	struct fib_info *fi;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq, "%-127s\n", "Iface\tDestination\tGateway "
 			   "\tFlags\tRefCnt\tUse\tMetric\tMask\t\tMTU"
 			   "\tWindow\tIRTT");
diff -urN linux-2.6.0-test4/net/ipv4/igmp.c SEQ_START_TOKEN/net/ipv4/igmp.c
-- linux-2.6.0-test4/net/ipv4/igmp.c	2003-09-02 12:52:45.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv4/igmp.c	2003-09-04 20:08:40.000000000 -0700
@@ -2162,13 +2162,13 @@
 static void *igmp_mc_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock(&dev_base_lock);
-	return *pos ? igmp_mc_get_idx(seq, *pos) : (void *)1;
+	return *pos ? igmp_mc_get_idx(seq, *pos) : SEQ_START_TOKEN;
 }
 
 static void *igmp_mc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct ip_mc_list *im;
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		im = igmp_mc_get_first(seq);
 	else
 		im = igmp_mc_get_next(seq, v);
@@ -2190,7 +2190,7 @@
 
 static int igmp_mc_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		seq_printf(seq, 
 			   "Idx\tDevice    : Count Querier\tGroup    Users Timer\tReporter\n");
 	else {
@@ -2337,13 +2337,13 @@
 static void *igmp_mcf_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock(&dev_base_lock);
-	return *pos ? igmp_mcf_get_idx(seq, *pos) : (void *)1;
+	return *pos ? igmp_mcf_get_idx(seq, *pos) : SEQ_START_TOKEN;
 }
 
 static void *igmp_mcf_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct ip_sf_list *psf;
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		psf = igmp_mcf_get_first(seq);
 	else
 		psf = igmp_mcf_get_next(seq, v);
@@ -2372,7 +2372,7 @@
 	struct ip_sf_list *psf = (struct ip_sf_list *)v;
 	struct igmp_mcf_iter_state *state = igmp_mcf_seq_private(seq);
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq, 
 			   "%3s %6s "
 			   "%10s %10s %6s %6s\n", "Idx",
diff -urN linux-2.6.0-test4/net/ipv4/raw.c SEQ_START_TOKEN/net/ipv4/raw.c
-- linux-2.6.0-test4/net/ipv4/raw.c	2003-08-22 16:56:34.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv4/raw.c	2003-09-04 20:06:37.000000000 -0700
@@ -736,14 +736,14 @@
 static void *raw_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock(&raw_v4_lock);
-	return *pos ? raw_get_idx(seq, *pos) : (void *)1;
+	return *pos ? raw_get_idx(seq, *pos) : SEQ_START_TOKEN;
 }
 
 static void *raw_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct sock *sk;
 
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		sk = raw_get_first(seq);
 	else
 		sk = raw_get_next(seq, v);
@@ -778,7 +778,7 @@
 {
 	char tmpbuf[129];
 
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		seq_printf(seq, "%-127s\n",
 			       "  sl  local_address rem_address   st tx_queue "
 			       "rx_queue tr tm->when retrnsmt   uid  timeout "
diff -urN linux-2.6.0-test4/net/ipv4/route.c SEQ_START_TOKEN/net/ipv4/route.c
-- linux-2.6.0-test4/net/ipv4/route.c	2003-09-02 12:52:46.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv4/route.c	2003-09-04 20:29:01.000000000 -0700
@@ -259,14 +259,14 @@
 
 static void *rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return *pos ? rt_cache_get_idx(seq, *pos) : (void *)1;
+	return *pos ? rt_cache_get_idx(seq, *pos) : SEQ_START_TOKEN;
 }
 
 static void *rt_cache_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct rtable *r = NULL;
 
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		r = rt_cache_get_first(seq);
 	else
 		r = rt_cache_get_next(seq, v);
@@ -276,13 +276,13 @@
 
 static void rt_cache_seq_stop(struct seq_file *seq, void *v)
 {
-	if (v && v != (void *)1)
+	if (v && v != SEQ_START_TOKEN)
 		rcu_read_unlock();
 }
 
 static int rt_cache_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		seq_printf(seq, "%-127s\n",
 			   "Iface\tDestination\tGateway \tFlags\t\tRefCnt\tUse\t"
 			   "Metric\tSource\t\tMTU\tWindow\tIRTT\tTOS\tHHRef\t"
diff -urN linux-2.6.0-test4/net/ipv4/tcp_ipv4.c SEQ_START_TOKEN/net/ipv4/tcp_ipv4.c
-- linux-2.6.0-test4/net/ipv4/tcp_ipv4.c	2003-08-22 16:53:54.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv4/tcp_ipv4.c	2003-09-04 20:52:09.000000000 -0700
@@ -2351,7 +2351,7 @@
 
 static void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return *pos ? tcp_get_idx(seq, *pos - 1) : (void *)1;
+	return *pos ? tcp_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 
 static void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -2359,7 +2359,7 @@
 	void *rc = NULL;
 	struct tcp_iter_state* st;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		rc = tcp_get_idx(seq, 0);
 		goto out;
 	}
@@ -2397,7 +2397,7 @@
 			read_unlock_bh(&tp->syn_wait_lock);
 		}
 	case TCP_SEQ_STATE_LISTENING:
-		if (v != (void *)1)
+		if (v != SEQ_START_TOKEN)
 			tcp_listen_unlock();
 		break;
 	case TCP_SEQ_STATE_TIME_WAIT:
@@ -2559,7 +2559,7 @@
 	struct tcp_iter_state* st;
 	char tmpbuf[TMPSZ + 1];
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq, "%-*s\n", TMPSZ - 1,
 			   "  sl  local_address rem_address   st tx_queue "
 			   "rx_queue tr tm->when retrnsmt   uid  timeout "
diff -urN linux-2.6.0-test4/net/ipv4/udp.c SEQ_START_TOKEN/net/ipv4/udp.c
-- linux-2.6.0-test4/net/ipv4/udp.c	2003-08-22 16:52:55.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv4/udp.c	2003-09-04 19:58:50.000000000 -0700
@@ -1380,7 +1380,7 @@
 static void *udp_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock(&udp_hash_lock);
-	return *pos ? udp_get_bucket(seq, pos) : (void *)1;
+	return *pos ? udp_get_bucket(seq, pos) : SEQ_START_TOKEN;
 }
 
 static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -1389,7 +1389,7 @@
 	struct hlist_node *node;
 	struct udp_iter_state *state;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		sk = udp_get_bucket(seq, pos);
 		goto out;
 	}
@@ -1496,7 +1496,7 @@
 
 static int udp4_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		seq_printf(seq, "%-127s\n",
 			   "  sl  local_address rem_address   st tx_queue "
 			   "rx_queue tr tm->when retrnsmt   uid  timeout "
diff -urN linux-2.6.0-test4/net/ipv6/addrconf.c SEQ_START_TOKEN/net/ipv6/addrconf.c
-- linux-2.6.0-test4/net/ipv6/addrconf.c	2003-08-22 17:00:35.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv6/addrconf.c	2003-09-04 20:17:07.000000000 -0700
@@ -2171,7 +2171,7 @@
 static void *if6_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock_bh(&addrconf_hash_lock);
-	return *pos ? if6_get_bucket(seq, pos) : (void *)1;
+	return *pos ? if6_get_bucket(seq, pos) : SEQ_START_TOKEN;
 }
 
 static void *if6_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -2179,7 +2179,7 @@
 	struct inet6_ifaddr *ifa;
 	struct if6_iter_state *state;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		ifa = if6_get_bucket(seq, pos);
 		goto out;
 	}
@@ -2215,7 +2215,7 @@
 
 static int if6_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		return 0;
 	else
 		if6_iface_seq_show(seq, v);
diff -urN linux-2.6.0-test4/net/ipv6/ip6_flowlabel.c SEQ_START_TOKEN/net/ipv6/ip6_flowlabel.c
-- linux-2.6.0-test4/net/ipv6/ip6_flowlabel.c	2003-08-22 16:53:09.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv6/ip6_flowlabel.c	2003-09-04 20:15:36.000000000 -0700
@@ -599,14 +599,14 @@
 static void *ip6fl_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock_bh(&ip6_fl_lock);
-	return *pos ? ip6fl_get_idx(seq, *pos) : (void *)1;
+	return *pos ? ip6fl_get_idx(seq, *pos) : SEQ_START_TOKEN;
 }
 
 static void *ip6fl_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct ip6_flowlabel *fl;
 
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		fl = ip6fl_get_first(seq);
 	else
 		fl = ip6fl_get_next(seq, v);
@@ -640,7 +640,7 @@
 
 static int ip6fl_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		seq_printf(seq, "Label S Owner  Users  Linger Expires  "
 				"Dst                              Opt\n");
 	else
diff -urN linux-2.6.0-test4/net/ipv6/mcast.c SEQ_START_TOKEN/net/ipv6/mcast.c
-- linux-2.6.0-test4/net/ipv6/mcast.c	2003-09-02 12:52:46.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv6/mcast.c	2003-09-04 20:29:18.000000000 -0700
@@ -2278,13 +2278,13 @@
 static void *igmp6_mcf_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock(&dev_base_lock);
-	return *pos ? igmp6_mcf_get_idx(seq, *pos) : (void *)1;
+	return *pos ? igmp6_mcf_get_idx(seq, *pos) : SEQ_START_TOKEN;
 }
 
 static void *igmp6_mcf_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct ip6_sf_list *psf;
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		psf = igmp6_mcf_get_first(seq);
 	else
 		psf = igmp6_mcf_get_next(seq, v);
@@ -2313,7 +2313,7 @@
 	struct ip6_sf_list *psf = (struct ip6_sf_list *)v;
 	struct igmp6_mcf_iter_state *state = igmp6_mcf_seq_private(seq);
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq, 
 			   "%3s %6s "
 			   "%32s %32s %6s %6s\n", "Idx",
diff -urN linux-2.6.0-test4/net/ipv6/raw.c SEQ_START_TOKEN/net/ipv6/raw.c
-- linux-2.6.0-test4/net/ipv6/raw.c	2003-08-22 16:54:29.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv6/raw.c	2003-09-04 20:15:32.000000000 -0700
@@ -961,14 +961,14 @@
 static void *raw6_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock(&raw_v6_lock);
-	return *pos ? raw6_get_idx(seq, *pos) : (void *)1;
+	return *pos ? raw6_get_idx(seq, *pos) : SEQ_START_TOKEN;
 }
 
 static void *raw6_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct sock *sk;
 
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		sk = raw6_get_first(seq);
 	else
 		sk = raw6_get_next(seq, v);
@@ -1010,7 +1010,7 @@
 
 static int raw6_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		seq_printf(seq,
 			   "  sl  "
 			   "local_address                         "
diff -urN linux-2.6.0-test4/net/ipv6/tcp_ipv6.c SEQ_START_TOKEN/net/ipv6/tcp_ipv6.c
-- linux-2.6.0-test4/net/ipv6/tcp_ipv6.c	2003-08-22 16:56:34.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv6/tcp_ipv6.c	2003-09-04 20:17:17.000000000 -0700
@@ -2027,7 +2027,7 @@
 {
 	struct tcp_iter_state *st;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq,
 			   "  sl  "
 			   "local_address                         "
diff -urN linux-2.6.0-test4/net/ipv6/udp.c SEQ_START_TOKEN/net/ipv6/udp.c
-- linux-2.6.0-test4/net/ipv6/udp.c	2003-08-22 16:58:49.000000000 -0700
+++ SEQ_START_TOKEN/net/ipv6/udp.c	2003-09-04 20:17:13.000000000 -0700
@@ -1113,7 +1113,7 @@
 
 static int udp6_seq_show(struct seq_file *seq, void *v)
 {
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		seq_printf(seq,
 			   "  sl  "
 			   "local_address                         "
diff -urN linux-2.6.0-test4/net/ipx/ipx_proc.c SEQ_START_TOKEN/net/ipx/ipx_proc.c
-- linux-2.6.0-test4/net/ipx/ipx_proc.c	2003-08-22 16:50:53.000000000 -0700
+++ SEQ_START_TOKEN/net/ipx/ipx_proc.c	2003-09-04 20:13:59.000000000 -0700
@@ -39,7 +39,7 @@
 	loff_t l = *pos;
 
 	spin_lock_bh(&ipx_interfaces_lock);
-	return l ? ipx_get_interface_idx(--l) : (void *)1;
+	return l ? ipx_get_interface_idx(--l) : SEQ_START_TOKEN;
 }
 
 static void *ipx_seq_interface_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -47,7 +47,7 @@
 	struct ipx_interface *i;
 
 	++*pos;
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		i = ipx_interfaces_head();
 	else
 		i = ipx_interfaces_next(v);
@@ -63,7 +63,7 @@
 {
 	struct ipx_interface *i;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Network    Node_Address   Primary  Device     "
 			      "Frame_Type");
 #ifdef IPX_REFCNT_DEBUG
@@ -123,7 +123,7 @@
 {
 	loff_t l = *pos;
 	read_lock_bh(&ipx_routes_lock);
-	return l ? ipx_get_route_idx(--l) : (void *)1;
+	return l ? ipx_get_route_idx(--l) : SEQ_START_TOKEN;
 }
 
 static void *ipx_seq_route_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -131,7 +131,7 @@
 	struct ipx_route *r;
 
 	++*pos;
-	if (v == (void *)1)
+	if (v == SEQ_START_TOKEN)
 		r = ipx_routes_head();
 	else
 		r = ipx_routes_next(v);
@@ -147,7 +147,7 @@
 {
 	struct ipx_route *rt;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Network    Router_Net   Router_Node\n");
 		goto out;
 	}
@@ -195,7 +195,7 @@
 	loff_t l = *pos;
 
 	spin_lock_bh(&ipx_interfaces_lock);
-	return l ? ipx_get_socket_idx(--l) : (void *)1;
+	return l ? ipx_get_socket_idx(--l) : SEQ_START_TOKEN;
 }
 
 static void *ipx_seq_socket_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -205,7 +205,7 @@
 	struct ipx_opt *ipxs;
 
 	++*pos;
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		sk = NULL;
 		i = ipx_interfaces_head();
 		if (!i)
@@ -245,7 +245,7 @@
 	struct sock *s;
 	struct ipx_opt *ipxs;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 #ifdef CONFIG_IPX_INTERN
 		seq_puts(seq, "Local_Address               "
 			      "Remote_Address              Tx_Queue  "
diff -urN linux-2.6.0-test4/net/llc/llc_proc.c SEQ_START_TOKEN/net/llc/llc_proc.c
-- linux-2.6.0-test4/net/llc/llc_proc.c	2003-09-02 12:52:46.000000000 -0700
+++ SEQ_START_TOKEN/net/llc/llc_proc.c	2003-09-04 20:11:06.000000000 -0700
@@ -67,7 +67,7 @@
 	loff_t l = *pos;
 
 	read_lock_bh(&llc_main_station.sap_list.lock);
-	return l ? llc_get_sk_idx(--l) : (void *)1;
+	return l ? llc_get_sk_idx(--l) : SEQ_START_TOKEN;
 }
 
 static void *llc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -77,7 +77,7 @@
 	struct llc_sap *sap;
 
 	++*pos;
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		sk = llc_get_sk_idx(0);
 		goto out;
 	}
@@ -123,7 +123,7 @@
 	struct sock* sk;
 	struct llc_opt *llc;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "SKt Mc local_mac_sap        remote_mac_sap   "
 			      "    tx_queue rx_queue st uid link\n");
 		goto out;
@@ -172,7 +172,7 @@
 	struct sock* sk;
 	struct llc_opt *llc;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Connection list:\n"
 			      "dsap state      retr txw rxw pf ff sf df rs cs "
 			      "tack tpfc trs tbs blog busr\n");
diff -urN linux-2.6.0-test4/net/rxrpc/proc.c SEQ_START_TOKEN/net/rxrpc/proc.c
-- linux-2.6.0-test4/net/rxrpc/proc.c	2003-08-22 16:57:07.000000000 -0700
+++ SEQ_START_TOKEN/net/rxrpc/proc.c	2003-09-04 20:30:33.000000000 -0700
@@ -226,7 +226,7 @@
 
 	/* allow for the header line */
 	if (!pos)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	pos--;
 
 	/* find the n'th element in the list */
@@ -248,7 +248,7 @@
 	(*pos)++;
 
 	_p = v;
-	_p = v==(void*)1 ? rxrpc_proc_transports.next : _p->next;
+	_p = v==SEQ_START_TOKEN ? rxrpc_proc_transports.next : _p->next;
 
 	return _p!=&rxrpc_proc_transports ? _p : NULL;
 } /* end rxrpc_proc_transports_next() */
@@ -272,7 +272,7 @@
 	struct rxrpc_transport *trans = list_entry(v,struct rxrpc_transport,proc_link);
 
 	/* display header on line 1 */
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(m, "LOCAL USE\n");
 		return 0;
 	}
@@ -319,7 +319,7 @@
 
 	/* allow for the header line */
 	if (!pos)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	pos--;
 
 	/* find the n'th element in the list */
@@ -341,7 +341,7 @@
 	(*pos)++;
 
 	_p = v;
-	_p = v==(void*)1 ? rxrpc_peers.next : _p->next;
+	_p = v==SEQ_START_TOKEN ? rxrpc_peers.next : _p->next;
 
 	return _p!=&rxrpc_peers ? _p : NULL;
 } /* end rxrpc_proc_peers_next() */
@@ -366,7 +366,7 @@
 	signed long timeout;
 
 	/* display header on line 1 */
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(m,"LOCAL REMOTE   USAGE CONNS  TIMEOUT   MTU RTT(uS)\n");
 		return 0;
 	}
@@ -422,7 +422,7 @@
 
 	/* allow for the header line */
 	if (!pos)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	pos--;
 
 	/* find the n'th element in the list */
@@ -444,7 +444,7 @@
 	(*pos)++;
 
 	_p = v;
-	_p = v==(void*)1 ? rxrpc_conns.next : _p->next;
+	_p = v==SEQ_START_TOKEN ? rxrpc_conns.next : _p->next;
 
 	return _p!=&rxrpc_conns ? _p : NULL;
 } /* end rxrpc_proc_conns_next() */
@@ -469,7 +469,7 @@
 	signed long timeout;
 
 	/* display header on line 1 */
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(m,
 			 "LOCAL REMOTE   RPORT SRVC CONN     END SERIALNO CALLNO     MTU  TIMEOUT"
 			 "\n");
@@ -530,7 +530,7 @@
 
 	/* allow for the header line */
 	if (!pos)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	pos--;
 
 	/* find the n'th element in the list */
@@ -552,7 +552,7 @@
 	(*pos)++;
 
 	_p = v;
-	_p = v==(void*)1 ? rxrpc_calls.next : _p->next;
+	_p = v==SEQ_START_TOKEN ? rxrpc_calls.next : _p->next;
 
 	return _p!=&rxrpc_calls ? _p : NULL;
 } /* end rxrpc_proc_calls_next() */
@@ -576,7 +576,7 @@
 	struct rxrpc_call *call = list_entry(v,struct rxrpc_call,call_link);
 
 	/* display header on line 1 */
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(m,
 			 "LOCAL REMOT SRVC CONN     CALL     DIR USE "
 			 " L STATE   OPCODE ABORT    ERRNO\n"
diff -urN linux-2.6.0-test4/net/sunrpc/cache.c SEQ_START_TOKEN/net/sunrpc/cache.c
-- linux-2.6.0-test4/net/sunrpc/cache.c	2003-08-22 16:56:58.000000000 -0700
+++ SEQ_START_TOKEN/net/sunrpc/cache.c	2003-09-04 20:11:09.000000000 -0700
@@ -1035,7 +1035,7 @@
 
 	read_lock(&cd->hash_lock);
 	if (!n--)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	hash = n >> 32;
 	entry = n & ((1LL<<32) - 1);
 
@@ -1060,7 +1060,7 @@
 	int hash = (*pos >> 32);
 	struct cache_detail *cd = ((struct handle*)m->private)->cd;
 
-	if (p == (void *)1)
+	if (p == SEQ_START_TOKEN)
 		hash = 0;
 	else if (ch->next == NULL) {
 		hash++;
@@ -1092,7 +1092,7 @@
 	struct cache_head *cp = p;
 	struct cache_detail *cd = ((struct handle*)m->private)->cd;
 
-	if (p == (void *)1)
+	if (p == SEQ_START_TOKEN)
 		return cd->cache_show(m, cd, NULL);
 
 	ifdebug(CACHE)
diff -urN linux-2.6.0-test4/net/wanrouter/wanproc.c SEQ_START_TOKEN/net/wanrouter/wanproc.c
-- linux-2.6.0-test4/net/wanrouter/wanproc.c	2003-08-22 16:55:39.000000000 -0700
+++ SEQ_START_TOKEN/net/wanrouter/wanproc.c	2003-09-04 20:29:56.000000000 -0700
@@ -86,7 +86,7 @@
 
 	lock_kernel();
 	if (!l--)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	for (wandev = wanrouter_router_devlist; l-- && wandev;
 	     wandev = wandev->next)
 		;
@@ -97,7 +97,7 @@
 {
 	struct wan_device *wandev = v;
 	(*pos)++;
-	return (v == (void *)1) ? wanrouter_router_devlist : wandev->next;
+	return (v == SEQ_START_TOKEN) ? wanrouter_router_devlist : wandev->next;
 }
 
 static void r_stop(struct seq_file *m, void *v)
@@ -108,7 +108,7 @@
 static int config_show(struct seq_file *m, void *v)
 {
 	struct wan_device *p = v;
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(m, "Device name    | port |IRQ|DMA|  mem.addr  |"
 			    "mem.size|option1|option2|option3|option4\n");
 		return 0;
@@ -124,7 +124,7 @@
 static int status_show(struct seq_file *m, void *v)
 {
 	struct wan_device *p = v;
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(m, "Device name    |protocol|station|interface|"
 			    "clocking|baud rate| MTU |ndev|link state\n");
 		return 0;
diff -urN linux-2.6.0-test4/net/x25/x25_proc.c SEQ_START_TOKEN/net/x25/x25_proc.c
-- linux-2.6.0-test4/net/x25/x25_proc.c	2003-08-22 16:52:54.000000000 -0700
+++ SEQ_START_TOKEN/net/x25/x25_proc.c	2003-09-04 20:29:43.000000000 -0700
@@ -44,7 +44,7 @@
 	loff_t l = *pos;
 
 	read_lock_bh(&x25_route_list_lock);
-	return l ? x25_get_route_idx(--l) : (void *)1;
+	return l ? x25_get_route_idx(--l) : SEQ_START_TOKEN;
 }
 
 static void *x25_seq_route_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -52,7 +52,7 @@
 	struct x25_route *rt;
 
 	++*pos;
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		rt = NULL;
 		if (!list_empty(&x25_route_list))
 			rt = list_entry(x25_route_list.next,
@@ -77,7 +77,7 @@
 {
 	struct x25_route *rt;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Address          Digits  Device\n");
 		goto out;
 	}
@@ -108,7 +108,7 @@
 	loff_t l = *pos;
 
 	read_lock_bh(&x25_list_lock);
-	return l ? x25_get_socket_idx(--l) : (void *)1;
+	return l ? x25_get_socket_idx(--l) : SEQ_START_TOKEN;
 }
 
 static void *x25_seq_socket_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -116,7 +116,7 @@
 	struct sock *s;
 
 	++*pos;
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		s = sk_head(&x25_list);
 		goto out;
 	}
@@ -137,7 +137,7 @@
 	struct net_device *dev;
 	const char *devname;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq, "dest_addr  src_addr   dev   lci st vs vr "
 				"va   t  t2 t21 t22 t23 Snd-Q Rcv-Q inode\n");
 		goto out;


