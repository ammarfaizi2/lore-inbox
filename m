Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129353AbQJ3XGW>; Mon, 30 Oct 2000 18:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbQJ3XGM>; Mon, 30 Oct 2000 18:06:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:519 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129353AbQJ3XGD>; Mon, 30 Oct 2000 18:06:03 -0500
Date: Mon, 30 Oct 2000 15:05:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test10-pre7
In-Reply-To: <Pine.GSO.4.21.0010301652370.1177-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10010301459250.1085-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Alexander Viro wrote:
>
> [ sync_page brokenness ]
> 
> To elaborate: the thing is called if we get a contention on the page lock.

Ok, sync_page() looks like a broken design, but I suspect that for
expediency the simplest fix is to just make the NFS sync_page() (re-)check
for "mapping == NULL", and let it be at that. Avoid the NULL pointer
dereference (very small window already).

We should probably in the long run make "page->buffers" be a more generic
thing, and let NFS use it as a wb-info thing, and be done with it. That's
obviously not 2.4.x material, though.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
