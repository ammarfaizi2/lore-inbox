Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946248AbWBDBKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946248AbWBDBKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946247AbWBDBKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:10:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42767 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946245AbWBDBKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:10:04 -0500
Date: Sat, 4 Feb 2006 02:10:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: per.liden@ericsson.com, jon.maloy@ericsson.com,
       allan.stephens@windriver.com, tipc-discussion@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] net/tipc/: possible cleanups
Message-ID: <20060204011002.GZ4408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - name_table.c: tipc_nametbl_print()
  - name_table.c: tipc_nametbl_dump()
  - net.c: tipc_net_next_node()


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 26 Jan 2006

 net/tipc/bcast.c      |    9 +++++----
 net/tipc/cluster.c    |   11 +++++------
 net/tipc/discover.c   |    8 ++++----
 net/tipc/name_table.c |   27 ++++++++++++++++++---------
 net/tipc/net.c        |    3 ++-
 net/tipc/node.c       |    2 +-
 6 files changed, 35 insertions(+), 25 deletions(-)

--- linux-2.6.16-rc1-mm3-full/net/tipc/bcast.c.old	2006-01-26 06:56:41.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/net/tipc/bcast.c	2006-01-26 06:57:33.000000000 +0100
@@ -314,7 +314,8 @@
  * Only tipc_net_lock set.
  */
 
-void tipc_bclink_peek_nack(u32 dest, u32 sender_tag, u32 gap_after, u32 gap_to)
+static void tipc_bclink_peek_nack(u32 dest, u32 sender_tag, u32 gap_after,
+				  u32 gap_to)
 {
 	struct node *n_ptr = tipc_node_find(dest);
 	u32 my_after, my_to;
@@ -525,9 +526,9 @@
  * Returns 0 if packet sent successfully, non-zero if not
  */
 
-int tipc_bcbearer_send(struct sk_buff *buf,
-		       struct tipc_bearer *unused1,
-		       struct tipc_media_addr *unused2)
+static int tipc_bcbearer_send(struct sk_buff *buf,
+			      struct tipc_bearer *unused1,
+			      struct tipc_media_addr *unused2)
 {
 	static int send_count = 0;
 
--- linux-2.6.16-rc1-mm3-full/net/tipc/cluster.c.old	2006-01-26 06:57:51.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/net/tipc/cluster.c	2006-01-26 06:58:31.000000000 +0100
@@ -44,9 +44,8 @@
 #include "msg.h"
 #include "bearer.h"
 
-void tipc_cltr_multicast(struct cluster *c_ptr, struct sk_buff *buf, 
-			 u32 lower, u32 upper);
-struct sk_buff *tipc_cltr_prepare_routing_msg(u32 data_size, u32 dest);
+static void tipc_cltr_multicast(struct cluster *c_ptr, struct sk_buff *buf, 
+				u32 lower, u32 upper);
 
 struct node **tipc_local_nodes = 0;
 struct node_map tipc_cltr_bcast_nodes = {0,{0,}};
@@ -229,7 +228,7 @@
  *    Routing table management: See description in node.c
  */
 
-struct sk_buff *tipc_cltr_prepare_routing_msg(u32 data_size, u32 dest)
+static struct sk_buff *tipc_cltr_prepare_routing_msg(u32 data_size, u32 dest)
 {
 	u32 size = INT_H_SIZE + data_size;
 	struct sk_buff *buf = buf_acquire(size);
@@ -495,8 +494,8 @@
  * tipc_cltr_multicast - multicast message to local nodes 
  */
 
-void tipc_cltr_multicast(struct cluster *c_ptr, struct sk_buff *buf, 
-			 u32 lower, u32 upper)
+static void tipc_cltr_multicast(struct cluster *c_ptr, struct sk_buff *buf, 
+				u32 lower, u32 upper)
 {
 	struct sk_buff *buf_copy;
 	struct node *n_ptr;
--- linux-2.6.16-rc1-mm3-full/net/tipc/discover.c.old	2006-01-26 06:59:53.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/net/tipc/discover.c	2006-01-26 07:00:05.000000000 +0100
@@ -110,10 +110,10 @@
  * @b_ptr: ptr to bearer issuing message
  */
 
-struct sk_buff *tipc_disc_init_msg(u32 type,
-				   u32 req_links,
-				   u32 dest_domain,
-				   struct bearer *b_ptr)
+static struct sk_buff *tipc_disc_init_msg(u32 type,
+					  u32 req_links,
+					  u32 dest_domain,
+					  struct bearer *b_ptr)
 {
 	struct sk_buff *buf = buf_acquire(DSC_H_SIZE);
 	struct tipc_msg *msg;
--- linux-2.6.16-rc1-mm3-full/net/tipc/name_table.c.old	2006-01-26 07:00:49.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/net/tipc/name_table.c	2006-01-26 07:03:54.000000000 +0100
@@ -46,7 +46,7 @@
 #include "cluster.h"
 #include "bcast.h"
 
-int tipc_nametbl_size = 1024;		/* must be a power of 2 */
+static int tipc_nametbl_size = 1024;	/* must be a power of 2 */
 
 /**
  * struct sub_seq - container for all published instances of a name sequence
@@ -142,7 +142,7 @@
  * tipc_subseq_alloc - allocate a specified number of sub-sequence structures
  */
 
-struct sub_seq *tipc_subseq_alloc(u32 cnt)
+static struct sub_seq *tipc_subseq_alloc(u32 cnt)
 {
 	u32 sz = cnt * sizeof(struct sub_seq);
 	struct sub_seq *sseq = (struct sub_seq *)kmalloc(sz, GFP_ATOMIC);
@@ -158,7 +158,8 @@
  * Allocates a single sub-sequence structure and sets it to all 0's.
  */
 
-struct name_seq *tipc_nameseq_create(u32 type, struct hlist_head *seq_head)
+static struct name_seq *tipc_nameseq_create(u32 type,
+					    struct hlist_head *seq_head)
 {
 	struct name_seq *nseq = 
 		(struct name_seq *)kmalloc(sizeof(*nseq), GFP_ATOMIC);
@@ -243,9 +244,11 @@
  * tipc_nameseq_insert_publ - 
  */
 
-struct publication *tipc_nameseq_insert_publ(struct name_seq *nseq,
-					u32 type, u32 lower, u32 upper,
-					u32 scope, u32 node, u32 port, u32 key)
+static struct publication *tipc_nameseq_insert_publ(struct name_seq *nseq,
+						    u32 type, u32 lower,
+						    u32 upper,
+						    u32 scope, u32 node,
+						    u32 port, u32 key)
 {
 	struct subscription *s;
 	struct subscription *st;
@@ -369,8 +372,9 @@
  * tipc_nameseq_remove_publ -
  */
 
-struct publication *tipc_nameseq_remove_publ(struct name_seq *nseq, u32 inst,
-					     u32 node, u32 ref, u32 key)
+static struct publication *tipc_nameseq_remove_publ(struct name_seq *nseq,
+						    u32 inst, u32 node,
+						    u32 ref, u32 key)
 {
 	struct publication *publ;
 	struct publication *prev;
@@ -487,7 +491,8 @@
  * sequence overlapping with the requested sequence
  */
 
-void tipc_nameseq_subscribe(struct name_seq *nseq, struct subscription *s)
+static void tipc_nameseq_subscribe(struct name_seq *nseq,
+				   struct subscription *s)
 {
 	struct sub_seq *sseq = nseq->sseqs;
 
@@ -983,6 +988,7 @@
 	}
 }
 
+#if 0
 void tipc_nametbl_print(struct print_buf *buf, const char *str)
 {
 	tipc_printf(buf, str);
@@ -990,6 +996,7 @@
 	nametbl_list(buf, 0, 0, 0, 0);
 	read_unlock_bh(&tipc_nametbl_lock);
 }
+#endif  /*  0  */
 
 #define MAX_NAME_TBL_QUERY 32768
 
@@ -1023,10 +1030,12 @@
 	return buf;
 }
 
+#if 0
 void tipc_nametbl_dump(void)
 {
 	nametbl_list(TIPC_CONS, 0, 0, 0, 0);
 }
+#endif  /*  0  */
 
 int tipc_nametbl_init(void)
 {
--- linux-2.6.16-rc1-mm3-full/net/tipc/net.c.old	2006-01-26 07:04:18.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/net/tipc/net.c	2006-01-26 07:04:39.000000000 +0100
@@ -128,13 +128,14 @@
 	return tipc_zone_select_router(tipc_net.zones[tipc_zone(addr)], addr, ref);
 }
 
-
+#if 0
 u32 tipc_net_next_node(u32 a)
 {
 	if (tipc_net.zones[tipc_zone(a)])
 		return tipc_zone_next_node(a);
 	return 0;
 }
+#endif  /*  0  */
 
 void tipc_net_remove_as_router(u32 router)
 {
--- linux-2.6.16-rc1-mm3-full/net/tipc/node.c.old	2006-01-26 07:05:03.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/net/tipc/node.c	2006-01-26 07:10:36.000000000 +0100
@@ -214,7 +214,7 @@
 		(n_ptr->active_links[0] != n_ptr->active_links[1]));
 }
 
-int tipc_node_has_active_routes(struct node *n_ptr)
+static int tipc_node_has_active_routes(struct node *n_ptr)
 {
 	return (n_ptr && (n_ptr->last_router >= 0));
 }


