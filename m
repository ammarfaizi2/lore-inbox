Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbVCJAZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVCJAZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVCJAUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:20:30 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:51470 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262558AbVCJARF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:17:05 -0500
Message-Id: <200503100215.j2A2FkDN015217@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/9] UML - Fix hostfs typo
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Mar 2005 21:15:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the hostfs setgid code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/include/kern.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/kern.h	2005-03-08 20:13:55.000000000 -0500
+++ linux-2.6.11/arch/um/include/kern.h	2005-03-08 21:56:19.000000000 -0500
@@ -26,6 +26,7 @@
 extern void perror(char *err);
 extern int kill(int pid, int sig);
 extern int getuid(void);
+extern int getgid(void);
 extern int pause(void);
 extern int write(int, const void *, int);
 extern int exit(int);
Index: linux-2.6.11/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.11.orig/fs/hostfs/hostfs_kern.c	2005-03-08 20:17:34.000000000 -0500
+++ linux-2.6.11/fs/hostfs/hostfs_kern.c	2005-03-08 20:18:15.000000000 -0500
@@ -845,7 +845,7 @@
 	if(attr->ia_valid & ATTR_GID){
 		if((dentry->d_inode->i_sb->s_dev == ROOT_DEV) &&
 		   (attr->ia_gid == 0))
-			attr->ia_gid = getuid();
+			attr->ia_gid = getgid();
 		attrs.ia_valid |= HOSTFS_ATTR_GID;
 		attrs.ia_gid = attr->ia_gid;
 	}

