Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVBLD3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVBLD3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVBLD1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:27:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33450 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262388AbVBLD0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:26:12 -0500
Date: Fri, 11 Feb 2005 19:26:07 -0800 (PST)
From: Ray Bryant <raybry@sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>, Hugh DIckins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcello@cyclades.com>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <20050212032607.18524.1073.41476@tomahawk.engr.sgi.com>
In-Reply-To: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
Subject: [RFC 2.6.11-rc2-mm2 5/7] mm: manual page migration -- cleanup 5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up a switch statement so gcc doesn't complain about it.

Signed-off-by: Ray Bryant <raybry@sgi.com>

Index: linux/mm/mmigrate.c
===================================================================
--- linux.orig/mm/mmigrate.c	2005-01-30 11:13:58.000000000 -0800
+++ linux/mm/mmigrate.c	2005-01-30 11:19:33.000000000 -0800
@@ -319,17 +319,17 @@ generic_migrate_page(struct page *page, 
 	/* Wait for all operations against the page to finish. */
 	ret = migrate_fn(page, newpage, &vlist);
 	switch (ret) {
-	default:
-		/* The page is busy. Try it later. */
-		goto out_busy;
 	case -ENOENT:
 		/* The file the page belongs to has been truncated. */
 		page_cache_get(page);
 		page_cache_release(newpage);
 		newpage->mapping = NULL;
-		/* fall thru */
+		break;
 	case 0:
-		/* fall thru */
+		break;
+	default:
+		/* The page is busy. Try it later. */
+		goto out_busy;
 	}
 
 	arch_migrate_page(page, newpage);

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
