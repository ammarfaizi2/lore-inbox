Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTJTLvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 07:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTJTLvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 07:51:24 -0400
Received: from intra.cyclades.com ([64.186.161.6]:57487 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262538AbTJTLvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 07:51:22 -0400
Date: Mon, 20 Oct 2003 08:54:04 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Shantanu Goel <sgoel01@yahoo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.23-pre7 vmscan.c typo
In-Reply-To: <20031020053229.GC1906@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0310200835210.1346-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Oct 2003, Andrea Arcangeli wrote:

> On Sun, Oct 19, 2003 at 10:00:05PM -0700, Andrew Morton wrote:
> > Shantanu Goel <sgoel01@yahoo.com> wrote:
> > >
> > > The following appears to be a typo in mm/vmscan.c
> > > 
> > 
> > It sure is.  Scary.
> 
> indeed, great spotting.
> 
> > 
> > --- a/mm/vmscan.c	2003-10-19 21:36:26.000000000 -0400
> > +++ a/mm/vmscan.c	2003-10-19 21:37:17.000000000 -0400
> > @@ -596,7 +596,7 @@
> >  			continue;
> >  		}
> >  
> > -		nr_pages--;
> > +		ratio--;
> >  
> >  		del_page_from_active_list(page);
> >  		add_page_to_inactive_list(page);
> > 
> > 
> > 
> > I note that `ratio' here is the number of pages which we try to deactivate
> > rather than the number of pages which we scan.  Is this intentional?
> 
> yes, it's intentional, this ensures we refile a number of pages and that
> we don't only roll the list, it won't loop forever since at the second
> pass the referenced bit will be clear.
> 
> BTW, the above obviously correct patch was apparently due an half merge
> error too, this is what my 2.4.22aa1 or alternatively 2.4.23pre6aa3
> looks like in this area. 

Fixed. Thanks Shantanu. 

It must have been a merge error. :(

> This gets right the highmem case too, so that we ensure to refile normal
> zone if the user is GFP_KERNEL and we don't deactivate highmem unless
> it's worthwhile, and it has the bh-related knwoledge, so over time it'd
> be better to merge these bits too.

Will take a look into this... 


