Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318717AbSIKLMp>; Wed, 11 Sep 2002 07:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318718AbSIKLMp>; Wed, 11 Sep 2002 07:12:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43930 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318717AbSIKLMn>;
	Wed, 11 Sep 2002 07:12:43 -0400
Date: Wed, 11 Sep 2002 13:17:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911111726.GJ1089@suse.de>
References: <20020911112808.A6341@namesys.com> <Pine.LNX.4.44.0209110937190.5764-100000@localhost.localdomain> <20020911120551.A937@namesys.com> <20020911102507.GA1364@suse.de> <20020911102926.GB1364@suse.de> <20020911144740.A911@namesys.com> <20020911105807.GF1089@suse.de> <20020911151602.A830@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911151602.A830@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Oleg Drokin wrote:
> Hello!
> 
> On Wed, Sep 11, 2002 at 12:58:07PM +0200, Jens Axboe wrote:
> 
> > > > > ok I see the bug. it's due to the imbalanced nature of ide_map_buffer()
> > > > > vs ide_unmap_buffer(). i'll cook up a fix right away.
> > > > Does this make it work?
> > > No. It fails exactly like without the patch.
> > Hmm, ok I'll try and reproduce it here then.
> 
> > > > -	bio_kunmap_irq(buffer, flags);
> > > > +	if (rq->bio)
> > > > +		bio_kunmap_irq(buffer, flags);
> > > >  }
> > > >  
> > > Perhaps you forgot to make sure rq->bio is zeroed on unmapping/freeing?
> > rq->bio must not be zeroed or free'd or anything like that. ok I see
> 
> Hm? So this branch is always executed? Why to check for it then?
> (I mean content of rq->bio, not the place where it points to).

ehm no it isn't always executed?! there might not be a ->bio attached to
the request. that goes for both ide_map_buffer() and ide_unmap_buffer()

> > what happens now. does this patch work for you? just back out the other
> > patch first (well you don't have to, but might as well).
> 
> Ok, with other patch it still fails in the same way.
> I have not backed out other patch so I tested with both patches perent.

alright, seems I do have to try it myself... ok will do that.

-- 
Jens Axboe

