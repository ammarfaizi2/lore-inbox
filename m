Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUJNT11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUJNT11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUJNSzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:55:31 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:12069 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S267353AbUJNSyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:54:24 -0400
Date: Thu, 14 Oct 2004 14:54:24 -0400
From: Jeffrey Mahoney <jeffm@csh.rit.edu>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Hans Reiser <reiser@namesys.com>
Subject: [PATCH 2/2] reiserfs: allow user_xattr and acl options to be ignored, with warning
Message-ID: <20041014185424.GC9619@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.108-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the REISERFS_UNSUPPORTED_OPT flag to denote -o(no)acl, and
-o(no)user_xattr as unsupported, but allowable, when support isn't built into
the kernel.

Signed-off-by: Jeff Mahoney <jeffm@novell.com>

diff -ruPX dontdiff linux-2.6.8/fs/reiserfs/super.c linux-2.6.8.fix/fs/reiserfs/super.c
--- linux-2.6.8/fs/reiserfs/super.c	2004-10-08 16:46:09.070660248 -0400
+++ linux-2.6.8.fix/fs/reiserfs/super.c	2004-10-08 16:42:59.896419104 -0400
@@ -741,11 +747,19 @@
 	{"conv",	.setmask = 1<<REISERFS_CONVERT},
 	{"attrs",	.setmask = 1<<REISERFS_ATTRS},
 	{"noattrs",	.clrmask = 1<<REISERFS_ATTRS},
+#ifdef CONFIG_REISERFS_FS_XATTR
 	{"user_xattr",	.setmask = 1<<REISERFS_XATTRS_USER},
 	{"nouser_xattr",.clrmask = 1<<REISERFS_XATTRS_USER},
+#else
+	{"user_xattr",	.setmask = 1<<REISERFS_UNSUPPORTED_OPT},
+	{"nouser_xattr",.clrmask = 1<<REISERFS_UNSUPPORTED_OPT},
+#endif
 #ifdef CONFIG_REISERFS_FS_POSIX_ACL
 	{"acl",		.setmask = 1<<REISERFS_POSIXACL},
 	{"noacl",	.clrmask = 1<<REISERFS_POSIXACL},
+#else
+	{"acl",		.setmask = 1<<REISERFS_UNSUPPORTED_OPT},
+	{"noacl",	.clrmask = 1<<REISERFS_UNSUPPORTED_OPT},
 #endif
 	{"nolog",},	 /* This is unsupported */
 	{"replayonly",	.setmask = 1<<REPLAYONLY},
