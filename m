Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271864AbRHUVK7>; Tue, 21 Aug 2001 17:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271869AbRHUVKt>; Tue, 21 Aug 2001 17:10:49 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:27921 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271864AbRHUVKe>; Tue, 21 Aug 2001 17:10:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Improved allocation failure warning
Date: Tue, 21 Aug 2001 23:17:09 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010821211043Z16127-32383+745@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

The following change to the allocation failure warning in __alloc_pages has worked
well for tracking down the cause of these failures.  It prints the gfp flags and
the state of the task, PF_MEMALLOC or not.

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
 
