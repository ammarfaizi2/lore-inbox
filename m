Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSIESdg>; Thu, 5 Sep 2002 14:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSIESdf>; Thu, 5 Sep 2002 14:33:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53183 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318067AbSIESde>;
	Thu, 5 Sep 2002 14:33:34 -0400
Date: Thu, 5 Sep 2002 20:38:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Suparna Bhattacharya <suparna@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
Message-ID: <20020905183809.GA23195@suse.de>
References: <20020905183117.GA22592@suse.de> <Pine.LNX.4.33.0209051136090.1307-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209051136090.1307-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19-pre8 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05 2002, Linus Torvalds wrote:
> 
> On Thu, 5 Sep 2002, Jens Axboe wrote:
> > 
> > However, I don't see how this is a two-liner change. Basically you are
> > changing bi_end_io() from a completion to partial completion invokation,
> 
> Right. So we'll add one
> 
> 	bio->bi_end_io(bio, nr_sectors)
> 
> to the partial bio completion case in "finish_that_request_first()".
> 
> That's one line.
> 
> The other line is
> 
> 	if (bio->bi_size) return;
> 
> which has to be added to the end-request thing.
> 
> (yeah, yeah, there are several end-request functions, and we need to fix 
> up the function prototypes too etc, but the point is that the actual 
> _work_ is just two real lines of new code).

Ah ok, then we completely agree on what needs doing :-)

And yes, this is 100% identical to the earlier bio code (I forget what
revisions, and that was prior to BK I think).

Jens

