Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262328AbSI1Uul>; Sat, 28 Sep 2002 16:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262330AbSI1Uul>; Sat, 28 Sep 2002 16:50:41 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:30665 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262328AbSI1Uuk>;
	Sat, 28 Sep 2002 16:50:40 -0400
Date: Sat, 28 Sep 2002 13:56:01 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200209282056.g8SKu1i2009029@napali.hpl.hp.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] avoid reference to struct page before it's declared
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCC currently warns when page-flags.h gets included before struct page
is declared.  Patch below fixes this.

	--david
--
Interested in learning more about IA-64 Linux?  Try http://www.lia64.org/book/

===== include/linux/page-flags.h 1.21 vs edited =====
--- 1.21/include/linux/page-flags.h	Fri Sep 27 15:52:04 2002
+++ edited/include/linux/page-flags.h	Sat Sep 28 12:50:48 2002
@@ -211,6 +211,8 @@
 extern struct address_space swapper_space;
 #define PageSwapCache(page) ((page)->mapping == &swapper_space)
 
+struct page;	/* forward declaration */
+
 int test_clear_page_dirty(struct page *page);
 
 static inline void clear_page_dirty(struct page *page)

