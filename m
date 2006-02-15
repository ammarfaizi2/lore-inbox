Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945916AbWBONHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945916AbWBONHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945929AbWBONHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:07:41 -0500
Received: from verein.lst.de ([213.95.11.210]:52892 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1945916AbWBONHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:07:41 -0500
Date: Wed, 15 Feb 2006 14:07:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] deprecate the tasklist_lock export
Message-ID: <20060215130734.GA5590@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers have no business looking at the task list and thus using this
lock.  The only possibly modular users left are:

 arch/ia64/kernel/mca.c
 drivers/edac/edac_mc.c
 fs/binfmt_elf.c

which I'll send out fixes for soon.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt	2006-02-15 14:03:37.000000000 +0100
+++ linux-2.6/Documentation/feature-removal-schedule.txt	2006-02-15 14:05:37.000000000 +0100
@@ -182,3 +182,14 @@
 	implementation details and provides a higherlevel interface that
 	prevents bugs and code duplication
 Who:	Christoph Hellwig <hch@lst.de>
+
+---------------------------
+
+What:	remove EXPORT_SYMBOL(tasklist_lock)
+When:	August 2006
+Files:	kernel/fork.c
+Why:	tasklist_lock protects the kernel internal task list.  Modules have
+	no business looking at it, and all instances in drivers have been due
+	to use of too-lowlevel APIs.  Having this symbol exported prevents
+	moving to more scalable locking schemes for the task list.
+Who:	Christoph Hellwig <hch@lst.de>
