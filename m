Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVFKHZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVFKHZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVFKHZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:25:51 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:5463 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S261634AbVFKHZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:25:40 -0400
Date: Sat, 11 Jun 2005 00:25:18 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] export generic_drop_inode()
Message-ID: <20050611072518.GB14537@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050611021805.GM1153@ca-server1.us.oracle.com> <42AA8CDF.1020104@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AA8CDF.1020104@yahoo.com.au>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 05:03:59PM +1000, Nick Piggin wrote:
> I think it is best to default these to EXPORT_SYMBOL_GPL to be on the
> safe side, unless you have the agreement of the authors of the code, in
> which case I beg your pardon.
No problem. I apologize if I stepped on anyone's toes by using EXPORT_SYMBOL
:) Here's a patch using EXPORT_SYMBOL_GPL instead.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

diff -aur linux-2.6.12-rc6.orig/fs/inode.c linux-2.6.12-rc6/fs/inode.c
--- linux-2.6.12-rc6.orig/fs/inode.c	2005-06-06 08:22:29.000000000 -0700
+++ linux-2.6.12-rc6/fs/inode.c	2005-06-11 00:15:06.000000000 -0700
@@ -1048,7 +1048,7 @@
  * inode when the usage count drops to zero, and
  * i_nlink is zero.
  */
-static void generic_drop_inode(struct inode *inode)
+void generic_drop_inode(struct inode *inode)
 {
 	if (!inode->i_nlink)
 		generic_delete_inode(inode);
@@ -1056,6 +1056,8 @@
 		generic_forget_inode(inode);
 }
 
+EXPORT_SYMBOL_GPL(generic_drop_inode);
+
 /*
  * Called when we're dropping the last reference
  * to an inode. 
diff -aur linux-2.6.12-rc6.orig/include/linux/fs.h linux-2.6.12-rc6/include/linux/fs.h
--- linux-2.6.12-rc6.orig/include/linux/fs.h	2005-06-06 08:22:29.000000000 -0700
+++ linux-2.6.12-rc6/include/linux/fs.h	2005-06-10 17:13:18.000000000 -0700
@@ -1411,6 +1411,7 @@
 extern ino_t iunique(struct super_block *, ino_t);
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
+extern void generic_drop_inode(struct inode *inode);
 
 extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data);
