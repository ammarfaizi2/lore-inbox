Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264798AbSJOVwY>; Tue, 15 Oct 2002 17:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSJOVwY>; Tue, 15 Oct 2002 17:52:24 -0400
Received: from infa.abo.fi ([130.232.208.126]:59403 "EHLO infa.abo.fi")
	by vger.kernel.org with ESMTP id <S264798AbSJOVwX>;
	Tue, 15 Oct 2002 17:52:23 -0400
Date: Wed, 16 Oct 2002 00:58:12 +0300
From: Marcus Alanen <marcus@infa.abo.fi>
Message-Id: <200210152158.AAA18031@infa.abo.fi>
To: maalanen@ra.abo.fi, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.5] __vmalloc allocates spurious page?
In-Reply-To: <Pine.LNX.4.44.0210152221080.14143-100000@tuxedo.abo.fi>
References: <Pine.LNX.4.44.0210152221080.14143-100000@tuxedo.abo.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The unnecessary page is allocated only if size is initially a multiple 
>of PAGE_SIZE, which sounds like a common case.

Actually, size is already PAGE_ALIGNed, so we get the amount of pages
even easier.

Marcus


diff -Naurd --exclude-from=/home/maalanen/linux/base/diff_exclude linus-2.5.42/mm/vmalloc.c msa-2.5.42/mm/vmalloc.c
--- linus-2.5.42/mm/vmalloc.c	Sat Oct 12 16:42:57 2002
+++ msa-2.5.42/mm/vmalloc.c	Wed Oct 16 00:52:33 2002
@@ -387,7 +387,7 @@
 	if (!area)
 		return NULL;
 
-	nr_pages = (size+PAGE_SIZE) >> PAGE_SHIFT;
+	nr_pages = size >> PAGE_SHIFT;
 	array_size = (nr_pages * sizeof(struct page *));
 
 	area->nr_pages = nr_pages;



