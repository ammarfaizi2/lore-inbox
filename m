Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268452AbUH3POO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268452AbUH3POO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUH3POO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:14:14 -0400
Received: from verein.lst.de ([213.95.11.210]:18889 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268452AbUH3POM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:14:12 -0400
Date: Mon, 30 Aug 2004 17:14:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] read EXTRAVERSION from file
Message-ID: <20040830151405.GA18836@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, sam@ravnborg.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The're an very interesting patch in the Debian tree still from the time
where Herbert Xu mentioned it, it allows creating a file .extraversion
in the toplevel kernel directory and the Makefile will set EXTRAVERSION
to it's contents.  This has the nice advantage of keeping an
extraversion pre-tree instead of having to patch the Makefile and
getting rejects everytime you pull a new tree (or BK refuses to touch
the Makefile).

The only thing I'm not fully comfortable is the .extraversion name, I
think I'd prefer a user-visible name.

Any other comments on this one?

--- kernel-source-2.6.6/Makefile	2004-05-10 19:47:45.000000000 +1000
+++ kernel-source-2.6.6-1/Makefile	2004-05-10 22:21:02.000000000 +1000
@@ -151,6 +151,9 @@
 
 export srctree objtree VPATH TOPDIR
 
+ifeq ($(EXTRAVERSION),)
+EXTRAVERSION := $(shell [ ! -f .extraversion ] || cat .extraversion)
+endif
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
