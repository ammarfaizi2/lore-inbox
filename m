Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293728AbSCGPh2>; Thu, 7 Mar 2002 10:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310359AbSCGPhS>; Thu, 7 Mar 2002 10:37:18 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:46516 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293728AbSCGPhE>;
	Thu, 7 Mar 2002 10:37:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: Thu, 7 Mar 2002 16:31:10 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E16iyGp-0002IL-00@the-village.bc.nu> <E16iylp-00038V-00@starship.berlin> <20020307073805.C27151@hq.fsmlabs.com>
In-Reply-To: <20020307073805.C27151@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16izrK-00038v-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 03:38 pm, yodaiken@fsmlabs.com wrote:
> On Thu, Mar 07, 2002 at 03:21:24PM +0100, Daniel Phillips wrote:
> > On March 7, 2002 03:04 pm, yodaiken@fsmlabs.com wrote:
> > > On Thu, Mar 07, 2002 at 02:36:08PM +0100, Daniel Phillips wrote:
> > > > On March 7, 2002 02:49 pm, Alan Cox wrote:
> > > > > Jeff Dike Apparently wrote
> > > > > > caller.  This is actually wrong because in this failure case, it effectively
> > > > > > changes the semantics of GFP_USER, GFP_KERNEL, and the other blocking GFP_* 
> > > > > > allocations to GFP_ATOMIC.  And that's what forced UML to segfault the 
> > > > > > compilations.
> > > > > 
> > > > > GFP_KERNEL will sometimes return NULL.
> > > > 
> > > > Sad but true.  IMHO we are on track to fix that in this kernel cycle, with
> > > > better locked/dirty accounting and rmap to forcibly unmap pages when necessary.
> > > 
> > > Why is that a fix? And how can it work?
> > 
> > Since there is always at least one freeable page in the system (or we're oom) then
> > we just have to find it and we know we can forcibly unmap it.  We do need to know
> > the total of pinned pages, I should have said locked/dirty/pinned.
> 
> 
> What if we are oom?

This problem didn't get any worse, we still have to deal with it.  We can wait, so
we deal with it in the standard way (i.e., we puke, have to do something about that.)

> What if we are on our way to deadlock?

huh??

> What if the caller of kmalloc will make less good use of the page
> than the current owner of the page?

That's life, that's what lrus are for.

> page_t *x,*p;
> for(i = 0; i < SOME_MADE_UP_NUMBER_THAT_SEEMS_GOOD;i++)
> 	if( p = kmalloc(..)){
> 		copyfromuser(x++,p);
>         	dispatch_to_output(p);
> 	    }
> 	else {//do the rest later
>             ...
>           }

Please put your thinking cap on and come up with a less borked interface
for doing that ;-)

You won't find one if you don't look for it.

-- 
Daniel
