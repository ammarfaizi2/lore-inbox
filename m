Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbTIFBuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbTIFBtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:49:07 -0400
Received: from DSL022.LABridge.com ([206.117.136.22]:16400 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S263598AbTIFBsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:48:18 -0400
Subject: [PATCH] 2.6.0-test4 SEQ_START_TOKEN fs/* (6/6)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Content-Type: text/plain
Message-Id: <1062812902.16851.173.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 18:48:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.6.0-test4/fs/afs/proc.c SEQ_START_TOKEN/fs/afs/proc.c
-- linux-2.6.0-test4/fs/afs/proc.c	2003-08-22 16:53:39.000000000 -0700
+++ SEQ_START_TOKEN/fs/afs/proc.c	2003-09-04 20:13:29.000000000 -0700
@@ -188,7 +188,7 @@
 
 	/* allow for the header line */
 	if (!pos)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	pos--;
 
 	/* find the n'th element in the list */
@@ -210,7 +210,7 @@
 	(*pos)++;
 
 	_p = v;
-	_p = v==(void*)1 ? afs_proc_cells.next : _p->next;
+	_p = v==SEQ_START_TOKEN ? afs_proc_cells.next : _p->next;
 
 	return _p!=&afs_proc_cells ? _p : NULL;
 } /* end afs_proc_cells_next() */
@@ -234,7 +234,7 @@
 	afs_cell_t *cell = list_entry(v,afs_cell_t,proc_link);
 
 	/* display header on line 1 */
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(m, "USE NAME\n");
 		return 0;
 	}
@@ -432,7 +432,7 @@
 
 	/* allow for the header line */
 	if (!pos)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	pos--;
 
 	/* find the n'th element in the list */
@@ -457,7 +457,7 @@
 	(*_pos)++;
 
 	_p = v;
-	_p = v==(void*)1 ? cell->vl_list.next : _p->next;
+	_p = v==SEQ_START_TOKEN ? cell->vl_list.next : _p->next;
 
 	return _p!=&cell->vl_list ? _p : NULL;
 } /* end afs_proc_cell_volumes_next() */
@@ -483,7 +483,7 @@
 	afs_vlocation_t *vlocation = list_entry(v,afs_vlocation_t,link);
 
 	/* display header on line 1 */
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(m, "USE VLID[0]  VLID[1]  VLID[2]  NAME\n");
 		return 0;
 	}
@@ -556,7 +556,7 @@
 
 	/* allow for the header line */
 	if (!pos)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	pos--;
 
 	if (pos>=cell->vl_naddrs)
@@ -673,7 +673,7 @@
 
 	/* allow for the header line */
 	if (!pos)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	pos--;
 
 	/* find the n'th element in the list */
@@ -698,7 +698,7 @@
 	(*_pos)++;
 
 	_p = v;
-	_p = v==(void*)1 ? cell->sv_list.next : _p->next;
+	_p = v==SEQ_START_TOKEN ? cell->sv_list.next : _p->next;
 
 	return _p!=&cell->sv_list ? _p : NULL;
 } /* end afs_proc_cell_servers_next() */
@@ -725,7 +725,7 @@
 	char ipaddr[20];
 
 	/* display header on line 1 */
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(m, "USE ADDR            STATE\n");
 		return 0;
 	}
diff -urN linux-2.6.0-test4/fs/nfsd/export.c SEQ_START_TOKEN/fs/nfsd/export.c
-- linux-2.6.0-test4/fs/nfsd/export.c	2003-08-22 16:57:00.000000000 -0700
+++ SEQ_START_TOKEN/fs/nfsd/export.c	2003-09-04 19:51:24.000000000 -0700
@@ -935,7 +935,7 @@
 	exp_readlock();
 	read_lock(&svc_export_cache.hash_lock);
 	if (!n--)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	hash = n >> 32;
 	export = n & ((1LL<<32) - 1);
 
@@ -959,7 +959,7 @@
 	struct cache_head *ch = p;
 	int hash = (*pos >> 32);
 
-	if (p == (void *)1)
+	if (p == SEQ_START_TOKEN)
 		hash = 0;
 	else if (ch->next == NULL) {
 		hash++;
@@ -1029,7 +1029,7 @@
 	struct svc_export *exp = container_of(cp, struct svc_export, h);
 	svc_client *clp;
 
-	if (p == (void *)1) {
+	if (p == SEQ_START_TOKEN) {
 		seq_puts(m, "# Version 1.1\n");
 		seq_puts(m, "# Path Client(Flags) # IPs\n");
 		return 0;


