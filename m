Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbSJACf0>; Mon, 30 Sep 2002 22:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbSJACf0>; Mon, 30 Sep 2002 22:35:26 -0400
Received: from dp.samba.org ([66.70.73.150]:16775 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261452AbSJACfZ>;
	Mon, 30 Sep 2002 22:35:25 -0400
Date: Tue, 1 Oct 2002 12:40:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Squash highmem related warnings
Message-ID: <20021001024055.GO10265@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  This adds to the non-highmem version of
kunmap_atomic() a dummy reference to its arguments.  This can prevent
unused variable warnings in its callers, such as in
put_aio_ring_event() in fs/aio.c.

diff -urN /home/dgibson/kernel/linuxppc-2.5/include/linux/highmem.h linux-bluefish/include/linux/highmem.h
--- /home/dgibson/kernel/linuxppc-2.5/include/linux/highmem.h	2002-09-20 14:36:09.000000000 +1000
+++ linux-bluefish/include/linux/highmem.h	2002-10-01 12:17:11.000000000 +1000
@@ -25,7 +25,8 @@
 #define kunmap(page) do { (void) (page); } while (0)
 
 #define kmap_atomic(page, idx)		page_address(page)
-#define kunmap_atomic(addr, idx)	do { } while (0)
+#define kunmap_atomic(addr, idx)	do { /* avoid unused variable warnings in caller: */ \
+					     (void)(addr); } while (0)
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 
 #endif /* CONFIG_HIGHMEM */


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
