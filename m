Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRACVz2>; Wed, 3 Jan 2001 16:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRACVzS>; Wed, 3 Jan 2001 16:55:18 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15699 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130701AbRACVzB>; Wed, 3 Jan 2001 16:55:01 -0500
Date: Wed, 3 Jan 2001 22:55:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Should page->count ever be -1?
Message-ID: <20010103225505.R32185@athlon.random>
In-Reply-To: <20010103210714Z129267-457+17@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010103210714Z129267-457+17@vger.kernel.org>; from ttabi@interactivesi.com on Wed, Jan 03, 2001 at 03:07:03PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 03:07:03PM -0600, Timur Tabi wrote:
> I'm experiencing some kind of memory leaks playing with ioremap and iounmap,
> and I've narrowed down the problem to iounmap refusing to unmap the memory that
> I just mapped.  The line of code in question is
> 
> 	if (!PageReserved(page) && atomic_dec_and_test(&page->count)) {
> 
> from page_alloc.c (this is 2.2.18pre15).  It appears that page->count is
> already zero when this code is executed, and after it's executed, page->count
> becomes -1 (or more accurately, 0xFFFFFFFF).  Is this acceptable, or is it an
> error condition?

It's an error condition. Make sure you marked the page as reserved in the mmap
callback if it's not an mmio region outside RAM.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
