Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293530AbSCKWOc>; Mon, 11 Mar 2002 17:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293515AbSCKWON>; Mon, 11 Mar 2002 17:14:13 -0500
Received: from air-2.osdl.org ([65.201.151.6]:18310 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S293503AbSCKWOD>;
	Mon, 11 Mar 2002 17:14:03 -0500
Date: Mon, 11 Mar 2002 14:13:56 -0800
From: Bob Miller <rem@osdl.org>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre3 Fix small race in BSD accounting [part 2]
Message-ID: <20020311141356.A6074@doc.pdx.osdl.net>
In-Reply-To: <20020311120744.B5995@doc.pdx.osdl.net> <1015878604.853.66.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1015878604.853.66.camel@phantasy>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 03:30:03PM -0500, Robert Love wrote:
> On Mon, 2002-03-11 at 15:07, Bob Miller wrote:
> 
> > While looking at the bug fix for part 1 I coded up this patch
> > to change the BSD accounting code to use a spinlock instead
> > of the BKL.
> 
> Oh, Good Job - BKL is evil.  And I think that is partly evident in the
> resulting code, and I have a couple comments about it.
> 
> I suspect the recursive nature of the BKL (and perhaps the locking rules
> such that you don't always hold alock, i.e. if name is not NULL) are
> responsible for:
> 
> 	if (!locked)
> 		spin_lock(&acct_lock);
> 
> which really isn't the prettiest or safest thing, although I don't
> actually see any problems with it here.  With the BKL removed, it may be
> better to rewrite the code in a cleaner and saner way.
> 
> I'd much rather see sane locking rules where we knew the callers and
> each function entry clearly either held or does not hold the spin_lock. 
> Make sure we don't call anything holding the lock, et cetera ...
> 
> Also, I like the struct but the defines are a bit ugly.  Why not just
> s/acct_lock/acct_globals.lock/, for example, in the code?  Or Just call
> the instance of the struct "acct" and have acct.lock, etc.
> 
> In other words, good job, but this is a development kernel - rip some of
> this cruft up and make it perfect, no?
> 
> 	Robert Love

Robert,

Thanks for the comments.  I was going for the minimal diff approach, but I
think the code would be better with a little re-arranging.  I'll make a
cut at it and re-submit.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
