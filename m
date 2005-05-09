Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVEIM3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVEIM3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 08:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVEIM32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 08:29:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:15252 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261305AbVEIM3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 08:29:25 -0400
X-Authenticated: #5039886
Date: Mon, 9 May 2005 14:29:16 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [patch] mm: fix rss counter being incremented when unmapping
Message-ID: <20050509122916.GA30726@doener.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.8i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug introduced by the "mm counter operations through
macros" patch, which replaced a decrement operation in with an increment
macro in try_to_unmap_one().

Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>

diff -NurpP --minimal linux-2.6.12-rc4/mm/rmap.c linux-2.6.12-rc4-fixed/mm/rmap.c
--- linux-2.6.12-rc4/mm/rmap.c  2005-05-08 17:53:49.000000000 +0200
+++ linux-2.6.12-rc4-fixed/mm/rmap.c    2005-05-09 13:38:03.000000000 +0200
@@ -586,7 +586,7 @@ static int try_to_unmap_one(struct page 
                dec_mm_counter(mm, anon_rss);
        }
 
-       inc_mm_counter(mm, rss);
+       dec_mm_counter(mm, rss);
        page_remove_rmap(page);
        page_cache_release(page);
 
