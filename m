Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272980AbTGaK5f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272982AbTGaK5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:57:34 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:54795 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S272980AbTGaK53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:57:29 -0400
Date: Thu, 31 Jul 2003 11:57:28 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 7/6 (so I can't count)] dm: resume() name clash
Message-ID: <20030731105728.GK394@fib011235813.fsnet.co.uk>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731104517.GD394@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures define an extern function called resume(), which
clashes with a static function in dm-ioctl-v4.c.  Rename static one to
do_resume().
--- diff/drivers/md/dm-ioctl-v4.c	2003-07-31 11:55:02.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-07-31 11:53:51.000000000 +0100
@@ -594,7 +594,7 @@
 	return dm_hash_rename(param->name, new_name);
 }
 
-static int suspend(struct dm_ioctl *param)
+static int do_suspend(struct dm_ioctl *param)
 {
 	int r = 0;
 	struct mapped_device *md;
@@ -613,7 +613,7 @@
 	return r;
 }
 
-static int resume(struct dm_ioctl *param)
+static int do_resume(struct dm_ioctl *param)
 {
 	int r = 0;
 	struct hash_cell *hc;
@@ -676,9 +676,9 @@
 static int dev_suspend(struct dm_ioctl *param, size_t param_size)
 {
 	if (param->flags & DM_SUSPEND_FLAG)
-		return suspend(param);
+		return do_suspend(param);
 
-	return resume(param);
+	return do_resume(param);
 }
 
 /*
