Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbULFUvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbULFUvV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbULFUvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:51:20 -0500
Received: from math.ut.ee ([193.40.5.125]:1414 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261637AbULFUvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:51:08 -0500
Date: Mon, 6 Dec 2004 22:51:06 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
To: linux-kernel@vger.kernel.org
cc: mroos@ut.ee
Subject: [PATCH 2.6] clean-up: fixes "shadows local" warning
Message-ID: <Pine.SOC.4.61.0412062249010.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warning "declaration of `err' shadows a previous local"
occuring on line 486

Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>

--- a/fs/exec.c	2004-11-30 19:43:52.000000000 +0000
+++ b/fs/exec.c	2004-12-04 12:05:58.000000000 +0000
@@ -483,17 +483,17 @@
  		file = ERR_PTR(-EACCES);
  		if (!(nd.mnt->mnt_flags & MNT_NOEXEC) &&
  		    S_ISREG(inode->i_mode)) {
-			int err = permission(inode, MAY_EXEC, &nd);
-			if (!err && !(inode->i_mode & 0111))
-				err = -EACCES;
-			file = ERR_PTR(err);
-			if (!err) {
+			int perm_err = permission(inode, MAY_EXEC, &nd);
+			if (!perm_err && !(inode->i_mode & 0111))
+				perm_err = -EACCES;
+			file = ERR_PTR(perm_err);
+			if (!perm_err) {
  				file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
  				if (!IS_ERR(file)) {
-					err = deny_write_access(file);
-					if (err) {
+					perm_err = deny_write_access(file);
+					if (perm_err) {
  						fput(file);
-						file = ERR_PTR(err);
+						file = ERR_PTR(perm_err);
  					}
  				}
  out:
