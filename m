Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLQIpt>; Sun, 17 Dec 2000 03:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLQIpi>; Sun, 17 Dec 2000 03:45:38 -0500
Received: from linuxcare.com.au ([203.29.91.49]:23556 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129401AbQLQIp0>; Sun, 17 Dec 2000 03:45:26 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: NFS: set_bit on an 'int' variable OK for 64-bit? 
In-Reply-To: Your message of "Mon, 11 Dec 2000 17:08:45 BST."
             <E145WRS-0008A3-00@the-village.bc.nu> 
Date: Fri, 15 Dec 2000 16:47:26 +1100
Message-Id: <E146niI-00009W-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E145WRS-0008A3-00@the-village.bc.nu> you write:
> > since test11, the NFS code uses the set_bit and related routines
> > to manipulate the wb_flags member of the nfs_page struct (nfs_page.h).
> > Unfortunately, wb_flags has still data type 'int'.
> 
> NFS is wrong. Rusty did a complete audit of the code and I've been feeding
> some stuff to Linus. That one may have been missed

Yes, didn't grep the headers.  Hmm... that's the only one in
include/linux/*.h though.

> > What do you suggest we should do?   Fix nfs_page to use a 'long'
> > variable, or change our bitops macros to use ints?
> 
> Fix NFS

Yep, it's trivial.

Cheers,
Rusty. 
--
Hacking time.

--- working-2.4.0-test12/include/linux/nfs_page.h.~1~	Thu Dec 14 14:20:28 2000
+++ working-2.4.0-test12/include/linux/nfs_page.h	Fri Dec 15 16:46:09 2000
@@ -31,10 +31,10 @@
 	struct page		*wb_page;	/* page to read in/write out */
 	wait_queue_head_t	wb_wait;	/* wait queue */
 	unsigned long		wb_timeout;	/* when to read/write/commit */
+	unsigned long		wb_flags;	/* long req'd for set_bit */
 	unsigned int		wb_offset,	/* Offset of read/write */
 				wb_bytes,	/* Length of request */
-				wb_count,	/* reference count */
-				wb_flags;
+				wb_count;	/* reference count */
 	struct nfs_writeverf	wb_verf;	/* Commit cookie */
 };
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
