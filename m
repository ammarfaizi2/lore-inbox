Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVEJQ7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVEJQ7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 12:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVEJQ7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 12:59:53 -0400
Received: from mail.uni-ulm.de ([134.60.1.1]:10884 "EHLO mail.uni-ulm.de")
	by vger.kernel.org with ESMTP id S261710AbVEJQ7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 12:59:39 -0400
Date: Tue, 10 May 2005 19:01:28 +0200
From: Markus Klotzbuecher <mk@creamnet.de>
To: Eric Lammerts <eric@lammerts.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Message-ID: <20050510170127.GA13280@mary>
Mail-Followup-To: Eric Lammerts <eric@lammerts.org>,
	linux-kernel@vger.kernel.org
References: <20050509183135.GB27743@mary> <42804FA9.3020307@lammerts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42804FA9.3020307@lammerts.org>
User-Agent: Mutt/1.5.8i
X-DCC-sgs_public_dcc_server-Metrics: gemini 1199; Body=2 Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Thank you for the feedback.

On Tue, May 10, 2005 at 02:07:37AM -0400, Eric Lammerts wrote:
> Some remarks:
> Some functions return -ENOTSUPP on error, which makes "ls -l" complain 
> loudly when getxattr() fails. This should be -EOPNOTSUPP.

You're right. Fixed in attached patch.

> The module taints the kernel because of MODULE_LICENSE("LGPL").
> Since all your copyright statements say it's GPL software, better change 
> this to "GPL".

It seems to be ok to change this. Patch corrects this too.

Cheers

Markus



diff -Nru mini_fo.ORIG/inode.c mini_fo/inode.c
--- mini_fo.ORIG/inode.c	2005-05-06 23:59:08.000000000 +0200
+++ mini_fo/inode.c	2005-05-10 18:09:47.000000000 +0200
@@ -1259,7 +1259,7 @@
 STATIC int
 mini_fo_getxattr(struct dentry *dentry, const char *name, void *value, size_t size) {
 	struct dentry *hidden_dentry = NULL;
-	int err = -ENOTSUPP;
+	int err = -EOPNOTSUPP;
 	/* Define these anyway so we don't need as much ifdef'ed code. */
 	char *encoded_name = NULL;
 	char *encoded_value = NULL;
@@ -1304,7 +1304,7 @@
 
 {
 	struct dentry *hidden_dentry = NULL;
-	int err = -ENOTSUPP;
+	int err = -EOPNOTSUPP;
 
 	/* Define these anyway, so we don't have as much ifdef'ed code. */
 	char *encoded_value = NULL;
@@ -1340,7 +1340,7 @@
 STATIC int
 mini_fo_removexattr(struct dentry *dentry, const char *name) {
 	struct dentry *hidden_dentry = NULL;
-	int err = -ENOTSUPP;
+	int err = -EOPNOTSUPP;
 	char *encoded_name;
 
 	check_mini_fo_dentry(dentry);
@@ -1372,7 +1372,7 @@
 STATIC int
 mini_fo_listxattr(struct dentry *dentry, char *list, size_t size) {
 	struct dentry *hidden_dentry = NULL;
-	int err = -ENOTSUPP;
+	int err = -EOPNOTSUPP;
 	char *encoded_list = NULL;
 
 	check_mini_fo_dentry(dentry);
diff -Nru mini_fo.ORIG/main.c mini_fo/main.c
--- mini_fo.ORIG/main.c	2005-05-06 23:59:08.000000000 +0200
+++ mini_fo/main.c	2005-05-10 17:54:13.000000000 +0200
@@ -405,7 +405,7 @@
 
 MODULE_AUTHOR("Erez Zadok <ezk@cs.sunysb.edu>");
 MODULE_DESCRIPTION("FiST-generated mini_fo filesystem");
-MODULE_LICENSE("LGPL");
+MODULE_LICENSE("GPL");
 
 /* MODULE_PARM(fist_debug_var, "i"); */
 /* MODULE_PARM_DESC(fist_debug_var, "Debug level"); */


