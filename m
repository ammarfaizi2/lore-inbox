Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSCGO1f>; Thu, 7 Mar 2002 09:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292920AbSCGO1Z>; Thu, 7 Mar 2002 09:27:25 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:6836 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292730AbSCGO1H>;
	Thu, 7 Mar 2002 09:27:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: Thu, 7 Mar 2002 15:21:24 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Dike <jdike@karaya.com>,
        Benjamin LaHaise <bcrl@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16iyGp-0002IL-00@the-village.bc.nu> <E16iy41-00037z-00@starship.berlin> <20020307070442.A26987@hq.fsmlabs.com>
In-Reply-To: <20020307070442.A26987@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16iylp-00038V-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 03:04 pm, yodaiken@fsmlabs.com wrote:
> On Thu, Mar 07, 2002 at 02:36:08PM +0100, Daniel Phillips wrote:
> > On March 7, 2002 02:49 pm, Alan Cox wrote:
> > > Jeff Dike Apparently wrote
> > > > caller.  This is actually wrong because in this failure case, it effectively
> > > > changes the semantics of GFP_USER, GFP_KERNEL, and the other blocking GFP_* 
> > > > allocations to GFP_ATOMIC.  And that's what forced UML to segfault the 
> > > > compilations.
> > > 
> > > GFP_KERNEL will sometimes return NULL.
> > 
> > Sad but true.  IMHO we are on track to fix that in this kernel cycle, with
> > better locked/dirty accounting and rmap to forcibly unmap pages when necessary.
> 
> Why is that a fix? And how can it work?

Since there is always at least one freeable page in the system (or we're oom) then
we just have to find it and we know we can forcibly unmap it.  We do need to know
the total of pinned pages, I should have said locked/dirty/pinned.

Since GFP_KERNEL includes __GFP_WAIT, we are even allowed to wait for dirty page
writeout.

-- 
Daniel
