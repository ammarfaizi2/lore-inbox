Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbUJYWIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbUJYWIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 18:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbUJYWF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:05:29 -0400
Received: from gprs214-185.eurotel.cz ([160.218.214.185]:15489 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261945AbUJYWAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:00:24 -0400
Date: Tue, 26 Oct 2004 00:00:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, vojtech@suse.cz
Subject: kill pm_access & friends from input layer
Message-ID: <20041025220010.GA24253@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

pm_access is a NOP (both in CONFIG_PM and !CONFIG_PM cases, its simply
obsolete), and ugly one, too. This removes it from input layer. Please
apply,

								Pavel


--- clean/drivers/input/input.c	2004-08-15 19:14:56.000000000 +0200
+++ linux/drivers/input/input.c	2004-10-25 23:54:57.000000000 +0200
@@ -67,9 +67,6 @@
 {
 	struct input_handle *handle;
 
-	if (dev->pm_dev)
-		pm_access(dev->pm_dev);
-
 	if (type > EV_MAX || !test_bit(type, dev->evbit))
 		return;
 
@@ -230,8 +227,6 @@
 
 int input_open_device(struct input_handle *handle)
 {
-	if (handle->dev->pm_dev)
-		pm_access(handle->dev->pm_dev);
 	handle->open++;
 	if (handle->dev->open)
 		return handle->dev->open(handle->dev);
@@ -249,8 +244,6 @@
 void input_close_device(struct input_handle *handle)
 {
 	input_release_device(handle);
-	if (handle->dev->pm_dev)
-		pm_dev_idle(handle->dev->pm_dev);
 	if (handle->dev->close)
 		handle->dev->close(handle->dev);
 	handle->open--;

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
