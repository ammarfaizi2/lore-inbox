Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277089AbRJQTS4>; Wed, 17 Oct 2001 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277071AbRJQTSq>; Wed, 17 Oct 2001 15:18:46 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:14824 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277064AbRJQTS2>; Wed, 17 Oct 2001 15:18:28 -0400
Date: Wed, 17 Oct 2001 15:19:00 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Making diff(1) of linux kernels faster
Message-ID: <20011017151900.E25684@redhat.com>
In-Reply-To: <3BCAB9B1.2F85F523@yahoo.com> <Pine.LNX.4.33.0110170949370.17757-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110170949370.17757-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Oct 17, 2001 at 09:59:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 09:59:35AM -0700, Linus Torvalds wrote:
> And I've for a long time thought about adding a "readahead()" system call.
> There are just too many uses for it, it has come up in many different
> areas..

Well, here's a sendpage for /dev/null which is useful for prefetching.  Now 
we just need a background open().

		-ben

...~/patches/v2.4.13-pre3-null_sendpage.diff
diff -urN v2.4.13-pre3/drivers/char/mem.c foo-v2.4.13-pre3/drivers/char/mem.c
--- v2.4.13-pre3/drivers/char/mem.c	Mon Sep 24 02:16:03 2001
+++ foo-v2.4.13-pre3/drivers/char/mem.c	Wed Oct 17 15:12:59 2001
@@ -339,6 +339,12 @@
 	return count;
 }
 
+static ssize_t sendpage_null(struct file *file, struct page *page, int offset,
+			     size_t size, loff_t *pos, int more)
+{
+	return size;
+}
+
 /*
  * For fun, we are using the MMU for this.
  */
@@ -512,6 +518,7 @@
 	llseek:		null_lseek,
 	read:		read_null,
 	write:		write_null,
+	sendpage:	sendpage_null,
 };
 
 #if !defined(__mc68000__)
