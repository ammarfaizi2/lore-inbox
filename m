Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268343AbUHXV2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268343AbUHXV2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268344AbUHXV2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:28:39 -0400
Received: from holomorphy.com ([207.189.100.168]:21382 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268343AbUHXV0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:26:32 -0400
Date: Tue, 24 Aug 2004 14:26:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-ID: <20040824212630.GY2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org> <20040824205621.GU2793@holomorphy.com> <20040824212345.GX2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824212345.GX2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 02:23:45PM -0700, William Lee Irwin III wrote:
> fs/reiser4/jnode.c: In function `jload_prefetch':
> fs/reiser4/jnode.c:878: warning: passing arg 1 of `prefetchw' discards qualifiers from pointer target type


Index: mm4-2.6.8.1/fs/reiser4/jnode.c
===================================================================
--- mm4-2.6.8.1.orig/fs/reiser4/jnode.c	2004-08-23 16:11:19.000000000 -0700
+++ mm4-2.6.8.1/fs/reiser4/jnode.c	2004-08-24 14:22:36.896616680 -0700
@@ -873,7 +873,7 @@
 /* prefetch jnode to speed up next call to jload. Call this when you are going
  * to call jload() shortly. This will bring appropriate portion of jnode into
  * CPU cache. */
-reiser4_internal void jload_prefetch(const jnode * node)
+reiser4_internal void jload_prefetch(jnode *node)
 {
 	prefetchw(&node->x_count);
 }
Index: mm4-2.6.8.1/fs/reiser4/jnode.h
===================================================================
--- mm4-2.6.8.1.orig/fs/reiser4/jnode.h	2004-08-23 16:11:19.000000000 -0700
+++ mm4-2.6.8.1/fs/reiser4/jnode.h	2004-08-24 14:23:17.721410368 -0700
@@ -569,7 +569,7 @@
 extern void jdrop(jnode * node) NONNULL;
 extern int jwait_io(jnode * node, int rw) NONNULL;
 
-extern void jload_prefetch(const jnode * node);
+void jload_prefetch(jnode *);
 
 extern jnode *alloc_io_head(const reiser4_block_nr * block) NONNULL;
 extern void drop_io_head(jnode * node) NONNULL;
