Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTJTNa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 09:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTJTNa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 09:30:27 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:13458 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262558AbTJTNaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 09:30:23 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 20 Oct 2003 15:27:53 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, 216547@bugs.debian.org,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] bttv kernel BUG at drivers/media/video/video-buf.c:378!
Message-ID: <20031020132725.GA28103@bytesex.org>
References: <E1ABFJd-0000qT-1o@jophur> <20031020121858.GA31030@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020121858.GA31030@gondor.apana.org.au>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 10:18:58PM +1000, Herbert Xu wrote:
> reassign 216547 kernel
> quit
> 
> Hi Gerd:
> 
> It looks like the your v4l update two weeks broke bttv.  Here is
> a crash dump.  videobuf_iolock was passed a vb that has just been
> filled with zeros.

> [ BUG in video-buf.c triggered -- oops log cutted ]

Fix below, please apply,

  Gerd

--- linux/drvers/media/video/bttv-driver.c.fix	2003-10-20 12:48:38.000000000 +0200
+++ linux/drvers/media/video/bttv-driver.c	2003-10-20 15:07:24.346278761 +0200
@@ -2819,6 +2819,7 @@
 				up(&fh->cap.lock);
 				return POLLERR;
 			}
+			fh->cap.read_buf->memory = V4L2_MEMORY_USERPTR;
 			field = videobuf_next_field(&fh->cap);
 			if (0 != fh->cap.ops->buf_prepare(file,fh->cap.read_buf,field)) {
 				up(&fh->cap.lock);
