Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbULNUOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbULNUOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbULNUOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:14:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9860 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261624AbULNUOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:14:10 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Get rid of arch_free_page() warning
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Tue, 14 Dec 2004 20:14:00 +0000
Message-ID: <16679.1103055240@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch gets rid of a warning produced when compiling
mm/page_alloc.c if the arch doesn't supply its own arch_free_page().

The problem is that there's one place in there that ignores the return value
of this function, and so you get a warning from gcc about an ineffectual
statement.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat ../archfreepage-2610rc3.diff 
 gfp.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -uNr linux-2.6.10-rc3-mm1-mmcleanup/include/linux/gfp.h linux-2.6.10-rc3-mm1-misc/include/linux/gfp.h
--- linux-2.6.10-rc3-mm1-mmcleanup/include/linux/gfp.h	2004-12-13 17:34:21.000000000 +0000
+++ linux-2.6.10-rc3-mm1-misc/include/linux/gfp.h	2004-12-14 14:08:48.836858832 +0000
@@ -79,7 +79,10 @@
  * immediately bail: the arch-specific function has done all the work.
  */
 #ifndef HAVE_ARCH_FREE_PAGE
-#define arch_free_page(page, order) 0
+static inline int arch_free_page(struct page *page, unsigned int order)
+{
+	return 0;
+}
 #endif
 
 extern struct page *
