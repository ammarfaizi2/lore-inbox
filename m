Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273163AbRIJCdY>; Sun, 9 Sep 2001 22:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273165AbRIJCdN>; Sun, 9 Sep 2001 22:33:13 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:12293 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273163AbRIJCc5>; Sun, 9 Sep 2001 22:32:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: linux-2.4.10-pre5
Date: Mon, 10 Sep 2001 04:40:21 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org> <20010910021513Z16066-26183+696@humbolt.nl.linux.org> <1324600000.1000088434@tiny>
In-Reply-To: <1324600000.1000088434@tiny>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910023312Z16066-26183+700@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 10, 2001 04:20 am, Chris Mason wrote:
> On Monday, September 10, 2001 04:22:25 AM +0200 Daniel Phillips
> <phillips@bonn-fries.net> wrote:
> 
> > On September 10, 2001 04:15 am, Daniel Phillips wrote:
> >> On September 10, 2001 03:55 am, Andrea Arcangeli wrote:
> >> > getblk should unconditionally alloc a new bh entity and only care to
> >> > map it to the right cache backing store with a pagecache hash lookup.
> >> 
> >> To feel anything like the original the new getblk has to be idempotent: 
> >> subsequent calls return the same block.
> > 
> > Err, buffer_head
> 
> How about subsequent calls for the same offset with the same blocksize need
> to return the same buffer head?

Are we picking nits?  Better add "the same dev" and "until the buffer head is 
freed" ;-)

<Attempting to add some content> I've always felt that passing the blocksize 
and hashing on it is just a little bizarre.  This means for example that you 
can have two 2K buffers overlaid on a 4K buffer, and they will be entirely 
non-coherent. If we substitute "mapping" where "dev" goes we wouldn't need 
the size any more.  We could still take it and just BUG if it doesn't match 
the mapping.

Bearing in mind Linus's comments about the liklihood that we might see mixed 
block sizes in a single mapping something in the future.

--
Daniel
