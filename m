Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbQJ3WBx>; Mon, 30 Oct 2000 17:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbQJ3WBn>; Mon, 30 Oct 2000 17:01:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:22987 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129245AbQJ3WBb>;
	Mon, 30 Oct 2000 17:01:31 -0500
Date: Mon, 30 Oct 2000 17:01:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test10-pre7
In-Reply-To: <Pine.GSO.4.21.0010301618160.1177-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0010301652370.1177-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Alexander Viro wrote:

> 
> 
> On Mon, 30 Oct 2000, Linus Torvalds wrote:
> 
> > How about just changing ->sync_page() semantics to own the page lock? That
> > sound slike the right thing anyway, no?
> 
> It would kill the ->sync_page(), but yes, _that_ might be the right thing ;-)

To elaborate: the thing is called if we get a contention on the page lock.
Essentially, its use in NFS is renice -20 for the requests on our page
wrt RPC scheduler. By the time when page gets unlocked it becomes a NOP.
On local filesystems it just runs the tq_disk - nothing in common with
the NFS case and IMO Trond was wrong lumping them together. In effect,
we are getting run_task_queue(&tq_disk) executed _very_ often and I'm less
than sure that it's a good idea. I think that ->sync_page() is not a
well-defined operation and NFS scheduler should use the locking of its own,
both for inavlidate_... and here.
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
