Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWCCPxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWCCPxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWCCPw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:52:59 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63131 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751479AbWCCPw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:52:59 -0500
Date: Fri, 3 Mar 2006 09:52:52 -0600
From: Jack Steiner <steiner@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - Increase max kmalloc size for very large systems
Message-ID: <20060303155252.GA32159@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Systems with extemely large numbers of nodes or cpus need to
kmalloc structures larger than is currently supported. This
patch increases the maximum supported size for very large systems.

This patch should have no effect on current systems.


	Signed-off-by: Jack Steiner <steiner@sgi.com>


Index: linux/include/linux/kmalloc_sizes.h
===================================================================
--- linux.orig/include/linux/kmalloc_sizes.h	2006-03-01 16:07:31.000000000 -0600
+++ linux/include/linux/kmalloc_sizes.h	2006-03-02 13:40:27.000000000 -0600
@@ -19,8 +19,10 @@
 	CACHE(32768)
 	CACHE(65536)
 	CACHE(131072)
-#ifndef CONFIG_MMU
+#if (NR_CPUS > 512) || (MAX_NUMNODES > 256) || !defined(CONFIG_MMU)
 	CACHE(262144)
+#endif
+#ifndef CONFIG_MMU
 	CACHE(524288)
 	CACHE(1048576)
 #ifdef CONFIG_LARGE_ALLOCS
