Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVDKUwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVDKUwL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVDKUwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:52:10 -0400
Received: from mail.dif.dk ([193.138.115.101]:22729 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261928AbVDKUvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:51:44 -0400
Date: Mon, 11 Apr 2005 22:54:25 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>
Cc: parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: kfree cleanup in arch/parisc/
Message-ID: <Pine.LNX.4.62.0504112249510.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Get rid of redundant NULL pointer checks before kfree() in arch/parisc/ as 
well as a few blank lines.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -upr linux-2.6.12-rc2-mm3-orig/arch/parisc/kernel/ioctl32.c linux-2.6.12-rc2-mm3/arch/parisc/kernel/ioctl32.c
--- linux-2.6.12-rc2-mm3-orig/arch/parisc/kernel/ioctl32.c	2005-04-05 21:21:08.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/parisc/kernel/ioctl32.c	2005-04-11 22:48:03.000000000 +0200
@@ -104,12 +104,9 @@ static int drm32_version(unsigned int fd
 	}
 
 out:
-	if (kversion.name)
-		kfree(kversion.name);
-	if (kversion.date)
-		kfree(kversion.date);
-	if (kversion.desc)
-		kfree(kversion.desc);
+	kfree(kversion.name);
+	kfree(kversion.date);
+	kfree(kversion.desc);
 	return ret;
 }
 
@@ -166,9 +163,7 @@ static int drm32_getsetunique(unsigned i
 			ret = -EFAULT;
 	}
 
-	if (karg.unique != NULL)
-		kfree(karg.unique);
-
+	kfree(karg.unique);
 	return ret;
 }
 
@@ -265,7 +260,6 @@ static int drm32_info_bufs(unsigned int 
 	}
 
 	kfree(karg.list);
-
 	return ret;
 }
 
@@ -305,7 +299,6 @@ static int drm32_free_bufs(unsigned int 
 
 out:
 	kfree(karg.list);
-
 	return ret;
 }
 
@@ -494,15 +487,10 @@ static int drm32_dma(unsigned int fd, un
 	}
 
 out:
-	if (karg.send_indices)
-		kfree(karg.send_indices);
-	if (karg.send_sizes)
-		kfree(karg.send_sizes);
-	if (karg.request_indices)
-		kfree(karg.request_indices);
-	if (karg.request_sizes)
-		kfree(karg.request_sizes);
-
+	kfree(karg.send_indices);
+	kfree(karg.send_sizes);
+	kfree(karg.request_indices);
+	kfree(karg.request_sizes);
 	return ret;
 }
 
@@ -555,9 +543,7 @@ static int drm32_res_ctx(unsigned int fd
 			ret = -EFAULT;
 	}
 
-	if (karg.contexts)
-		kfree(karg.contexts);
-
+	kfree(karg.contexts);
 	return ret;
 }
 




PS. If you reply to lists other than Linux-kernel, then please keep me on CC:



