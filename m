Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSEUNLa>; Tue, 21 May 2002 09:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSEUNLD>; Tue, 21 May 2002 09:11:03 -0400
Received: from imladris.infradead.org ([194.205.184.45]:25101 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314525AbSEUNKN>; Tue, 21 May 2002 09:10:13 -0400
Date: Tue, 21 May 2002 14:10:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] buffermem_pages removal (4/5)
Message-ID: <20020521141009.D15796@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the most discussion-worthy patch of the series:  Change the
meaning of si_meminfo->bufferram from "all pages in pagecache
backed by block devices" to "all pages in pagecache".

In the header/manpage is is documented as "Memory used by buffers",
but as the buffercache is gone I think the new meaning fits the
intention from pre-pagecache days much better.


--- 1.57/mm/page_alloc.c	Sun May  5 18:56:08 2002
+++ edited/mm/page_alloc.c	Tue May 21 14:27:32 2002
@@ -608,7 +608,7 @@
 	val->totalram = totalram_pages;
 	val->sharedram = 0;
 	val->freeram = nr_free_pages();
-	val->bufferram = atomic_read(&buffermem_pages);
+	val->bufferram = get_page_cache_size();
 #ifdef CONFIG_HIGHMEM
 	val->totalhigh = totalhigh_pages;
 	val->freehigh = nr_free_highpages();
