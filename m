Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIRfe>; Tue, 9 Jan 2001 12:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130850AbRAIRfY>; Tue, 9 Jan 2001 12:35:24 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:59633 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129324AbRAIRfK>; Tue, 9 Jan 2001 12:35:10 -0500
Date: Tue, 9 Jan 2001 11:35:09 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux MM mailing list <linux-mm@kvack.org>
Subject: ioremap doesn't increment page->count, but iounmap decrements it
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010109173515Z129324-400+2363@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just discovered an oddity in 2.2.18pre15.  When ioremap() is used to map
reserved pages (of real RAM), it does not increment the "count" field for the
page it remaps (i.e. page->count).  However, when you call iounmap on that
memory, that function decrements page->count.  Since the count was originally
zero, it gets decremented to -1, and that's when things start to go bad.

I get the feeling that if I remap reserved memory, I'm not supposed to ever
unmap it.  But that means that my driver will have a memory leak.  Can someone
help me out?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
