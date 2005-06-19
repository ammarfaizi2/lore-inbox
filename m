Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVFSUJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVFSUJr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 16:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVFSUJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 16:09:47 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:6870 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262267AbVFSUJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 16:09:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=spLmugZbOz9jgBBXGdv86c2fDiHejAH5IGnLr+/N6sB8eVYo8ZuMDj+MR1CYhwr9UKeH1HOLF5O14z6uha/c7ZWkFFIVQVj8EIjHVPunzO+ieqv/f/yPumKJr+xcfvgP9iuIe0pnSilqlECqwl8NHtQbUWOhPBWs/LbP36uIsE4=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>
Subject: [PATCH] selinux: endian annotations
Date: Mon, 20 Jun 2005 00:14:44 +0400
User-Agent: KMail/1.7.2
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506200014.44614.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 security/selinux/avc.c            |    4 ++--
 security/selinux/ss/avtab.c       |    4 ++--
 security/selinux/ss/conditional.c |   12 ++++++++----
 security/selinux/ss/ebitmap.c     |    5 +++--
 security/selinux/ss/policydb.c    |   37 ++++++++++++++++++++++++-------------
 5 files changed, 39 insertions(+), 23 deletions(-)

Index: linux-sparse/security/selinux/avc.c
===================================================================
--- linux-sparse.orig/security/selinux/avc.c	2005-06-14 08:21:51.000000000 +0400
+++ linux-sparse/security/selinux/avc.c	2005-06-15 02:10:40.000000000 +0400
@@ -490,7 +490,7 @@ out:
 }
 
 static inline void avc_print_ipv6_addr(struct audit_buffer *ab,
-				       struct in6_addr *addr, u16 port,
+				       struct in6_addr *addr, __be16 port,
 				       char *name1, char *name2)
 {
 	if (!ipv6_addr_any(addr))
@@ -501,7 +501,7 @@ static inline void avc_print_ipv6_addr(s
 }
 
 static inline void avc_print_ipv4_addr(struct audit_buffer *ab, u32 addr,
-				       u16 port, char *name1, char *name2)
+				       __be16 port, char *name1, char *name2)
 {
 	if (addr)
 		audit_log_format(ab, " %s=%d.%d.%d.%d", name1, NIPQUAD(addr));
Index: linux-sparse/security/selinux/ss/ebitmap.c
===================================================================
--- linux-sparse.orig/security/selinux/ss/ebitmap.c	2005-06-14 08:21:52.000000000 +0400
+++ linux-sparse/security/selinux/ss/ebitmap.c	2005-06-15 02:10:45.000000000 +0400
@@ -196,8 +196,9 @@ int ebitmap_read(struct ebitmap *e, void
 {
 	int rc;
 	struct ebitmap_node *n, *l;
-	u32 buf[3], mapsize, count, i;
-	u64 map;
+	__le32 buf[3];
+	u32 mapsize, count, i;
+	__le64 map;
 
 	ebitmap_init(e);
 
Index: linux-sparse/security/selinux/ss/avtab.c
===================================================================
--- linux-sparse.orig/security/selinux/ss/avtab.c	2005-06-15 02:10:45.000000000 +0400
+++ linux-sparse/security/selinux/ss/avtab.c	2005-06-15 02:12:44.000000000 +0400
@@ -280,7 +280,7 @@ void avtab_hash_eval(struct avtab *h, ch
 
 int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey)
 {
-	u32 buf[7];
+	__le32 buf[7];
 	u32 items, items2;
 	int rc;
 
@@ -347,7 +347,7 @@ int avtab_read(struct avtab *a, void *fp
 	int rc;
 	struct avtab_key avkey;
 	struct avtab_datum avdatum;
-	u32 buf[1];
+	__le32 buf[1];
 	u32 nel, i;
 
 
Index: linux-sparse/security/selinux/ss/policydb.c
===================================================================
--- linux-sparse.orig/security/selinux/ss/policydb.c	2005-06-15 02:10:45.000000000 +0400
+++ linux-sparse/security/selinux/ss/policydb.c	2005-06-15 02:19:09.000000000 +0400
@@ -719,7 +719,8 @@ int policydb_context_isvalid(struct poli
  */
 static int mls_read_range_helper(struct mls_range *r, void *fp)
 {
-	u32 buf[2], items;
+	__le32 buf[2];
+	u32 items;
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof(u32));
@@ -780,7 +781,7 @@ static int context_read_and_validate(str
 				     struct policydb *p,
 				     void *fp)
 {
-	u32 buf[3];
+	__le32 buf[3];
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof buf);
@@ -820,7 +821,8 @@ static int perm_read(struct policydb *p,
 	char *key = NULL;
 	struct perm_datum *perdatum;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	perdatum = kmalloc(sizeof(*perdatum), GFP_KERNEL);
 	if (!perdatum) {
@@ -860,7 +862,8 @@ static int common_read(struct policydb *
 {
 	char *key = NULL;
 	struct common_datum *comdatum;
-	u32 buf[4], len, nel;
+	__le32 buf[4];
+	u32 len, nel;
 	int i, rc;
 
 	comdatum = kmalloc(sizeof(*comdatum), GFP_KERNEL);
@@ -914,7 +917,8 @@ static int read_cons_helper(struct const
 {
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
-	u32 buf[3], nexpr;
+	__le32 buf[3];
+	u32 nexpr;
 	int rc, i, j, depth;
 
 	lc = NULL;
@@ -998,7 +1002,8 @@ static int class_read(struct policydb *p
 {
 	char *key = NULL;
 	struct class_datum *cladatum;
-	u32 buf[6], len, len2, ncons, nel;
+	__le32 buf[6];
+	u32 len, len2, ncons, nel;
 	int i, rc;
 
 	cladatum = kmalloc(sizeof(*cladatum), GFP_KERNEL);
@@ -1092,7 +1097,8 @@ static int role_read(struct policydb *p,
 	char *key = NULL;
 	struct role_datum *role;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	role = kmalloc(sizeof(*role), GFP_KERNEL);
 	if (!role) {
@@ -1152,7 +1158,8 @@ static int type_read(struct policydb *p,
 	char *key = NULL;
 	struct type_datum *typdatum;
 	int rc;
-	u32 buf[3], len;
+	__le32 buf[3];
+	u32 len;
 
 	typdatum = kmalloc(sizeof(*typdatum),GFP_KERNEL);
 	if (!typdatum) {
@@ -1196,7 +1203,7 @@ bad:
  */
 static int mls_read_level(struct mls_level *lp, void *fp)
 {
-	u32 buf[1];
+	__le32 buf[1];
 	int rc;
 
 	memset(lp, 0, sizeof(*lp));
@@ -1224,7 +1231,8 @@ static int user_read(struct policydb *p,
 	char *key = NULL;
 	struct user_datum *usrdatum;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	usrdatum = kmalloc(sizeof(*usrdatum), GFP_KERNEL);
 	if (!usrdatum) {
@@ -1278,7 +1286,8 @@ static int sens_read(struct policydb *p,
 	char *key = NULL;
 	struct level_datum *levdatum;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	levdatum = kmalloc(sizeof(*levdatum), GFP_ATOMIC);
 	if (!levdatum) {
@@ -1329,7 +1338,8 @@ static int cat_read(struct policydb *p, 
 	char *key = NULL;
 	struct cat_datum *catdatum;
 	int rc;
-	u32 buf[3], len;
+	__le32 buf[3];
+	u32 len;
 
 	catdatum = kmalloc(sizeof(*catdatum), GFP_ATOMIC);
 	if (!catdatum) {
@@ -1392,7 +1402,8 @@ int policydb_read(struct policydb *p, vo
 	struct ocontext *l, *c, *newc;
 	struct genfs *genfs_p, *genfs, *newgenfs;
 	int i, j, rc;
-	u32 buf[8], len, len2, config, nprim, nel, nel2;
+	__le32 buf[8];
+	u32 len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
 	struct range_trans *rt, *lrt;
Index: linux-sparse/security/selinux/ss/conditional.c
===================================================================
--- linux-sparse.orig/security/selinux/ss/conditional.c	2005-06-15 02:10:45.000000000 +0400
+++ linux-sparse/security/selinux/ss/conditional.c	2005-06-15 02:22:25.000000000 +0400
@@ -219,7 +219,8 @@ int cond_read_bool(struct policydb *p, s
 {
 	char *key = NULL;
 	struct cond_bool_datum *booldatum;
-	u32 buf[3], len;
+	__le32 buf[3];
+	u32 len;
 	int rc;
 
 	booldatum = kmalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
@@ -263,7 +264,8 @@ static int cond_read_av_list(struct poli
 	struct avtab_datum datum;
 	struct avtab_node *node_ptr;
 	int rc;
-	u32 buf[1], i, len;
+	__le32 buf[1];
+	u32 i, len;
 	u8 found;
 
 	*ret_list = NULL;
@@ -369,7 +371,8 @@ static int expr_isvalid(struct policydb 
 
 static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 {
-	u32 buf[2], len, i;
+	__le32 buf[2];
+	u32 len, i;
 	int rc;
 	struct cond_expr *expr = NULL, *last = NULL;
 
@@ -427,7 +430,8 @@ err:
 int cond_read_list(struct policydb *p, void *fp)
 {
 	struct cond_node *node, *last = NULL;
-	u32 buf[1], i, len;
+	__le32 buf[1];
+	u32 i, len;
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof buf);
