Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUDEUuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 16:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUDEUuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 16:50:10 -0400
Received: from waste.org ([209.173.204.2]:62606 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262041AbUDEUuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 16:50:05 -0400
Date: Mon, 5 Apr 2004 15:49:58 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] shrink core hashes on small systems
Message-ID: <20040405204957.GF6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shrink hashes on small systems

Tweak vfs_caches_init logic so that hashes don't start growing as
quickly on small systems.


 tiny-mpm/init/main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN init/main.c~hash-sizes init/main.c
--- tiny/init/main.c~hash-sizes	2004-03-20 12:14:43.000000000 -0600
+++ tiny-mpm/init/main.c	2004-03-20 12:14:43.000000000 -0600
@@ -470,7 +470,9 @@ asmlinkage void __init start_kernel(void
 	buffer_init();
 	unnamed_dev_init();
 	security_scaffolding_startup();
-	vfs_caches_init(num_physpages);
+	/* Treat machines smaller than 6M as having 2M of memory
+	   for hash-sizing purposes */
+	vfs_caches_init(max(500, (int)num_physpages-1000));
 	radix_tree_init();
 	signals_init();
 	/* rootfs populating might need page-writeback */

_


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
