Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUJOMlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUJOMlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 08:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUJOMjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 08:39:11 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:37349 "EHLO
	holub.nextsoft.cz") by vger.kernel.org with ESMTP id S267751AbUJOMfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 08:35:01 -0400
From: Michal Rokos <michal@rokos.info>
To: linux-net@vger.kernel.org
Subject: [Patch 2.6] Net - Exclude uneeded code when ! CONFIG_PROC_FS
Date: Fri, 15 Oct 2004 14:34:57 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410151434.57217.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just tiny fixes for ! CONFIG_PROC_FS configuration.

It removes few "unused code" warnings.

Tested by compilation only. (With CONFIG_PROC_FS on and off)

Michal

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/15 13:26:25+02:00 michal@nb-rokos.nx.cz 
#   Fixes for ifdef code wrapping for ! CONFIG_PROC_FS setup.
# 
# net/irda/ircomm/ircomm_tty.c
#   2004/10/15 13:26:12+02:00 michal@nb-rokos.nx.cz +1 -1
#   Move ifdef more on top, so no /proc related code is compiled when ! 
CONFIG_PROC_FS.
# 
# net/ipv6/tcp_ipv6.c
#   2004/10/15 13:26:11+02:00 michal@nb-rokos.nx.cz +1 -1
#   Move ifdef more on top, so no /proc related code is compiled when ! 
CONFIG_PROC_FS.
# 
# net/ipv6/route.c
#   2004/10/15 13:26:11+02:00 michal@nb-rokos.nx.cz +2 -0
#   Fix 1 missing bit for ! CONFIG_PROC_FS setup.
# 
# net/ipv6/netfilter/ip6_queue.c
#   2004/10/15 13:26:11+02:00 michal@nb-rokos.nx.cz +2 -0
#   Exclude /proc related code when ! CONFIG_PROC_FS.
# 
# net/core/neighbour.c
#   2004/10/15 13:26:11+02:00 michal@nb-rokos.nx.cz +3 -0
#   Fix 1 missing bit for ! CONFIG_PROC_FS setup.
# 
diff -Nru a/net/core/neighbour.c b/net/core/neighbour.c
--- a/net/core/neighbour.c 2004-10-15 14:25:44 +02:00
+++ b/net/core/neighbour.c 2004-10-15 14:25:44 +02:00
@@ -61,7 +61,10 @@
 
 static int neigh_glbl_allocs;
 static struct neigh_table *neigh_tables;
+
+#ifdef CONFIG_PROC_FS
 static struct file_operations neigh_stat_seq_fops;
+#endif
 
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.
diff -Nru a/net/ipv6/netfilter/ip6_queue.c 
b/net/ipv6/netfilter/ip6_queue.c
--- a/net/ipv6/netfilter/ip6_queue.c 2004-10-15 14:25:44 +02:00
+++ b/net/ipv6/netfilter/ip6_queue.c 2004-10-15 14:25:44 +02:00
@@ -622,6 +622,7 @@
  { .ctl_name = 0 }
 };
 
+#ifdef CONFIG_PROC_FS
 static int
 ipq_get_info(char *buffer, char **start, off_t offset, int length)
 {
@@ -651,6 +652,7 @@
   len = 0;
  return len;
 }
+#endif
 
 static int
 init_or_cleanup(int init)
diff -Nru a/net/ipv6/route.c b/net/ipv6/route.c
--- a/net/ipv6/route.c 2004-10-15 14:25:44 +02:00
+++ b/net/ipv6/route.c 2004-10-15 14:25:44 +02:00
@@ -2066,7 +2066,9 @@
 
 void __init ip6_route_init(void)
 {
+#ifdef  CONFIG_PROC_FS
  struct proc_dir_entry *p;
+#endif
 
  ip6_dst_ops.kmem_cachep = kmem_cache_create("ip6_dst_cache",
            sizeof(struct rt6_info),
diff -Nru a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
--- a/net/ipv6/tcp_ipv6.c 2004-10-15 14:25:44 +02:00
+++ b/net/ipv6/tcp_ipv6.c 2004-10-15 14:25:44 +02:00
@@ -1960,6 +1960,7 @@
 }
 
 /* Proc filesystem TCPv6 sock list dumping. */
+#ifdef CONFIG_PROC_FS
 static void get_openreq6(struct seq_file *seq, 
     struct sock *sk, struct open_request *req, int i, int uid)
 {
@@ -2070,7 +2071,6 @@
      atomic_read(&tw->tw_refcnt), tw);
 }
 
-#ifdef CONFIG_PROC_FS
 static int tcp6_seq_show(struct seq_file *seq, void *v)
 {
  struct tcp_iter_state *st;
diff -Nru a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
--- a/net/irda/ircomm/ircomm_tty.c 2004-10-15 14:25:44 +02:00
+++ b/net/irda/ircomm/ircomm_tty.c 2004-10-15 14:25:44 +02:00
@@ -1268,6 +1268,7 @@
  self->flow = cmd;
 }
 
+#ifdef CONFIG_PROC_FS
 static int ircomm_tty_line_info(struct ircomm_tty_cb *self, char *buf)
 {
         int  ret=0;
@@ -1377,7 +1378,6 @@
  *    
  *
  */
-#ifdef CONFIG_PROC_FS
 static int ircomm_tty_read_proc(char *buf, char **start, off_t offset, 
int len,
     int *eof, void *unused)
 {

