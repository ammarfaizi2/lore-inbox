Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUAPDWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 22:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbUAPDWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 22:22:00 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:21610
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S265251AbUAPDVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 22:21:54 -0500
Message-ID: <40075914.5000008@rogers.com>
Date: Thu, 15 Jan 2004 22:23:00 -0500
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] cleanup single_open usage in dma.c
Content-Type: multipart/mixed;
 boundary="------------070605080000080201090608"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [129.97.226.198] using ID <muizelaar@rogers.com> at Thu, 15 Jan 2004 22:20:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070605080000080201090608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch lets the seq_file api take care of buffer allocation 
instead of doing it by hand.

-Jeff

--------------070605080000080201090608
Content-Type: text/plain;
 name="dma-proc-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma-proc-cleanup.patch"

diff -ur linux-2.6.1-mm3/kernel/dma.c linux-2.6.1-mm3-dma-proc/kernel/dma.c
--- linux-2.6.1-mm3/kernel/dma.c	2004-01-09 01:59:10.000000000 -0500
+++ linux-2.6.1-mm3-dma-proc/kernel/dma.c	2004-01-15 22:10:04.000000000 -0500
@@ -136,20 +136,7 @@
 
 static int proc_dma_open(struct inode *inode, struct file *file)
 {
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	struct seq_file *m;
-	int res;
-
-	if (!buf)
-		return -ENOMEM;
-	res = single_open(file, proc_dma_show, NULL);
-	if (!res) {
-		m = file->private_data;
-		m->buf = buf;
-		m->size = PAGE_SIZE;
-	} else
-		kfree(buf);
-	return res;
+	return single_open(file, proc_dma_show, NULL);
 }
 
 static struct file_operations proc_dma_operations = {

--------------070605080000080201090608--

