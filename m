Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313754AbSDPQOh>; Tue, 16 Apr 2002 12:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313747AbSDPQNt>; Tue, 16 Apr 2002 12:13:49 -0400
Received: from tstac.esa.lanl.gov ([128.165.46.3]:18367 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S313751AbSDPQMQ>; Tue, 16 Apr 2002 12:12:16 -0400
Subject: Re: readahead
From: Steven Cole <elenstev@mesatop.com>
To: Andries.Brouwer@cwi.nl
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>
In-Reply-To: <UTC200204161354.g3GDsFO28323.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 16 Apr 2002 10:08:23 -0600
Message-Id: <1018973304.2304.10.camel@spc.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-16 at 07:54, Andries.Brouwer@cwi.nl wrote:
> [readahead.c has badly readable comments, on a standard
> 80-column display: many lines have a size just slightly
> over 80 chars]

[other stuff snipped]

How is this?  Now the longest comment line should end at column 80.
Patch is made against 2.5.8-dj1.

Steven

--- linux-2.5.8-dj1/mm/readahead.c.orig	Tue Apr 16 09:25:36 2002
+++ linux-2.5.8-dj1/mm/readahead.c	Tue Apr 16 09:54:31 2002
@@ -63,9 +63,10 @@
  *              Together, start and size represent the `readahead window'.
  * next_size:   The number of pages to read when we get the next readahead miss.
  * prev_page:   The page which the readahead algorithm most-recently inspected.
- *              prev_page is mainly an optimisation: if page_cache_readahead sees
- *              that it is again being called for a page which it just looked at,
- *              it can return immediately without making any state changes.
+ *              prev_page is mainly an optimisation: if page_cache_readahead
+ *              sees that it is again being called for a page which it just
+ *              looked at, it can return immediately without making any state
+ *              changes.
  * ahead_start,
  * ahead_size:  Together, these form the "ahead window".
  *
@@ -95,30 +96,31 @@
  * If readahead hits are more sparse (say, the application is only reading every
  * second page) then the window will build more slowly.
  *
- * On a readahead miss (the application seeked away) the readahead window is shrunk
- * by 25%.  We don't want to drop it too aggressively, because it's a good assumption
- * that an application which has built a good readahead window will continue to
- * perform linear reads.  Either at the new file position, or at the old one after
- * another seek.
- *
- * There is a special-case: if the first page which the application tries to read
- * happens to be the first page of the file, it is assumed that a linear read is
- * about to happen and the window is immediately set to half of the device maximum.
+ * On a readahead miss (the application seeked away) the readahead window is
+ * shrunk by 25%.  We don't want to drop it too aggressively, because it's a
+ * good assumption that an application which has built a good readahead window
+ * will continue to perform linear reads.  Either at the new file position,
+ * or at the old one after another seek.
+ *
+ * There is a special-case: if the first page which the application tries to
+ * read happens to be the first page of the file, it is assumed that a linear
+ * read is about to happen and the window is immediately set to half of the
+ * device maximum.
  * 
  * A page request at (start + size) is not a miss at all - it's just a part of
  * sequential file reading.
  *
  * This function is to be called for every page which is read, rather than when
- * it is time to perform readahead.  This is so the readahead algorithm can centrally
- * work out the access patterns.  This could be costly with many tiny read()s, so
- * we specifically optimise for that case with prev_page.
+ * it is time to perform readahead.  This is so the readahead algorithm can
+ * centrally work out the access patterns.  This could be costly with many tiny
+ * read()s, so we specifically optimise for that case with prev_page.
  */
 
 /*
  * do_page_cache_readahead actually reads a chunk of disk.  It allocates all the
- * pages first, then submits them all for I/O. This avoids the very bad behaviour
- * which would occur if page allocations are causing VM writeback.  We really don't
- * want to intermingle reads and writes like that.
+ * pages first, then submits them all for I/O. This avoids the very bad
+ * behaviour which would occur if page allocations are causing VM writeback.
+ * We really don't want to intermingle reads and writes like that.
  */
 void do_page_cache_readahead(struct file *file,
 			unsigned long offset, unsigned long nr_to_read)
@@ -231,7 +233,8 @@
 		ra->next_size += 2;
 	} else {
 		/*
-		 * A miss - lseek, pread, etc.  Shrink the readahead window by 25%.
+		 * A miss - lseek, pread, etc.
+		 * Shrink the readahead window by 25%.
 		 */
 		ra->next_size -= ra->next_size / 4;
 		if (ra->next_size < min)


