Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135914AbRDZVBo>; Thu, 26 Apr 2001 17:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135917AbRDZVAt>; Thu, 26 Apr 2001 17:00:49 -0400
Received: from zeus.kernel.org ([209.10.41.242]:128 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135926AbRDZU7x>;
	Thu, 26 Apr 2001 16:59:53 -0400
Date: Thu, 26 Apr 2001 22:14:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010426221445.F819@athlon.random>
In-Reply-To: <20010426214444.B819@athlon.random> <Pine.GSO.4.21.0104261554050.15385-100000@weyl.math.psu.edu> <20010426221109.E819@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010426221109.E819@athlon.random>; from andrea@suse.de on Thu, Apr 26, 2001 at 10:11:09PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 10:11:09PM +0200, Andrea Arcangeli wrote:
> On Thu, Apr 26, 2001 at 03:55:19PM -0400, Alexander Viro wrote:
> > 
> > 
> > On Thu, 26 Apr 2001, Andrea Arcangeli wrote:
> > 
> > > On Thu, Apr 26, 2001 at 03:34:00PM -0400, Alexander Viro wrote:
> > > > Same scenario, but with read-in-progress started before we do getblk(). BTW,
> > > 
> > > how can the read in progress see a branch that we didn't spliced yet? We
> > 
> > fd = open("/dev/hda1", O_RDONLY);
> > read(fd, buf, sizeof(buf));
> 
> You misunderstood the context of what I said, I perfectly know the race
> you are talking about, I was answering Linus's question "the
> wait_on_buffer isn't even necessary to protect ext2 against ext2". You
> are talking about the other race that is "ext2" against "block_dev", and
> I obviously agree on that one since the first place as I immediatly
> answered you "correct".
> 
> What I'm saying above is that even without the wait_on_buffer ext2 can
								     ^^^ "cannot" of course
> screwup itself because the splice happens after the buffer are just all
> uptodate so any "reader" (I mean any reader through ext2 not through
> block_dev) will never try to do a bread on that blocks before they're
> just zeroed and uptodate.
> 
> Andrea


Andrea
