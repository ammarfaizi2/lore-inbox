Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSFYTYh>; Tue, 25 Jun 2002 15:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315893AbSFYTYh>; Tue, 25 Jun 2002 15:24:37 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:50610 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315856AbSFYTYf>; Tue, 25 Jun 2002 15:24:35 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 25 Jun 2002 12:24:17 -0700
Message-Id: <200206251924.MAA00672@adam.yggdrasil.com>
To: torvalds@transmeta.com
Subject: PATCH: linux-2.5.24/Documentation/DMA-mapping.txt update for struct scatterlist change
Cc: akpm@zip.com.au, axboe@suse.de, davem@redhat.com,
       linux-kernel@vger.kernel.org, martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	linux-2.5.24/Documentation/DMA-mapping.txt contains a few
sentences about struct scatterlist that are no longer accurate, now
that scatterlist.address has been deleetd in Linux-2.5.  Dave Miller
says that I should "feel free to submit a patch" to fix this.  So,
here it is.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.24/Documentation/DMA-mapping.txt	2002-06-20 15:53:53.000000000 -0700
+++ linux/Documentation/DMA-mapping.txt	2002-06-25 12:16:49.000000000 -0700
@@ -759,22 +759,20 @@
    Struct scatterlist must contain, at a minimum, the following
    members:
 
 	struct page *page;
 	unsigned int offset;
 	unsigned int length;
 
-   This means that your pci_{map,unmap}_sg() and all other
-   interfaces dealing with scatterlists must be able to cope
-   properly with page being non NULL.
-
-   A scatterlist is in one of two states.  The base address is
-   either specified by "address" or by a "page+offset" pair.
-   If "address" is NULL, then "page+offset" is being used.
-   If "page" is NULL, then "address" is being used.
+   The base address is specified by a "page+offset" pair.
+
+   Previous versions of struct scatterlist contained a "void *address"
+   field that was sometimes used instead of page+offset.  As of Linux
+   2.5., page+offset is always used, and the "address" field has been
+   deleted.
 
 2) More to come...
 
 			   Closing
 
 This document, and the API itself, would not be in it's current
 form without the feedback and suggestions from numerous individuals.
