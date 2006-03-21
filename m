Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWCUXkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWCUXkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWCUXkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:40:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:62149 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965148AbWCUXkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:40:05 -0500
Date: Tue, 21 Mar 2006 15:40:00 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2: Why is CONFIG_MIGRATION available for everyone?
In-Reply-To: <20060321225430.GJ3890@stusta.de>
Message-ID: <Pine.LNX.4.64.0603211538260.14399@schroedinger.engr.sgi.com>
References: <20060318044056.350a2931.akpm@osdl.org> <20060321225430.GJ3890@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Adrian Bunk wrote:

> Can we express this explicitely?

How about this fix?

Make page migration dependent on swap and NUMA. The page migration code 
could function without NUMA but we currently have no users for the 
non-NUMA case.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc6-mm2/mm/Kconfig
===================================================================
--- linux-2.6.16-rc6-mm2.orig/mm/Kconfig	2006-03-21 14:51:37.000000000 -0800
+++ linux-2.6.16-rc6-mm2/mm/Kconfig	2006-03-21 15:36:25.000000000 -0800
@@ -138,8 +138,8 @@ config SPLIT_PTLOCK_CPUS
 #
 config MIGRATION
 	bool "Page migration"
-	def_bool y if NUMA || SPARSEMEM || DISCONTIGMEM
-	depends on SWAP
+	def_bool y if NUMA
+	depends on SWAP && NUMA
 	help
 	  Allows the migration of the physical location of pages of processes
 	  while the virtual addresses are not changed. This is useful for
