Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310201AbSCGOi2>; Thu, 7 Mar 2002 09:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310170AbSCGOiI>; Thu, 7 Mar 2002 09:38:08 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:44298 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293515AbSCGOiA>;
	Thu, 7 Mar 2002 09:38:00 -0500
Date: Thu, 7 Mar 2002 07:38:05 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020307073805.C27151@hq.fsmlabs.com>
In-Reply-To: <E16iyGp-0002IL-00@the-village.bc.nu> <E16iy41-00037z-00@starship.berlin> <20020307070442.A26987@hq.fsmlabs.com> <E16iylp-00038V-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16iylp-00038V-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Mar 07, 2002 at 03:21:24PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 03:21:24PM +0100, Daniel Phillips wrote:
> On March 7, 2002 03:04 pm, yodaiken@fsmlabs.com wrote:
> > On Thu, Mar 07, 2002 at 02:36:08PM +0100, Daniel Phillips wrote:
> > > On March 7, 2002 02:49 pm, Alan Cox wrote:
> > > > Jeff Dike Apparently wrote
> > > > > caller.  This is actually wrong because in this failure case, it effectively
> > > > > changes the semantics of GFP_USER, GFP_KERNEL, and the other blocking GFP_* 
> > > > > allocations to GFP_ATOMIC.  And that's what forced UML to segfault the 
> > > > > compilations.
> > > > 
> > > > GFP_KERNEL will sometimes return NULL.
> > > 
> > > Sad but true.  IMHO we are on track to fix that in this kernel cycle, with
> > > better locked/dirty accounting and rmap to forcibly unmap pages when necessary.
> > 
> > Why is that a fix? And how can it work?
> 
> Since there is always at least one freeable page in the system (or we're oom) then
> we just have to find it and we know we can forcibly unmap it.  We do need to know
> the total of pinned pages, I should have said locked/dirty/pinned.


What if we are oom?
What if we are on our way to deadlock?
What if the caller of kmalloc will make less good use of the page
than the current owner of the page?

page_t *x,*p;
for(i = 0; i < SOME_MADE_UP_NUMBER_THAT_SEEMS_GOOD;i++)
	if( p = kmalloc(..)){
		copyfromuser(x++,p);
        	dispatch_to_output(p);
	    }
	else {//do the rest later
            ...
          }




	
> 
> Since GFP_KERNEL includes __GFP_WAIT, we are even allowed to wait for dirty page
> writeout.
> 
> -- 
> Daniel

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

