Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVAXGOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVAXGOh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVAXGOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:14:37 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261448AbVAXGO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:26 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][1/12] InfiniBand/core: compat_ioctl conversion minor fixes
In-Reply-To: <20051232214.Ndv3rt3gl8fJimFA@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:23 -0800
Message-Id: <20051232214.3xuiAqAqwBM4Tlb4@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:24.0981 (UTC) FILETIME=[F3CED050:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly tidy up Andi Kleen's compat_ioctl conversion for the
InfiniBand MAD driver by removing the no-longer-needed include of
ioctl32.h, killing unreachable code and doing some really anal
whitespace fixing.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/core/user_mad.c	2005-01-23 21:48:45.709546808 -0800
+++ linux-bk/drivers/infiniband/core/user_mad.c	2005-01-23 21:49:32.872376968 -0800
@@ -43,7 +43,6 @@
 #include <linux/poll.h>
 #include <linux/rwsem.h>
 #include <linux/kref.h>
-#include <linux/ioctl32.h>
 
 #include <asm/uaccess.h>
 
@@ -502,14 +501,14 @@
 }
 
 static struct file_operations umad_fops = {
-	.owner 	 = THIS_MODULE,
-	.read 	 = ib_umad_read,
-	.write 	 = ib_umad_write,
-	.poll 	 = ib_umad_poll,
+	.owner 	        = THIS_MODULE,
+	.read 	        = ib_umad_read,
+	.write 	        = ib_umad_write,
+	.poll 	        = ib_umad_poll,
 	.unlocked_ioctl = ib_umad_ioctl,
-	.compat_ioctl = ib_umad_ioctl,
-	.open 	 = ib_umad_open,
-	.release = ib_umad_close
+	.compat_ioctl   = ib_umad_ioctl,
+	.open 	        = ib_umad_open,
+	.release        = ib_umad_close
 };
 
 static struct ib_client umad_client = {
@@ -705,8 +704,6 @@
 
 	return 0;
 
-	ib_unregister_client(&umad_client);
-
 out_class:
 	class_unregister(&umad_class);
 

