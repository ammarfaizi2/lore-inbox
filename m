Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWHMVBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWHMVBT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWHMVBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:01:16 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7950 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751503AbWHMVBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:01:13 -0400
Date: Sun, 13 Aug 2006 23:01:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       patrick@tykepenguin.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-decnet-user@lists.sourceforge.net
Subject: [-mm patch] net/decnet/: cleanups
Message-ID: <20060813210112.GP3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
>  git-net.patch
>...
>  git trees
>...

This patch contains the following cleanups:
- make the following needlessly global functions static:
  - dn_fib.c: dn_fib_sync_down()
  - dn_fib.c: dn_fib_sync_up()
  - dn_rules.c: dn_fib_rule_action()
- remove the following unneeded prototype:
  - dn_fib.c: dn_cache_dump()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/net/dn_fib.h  |    3 ---
 net/decnet/dn_fib.c   |    9 +++++----
 net/decnet/dn_rules.c |    4 ++--
 3 files changed, 7 insertions(+), 9 deletions(-)

--- linux-2.6.18-rc4-mm1/include/net/dn_fib.h.old	2006-08-13 20:18:58.000000000 +0200
+++ linux-2.6.18-rc4-mm1/include/net/dn_fib.h	2006-08-13 20:19:08.000000000 +0200
@@ -131,9 +131,6 @@
 extern void dn_fib_flush(void);
 extern void dn_fib_select_multipath(const struct flowi *fl,
 					struct dn_fib_res *res);
-extern int dn_fib_sync_down(__le16 local, struct net_device *dev,
-				int force);
-extern int dn_fib_sync_up(struct net_device *dev);
 
 /*
  * dn_tables.c
--- linux-2.6.18-rc4-mm1/net/decnet/dn_fib.c.old	2006-08-13 20:20:05.000000000 +0200
+++ linux-2.6.18-rc4-mm1/net/decnet/dn_fib.c	2006-08-13 20:22:40.000000000 +0200
@@ -55,8 +55,6 @@
 
 #define endfor_nexthops(fi) }
 
-extern int dn_cache_dump(struct sk_buff *skb, struct netlink_callback *cb);
-
 static DEFINE_SPINLOCK(dn_fib_multipath_lock);
 static struct dn_fib_info *dn_fib_info_list;
 static DEFINE_SPINLOCK(dn_fib_info_lock);
@@ -80,6 +78,9 @@
 	[RTN_XRESOLVE] =    { .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },
 };
 
+static int dn_fib_sync_down(__le16 local, struct net_device *dev, int force);
+static int dn_fib_sync_up(struct net_device *dev);
+
 void dn_fib_free_info(struct dn_fib_info *fi)
 {
 	if (fi->fib_dead == 0) {
@@ -651,7 +652,7 @@
 	return NOTIFY_DONE;
 }
 
-int dn_fib_sync_down(__le16 local, struct net_device *dev, int force)
+static int dn_fib_sync_down(__le16 local, struct net_device *dev, int force)
 {
         int ret = 0;
         int scope = RT_SCOPE_NOWHERE;
@@ -695,7 +696,7 @@
 }
 
 
-int dn_fib_sync_up(struct net_device *dev)
+static int dn_fib_sync_up(struct net_device *dev)
 {
         int ret = 0;
 
--- linux-2.6.18-rc4-mm1/net/decnet/dn_rules.c.old	2006-08-13 20:22:45.000000000 +0200
+++ linux-2.6.18-rc4-mm1/net/decnet/dn_rules.c	2006-08-13 20:23:02.000000000 +0200
@@ -75,8 +75,8 @@
 	return err;
 }
 
-int dn_fib_rule_action(struct fib_rule *rule, struct flowi *flp, int flags,
-		       struct fib_lookup_arg *arg)
+static int dn_fib_rule_action(struct fib_rule *rule, struct flowi *flp,
+			      int flags, struct fib_lookup_arg *arg)
 {
 	int err = -EAGAIN;
 	struct dn_fib_table *tbl;

