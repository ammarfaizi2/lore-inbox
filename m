Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316486AbSEWM3z>; Thu, 23 May 2002 08:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316526AbSEWM2A>; Thu, 23 May 2002 08:28:00 -0400
Received: from imladris.infradead.org ([194.205.184.45]:39690 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316474AbSEWM0k>; Thu, 23 May 2002 08:26:40 -0400
Date: Thu, 23 May 2002 13:26:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include buffer_head.h in actual users instead of fs.h (2/10)
Message-ID: <20020523132638.C24361@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Declare buffer_init() extern in init/main.c like the other _init so that
it doesn't have to include buffer_head.h.  Remove buffer_init() there.


--- 1.9/include/linux/buffer_head.h	Sun May 19 13:49:49 2002
+++ edited/include/linux/buffer_head.h	Thu May 23 14:18:31 2002
@@ -138,7 +143,6 @@
  */
 
 void FASTCALL(mark_buffer_dirty(struct buffer_head *bh));
-void buffer_init(void);
 void init_buffer(struct buffer_head *, bh_end_io_t *, void *);
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset);
--- 1.45/init/main.c	Tue Apr 30 00:18:31 2002
+++ edited/init/main.c	Thu May 23 13:19:04 2002
@@ -68,6 +68,7 @@
 extern void sbus_init(void);
 extern void sysctl_init(void);
 extern void signals_init(void);
+extern void buffer_init(void);
 
 extern void radix_tree_init(void);
 extern void free_initmem(void);
