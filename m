Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVC0VRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVC0VRk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVC0VRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:17:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261555AbVC0VRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:17:30 -0500
Date: Sun, 27 Mar 2005 23:17:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/rme96xx.c: fix two check after use
Message-ID: <20050327211728.GF4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm3-full/sound/oss/rme96xx.c.old	2005-03-27 23:16:02.000000000 +0200
+++ linux-2.6.12-rc1-mm3-full/sound/oss/rme96xx.c	2005-03-27 23:16:11.000000000 +0200
@@ -1534,18 +1534,20 @@
 static ssize_t rme96xx_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
 {
 	struct dmabuf *dma = (struct dmabuf *)file->private_data;
 	ssize_t ret = 0;
 	int cnt; /* number of bytes from "buffer" that will/can be used */
-	int hop = count/dma->outchannels;
+	int hop;
 	int hwp;
 	int exact = (file->f_flags & O_NONBLOCK); 
 
 
 	if(dma == NULL || (dma->s) == NULL) 
 		return -ENXIO;
 
+	hop = count/dma->outchannels;
+
 	if (dma->mmapped || !dma->opened)
 		return -ENXIO;
 
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
@@ -1599,18 +1601,20 @@
 static ssize_t rme96xx_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 { 
 	struct dmabuf *dma = (struct dmabuf *)file->private_data;
 	ssize_t ret = 0;
 	int cnt; /* number of bytes from "buffer" that will/can be used */
-	int hop = count/dma->inchannels;
+	int hop;
 	int hwp;
 	int exact = (file->f_flags & O_NONBLOCK); 
 
 
 	if(dma == NULL || (dma->s) == NULL) 
 		return -ENXIO;
 
+	hop = count/dma->inchannels;
+
 	if (dma->mmapped || !dma->opened)
 		return -ENXIO;
 
 	if (!access_ok(VERIFY_WRITE, buffer, count))
 		return -EFAULT;

