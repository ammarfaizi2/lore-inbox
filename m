Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314783AbSEDF0o>; Sat, 4 May 2002 01:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314794AbSEDF0o>; Sat, 4 May 2002 01:26:44 -0400
Received: from sullivan.realtime.net ([205.238.128.209]:25617 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S314783AbSEDF0n>; Sat, 4 May 2002 01:26:43 -0400
Date: Sat, 4 May 2002 00:26:42 -0500 (CDT)
Message-Id: <200205040526.g445Qgc74545@sullivan.realtime.net>
To: Milton Miller <miltonm@sss.org>
Cc: linux-kernel@vger.kernel.org
From: Milton Miller <miltonm@bga.com>
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <87offy17li.fsf@enki.rimspace.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this patch would make a difference ??

milton

===== mm/filemap.c 1.81 vs edited =====
--- 1.81/mm/filemap.c	Mon Apr 29 17:18:54 2002
+++ edited/mm/filemap.c	Fri May  3 20:47:35 2002
@@ -287,11 +287,11 @@
 	clean_list_pages(mapping, &mapping->io_pages, start);
 	clean_list_pages(mapping, &mapping->dirty_pages, start);
 	do {
-		unlocked |= truncate_list_pages(mapping,
+		unlocked = truncate_list_pages(mapping,
 				&mapping->io_pages, start, &partial);
 		unlocked |= truncate_list_pages(mapping,
 				&mapping->dirty_pages, start, &partial);
-		unlocked = truncate_list_pages(mapping,
+		unlocked |= truncate_list_pages(mapping,
 				&mapping->clean_pages, start, &partial);
 		unlocked |= truncate_list_pages(mapping,
 				&mapping->locked_pages, start, &partial);
