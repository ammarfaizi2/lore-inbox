Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130849AbQL1TL1>; Thu, 28 Dec 2000 14:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130756AbQL1TLR>; Thu, 28 Dec 2000 14:11:17 -0500
Received: from hermes.mixx.net ([212.84.196.2]:56584 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130592AbQL1TLM>;
	Thu, 28 Dec 2000 14:11:12 -0500
Message-ID: <3A4B8895.CEDA8311@innominate.de>
Date: Thu, 28 Dec 2000 19:38:13 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012271717230.14052-100000@duckman.distro.conectiva> <87d7eded2d.fsf@atlas.iskon.hr> <3A4A758F.98EBC605@innominate.de> <3A4B4E62.237DC3C5@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[in vmscan.c]
> Between line 573 and 594 the page can have 1 user and be unlocked, so it
> can be removed by invalidate_inode_pages, and the mapping will be
> cleared here:
> http://innominate.org/~graichen/projects/lxr/source/mm/filemap.c?v=v2.3#L98

This seems like the obvious thing to do:

--- 2.4.0-test13.clean/mm/filemap.c	Fri Dec 29 03:14:58 2000
+++ 2.4.0-test13/mm/filemap.c	Fri Dec 29 03:16:21 2000
@@ -96,6 +96,7 @@
 	remove_page_from_inode_queue(page);
 	remove_page_from_hash_queue(page);
 	page->mapping = NULL;
+	ClearPageDirty(page);
 }
 
 void remove_inode_page(struct page *page)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
