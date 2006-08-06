Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWHFQ2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWHFQ2O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 12:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWHFQ2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 12:28:14 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:31450 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750801AbWHFQ2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 12:28:13 -0400
Date: Sun, 6 Aug 2006 12:23:52 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] unwind: fix unused variable warning when
  !CONFIG_MODULES
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>
Message-ID: <200608061226_MC3-1-C742-2B7B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "variable defined but not used" compiler warning in unwind.c
when CONFIG_MODULES is not set.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc3-32.orig/kernel/unwind.c
+++ 2.6.18-rc3-32/kernel/unwind.c
@@ -102,7 +102,7 @@ static struct unwind_table {
 	unsigned long size;
 	struct unwind_table *link;
 	const char *name;
-} root_table, *last_table;
+} root_table;
 
 struct unwind_item {
 	enum item_location {
@@ -174,6 +174,8 @@ void __init unwind_init(void)
 
 #ifdef CONFIG_MODULES
 
+static struct unwind_table *last_table;
+
 /* Must be called with module_mutex held. */
 void *unwind_add_table(struct module *module,
                        const void *table_start,
-- 
Chuck
