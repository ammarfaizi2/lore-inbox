Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129426AbQK3WDr>; Thu, 30 Nov 2000 17:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbQK3WDh>; Thu, 30 Nov 2000 17:03:37 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:27845 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129426AbQK3WDT>; Thu, 30 Nov 2000 17:03:19 -0500
Message-ID: <3A26C82D.26267202@uow.edu.au>
Date: Fri, 01 Dec 2000 08:35:41 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test11-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> Confirms. That's definitely an empty list_head at address 0xc3c49058 and -pre2
> has O_SYNC patches.

foo.   The overnight run wedged tight in mmap002. No progress.

I bet this'll catch it:

--- include/linux/list.h.orig	Fri Dec  1 08:33:36 2000
+++ include/linux/list.h	Fri Dec  1 08:33:55 2000
@@ -90,6 +90,7 @@
 static __inline__ void list_del(struct list_head *entry)
 {
 	__list_del(entry->prev, entry->next);
+	entry->next = entry->prev = 0;
 }
 
 /**


First person to send a ksymoops trace gets a cookie.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
