Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132600AbRANTVb>; Sun, 14 Jan 2001 14:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135259AbRANTVZ>; Sun, 14 Jan 2001 14:21:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4362 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132600AbRANTVM>; Sun, 14 Jan 2001 14:21:12 -0500
Date: Sun, 14 Jan 2001 11:20:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SetPageDirty in shmem_nopage
In-Reply-To: <m3zoguf115.fsf@linux.local>
Message-ID: <Pine.LNX.4.10.10101141116550.4086-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 14 Jan 2001, Christoph Rohland wrote:
> 
> Since we do not mark the page dirty at allocation time the vm can drop
> it at any time as long as it is not written to. But shmem never
> adjusts its accounting to that and will happily increase the use
> counter for both the inode and the fs.

Why do you increment the use counter at all in nopage?

There's something wrong here. You shouldn't need to calculate any of this.
The VM layer already keeps track of how many pages are associated with a
mapping in "mapping->nr_pages".  Why do you maintain extra counters that
do not give you anything at all?

You should count how many swap cache entries you have allocated for this
inode, and nothing more - the VM keeps track of everything else for you
already. It looks like this code is all historical baggage from when the
shm code didn't use the VM page cache? I'd rather remove it than try to
edit it, no?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
