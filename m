Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130407AbQKGIqz>; Tue, 7 Nov 2000 03:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130414AbQKGIqw>; Tue, 7 Nov 2000 03:46:52 -0500
Received: from mail.zmailer.org ([194.252.70.162]:39685 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S130407AbQKGIqk>;
	Tue, 7 Nov 2000 03:46:40 -0500
Date: Tue, 7 Nov 2000 10:46:34 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Lyle Coder <x_coder@hotmail.com>
Cc: David Schwartz <davids@webmaster.com>, RAJESH BALAN <atmproj@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: malloc(1/0) ??
Message-ID: <20001107104634.G13151@mea-ext.zmailer.org>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKEEAJLMAA.davids@webmaster.com> <OE28zGnClQwSaY2lsLR00001672@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OE28zGnClQwSaY2lsLR00001672@hotmail.com>; from x_coder@hotmail.com on Tue, Nov 07, 2000 at 12:09:09AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 12:09:09AM -0800, Lyle Coder wrote:
> When a program does a malloc... the glibc gets atleast on page (brk)
> [actually, glibs determins of it needs to brk more memory from the kernel...
> because it maintains it;s own pool].. so if you malloc 4 byts, you can copy
> to that pointer more than 4 bytes (upto a page size, ex 4K)... hope that
> answers one of your questions... as far as why malloc(0) works... I dunno

Maybe following extract from  glibc's malloc/malloc.c  beginning
comments can help you there:


  Minimum overhead per allocated chunk: 4 or 8 bytes
       Each malloced chunk has a hidden overhead of 4 bytes holding size
       and status information.

  Minimum allocated size: 4-byte ptrs:  16 bytes    (including 4 overhead)
                          8-byte ptrs:  24/32 bytes (including, 4/8 overhead)

       When a chunk is freed, 12 (for 4byte ptrs) or 20 (for 8 byte
       ptrs but 4 byte size) or 24 (for 8/8) additional bytes are
       needed; 4 (8) for a trailing size field
       and 8 (16) bytes for free list pointers. Thus, the minimum
       allocatable size is 16/24/32 bytes.

       Even a request for zero bytes (i.e., malloc(0)) returns a
       pointer to something of the minimum allocatable size.

  Maximum allocated size: 4-byte size_t: 2^31 -  8 bytes
                          8-byte size_t: 2^63 - 16 bytes



Other systems (malloc libraries) may have different strategies on this
allocation management issue, thus allocating anything smaller than the
needed size is bound to get user burned.   malloc(0)  is insane thing
(IMO), but at least glibc supports it for some reason.  Likely just due
to padding and minimum size issues.

> Best Wishes,
> Lyle
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
