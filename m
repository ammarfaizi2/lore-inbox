Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTHaDGq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 23:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTHaDGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 23:06:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61606 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264537AbTHaDGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 23:06:44 -0400
Date: Sun, 31 Aug 2003 04:06:43 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] vmalloc might sleep
Message-ID: <20030831030643.GQ13467@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So let's whack people upside the head when they misuse it.

vmalloc-might-sleep.diff:

Index: mm/vmalloc.c
===================================================================
RCS file: /var/cvs/linux-2.6/mm/vmalloc.c,v
retrieving revision 1.2
diff -u -p -r1.2 vmalloc.c
--- a/mm/vmalloc.c	23 Aug 2003 02:47:26 -0000	1.2
+++ b/mm/vmalloc.c	31 Aug 2003 03:04:25 -0000
@@ -438,7 +438,8 @@ fail:
  */
 void *vmalloc(unsigned long size)
 {
-       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
+	might_sleep();
+	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
 }
 
 /**
@@ -451,6 +452,7 @@ void *vmalloc(unsigned long size)
  */
 void *vmalloc_32(unsigned long size)
 {
+	might_sleep();
 	return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);
 }
 

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
