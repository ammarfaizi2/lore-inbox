Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262982AbVAFTGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbVAFTGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbVAFTGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:06:33 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33225 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262959AbVAFTFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:05:55 -0500
Date: Thu, 6 Jan 2005 11:05:38 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
Subject: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106190538.GB1618@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew,

Some export-removal work causes breakage for an out-of-tree filesystem.
Could you please apply the attached patch to restore the exports for
files_lock and set_fs_root?

						Thanx, Paul

----- End forwarded message -----

diff -urpN -X ../dontdiff linux-2.5/fs/file_table.c linux-2.5-MVFS/fs/file_table.c
--- linux-2.5/fs/file_table.c	Wed Jan  5 13:54:21 2005
+++ linux-2.5-MVFS/fs/file_table.c	Wed Jan  5 17:12:53 2005
@@ -26,6 +26,7 @@ EXPORT_SYMBOL(files_stat); /* Needed by 
 
 /* public. Not pretty! */
 spinlock_t __cacheline_aligned_in_smp files_lock = SPIN_LOCK_UNLOCKED;
+EXPORT_SYMBOL(files_lock);
 
 static spinlock_t filp_count_lock = SPIN_LOCK_UNLOCKED;
 
diff -urpN -X ../dontdiff linux-2.5/fs/namespace.c linux-2.5-MVFS/fs/namespace.c
--- linux-2.5/fs/namespace.c	Wed Jan  5 13:54:22 2005
+++ linux-2.5-MVFS/fs/namespace.c	Wed Jan  5 17:12:08 2005
@@ -1207,6 +1207,7 @@ void set_fs_root(struct fs_struct *fs, s
 		mntput(old_rootmnt);
 	}
 }
+EXPORT_SYMBOL(set_fs_root);
 
 /*
  * Replace the fs->{pwdmnt,pwd} with {mnt,dentry}. Put the old values.

----- End forwarded message -----
