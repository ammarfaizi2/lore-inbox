Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSEFWaY>; Mon, 6 May 2002 18:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315236AbSEFWaX>; Mon, 6 May 2002 18:30:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38673 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315213AbSEFWaW>;
	Mon, 6 May 2002 18:30:22 -0400
Message-ID: <3CD703C1.A0D45C4F@zip.com.au>
Date: Mon, 06 May 2002 15:29:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Writing to the swap space
In-Reply-To: <20020506221125.GA25298@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> For swsusp, I need to write to the swap space.
> 

Ah.  That's some left-over code.  Reads will be OK, but
writes will be unexpectedly asynchronous.  Nothing in
the kernel uses that function for writes so it didn't show up.

--- linux-2.5.14/mm/page_io.c	Tue Apr 30 17:56:30 2002
+++ 25/mm/page_io.c	Mon May  6 15:24:09 2002
@@ -117,9 +117,6 @@ void rw_swap_page_nolock(int rw, swp_ent
 	page->mapping = &swapper_space;
 	if (!rw_swap_page_base(rw, entry, page))
 		unlock_page(page);
-	if (rw == WRITE)
-		wait_on_page_writeback(page);
-	else
-		wait_on_page_locked(page);
+	wait_on_page_locked(page);
 	page->mapping = NULL;
 }


-
