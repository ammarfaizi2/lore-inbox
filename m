Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTHZNwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 09:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbTHZNwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 09:52:06 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:18607 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262679AbTHZNwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 09:52:02 -0400
Subject: [PATCH] Fix selinux_file_fcntl
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1061905903.23880.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Aug 2003 09:51:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morris <jmorris@redhat.com>

This patch adds the appropriate #if around the F_*64 commands
in the selinux_file_fcntl hook function.

 security/selinux/hooks.c |    2 ++
 1 files changed, 2 insertions(+)

diff -urN -X dontdiff linux-2.6.0-test4.orig/security/selinux/hooks.c linux-2.6.0-test4.w1/security/selinux/hooks.c
--- linux-2.6.0-test4.orig/security/selinux/hooks.c	2003-08-23 11:53:14.000000000 +1000
+++ linux-2.6.0-test4.w1/security/selinux/hooks.c	2003-08-25 01:23:11.690432168 +1000
@@ -2057,9 +2057,11 @@
 		case F_GETLK:
 		case F_SETLK:
 	        case F_SETLKW:
+#if BITS_PER_LONG == 32
 	        case F_GETLK64:
 		case F_SETLK64:
 	        case F_SETLKW64:
+#endif
 			if (!file->f_dentry || !file->f_dentry->d_inode) {
 				err = -EINVAL;
 				break;




-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

