Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTE2KP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTE2KP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:15:59 -0400
Received: from smtpout.mac.com ([17.250.248.87]:18148 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262100AbTE2KP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:15:57 -0400
Date: Thu, 29 May 2003 20:29:40 +1000
Subject: buffer_head.b_bsize type
Content-Type: multipart/mixed; boundary=Apple-Mail-22-735052680
Mime-Version: 1.0 (Apple Message framework v552)
Cc: trivial@rustcorp.com.au
To: linux-kernel@vger.kernel.org
From: Stewart Smith <stewartsmith@mac.com>
Message-Id: <746529B0-91C0-11D7-9488-00039346F142@mac.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-22-735052680
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

The buffer_head structure (include/linux/buffer_head.h) uses a u32 type 
while everywhere else (e.g. bread) the size parameter is of type int.

Currently on all architectures u32 is defined as unsigned int. We 
should probably not be doing unsigned and signed swaps. And you should 
never really have a negative size of a buffer.

So, there are two solutions: either change the buffer_head struct to be 
int so it matches everywhere else, or change everywhere else.

The attached patch does the change in one place. Although perhaps 
changing everywhere else would be better. Thoughts? I'm happy to make 
up the patch if needed.


Applies cleanly to 2.5.69 and 2.5.70 and has been tested on i386 
without causing any further problems (that I can see at least).

diff -ur linux-2.5.69-orig/include/linux/buffer_head.h 
linux-2.5.69/include/linux/buffer_head.h
--- linux-2.5.69-orig/include/linux/buffer_head.h	Mon May  5 09:52:49 
2003
+++ linux-2.5.69/include/linux/buffer_head.h	Fri May 16 12:05:16 2003
@@ -51,7 +51,7 @@
  	struct page *b_page;		/* the page this bh is mapped to */

  	sector_t b_blocknr;		/* block number */
-	u32 b_size;			/* block size */
+	int b_size;			/* block size */
  	char *b_data;			/* pointer to data block */

  	struct block_device *b_bdev;



--Apple-Mail-22-735052680
Content-Disposition: attachment;
	filename=patch-buffer_head-u32toint.diff
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="patch-buffer_head-u32toint.diff"

diff -ur linux-2.5.69-orig/include/linux/buffer_head.h linux-2.5.69/include/linux/buffer_head.h
--- linux-2.5.69-orig/include/linux/buffer_head.h	Mon May  5 09:52:49 2003
+++ linux-2.5.69/include/linux/buffer_head.h	Fri May 16 12:05:16 2003
@@ -51,7 +51,7 @@
 	struct page *b_page;		/* the page this bh is mapped to */
 
 	sector_t b_blocknr;		/* block number */
-	u32 b_size;			/* block size */
+	int b_size;			/* block size */
 	char *b_data;			/* pointer to data block */
 
 	struct block_device *b_bdev;


--Apple-Mail-22-735052680
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


------------------------------
Stewart Smith
stewartsmith@mac.com
Ph: +61 4 3884 4332
ICQ: 6734154
http://www.flamingspork.com/       http://www.linux.org.au
--Apple-Mail-22-735052680--

