Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272971AbTGaKt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272976AbTGaKt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:49:56 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:25860 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S272971AbTGaKty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:49:54 -0400
Date: Thu, 31 Jul 2003 11:49:53 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 3/6] dm: decimal device num sscanf
Message-ID: <20030731104953.GG394@fib011235813.fsnet.co.uk>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731104517.GD394@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4 version of Device-Mapper scans for device-numbers in decimal
instead of hex (in dm_get_device()). Update 2.6 so both versions use
the same behavior.  [Kevin Corry]

--- diff/drivers/md/dm-table.c	2003-07-28 11:55:33.000000000 +0100
+++ source/drivers/md/dm-table.c	2003-07-31 11:13:24.000000000 +0100
@@ -418,12 +418,12 @@
 	int r;
 	dev_t dev;
 	struct dm_dev *dd;
-	int major, minor;
+	unsigned int major, minor;
 
 	if (!t)
 		BUG();
 
-	if (sscanf(path, "%x:%x", &major, &minor) == 2) {
+	if (sscanf(path, "%u:%u", &major, &minor) == 2) {
 		/* Extract the major/minor numbers */
 		dev = MKDEV(major, minor);
 	} else {
