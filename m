Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbTE1Xvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTE1Xvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:51:50 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:34126
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261747AbTE1Xvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:51:49 -0400
Message-ID: <3ED54ECD.1050005@rogers.com>
Date: Wed, 28 May 2003 20:05:33 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] cleanup up seq file usage in resource.c
Content-Type: multipart/mixed;
 boundary="------------040409080504000006090704"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Wed, 28 May 2003 20:05:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040409080504000006090704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch against 2.5.70-bk2 removes the buffer allocation from 
resource.c and lets seq_read do it instead.

-Jeff

--------------040409080504000006090704
Content-Type: text/plain;
 name="resource-seq-file-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resource-seq-file-cleanup.patch"

diff -urN linux-2.5.70-bk2/kernel/resource.c linux-2.5.70-bk2-resource-seq-file-cleanup/kernel/resource.c
--- linux-2.5.70-bk2/kernel/resource.c	2003-05-26 21:00:42.000000000 -0400
+++ linux-2.5.70-bk2-resource-seq-file-cleanup/kernel/resource.c	2003-05-28 19:22:04.000000000 -0400
@@ -71,20 +71,7 @@
 
 static int ioresources_open(struct file *file, struct resource *root)
 {
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	struct seq_file *m;
-	int res;
-
-	if (!buf)
-		return -ENOMEM;
-	res = single_open(file, ioresources_show, root);
-	if (!res) {
-		m = file->private_data;
-		m->buf = buf;
-		m->size = PAGE_SIZE;
-	} else
-		kfree(buf);
-	return res;
+	return single_open(file, ioresources_show, root);
 }
 
 static int ioports_open(struct inode *inode, struct file *file)

--------------040409080504000006090704--

