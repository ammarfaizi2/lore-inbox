Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310398AbSCGQvJ>; Thu, 7 Mar 2002 11:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310401AbSCGQuv>; Thu, 7 Mar 2002 11:50:51 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:47116 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310398AbSCGQun>;
	Thu, 7 Mar 2002 11:50:43 -0500
Date: Thu, 7 Mar 2002 09:50:46 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020307095046.A29364@hq.fsmlabs.com>
In-Reply-To: <E16iyGp-0002IL-00@the-village.bc.nu> <E16iylp-00038V-00@starship.berlin> <20020307073805.C27151@hq.fsmlabs.com> <E16izrK-00038v-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16izrK-00038v-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Mar 07, 2002 at 04:31:10PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 04:31:10PM +0100, Daniel Phillips wrote:
> > > > Why is that a fix? And how can it work?
> > > 
> > > Since there is always at least one freeable page in the system (or we're oom) then
> > > we just have to find it and we know we can forcibly unmap it.  We do need to know
> > > the total of pinned pages, I should have said locked/dirty/pinned.
> > 
> > 
> > What if we are oom?
> 
> This problem didn't get any worse, we still have to deal with it.  We can wait, so
> we deal with it in the standard way (i.e., we puke, have to do something about that.)

So it can return NULL? 

> 
> > What if we are on our way to deadlock?
> 
> huh??

Process A needs 4 pages, Process B needs 4 pages, each grabs 3.
One easy, traditional unix algorithm for dealing with this is
	for(i=0; i < 4; i++)if !(p[i]=kmallloc(...))
                                free all that we have so far


> > What if the caller of kmalloc will make less good use of the page
> > than the current owner of the page?
> 
> That's life, that's what lrus are for.

Really? I thought LRUs were to approximate working sets. Obviously
if a program is kmallocing its working set is changing but that
does not tell us anything about whether it is a correct decision to
rip a page from the working set of another process.

> 
> > page_t *x,*p;
> > for(i = 0; i < SOME_MADE_UP_NUMBER_THAT_SEEMS_GOOD;i++)
> > 	if( p = kmalloc(..)){
> > 		copyfromuser(x++,p);
> >         	dispatch_to_output(p);
> > 	    }
> > 	else {//do the rest later
> >             ...
> >           }
> 
> Please put your thinking cap on and come up with a less borked interface
> for doing that ;-)
> 
> You won't find one if you don't look for it.

I'm too dumb to come up with a solution here, but you are the one
changing the interface, so surely you have a couple of "less borked"
solutions in mind - right?







-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

