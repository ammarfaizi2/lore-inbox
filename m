Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbTLHOXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 09:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265425AbTLHOXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 09:23:42 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:15306
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S265422AbTLHOXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 09:23:40 -0500
From: Con Kolivas <kernel@kolivas.org>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Tue, 9 Dec 2003 01:23:31 +1100
User-Agent: KMail/1.5.3
Cc: Chris Vine <chris@cvine.freeserve.co.uk>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com>
In-Reply-To: <20031208135225.GT19856@holomorphy.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jlI1/I1wAysTfya"
Message-Id: <200312090123.31895.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_jlI1/I1wAysTfya
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[snip original discussion thrashing swap on 2.6test with 32mb ram]

Chris

By an unusual coincidence I was looking into the patches that were supposed to 
speed up application startup and noticed this one was merged. A brief 
discussion with wli suggests this could cause thrashing problems on low 
memory boxes so can you try this patch? Applies to test11.

Con

--Boundary-00=_jlI1/I1wAysTfya
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-backout-readahead"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-backout-readahead"

--- linux-2.6.0-test11-base/mm/filemap.c	2003-11-24 22:18:56.000000000 +1100
+++ linux-2.6.0-test11-fremap/mm/filemap.c	2003-12-09 01:17:47.793384425 +1100
@@ -1285,10 +1285,6 @@ static int filemap_populate(struct vm_ar
 	struct page *page;
 	int err;
 
-	if (!nonblock)
-		force_page_cache_readahead(mapping, vma->vm_file,
-					pgoff, len >> PAGE_CACHE_SHIFT);
-
 repeat:
 	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if (pgoff + (len >> PAGE_CACHE_SHIFT) > size)

--Boundary-00=_jlI1/I1wAysTfya--

