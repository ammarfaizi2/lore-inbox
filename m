Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132608AbQLHVt2>; Fri, 8 Dec 2000 16:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132804AbQLHVtS>; Fri, 8 Dec 2000 16:49:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44561 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132608AbQLHVtC>; Fri, 8 Dec 2000 16:49:02 -0500
Date: Fri, 8 Dec 2000 13:17:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: Alexander Viro <viro@math.psu.edu>, David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <00120821583804.00491@gimli>
Message-ID: <Pine.LNX.4.10.10012081314530.11626-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2000, Daniel Phillips wrote:
>
> [ flush-buffers taking the page lock ]
> 
> This is great when you have buffersize==pagesize.  When there are
> multiple buffers per page it means that some of the buffers might have
> to wait for flushing just because bdflush started IO on some other
> buffer on the same page.  Oh well.  The common case improves in terms
> being proveably correct and the uncommon case gets worse a tiny bit. 
> It sounds like a win.

Also, I think that we should strive for a setup where most of the dirty
buffer flushing is done through "page_launder()" instead of using
sync_buffers all that much at all. 

I'm convinced that the page LRU list is as least as good as, if not better
than, the dirty buffer timestamp stuff. And as we need to have the page
LRU for other reasons anyway, I'd like the long-range plan to be to get
rid of the buffer LRU completely. It wastes memory and increases
complexity for very little gain, I think.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
