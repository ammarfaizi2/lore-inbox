Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136730AbRAHFko>; Mon, 8 Jan 2001 00:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136984AbRAHFke>; Mon, 8 Jan 2001 00:40:34 -0500
Received: from cc493382-b.whmh1.md.home.com ([24.3.58.253]:3110 "EHLO
	legion.wienholt.net") by vger.kernel.org with ESMTP
	id <S136730AbRAHFkU>; Mon, 8 Jan 2001 00:40:20 -0500
From: "Robert Wienholt, Jr." <rwienholt@legiontech.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mmap.c find_vma(), kernel 2.4.0
In-Reply-To: <Pine.GSO.4.21.0101080024260.2221-100000@weyl.math.psu.edu>
Message-ID: <Pine.SGI.4.30.0101080026400.1511-100000@legion.wienholt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Date: Mon, 8 Jan 2001 00:29:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
> On Mon, 8 Jan 2001, Robert Wienholt, Jr. wrote:
>
> > Gentlemen,
> >
> > 	I was looking through some of the memory management code today and
> > came across something that may provide a minor performance boost.  I have
> > included a patch below for the 2.4.0 source.
> >
> > 	In the find_vma function a cached vma is checked and if that is
> > not the requested vma, the linked list (unless there's an avl tree) is
> > traversed from the beginning.  My thought was that if the cached vma is
> > somewhere in the middle of a "long" list, and the memory address we are
> 				^^^^^^^^^^
> No such thing. If you get many VMAs you get AVL tree and that's what is
> used for search.
>

Well, that's why I put the "long" in quotes.  If the cached vma is the
10th in the list and we're looking for the 12th... we'll go through the
traversal loop twice instead of 12 times.  That's the point I was trying
to make.  But if we're looking for the 3rd... we'll just start at the
beginning and no harm was done.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
