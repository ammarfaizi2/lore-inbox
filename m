Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSIES0w>; Thu, 5 Sep 2002 14:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318028AbSIES0w>; Thu, 5 Sep 2002 14:26:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15807 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318016AbSIES0u>;
	Thu, 5 Sep 2002 14:26:50 -0400
Date: Thu, 5 Sep 2002 20:31:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Suparna Bhattacharya <suparna@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
Message-ID: <20020905183117.GA22592@suse.de>
References: <3D779BAA.BAA5A742@zip.com.au> <Pine.LNX.4.33.0209051120100.1307-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209051120100.1307-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19-pre8 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05 2002, Linus Torvalds wrote:
> > OK.  But still, I don't see why we need partial BIO completions.  If
> > we say that the basic unit of completion is a whole BIO, then readahead
> > can then manage latency via the outgoing bio size.
> 
> But that's horrible. The floppy driver can take huge bio's no problem, and 
> limiting bio sizes to track sizes would be a huge pain in the driver for 
> no good reason. In fact, it would be pretty much impossible, since the 
> tracks aren't even page-aligned.
> 
> So limiting bio's fundamentally _cannot_ do the right thing. While adding
> two lines of code _can_.

I agree that partial completions are the right thing to do here, and in
fact this is how the interface was originally remember?

However, I don't see how this is a two-liner change. Basically you are
changing bi_end_io() from a completion to partial completion invokation,
which requires changing (and complicating) all of them. Just adding
a sector count to bio_endio() does not enable that to partially complete
some pages. What am I missing?

Jens

