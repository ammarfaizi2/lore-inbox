Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbUB2Via (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 16:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUB2Vi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 16:38:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39337 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262150AbUB2ViX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 16:38:23 -0500
Date: Sun, 29 Feb 2004 16:38:51 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [SELINUX] Handle fuse binary mount data.
Message-ID: <Xine.LNX.4.44.0402291637360.22151-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ensures that fuse filesystems are able to be mounted with 
SELinux enabled.

Please apply.


diff -urN -X dontdiff linux-2.6.3-mm4.o/security/selinux/hooks.c linux-2.6.3-mm4.w/security/selinux/hooks.c
--- linux-2.6.3-mm4.o/security/selinux/hooks.c	2004-02-25 22:42:16.000000000 -0500
+++ linux-2.6.3-mm4.w/security/selinux/hooks.c	2004-02-28 23:44:04.885656768 -0500
@@ -332,8 +332,8 @@
 	name = sb->s_type->name;
 
 	/* Ignore these fileystems with binary mount option data. */
-	if (!strcmp(name, "coda") ||
-	    !strcmp(name, "afs") || !strcmp(name, "smbfs"))
+	if (!strcmp(name, "coda") || !strcmp(name, "afs") ||
+	    !strcmp(name, "smbfs") || !strcmp(name, "fuse"))
 		goto out;
 
 	/* NFS we understand. */
@@ -1897,7 +1897,8 @@
 
 	/* Binary mount data: just copy */
 	if (!strcmp(fstype, "nfs") || !strcmp(fstype, "coda") ||
-	    !strcmp(fstype, "smbfs") || !strcmp(fstype, "afs")) {
+	    !strcmp(fstype, "smbfs") || !strcmp(fstype, "afs") ||
+	    !strcmp(fstype, "fuse")) {
 		copy_page(sec_curr, in_curr);
 		goto out;
 	}

