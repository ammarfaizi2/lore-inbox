Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbQLNHxs>; Thu, 14 Dec 2000 02:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130870AbQLNHxi>; Thu, 14 Dec 2000 02:53:38 -0500
Received: from www.wen-online.de ([212.223.88.39]:42506 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129771AbQLNHxV>;
	Thu, 14 Dec 2000 02:53:21 -0500
Date: Thu, 14 Dec 2000 08:22:47 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11 - the continuing saga
In-Reply-To: <Pine.LNX.4.10.10012131213160.802-100000@penguin.transmeta.com>
Message-ID: <Pine.Linu.4.10.10012140809180.1309-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Linus Torvalds wrote:

> On Wed, 13 Dec 2000, Linus Torvalds wrote:
> > 
> > Hint: "ptep_mkdirty()".

<g> rather obvious oopsie.. once spotted.

> In case you wonder why the bug was so insidious, what this caused was two
> separate problems, both of them able to cause SIGSGV's. 
> 
> One: we didn't mark the page table entry dirty like we were supposed to.
> 
> Two: by making it writable, we also made the page shared, even if it
> wasn't supposed to be shared (so when the next process wrote to the page,
> if the swap page was shared with somebody else, the changes would show up
> even in the process that _didn't_ write to it).
> 
> And "ptep_mkdirty()" is only used by swapoff, so nothing else would show
> this. Which was why it hadn't been immediately obvious that anything was
> broken.

The terminal OOM problem is now gone and I haven't seen a SIGSEGV yet
running virgin source.

	IOU 5 bogo$$

	-Mike

(I still see something with IKD that _could_ be timing related troubles.
There are a couple of grubby fingerprints I need to wipe off, and some
churn/burn hours to be sure)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
