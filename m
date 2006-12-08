Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425429AbWLHLzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425429AbWLHLzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425430AbWLHLxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:53:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52385 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425429AbWLHLwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:52:55 -0500
Message-Id: <200612081152.kB8BqUNp019771@shell0.pdx.osdl.net>
Subject: [patch 08/13] io-accounting: direct-io
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Account for direct-io.

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/direct-io.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN fs/direct-io.c~io-accounting-direct-io fs/direct-io.c
--- a/fs/direct-io.c~io-accounting-direct-io
+++ a/fs/direct-io.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/task_io_accounting_ops.h>
 #include <linux/bio.h>
 #include <linux/wait.h>
 #include <linux/err.h>
@@ -675,6 +676,13 @@ submit_page_section(struct dio *dio, str
 {
 	int ret = 0;
 
+	if (dio->rw & WRITE) {
+		/*
+		 * Read accounting is performed in submit_bio()
+		 */
+		task_io_account_write(len);
+	}
+
 	/*
 	 * Can we just grow the current page's presence in the dio?
 	 */
_
