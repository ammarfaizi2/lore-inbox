Return-Path: <linux-kernel-owner+w=401wt.eu-S1750856AbWL0ISK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWL0ISK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 03:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWL0ISK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 03:18:10 -0500
Received: from koto.vergenet.net ([210.128.90.7]:59290 "EHLO koto.vergenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbWL0ISJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 03:18:09 -0500
Date: Wed, 27 Dec 2006 17:17:02 +0900
From: Horms <horms@verge.net.au>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [patch] linux/preempt.h needs linux/thread_info.h
Message-ID: <20061227081701.GA19379@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that linux/preempt.h needs to include linux/thread_info.h
in order to access current_thread_info(), which is used in
preempt_count().

I guess that all callers of preempt_count() must include
both linux/thread_info.h and linux/preempt.h directly or indirectly,
as this does not cause a compile error. I noticed the problem while
working on an unrelated issue in xen-land.

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/include/linux/preempt.h
===================================================================
--- linux-2.6.orig/include/linux/preempt.h	2006-12-27 16:58:46.000000000 +0900
+++ linux-2.6/include/linux/preempt.h	2006-12-27 17:13:12.000000000 +0900
@@ -8,6 +8,7 @@
 
 #include <linux/thread_info.h>
 #include <linux/linkage.h>
+#include <linux/thread_info.h>
 
 #ifdef CONFIG_DEBUG_PREEMPT
   extern void fastcall add_preempt_count(int val);
