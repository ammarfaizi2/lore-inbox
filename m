Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265325AbUGGT0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUGGT0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 15:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUGGT0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 15:26:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:60057 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265325AbUGGTZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 15:25:36 -0400
Date: Wed, 7 Jul 2004 12:25:25 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Mika Kukkonen <mika@osdl.org>
Subject: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040707122525.X1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup another round of sparse warnings of the type:
	warning: Using plain integer as NULL pointer
Acked by Stephen.  Rediffed against bk-current.

From: Mika Kukkonen <mika@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/selinux/avc.c 1.13 vs edited =====
--- 1.13/security/selinux/avc.c	2004-07-05 03:32:34 -07:00
+++ edited/security/selinux/avc.c	2004-07-07 12:15:48 -07:00
@@ -106,7 +106,7 @@
  */
 void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 {
-	char **common_pts = 0;
+	char **common_pts = NULL;
 	u32 common_base = 0;
 	int i, i2, perm;
 
@@ -734,7 +734,7 @@
 		}
 	} else {
 		/* apply to one node */
-		node = avc_search_node(ssid, tsid, tclass, 0);
+		node = avc_search_node(ssid, tsid, tclass, NULL);
 		if (node) {
 			avc_update_node(event,node,perms);
 		}
@@ -808,7 +808,7 @@
                  u32 perms, u32 seqno)
 {
 	return avc_control(AVC_CALLBACK_GRANT,
-			   ssid, tsid, tclass, perms, seqno, 0);
+			   ssid, tsid, tclass, perms, seqno, NULL);
 }
 
 /**
@@ -846,7 +846,7 @@
                   u32 perms, u32 seqno)
 {
 	return avc_control(AVC_CALLBACK_REVOKE,
-			   ssid, tsid, tclass, perms, seqno, 0);
+			   ssid, tsid, tclass, perms, seqno, NULL);
 }
 
 /**
@@ -878,7 +878,7 @@
 			avc_node_freelist = tmp;
 			avc_cache.active_nodes--;
 		}
-		avc_cache.slots[i] = 0;
+		avc_cache.slots[i] = NULL;
 	}
 	avc_cache.lru_hint = 0;
 
@@ -890,7 +890,7 @@
 	for (c = avc_callbacks; c; c = c->next) {
 		if (c->events & AVC_CALLBACK_RESET) {
 			rc = c->callback(AVC_CALLBACK_RESET,
-					 0, 0, 0, 0, 0);
+					 0, 0, 0, 0, NULL);
 			if (rc)
 				goto out;
 		}
@@ -918,10 +918,10 @@
 {
 	if (enable)
 		return avc_control(AVC_CALLBACK_AUDITALLOW_ENABLE,
-				   ssid, tsid, tclass, perms, seqno, 0);
+				   ssid, tsid, tclass, perms, seqno, NULL);
 	else
 		return avc_control(AVC_CALLBACK_AUDITALLOW_DISABLE,
-				   ssid, tsid, tclass, perms, seqno, 0);
+				   ssid, tsid, tclass, perms, seqno, NULL);
 }
 
 /**
@@ -938,10 +938,10 @@
 {
 	if (enable)
 		return avc_control(AVC_CALLBACK_AUDITDENY_ENABLE,
-				   ssid, tsid, tclass, perms, seqno, 0);
+				   ssid, tsid, tclass, perms, seqno, NULL);
 	else
 		return avc_control(AVC_CALLBACK_AUDITDENY_DISABLE,
-				   ssid, tsid, tclass, perms, seqno, 0);
+				   ssid, tsid, tclass, perms, seqno, NULL);
 }
 
 /**
@@ -993,7 +993,7 @@
 			ae->used = 1;
 		} else {
 			avc_cache_stats_incr(AVC_ENTRY_DISCARDS);
-			ae = 0;
+			ae = NULL;
 		}
 	}
 
===== security/selinux/ss/conditional.c 1.1 vs edited =====
--- 1.1/security/selinux/ss/conditional.c	2004-03-16 02:29:22 -08:00
+++ edited/security/selinux/ss/conditional.c	2004-07-07 12:15:48 -07:00
@@ -217,7 +217,7 @@
 
 int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	struct cond_bool_datum *booldatum;
 	__u32 *buf, len;
 
@@ -251,7 +251,7 @@
 
 	return 0;
 err:
-	cond_destroy_bool(key, booldatum, 0);
+	cond_destroy_bool(key, booldatum, NULL);
 	return -1;
 }
 
===== security/selinux/ss/ebitmap.c 1.3 vs edited =====
--- 1.3/security/selinux/ss/ebitmap.c	2003-12-30 00:40:54 -08:00
+++ edited/security/selinux/ss/ebitmap.c	2004-07-07 12:15:48 -07:00
@@ -17,7 +17,7 @@
 
 	n1 = e1->node;
 	n2 = e2->node;
-	prev = 0;
+	prev = NULL;
 	while (n1 || n2) {
 		new = kmalloc(sizeof(*new), GFP_ATOMIC);
 		if (!new) {
@@ -40,7 +40,7 @@
 			n2 = n2->next;
 		}
 
-		new->next = 0;
+		new->next = NULL;
 		if (prev)
 			prev->next = new;
 		else
@@ -80,7 +80,7 @@
 
 	ebitmap_init(dst);
 	n = src->node;
-	prev = 0;
+	prev = NULL;
 	while (n) {
 		new = kmalloc(sizeof(*new), GFP_ATOMIC);
 		if (!new) {
@@ -90,7 +90,7 @@
 		memset(new, 0, sizeof(*new));
 		new->startbit = n->startbit;
 		new->map = n->map;
-		new->next = 0;
+		new->next = NULL;
 		if (prev)
 			prev->next = new;
 		else
@@ -155,7 +155,7 @@
 {
 	struct ebitmap_node *n, *prev, *new;
 
-	prev = 0;
+	prev = NULL;
 	n = e->node;
 	while (n && n->startbit <= bit) {
 		if ((n->startbit + MAPSIZE) > bit) {
@@ -231,7 +231,7 @@
 	}
 
 	e->highbit = 0;
-	e->node = 0;
+	e->node = NULL;
 	return;
 }
 
===== security/selinux/ss/mls.c 1.4 vs edited =====
--- 1.4/security/selinux/ss/mls.c	2004-06-03 01:46:38 -07:00
+++ edited/security/selinux/ss/mls.c	2004-07-07 12:15:48 -07:00
@@ -654,7 +654,7 @@
 
 int sens_read(struct policydb *p, struct hashtab *h, void *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	struct level_datum *levdatum;
 	int rc;
 	u32 *buf, len;
@@ -707,7 +707,7 @@
 
 int cat_read(struct policydb *p, struct hashtab *h, void *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	struct cat_datum *catdatum;
 	int rc;
 	u32 *buf, len;
===== security/selinux/ss/policydb.c 1.12 vs edited =====
--- 1.12/security/selinux/ss/policydb.c	2004-06-18 11:43:31 -07:00
+++ edited/security/selinux/ss/policydb.c	2004-07-07 12:15:48 -07:00
@@ -99,7 +99,7 @@
  */
 int roles_init(struct policydb *p)
 {
-	char *key = 0;
+	char *key = NULL;
 	int rc;
 	struct role_datum *role;
 
@@ -402,7 +402,7 @@
 
 	kfree(key);
 	comdatum = datum;
-	hashtab_map(comdatum->permissions.table, perm_destroy, 0);
+	hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
 	hashtab_destroy(comdatum->permissions.table);
 	kfree(datum);
 	return 0;
@@ -416,7 +416,7 @@
 
 	kfree(key);
 	cladatum = datum;
-	hashtab_map(cladatum->permissions.table, perm_destroy, 0);
+	hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
 	hashtab_destroy(cladatum->permissions.table);
 	constraint = cladatum->constraints;
 	while (constraint) {
@@ -498,7 +498,7 @@
 	int i;
 
 	for (i = 0; i < SYM_NUM; i++) {
-		hashtab_map(p->symtab[i].table, destroy_f[i], 0);
+		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
 		hashtab_destroy(p->symtab[i].table);
 	}
 
@@ -669,7 +669,7 @@
 
 static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	struct perm_datum *perdatum;
 	int rc;
 	u32 *buf, len;
@@ -718,7 +718,7 @@
 
 static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	struct common_datum *comdatum;
 	u32 *buf, len, nel;
 	int i, rc;
@@ -776,7 +776,7 @@
 
 static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	struct class_datum *cladatum;
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
@@ -943,7 +943,7 @@
 
 static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	struct role_datum *role;
 	int rc;
 	u32 *buf, len;
@@ -1008,7 +1008,7 @@
 
 static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	struct type_datum *typdatum;
 	int rc;
 	u32 *buf, len;
@@ -1055,7 +1055,7 @@
 
 static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 {
-	char *key = 0;
+	char *key = NULL;
 	struct user_datum *usrdatum;
 	int rc;
 	u32 *buf, len;
===== security/selinux/ss/services.c 1.16 vs edited =====
--- 1.16/security/selinux/ss/services.c	2004-06-18 11:43:31 -07:00
+++ edited/security/selinux/ss/services.c	2004-07-07 12:15:48 -07:00
@@ -308,7 +308,7 @@
 			u32 requested,
 			struct av_decision *avd)
 {
-	struct context *scontext = 0, *tcontext = 0;
+	struct context *scontext = NULL, *tcontext = NULL;
 	int rc = 0;
 
 	if (!ss_initialized) {
@@ -355,7 +355,7 @@
 {
 	char *scontextp;
 
-	*scontext = 0;
+	*scontext = NULL;
 	*scontext_len = 0;
 
 	/* Compute the size of the context. */
@@ -600,8 +600,8 @@
 				u32 specified,
 				u32 *out_sid)
 {
-	struct context *scontext = 0, *tcontext = 0, newcontext;
-	struct role_trans *roletr = 0;
+	struct context *scontext = NULL, *tcontext = NULL, newcontext;
+	struct role_trans *roletr = NULL;
 	struct avtab_key avkey;
 	struct avtab_datum *avdatum;
 	struct avtab_node *node;
