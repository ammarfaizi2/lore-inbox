Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbUJ0MOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbUJ0MOB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbUJ0MOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:14:00 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:45267 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262399AbUJ0MNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:13:47 -0400
Date: Wed, 27 Oct 2004 13:13:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Adrian Bunk <bunk@stusta.de>
cc: Mathieu Segaud <matt@minas-morgul.org>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <reiserfs-dev@namesys.com>
Subject: Re: 2.6.10-rc1-mm1: reiser4 delete_from_page_cache compile error
In-Reply-To: <20041027111102.GD2550@stusta.de>
Message-ID: <Pine.LNX.4.44.0410271308150.20127-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Adrian Bunk wrote:
>   LD      .tmp_vmlinux1
> fs/built-in.o(.text+0xd2393): In function `drop_page':
> : undefined reference to `delete_from_page_cache'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Hugh already requested to drop his patch.

That's right, thanks Adrian.  Mathieu, please just "patch -R -p1" the below

--- 25/fs/reiser4/page_cache.c~reiser4-delete_from_page_cache	2004-10-24 23:37:37.997272448 -0700
+++ 25-akpm/fs/reiser4/page_cache.c	2004-10-24 23:37:38.001271840 -0700
@@ -759,13 +759,9 @@ drop_page(struct page *page)
 #if defined(PG_skipped)
 	ClearPageSkipped(page);
 #endif
-	if (page->mapping != NULL) {
-		remove_from_page_cache(page);
-		unlock_page(page);
-		/* page removed from the mapping---decrement page counter */
-		page_cache_release(page);
-	} else
-		unlock_page(page);
+	if (page->mapping != NULL)
+		delete_from_page_cache(page);
+	unlock_page(page);
 }
 
 

