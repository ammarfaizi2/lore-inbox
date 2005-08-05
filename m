Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbVHETzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbVHETzX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbVHETzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:55:23 -0400
Received: from peabody.ximian.com ([130.57.169.10]:37587 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263040AbVHETzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:55:17 -0400
Subject: [patch] fsnotify: hook on removexattr, too
From: Robert Love <rml@novell.com>
To: marijn ros <marijn@mad.scientist.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050805180739.A49DF1F50B1@ws1-2.us4.outblaze.com>
References: <20050805180739.A49DF1F50B1@ws1-2.us4.outblaze.com>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 15:55:15 -0400
Message-Id: <1123271715.30486.82.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2005-08-05 at 19:07 +0100, marijn ros wrote:

> I got wondering, why does fs_notify_xattr get called from setxattr in fs/xattr.c, but
> not from removexattr that is below it in the same file? Both seem to make changes to
> xattrs and both are exported as system calls.

We should.

	Robert Love


Add fsnotify_xattr() hook to removexattr().

Signed-off-by: Robert Love <rml@novell.com>

 fs/xattr.c |    2 ++
 1 files changed, 2 insertions(+)

diff -urN linux-2.6.13-rc5/fs/xattr.c linux/fs/xattr.c
--- linux-2.6.13-rc5/fs/xattr.c	2005-08-05 15:49:17.000000000 -0400
+++ linux/fs/xattr.c	2005-08-05 15:53:45.000000000 -0400
@@ -307,6 +307,8 @@
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->removexattr(d, kname);
 		up(&d->d_inode->i_sem);
+		if (!error)
+			fsnotify_xattr(d);
 	}
 out:
 	return error;


