Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVKFIWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVKFIWc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVKFIWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:22:31 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:55187 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932320AbVKFIWa (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:22:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=TLjLk7a4Gd43zrRJHpt5tDgwfHt2auz4r3xBh2nhyzsor3VEIQfNdir3jMIpoG202DfWYnMy2g6d0ANYAc0JCuZr2vvyJlM2ZbsXC9D2cYepl/nXI/qNA8NJ61bpmixd24w5wDP2cYAvWw0QUQqQg1pJQtbLfvOVZPVuidLBgcU=  ;
Message-ID: <436DBDC8.5090308@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:24:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 7/14] mm: remove bad_range
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au>
In-Reply-To: <436DBDA9.2040908@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090402010607080300060008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090402010607080300060008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

7/14

-- 
SUSE Labs, Novell Inc.


--------------090402010607080300060008
Content-Type: text/plain;
 name="mm-remove-bad_range.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-remove-bad_range.patch"

bad_range is supposed to be a temporary check. It would be a pity to throw
it out. Make it depend on CONFIG_DEBUG_VM instead.

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -78,6 +78,7 @@ int min_free_kbytes = 1024;
 unsigned long __initdata nr_kernel_pages;
 unsigned long __initdata nr_all_pages;
 
+#ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
 	int ret = 0;
@@ -119,6 +120,13 @@ static int bad_range(struct zone *zone, 
 	return 0;
 }
 
+#else
+static inline int bad_range(struct zone *zone, struct page *page)
+{
+	return 0;
+}
+#endif
+
 static void bad_page(const char *function, struct page *page)
 {
 	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
Index: linux-2.6/lib/Kconfig.debug
===================================================================
--- linux-2.6.orig/lib/Kconfig.debug
+++ linux-2.6/lib/Kconfig.debug
@@ -172,7 +172,8 @@ config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
 	help
-	  Enable this to debug the virtual-memory system.
+	  Enable this to turn on extended checks in the virtual-memory system
+          that may impact performance.
 
 	  If unsure, say N.
 

--------------090402010607080300060008--
Send instant messages to your online friends http://au.messenger.yahoo.com 
