Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbUKQUgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbUKQUgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbUKQUbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:31:46 -0500
Received: from peabody.ximian.com ([130.57.169.10]:33439 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262519AbUKQUb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:31:26 -0500
Subject: Re: [patch] inotify: use permission not vfs_permission
From: Robert Love <rml@novell.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Christoph Hellwig <hch@infradead.org>, ttb@tentacle.dhs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <419BB3B6.40703@sun.com>
References: <1100710677.6280.2.camel@betsy.boston.ximian.com>
	 <1100714560.6280.7.camel@betsy.boston.ximian.com>
	 <20041117190850.GA11682@infradead.org>
	 <1100718601.4981.2.camel@betsy.boston.ximian.com>
	 <20041117191803.GA11830@infradead.org>
	 <1100719052.4981.4.camel@betsy.boston.ximian.com>
	 <419BAFE1.7030500@sun.com>
	 <1100722624.4981.49.camel@betsy.boston.ximian.com> <419BB3B6.40703@sun.com>
Content-Type: text/plain
Date: Wed, 17 Nov 2004 15:28:34 -0500
Message-Id: <1100723314.28785.0.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 15:25 -0500, Mike Waychison wrote:

> permission() still takes 3 arguments though.  I think it is safe to pass
> NULL for the nameidata.

Ugh, I compile-tested the wrong tree.  Thanks.

It is safe to pass NULL.

Patch below.

	Robert Love


Use permission() instead of generic_permission().

Signed-Off-By: Robert Love <rml@novell.com>

diff -u linux/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux/drivers/char/inotify.c	2004-11-17 12:28:27.921136656 -0500
+++ linux/drivers/char/inotify.c	2004-11-17 12:28:27.921136656 -0500
@@ -166,7 +166,7 @@
 	inode = nd.dentry->d_inode;
 
 	/* you can only watch an inode if you have read permissions on it */
-	error = vfs_permission(inode, MAY_READ);
+	error = permission(inode, MAY_READ, NULL);
 	if (error) {
 		inode = ERR_PTR(error);
 		goto release_and_out;


