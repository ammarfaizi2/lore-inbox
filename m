Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314126AbSEFGfc>; Mon, 6 May 2002 02:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSEFGfb>; Mon, 6 May 2002 02:35:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43026 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314126AbSEFGfa>;
	Mon, 6 May 2002 02:35:30 -0400
Message-ID: <3CD624BA.3D094500@zip.com.au>
Date: Sun, 05 May 2002 23:37:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: LKML <linux-kernel@vger.kernel.org>, Anton Altaparmakov <aia21@cantab.net>
Subject: Re: 2.5.14 -- fs/fs.o: In function `end_buffer_read_file_async': 
 undefinedreference to `clear_buffer_async'
In-Reply-To: <3CD61A42.7050502@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> fs/fs.o: In function `end_buffer_read_file_async':
> fs/fs.o(.text+0x705a4): undefined reference to `clear_buffer_async'

oops.  I broke it again.  This is probably a subconcious reaction
to the "NT" thing.   Apologies.

--- 2.5.14/fs/ntfs/aops.c~ntfs	Sun May  5 23:33:05 2002
+++ 2.5.14-akpm/fs/ntfs/aops.c	Sun May  5 23:34:34 2002
@@ -76,13 +76,13 @@ static void end_buffer_read_file_async(s
 		SetPageError(page);
 
 	spin_lock_irqsave(&page_uptodate_lock, flags);
-	clear_buffer_async(bh);
+	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 
 	tmp = bh->b_this_page;
 	while (tmp != bh) {
 		if (buffer_locked(tmp)) {
-			if (buffer_async(tmp))
+			if (buffer_async_read(tmp))
 				goto still_busy;
 		} else if (!buffer_uptodate(tmp))
 			SetPageError(page);
@@ -218,7 +218,7 @@ handle_zblock:
 			struct buffer_head *tbh = arr[i];
 			lock_buffer(tbh);
 			tbh->b_end_io = end_buffer_read_file_async;
-			set_buffer_async(tbh);
+			set_buffer_async_read(tbh);
 		}
 		/* Finally, start i/o on the buffers. */
 		for (i = 0; i < nr; i++)
@@ -378,13 +378,13 @@ static void end_buffer_read_mftbmp_async
 		SetPageError(page);
 
 	spin_lock_irqsave(&page_uptodate_lock, flags);
-	clear_buffer_async(bh);
+	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 
 	tmp = bh->b_this_page;
 	while (tmp != bh) {
 		if (buffer_locked(tmp)) {
-			if (buffer_async(tmp))
+			if (buffer_async_read(tmp))
 				goto still_busy;
 		} else if (!buffer_uptodate(tmp))
 			SetPageError(page);
@@ -501,7 +501,7 @@ handle_zblock:
 			struct buffer_head *tbh = arr[i];
 			lock_buffer(tbh);
 			tbh->b_end_io = end_buffer_read_mftbmp_async;
-			set_buffer_async(tbh);
+			set_buffer_async_read(tbh);
 		}
 		/* Finally, start i/o on the buffers. */
 		for (i = 0; i < nr; i++)
@@ -574,13 +574,13 @@ static void end_buffer_read_mst_async(st
 		SetPageError(page);
 
 	spin_lock_irqsave(&page_uptodate_lock, flags);
-	clear_buffer_async(bh);
+	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 
 	tmp = bh->b_this_page;
 	while (tmp != bh) {
 		if (buffer_locked(tmp)) {
-			if (buffer_async(tmp))
+			if (buffer_async_read(tmp))
 				goto still_busy;
 		} else if (!buffer_uptodate(tmp))
 			SetPageError(page);
@@ -758,7 +758,7 @@ handle_zblock:
 			struct buffer_head *tbh = arr[i];
 			lock_buffer(tbh);
 			tbh->b_end_io = end_buffer_read_mst_async;
-			set_buffer_async(tbh);
+			set_buffer_async_read(tbh);
 		}
 		/* Finally, start i/o on the buffers. */
 		for (i = 0; i < nr; i++)


-
