Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVCSN70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVCSN70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVCSNyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:54:04 -0500
Received: from coderock.org ([193.77.147.115]:52360 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262562AbVCSNT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:19:57 -0500
Subject: [patch 4/4] security/selinux/ss/conditional.c: fix sparse warnings
To: sds@epoch.ncsc.mil
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, domen@coderock.org,
       adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:19:48 +0100
Message-Id: <20050319131948.84AC51F1EE@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/security/selinux/ss/conditional.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff -puN security/selinux/ss/conditional.c~sparse-security_selinux_ss_conditional security/selinux/ss/conditional.c
--- kj/security/selinux/ss/conditional.c~sparse-security_selinux_ss_conditional	2005-03-18 20:05:33.000000000 +0100
+++ kj-domen/security/selinux/ss/conditional.c	2005-03-18 20:05:33.000000000 +0100
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
_
