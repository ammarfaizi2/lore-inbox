Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVIGUod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVIGUod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVIGUod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:44:33 -0400
Received: from fmr24.intel.com ([143.183.121.16]:25800 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932253AbVIGUoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:44:32 -0400
Date: Wed, 7 Sep 2005 16:39:56 -0400
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] change io_cancel return code for no cancel case
Message-ID: <20050907203956.GA21330@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wendy Cheng <wcheng@redhat.com>

Note that other than few exceptions, most of the current filesystem and/or
drivers do not have aio cancel specifically defined (kiob->ki_cancel field
is mostly NULL).  However, sys_io_cancel system call universally sets
return code to -EAGAIN.  This gives applications a wrong impression that
this call is implemented but just never works.  We have customer inquires
about this issue.

Changed by Benjamin LaHaise to EINVAL instead of ENOSYS

Signed-off-by: S. Wendy Cheng <wcheng@redhat.com>
Acked-by: Benjamin LaHaise <bcrl@kvack.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>

 aio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -purN --exclude=description 00_linus-git/fs/aio.c 01_aio_enosys/fs/aio.c
--- 00_linus-git/fs/aio.c	2005-09-07 10:59:31.000000000 -0400
+++ 01_aio_enosys/fs/aio.c	2005-09-07 11:03:55.000000000 -0400
@@ -1673,7 +1673,7 @@ asmlinkage long sys_io_cancel(aio_contex
 				ret = -EFAULT;
 		}
 	} else
-		printk(KERN_DEBUG "iocb has no cancel operation\n");
+		ret = -EINVAL;
 
 	put_ioctx(ctx);
 
