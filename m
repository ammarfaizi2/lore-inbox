Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSGDXpQ>; Thu, 4 Jul 2002 19:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSGDXpP>; Thu, 4 Jul 2002 19:45:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27405 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314707AbSGDXpP>;
	Thu, 4 Jul 2002 19:45:15 -0400
Message-ID: <3D24E002.CB648D47@zip.com.au>
Date: Thu, 04 Jul 2002 16:53:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 1/27] handle BIO allocation failures in swap_writepage()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



If allocation of a BIO for swap writeout fails, mark the page dirty
again to save it from eviction.



 page_io.c |    1 +
 1 files changed, 1 insertion(+)

--- 2.5.24/mm/page_io.c~swap-bio-fail	Thu Jul  4 16:17:05 2002
+++ 2.5.24-akpm/mm/page_io.c	Thu Jul  4 16:22:13 2002
@@ -98,6 +98,7 @@ int swap_writepage(struct page *page)
 	}
 	bio = get_swap_bio(GFP_NOIO, page, end_swap_bio_write);
 	if (bio == NULL) {
+		set_page_dirty(page);
 		ret = -ENOMEM;
 		goto out;
 	}

-
