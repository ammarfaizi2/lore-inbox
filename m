Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVADOZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVADOZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVADOZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:25:44 -0500
Received: from darwin.snarc.org ([81.56.210.228]:10117 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261661AbVADOZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:25:40 -0500
Date: Tue, 4 Jan 2005 15:25:38 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill one "if (X) vfree(X)" usage
Message-ID: <20050104142538.GA4771@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040907i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, the following patch remove a if (x) vfree(x) usage
please apply.

Signed-off-by: Vincent Hanquez <tab@snarc.org>

--- linux-2.6.10.orig/mm/swapfile.c.orig	2005-01-04 14:59:04 +0100
+++ linux-2.6.10/mm/swapfile.c	2005-01-04 14:59:35 +0100
@@ -1592,8 +1592,7 @@
 		++least_priority;
 	swap_list_unlock();
 	destroy_swap_extents(p);
-	if (swap_map)
-		vfree(swap_map);
+	vfree(swap_map);
 	if (swap_file)
 		filp_close(swap_file, NULL);
 out:
