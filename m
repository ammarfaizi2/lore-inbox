Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRCHKLs>; Thu, 8 Mar 2001 05:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131310AbRCHKLh>; Thu, 8 Mar 2001 05:11:37 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:49149 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131307AbRCHKL3>; Thu, 8 Mar 2001 05:11:29 -0500
Message-Id: <5.0.2.1.2.20010308095213.00a59040@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 08 Mar 2001 10:11:50 +0000
To: Rik van Riel <riel@conectiva.com.br>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Questions - Re: [PATCH] documentation for mm.h
Cc: Andrew Morton <andrewm@uow.edu.au>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0103071931400.1409-100000@duckman.distro.con
 ectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:33 07/03/2001, Rik van Riel wrote:
[snip]
>  typedef struct page {
>+       struct list_head list;          /* ->mapping has some page lists. */
>+       struct address_space *mapping;  /* The inode (or ...) we belong to. */
>+       unsigned long index;            /* Our offset within mapping. */

Assuming index is in bytes (it looks like it is): Shouldn't index of type 
unsigned long long or __u64? Otherwise, AFAICS using the page cache 
automatically results in an artificial 4Gib limit on file size, which is 
not very good, even by todays standards.

[snip]
>+ * During disk I/O, PG_locked is used. This bit is set before I/O
>+ * and reset when I/O completes. page->wait is a wait queue of all
>+ * tasks waiting for the I/O on this page to complete.

Is this physical I/O only or does it include a driver writing/reading the page?

Thanks,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

