Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACVH2>; Wed, 3 Jan 2001 16:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRACVHS>; Wed, 3 Jan 2001 16:07:18 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:13303 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129267AbRACVHE>; Wed, 3 Jan 2001 16:07:04 -0500
Date: Wed, 3 Jan 2001 15:07:03 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Should page->count ever be -1?
X-Mailer: The Polarbar Mailer; version=1.19; build=71
Message-Id: <20010103210714Z129267-457+17@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing some kind of memory leaks playing with ioremap and iounmap,
and I've narrowed down the problem to iounmap refusing to unmap the memory that
I just mapped.  The line of code in question is

	if (!PageReserved(page) && atomic_dec_and_test(&page->count)) {

from page_alloc.c (this is 2.2.18pre15).  It appears that page->count is
already zero when this code is executed, and after it's executed, page->count
becomes -1 (or more accurately, 0xFFFFFFFF).  Is this acceptable, or is it an
error condition?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
