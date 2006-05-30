Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWE3Irc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWE3Irc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 04:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWE3IrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 04:47:21 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:34447 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932191AbWE3Iq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 04:46:57 -0400
Message-ID: <348978814.17342@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060530084703.965331349@localhost.localdomain>
References: <20060530084030.274375770@localhost.localdomain>
Date: Tue, 30 May 2006 16:40:33 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [patch 3/4] readahead: context based method - fix *remain counting
Content-Disposition: inline; filename=readahead-method-context-fix-remain.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*remain in query_page_cache_segment() is over counted by 1, fix it.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1334,7 +1334,7 @@ static unsigned long query_page_cache_se
 	index = radix_tree_scan_hole_backward(&mapping->page_tree,
 							offset - 1, ra_max);
 
-	*remain = offset - index;
+	*remain = (offset - 1) - index;
 
 	if (offset == ra->readahead_index && ra_cache_hit_ok(ra))
 		count = *remain;

--
