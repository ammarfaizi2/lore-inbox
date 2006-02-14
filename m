Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422736AbWBNSDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422736AbWBNSDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbWBNSDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:03:21 -0500
Received: from verein.lst.de ([213.95.11.210]:58061 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422736AbWBNSDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:03:20 -0500
Date: Tue, 14 Feb 2006 19:03:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] deprecate the kernel_thread export
Message-ID: <20060214180315.GA19369@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Announce that the kernel_thread export will be removed in half a year,
after all it's users have been converted to the kthread_ API, which I
plan to do over the next month.

(and no, Adrian, please no __deprecate_as_module yet, there's still
 too many users left)


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt	2006-02-10 19:45:40.000000000 +0100
+++ linux-2.6/Documentation/feature-removal-schedule.txt	2006-02-12 18:44:40.000000000 +0100
@@ -171,3 +171,14 @@
 	probing is also known to cause trouble in at least one case (see
 	bug #5889.)
 Who:	Jean Delvare <khali@linux-fr.org>
+
+---------------------------
+
+What:	remove EXPORT_SYMBOL(kernel_thread)
+When:	August 2006
+Files:	arch/*/kernel/*_ksyms.c
+Why:	kernel_thread is a low-level implementation detail.  Drivers should
+        use the <linux/kthread.h> API instead which shields them from
+	implementation details and provides a higherlevel interface that
+	prevents bugs and code duplication
+Who:	Christoph Hellwig <hch@lst.de>
