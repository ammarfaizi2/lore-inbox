Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbSJLSLP>; Sat, 12 Oct 2002 14:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261324AbSJLSLP>; Sat, 12 Oct 2002 14:11:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6162 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261323AbSJLSLO>; Sat, 12 Oct 2002 14:11:14 -0400
Date: Sat, 12 Oct 2002 11:19:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange patch to the Z85230 driver.
In-Reply-To: <1034445749.15067.6.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0210121114570.12536-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Oct 2002, Alan Cox wrote:
>
> These are DMA ring buffers for ISA DMA, they do not need to be zeroed. 

Note that the code is the same as it alwasy was - the patch is part of a 
rename: "get_free_page()" is gone and is now called "get_zeroed_page()" 
so that people see what it does.

"get_free_page()" has always zeroed the contents, with "__get_free_page()" 
being the old traditional (and now long non-zeroing variety.

So the patch is purely cosmetic, and if the code was strange before, it's 
strange now.

And it's perhaps more _clearly_ strange, which was really the whole point
of the patch.

See the part of the changeset that touches <linux/gfp.h>:

	--- a/include/linux/gfp.h       Sat Oct 12 11:16:59 2002
	+++ b/include/linux/gfp.h       Sat Oct 12 11:16:59 2002
	@@ -71,11 +71,6 @@
	                __get_free_pages((gfp_mask) | GFP_DMA,(order))
	 
	 /*
	- * The old interface name will be removed in 2.5:
	- */
	-#define get_free_page get_zeroed_page
	-
	-/*
	  * There is only one 'core' page-freeing function.
	  */
	 extern void FASTCALL(__free_pages(struct page *page, unsigned int order));

to see that even the comment said this should be done.

		Linus

