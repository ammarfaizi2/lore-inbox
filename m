Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311536AbSCTEHq>; Tue, 19 Mar 2002 23:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311548AbSCTEFv>; Tue, 19 Mar 2002 23:05:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51472 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311532AbSCTEE6>; Tue, 19 Mar 2002 23:04:58 -0500
Message-ID: <3C980A11.AD5A7660@zip.com.au>
Date: Tue, 19 Mar 2002 20:03:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-200-active_page_swapout
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last one.


Don't bother checking for active pages in the swapout path.

Not sure about this one.  Clearly the page isn't *likely* to be on the
active list, because the caller found it on the inactive list.  But I
don't see any locking which would prevent the page from getting bumped
up to the active list in the meanwhile.

Needs more explanation.


=====================================

--- 2.4.19-pre3/mm/vmscan.c~aa-200-active_page_swapout	Tue Mar 19 19:49:04 2002
+++ 2.4.19-pre3-akpm/mm/vmscan.c	Tue Mar 19 19:49:04 2002
@@ -83,10 +83,6 @@ static inline int try_to_swap_out(struct
 		return 0;
 	}
 
-	/* Don't bother unmapping pages that are active */
-	if (PageActive(page))
-		return 0;
-
 	/* Don't bother replenishing zones not under pressure.. */
 	if (!memclass(page_zone(page), classzone))
 		return 0;

-
