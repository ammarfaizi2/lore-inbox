Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVCTL7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVCTL7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVCTL7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:59:36 -0500
Received: from coderock.org ([193.77.147.115]:652 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262146AbVCTL7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:59:23 -0500
Date: Sun, 20 Mar 2005 12:59:16 +0100
From: Domen Puncer <domen@coderock.org>
To: sds@epoch.ncsc.mil
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 1/4 with proper signed-off] security/selinux/ss/policydb.c: fix sparse warnings
Message-ID: <20050320115916.GT14273@nd47.coderock.org>
References: <20050319131938.E04781ECA8@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131938.E04781ECA8@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/security/selinux/ss/policydb.c |   35 ++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff -puN security/selinux/ss/policydb.c~sparse-security_selinux_ss_policydb security/selinux/ss/policydb.c
--- kj/security/selinux/ss/policydb.c~sparse-security_selinux_ss_policydb	2005-03-20 12:11:25.000000000 +0100
+++ kj-domen/security/selinux/ss/policydb.c	2005-03-20 12:11:25.000000000 +0100
@@ -780,7 +780,7 @@ static int context_read_and_validate(str
 				     struct policydb *p,
 				     void *fp)
 {
-	u32 buf[3];
+	__le32 buf[3];
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof buf);
@@ -820,7 +820,8 @@ static int perm_read(struct policydb *p,
 	char *key = NULL;
 	struct perm_datum *perdatum;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	perdatum = kmalloc(sizeof(*perdatum), GFP_KERNEL);
 	if (!perdatum) {
@@ -860,7 +861,8 @@ static int common_read(struct policydb *
 {
 	char *key = NULL;
 	struct common_datum *comdatum;
-	u32 buf[4], len, nel;
+	__le32 buf[4];
+	u32 len, nel;
 	int i, rc;
 
 	comdatum = kmalloc(sizeof(*comdatum), GFP_KERNEL);
@@ -1092,7 +1094,8 @@ static int role_read(struct policydb *p,
 	char *key = NULL;
 	struct role_datum *role;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	role = kmalloc(sizeof(*role), GFP_KERNEL);
 	if (!role) {
@@ -1152,7 +1155,8 @@ static int type_read(struct policydb *p,
 	char *key = NULL;
 	struct type_datum *typdatum;
 	int rc;
-	u32 buf[3], len;
+	__le32 buf[3];
+	u32 len;
 
 	typdatum = kmalloc(sizeof(*typdatum),GFP_KERNEL);
 	if (!typdatum) {
@@ -1224,7 +1228,8 @@ static int user_read(struct policydb *p,
 	char *key = NULL;
 	struct user_datum *usrdatum;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	usrdatum = kmalloc(sizeof(*usrdatum), GFP_KERNEL);
 	if (!usrdatum) {
@@ -1392,7 +1397,8 @@ int policydb_read(struct policydb *p, vo
 	struct ocontext *l, *c, *newc;
 	struct genfs *genfs_p, *genfs, *newgenfs;
 	int i, j, rc;
-	u32 buf[8], len, len2, config, nprim, nel, nel2;
+	__le32 buf[8];
+	u32 len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
 	struct range_trans *rt, *lrt;
@@ -1408,17 +1414,14 @@ int policydb_read(struct policydb *p, vo
 	if (rc < 0)
 		goto bad;
 
-	for (i = 0; i < 2; i++)
-		buf[i] = le32_to_cpu(buf[i]);
-
-	if (buf[0] != POLICYDB_MAGIC) {
+	if (buf[0] != cpu_to_le32(POLICYDB_MAGIC)) {
 		printk(KERN_ERR "security:  policydb magic number 0x%x does "
 		       "not match expected magic number 0x%x\n",
-		       buf[0], POLICYDB_MAGIC);
+		       le32_to_cpu(buf[0]), POLICYDB_MAGIC);
 		goto bad;
 	}
 
-	len = buf[1];
+	len = le32_to_cpu(buf[1]);
 	if (len != strlen(POLICYDB_STRING)) {
 		printk(KERN_ERR "security:  policydb string length %d does not "
 		       "match expected length %Zu\n",
@@ -1494,9 +1497,11 @@ int policydb_read(struct policydb *p, vo
 		goto bad;
 	}
 
-	if (buf[2] != info->sym_num || buf[3] != info->ocon_num) {
+	if (le32_to_cpu(buf[2]) != info->sym_num ||
+	    le32_to_cpu(buf[3]) != info->ocon_num) {
 		printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
-		       "not match mine (%d,%d)\n", buf[2], buf[3],
+		       "not match mine (%d,%d)\n",
+		       le32_to_cpu(buf[2]), le32_to_cpu(buf[3]),
 		       info->sym_num, info->ocon_num);
 		goto bad;
 	}
_
