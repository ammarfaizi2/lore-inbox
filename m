Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSGDXud>; Thu, 4 Jul 2002 19:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSGDXr7>; Thu, 4 Jul 2002 19:47:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40973 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315200AbSGDXqW>;
	Thu, 4 Jul 2002 19:46:22 -0400
Message-ID: <3D24E046.D0945FE0@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 17/27] Use __GFP_HIGH in mpage_writepages()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In mpage_writepage(), use __GFP_HIGH when allocating the BIO: writeback
is a memory reclaim function and is entitle to dip into the page
reserves to get its IO underway.


 mpage.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.5.24/fs/mpage.c~mpage_writepage-tryharder	Thu Jul  4 16:17:26 2002
+++ 2.5.24-akpm/fs/mpage.c	Thu Jul  4 16:22:08 2002
@@ -431,7 +431,7 @@ page_is_mapped:
 		unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;
 
 		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
-					nr_bvecs, GFP_NOFS);
+					nr_bvecs, GFP_NOFS|__GFP_HIGH);
 		if (bio == NULL)
 			goto confused;
 	}

-
