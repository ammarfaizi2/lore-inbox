Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUC1MMd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 07:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbUC1MMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 07:12:32 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:61449 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261451AbUC1MMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 07:12:30 -0500
Date: Sun, 28 Mar 2004 14:12:25 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, volker@kki.org
Subject: [PATCH-2.4.26] smbfs cleanup
Message-ID: <20040328121225.GC24421@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328042608.GA17969@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Compiling smbfs without CONFIG_SMB_UNIX ouputs a few warnings.
Here's the fix. Please apply.
Willy


--- ./fs/smbfs/proc.c.orig	Sun Mar 28 14:02:27 2004
+++ ./fs/smbfs/proc.c	Sun Mar 28 14:06:59 2004
@@ -49,7 +49,9 @@
 static struct smb_ops smb_ops_os2;
 static struct smb_ops smb_ops_win95;
 static struct smb_ops smb_ops_winNT;
+#ifdef CONFIG_SMB_UNIX
 static struct smb_ops smb_ops_unix;
+#endif
 
 static void
 smb_init_dirent(struct smb_sb_info *server, struct smb_fattr *fattr);
@@ -2636,6 +2638,7 @@
 	return result;
 }
 
+#ifdef CONFIG_SMB_UNIX
 /*
  * Note: called with the server locked.
  */
@@ -2680,6 +2683,7 @@
 out:
 	return result;
 }
+#endif
 
 static int
 smb_proc_getattr_null(struct smb_sb_info *server, struct dentry *dir,
@@ -3332,6 +3336,7 @@
 	.truncate       = smb_proc_trunc64,
 };
 
+#ifdef CONFIG_SMB_UNIX
 /* Samba w/ unix extensions. Others? */
 static struct smb_ops smb_ops_unix =
 {
@@ -3341,6 +3346,7 @@
 	.getattr        = smb_proc_getattr_unix,
 	.truncate       = smb_proc_trunc64,
 };
+#endif
 
 /* Place holder until real ops are in place */
 static struct smb_ops smb_ops_null =
