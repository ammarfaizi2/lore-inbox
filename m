Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269639AbRH0Wqa>; Mon, 27 Aug 2001 18:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269645AbRH0WqU>; Mon, 27 Aug 2001 18:46:20 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:2833 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269639AbRH0WqM>; Mon, 27 Aug 2001 18:46:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Improved allocation failure warning
Date: Tue, 28 Aug 2001 00:53:01 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827224626Z16259-32384+745@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you please consider applying this change to __alloc_pages, which
adds the gfp flags and process state information to the "allocation
failed" message.  This has already proved useful in diagnosing at least
one vm problem.

--- 2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
+++ 2.4.9/mm/page_alloc.c	Mon Aug 20 22:05:40 2001
@@ -502,7 +502,8 @@
 	}
 
 	/* No luck.. */
-	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
+	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed (gfp=0x%x/%i).\n",
+		order, gfp_mask, !!(current->flags & PF_MEMALLOC));
 	return NULL;
 }
 

