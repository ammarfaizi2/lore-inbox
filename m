Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbTB1MgB>; Fri, 28 Feb 2003 07:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267869AbTB1MgB>; Fri, 28 Feb 2003 07:36:01 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11396 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S267859AbTB1MgA>; Fri, 28 Feb 2003 07:36:00 -0500
Date: Fri, 28 Feb 2003 12:48:06 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Con Kolivas <kernel@kolivas.org>, <dmccr@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Rising io_load results Re: 2.5.63-mm1
In-Reply-To: <20030227160656.40ebeb93.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302281245170.1203-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2003, Andrew Morton wrote:
> 
> No, it is still wrong.  Mapped cannot exceed MemTotal.

It needs this in addition to Dave's patch from yesterday:

--- 2.5.63-objfix-1/mm/rmap.c	Thu Feb 27 23:37:28 2003
+++ 2.5.63-objfix-2/mm/rmap.c	Fri Feb 28 12:33:58 2003
@@ -349,7 +349,8 @@
 			BUG();
 		if (atomic_read(&page->pte.mapcount) == 0)
 			BUG();
-		atomic_dec(&page->pte.mapcount);
+		if (atomic_dec_and_test(&page->pte.mapcount))
+			dec_page_state(nr_mapped);
 		return;
 	}
 

