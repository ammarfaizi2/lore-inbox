Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVAMQkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVAMQkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVAMQkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:40:02 -0500
Received: from ida.rowland.org ([192.131.102.52]:7684 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261196AbVAMQjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:39:21 -0500
Date: Thu, 13 Jan 2005 11:39:20 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH as442] gcc 2.96 workaround in sys_getdents64()
Message-ID: <Pine.LNX.4.44L0.0501131132520.959-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:

How serious are people about continuing to support versions of gcc prior 
to 3.0?  My copy of RedHat's gcc-2.96 croaks without this patch:


Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

===== fs/readdir.c 1.26 vs edited =====
--- 1.26/fs/readdir.c	2005-01-09 08:29:46 -05:00
+++ edited/fs/readdir.c	2005-01-13 11:31:58 -05:00
@@ -288,7 +288,7 @@
 	if (lastdirent) {
 		typeof(lastdirent->d_off) d_off = file->f_pos;
 		error = count - buf.count;
-		if (__put_user(d_off, &lastdirent->d_off))
+		if (put_user(d_off, &lastdirent->d_off))
 			error = -EFAULT;
 	}
 

For changes involving code that's not executed very often I wouldn't
hesitate to recommend adopting such a patch.  Does sys_getdents64() fall
in that category?  Also I'm not sure how much extra overhead is added by
calling put_user() rather than __put_user().

So I'll leave it up to you to decide whether the patch should be applied.

Alan Stern

