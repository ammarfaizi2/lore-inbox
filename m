Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSFAIgm>; Sat, 1 Jun 2002 04:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSFAIgl>; Sat, 1 Jun 2002 04:36:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41994 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315413AbSFAIgk>;
	Sat, 1 Jun 2002 04:36:40 -0400
Message-ID: <3CF88863.BF3AF0FA@zip.com.au>
Date: Sat, 01 Jun 2002 01:40:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/16] list_head debugging
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A common and very subtle bug is to use list_heads which aren't on any
lists.  It causes kernel memory corruption which is observed long after
the offending code has executed.

The patch nulls out the dangling pointers so we get a nice oops at the
site of the buggy code.


=====================================

--- 2.5.19/include/linux/list.h~list-debug	Sat Jun  1 01:18:05 2002
+++ 2.5.19-akpm/include/linux/list.h	Sat Jun  1 01:18:05 2002
@@ -94,6 +94,11 @@ static __inline__ void __list_del(struct
 static __inline__ void list_del(struct list_head *entry)
 {
 	__list_del(entry->prev, entry->next);
+	/*
+	 * This is debug.  Remove it when the kernel has no bugs ;)
+	 */
+	entry->next = 0;
+	entry->prev = 0;
 }
 
 /**

-
