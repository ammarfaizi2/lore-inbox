Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031851AbWLGIZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031851AbWLGIZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031853AbWLGIZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:25:35 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:1261 "EHLO
	outbound0.sv.meer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031851AbWLGIZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:25:35 -0500
Subject: [PATCH 5/5 -mm] fault-injection: defaults likely to please a new
	user
From: Don Mullis <dwm@meer.net>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>
In-Reply-To: <1165478812.2706.8.camel@localhost.localdomain>
References: <1165478812.2706.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 00:25:30 -0800
Message-Id: <1165479930.2706.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assign defaults most likely to please a new user:
 1) generate some logging output
    (verbose=2)
 2) avoid injecting failures likely to lock up UI
    (ignore_gfp_wait=1, ignore_gfp_highmem=1)

Signed-off-by: Don Mullis <dwm@meer.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 include/linux/fault-inject.h |    1 +
 mm/page_alloc.c              |    2 ++
 mm/slab.c                    |    1 +
 3 files changed, 4 insertions(+)

Index: linux-2.6.18/include/linux/fault-inject.h
===================================================================
--- linux-2.6.18.orig/include/linux/fault-inject.h
+++ linux-2.6.18/include/linux/fault-inject.h
@@ -52,6 +52,7 @@ struct fault_attr {
 		.times = ATOMIC_INIT(1),			\
 		.require_end = ULONG_MAX,			\
 		.stacktrace_depth = 32,				\
+		.verbose = 2,					\
 	}
 
 #define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER
Index: linux-2.6.18/mm/page_alloc.c
===================================================================
--- linux-2.6.18.orig/mm/page_alloc.c
+++ linux-2.6.18/mm/page_alloc.c
@@ -914,6 +914,8 @@ static struct fail_page_alloc_attr {
 
 } fail_page_alloc = {
 	.attr = FAULT_ATTR_INITIALIZER,
+	.ignore_gfp_wait = 1,
+	.ignore_gfp_highmem = 1,
 };
 
 static int __init setup_fail_page_alloc(char *str)
Index: linux-2.6.18/mm/slab.c
===================================================================
--- linux-2.6.18.orig/mm/slab.c
+++ linux-2.6.18/mm/slab.c
@@ -3108,6 +3108,7 @@ static struct failslab_attr {
 
 } failslab = {
 	.attr = FAULT_ATTR_INITIALIZER,
+	.ignore_gfp_wait = 1,
 };
 
 static int __init setup_failslab(char *str)


