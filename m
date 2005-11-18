Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVKRR01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVKRR01 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKRR01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:26:27 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:9898 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932332AbVKRR0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:26:10 -0500
Subject: [PATCH 3/5] slab: extract slabinfo header printing to separate function
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       manfred@colorfullife.com
Content-Type: text/plain
Message-Id: <iq5uuc.zmsv6.a6p8qowodnwx9kaa8jonhv8n3.beaver@cs.helsinki.fi>
In-Reply-To: <iq5uu6.r1w80m.fi2lra14o0wdqqk5ln4hwlcm.beaver@cs.helsinki.fi>
Date: Fri, 18 Nov 2005 19:20:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch extracts slabinfo header printing to a separate function
print_slabinfo_header() to make s_start() more readable.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 slab.c |   45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -3369,32 +3369,37 @@ next:
 
 #ifdef CONFIG_PROC_FS
 
-static void *s_start(struct seq_file *m, loff_t *pos)
+static inline void print_slabinfo_header(struct seq_file *m)
 {
-	loff_t n = *pos;
-	struct list_head *p;
-
-	down(&cache_chain_sem);
-	if (!n) {
-		/*
-		 * Output format version, so at least we can change it
-		 * without _too_ many complaints.
-		 */
+	/*
+	 * Output format version, so at least we can change it
+	 * without _too_ many complaints.
+	 */
 #if STATS
-		seq_puts(m, "slabinfo - version: 2.1 (statistics)\n");
+	seq_puts(m, "slabinfo - version: 2.1 (statistics)\n");
 #else
-		seq_puts(m, "slabinfo - version: 2.1\n");
+	seq_puts(m, "slabinfo - version: 2.1\n");
 #endif
-		seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
-		seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
-		seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
+	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> "
+		 "<objperslab> <pagesperslab>");
+	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
+	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 #if STATS
-		seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped>"
-				" <error> <maxfreeable> <nodeallocs> <remotefrees>");
-		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
+	seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> "
+		 "<error> <maxfreeable> <nodeallocs> <remotefrees>");
+	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
-		seq_putc(m, '\n');
-	}
+	seq_putc(m, '\n');
+}
+
+static void *s_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t n = *pos;
+	struct list_head *p;
+
+	down(&cache_chain_sem);
+	if (!n)
+		print_slabinfo_header(m);
 	p = cache_chain.next;
 	while (n--) {
 		p = p->next;
