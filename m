Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWHGPuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWHGPuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWHGPuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:50:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9999 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932188AbWHGPtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:49:49 -0400
Date: Mon, 7 Aug 2006 17:49:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] net/: make code static
Message-ID: <20060807154947.GE3691@stusta.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

BTW:
It doesn't seem to be intended that the new
ipv4/fib_rules.c:fib4_rules_cleanup() is completely unused?

 include/net/ip6_fib.h              |    4 ----
 net/ipv4/cipso_ipv4.c              |    2 +-
 net/ipv4/fib_rules.c               |    4 ++--
 net/ipv6/fib6_rules.c              |    4 ++--
 net/ipv6/ip6_fib.c                 |    6 +++---
 net/ipv6/route.c                   |    6 +++---
 net/netlabel/netlabel_domainhash.c |    4 ++--
 7 files changed, 13 insertions(+), 17 deletions(-)

--- linux-2.6.18-rc3-mm2-full/net/ipv4/cipso_ipv4.c.old	2006-08-07 16:39:05.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/net/ipv4/cipso_ipv4.c	2006-08-07 16:39:15.000000000 +0200
@@ -60,7 +60,7 @@
  * if in practice there are a lot of different DOIs this list should
  * probably be turned into a hash table or something similar so we
  * can do quick lookups. */
-DEFINE_SPINLOCK(cipso_v4_doi_list_lock);
+static DEFINE_SPINLOCK(cipso_v4_doi_list_lock);
 static struct list_head cipso_v4_doi_list = LIST_HEAD_INIT(cipso_v4_doi_list);
 
 /* Label mapping cache */
--- linux-2.6.18-rc3-mm2-full/net/ipv4/fib_rules.c.old	2006-08-07 16:39:33.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/net/ipv4/fib_rules.c	2006-08-07 16:39:51.000000000 +0200
@@ -101,8 +101,8 @@
 	return err;
 }
 
-int fib4_rule_action(struct fib_rule *rule, struct flowi *flp, int flags,
-		     struct fib_lookup_arg *arg)
+static int fib4_rule_action(struct fib_rule *rule, struct flowi *flp,
+			    int flags, struct fib_lookup_arg *arg)
 {
 	int err = -EAGAIN;
 	struct fib_table *tbl;
--- linux-2.6.18-rc3-mm2-full/net/ipv6/fib6_rules.c.old	2006-08-07 16:41:07.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/net/ipv6/fib6_rules.c	2006-08-07 16:41:16.000000000 +0200
@@ -66,8 +66,8 @@
 	return (struct dst_entry *) arg.result;
 }
 
-int fib6_rule_action(struct fib_rule *rule, struct flowi *flp,
-		     int flags, struct fib_lookup_arg *arg)
+static int fib6_rule_action(struct fib_rule *rule, struct flowi *flp,
+			    int flags, struct fib_lookup_arg *arg)
 {
 	struct rt6_info *rt = NULL;
 	struct fib6_table *table;
--- linux-2.6.18-rc3-mm2-full/include/net/ip6_fib.h.old	2006-08-07 16:41:36.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/include/net/ip6_fib.h	2006-08-07 16:41:43.000000000 +0200
@@ -192,10 +192,6 @@
 					     struct in6_addr *daddr, int dst_len,
 					     struct in6_addr *saddr, int src_len);
 
-extern void			fib6_clean_tree(struct fib6_node *root,
-						int (*func)(struct rt6_info *, void *arg),
-						int prune, void *arg);
-
 extern void			fib6_clean_all(int (*func)(struct rt6_info *, void *arg),
 					       int prune, void *arg);
 
--- linux-2.6.18-rc3-mm2-full/net/ipv6/ip6_fib.c.old	2006-08-07 16:41:51.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/net/ipv6/ip6_fib.c	2006-08-07 16:42:05.000000000 +0200
@@ -1169,9 +1169,9 @@
  *	ignoring pure split nodes) will be scanned.
  */
 
-void fib6_clean_tree(struct fib6_node *root,
-		     int (*func)(struct rt6_info *, void *arg),
-		     int prune, void *arg)
+static void fib6_clean_tree(struct fib6_node *root,
+			    int (*func)(struct rt6_info *, void *arg),
+			    int prune, void *arg)
 {
 	struct fib6_cleaner_t c;
 
--- linux-2.6.18-rc3-mm2-full/net/ipv6/route.c.old	2006-08-07 16:42:24.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/net/ipv6/route.c	2006-08-07 16:43:05.000000000 +0200
@@ -613,8 +613,8 @@
 	return rt;
 }
 
-struct rt6_info *ip6_pol_route_input(struct fib6_table *table, struct flowi *fl,
-				     int flags)
+static struct rt6_info *ip6_pol_route_input(struct fib6_table *table,
+					    struct flowi *fl, int flags)
 {
 	struct fib6_node *fn;
 	struct rt6_info *rt, *nrt;
@@ -872,7 +872,7 @@
 }
 
 static struct dst_entry *ndisc_dst_gc_list;
-DEFINE_SPINLOCK(ndisc_lock);
+static DEFINE_SPINLOCK(ndisc_lock);
 
 struct dst_entry *ndisc_dst_alloc(struct net_device *dev, 
 				  struct neighbour *neigh,
--- linux-2.6.18-rc3-mm2-full/net/netlabel/netlabel_domainhash.c.old	2006-08-07 16:43:27.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/net/netlabel/netlabel_domainhash.c	2006-08-07 16:43:53.000000000 +0200
@@ -50,11 +50,11 @@
 /* Domain hash table */
 /* XXX - updates should be so rare that having one spinlock for the entire
  * hash table should be okay */
-DEFINE_SPINLOCK(netlbl_domhsh_lock);
+static DEFINE_SPINLOCK(netlbl_domhsh_lock);
 static struct netlbl_domhsh_tbl *netlbl_domhsh = NULL;
 
 /* Default domain mapping */
-DEFINE_SPINLOCK(netlbl_domhsh_def_lock);
+static DEFINE_SPINLOCK(netlbl_domhsh_def_lock);
 static struct netlbl_dom_map *netlbl_domhsh_def = NULL;
 
 /*

