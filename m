Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270000AbUJHRkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270000AbUJHRkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270054AbUJHRjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:39:52 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:60848 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S270045AbUJHRiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:38:08 -0400
Date: Fri, 8 Oct 2004 19:37:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/12): z/VM monitor stream.
Message-ID: <20041008173756.GE7356@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: z/VM monitor stream.

From: Gerald Schaefer <geraldsc@de.ibm.com>

z/VM monitor stream changes:
 - Reduce stack usage of appldata_get_mem_data.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/appldata/appldata_mem.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -urN linux-2.6/arch/s390/appldata/appldata_mem.c linux-2.6-patched/arch/s390/appldata/appldata_mem.c
--- linux-2.6/arch/s390/appldata/appldata_mem.c	2004-08-14 12:54:50.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_mem.c	2004-10-08 19:19:11.000000000 +0200
@@ -102,8 +102,12 @@
  */
 static void appldata_get_mem_data(void *data)
 {
-	struct sysinfo val;
-	struct page_state ps;
+	/*
+	 * don't put large structures on the stack, we are
+	 * serialized through the appldata_ops_lock and can use static
+	 */
+	static struct sysinfo val;
+	static struct page_state ps;
 	struct appldata_mem_data *mem_data;
 
 	mem_data = data;
