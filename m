Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSGDXuc>; Thu, 4 Jul 2002 19:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSGDXrn>; Thu, 4 Jul 2002 19:47:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39693 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315192AbSGDXqN>;
	Thu, 4 Jul 2002 19:46:13 -0400
Message-ID: <3D24E03C.4713314E@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 15/27] set_page_dirty() in mark_dirty_kiobuf()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Yet another SetPageDirty/set_page_dirty bugfix: mark_dirty_kiobuf needs
to run set_page_dirty() so the page goes onto its mapping's dirty_pages
list.


 memory.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.5.24/mm/memory.c~mark_dirty_kiobuf	Thu Jul  4 16:17:24 2002
+++ 2.5.24-akpm/mm/memory.c	Thu Jul  4 16:22:03 2002
@@ -612,7 +612,7 @@ void mark_dirty_kiobuf(struct kiobuf *io
 		page = iobuf->maplist[index];
 		
 		if (!PageReserved(page))
-			SetPageDirty(page);
+			set_page_dirty(page);
 
 		remaining -= (PAGE_SIZE - offset);
 		offset = 0;

-
