Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318538AbSIMNjm>; Fri, 13 Sep 2002 09:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319196AbSIMNjm>; Fri, 13 Sep 2002 09:39:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43983 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318538AbSIMNjl>;
	Fri, 13 Sep 2002 09:39:41 -0400
Date: Fri, 13 Sep 2002 15:44:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Linux Aio <linux-aio@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 port of aio-20020619 for raw devices
Message-ID: <20020913134404.GG935@suse.de>
References: <3D80DB14.2040809@watson.ibm.com> <20020912143540.J18217@redhat.com> <20020913184652.C2758@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913184652.C2758@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13 2002, Suparna Bhattacharya wrote:
> On Thu, Sep 12, 2002 at 02:35:40PM -0400, Benjamin LaHaise wrote:
> > On Thu, Sep 12, 2002 at 02:21:08PM -0400, Shailabh Nagar wrote:
> > > I just did a rough port of the raw device part of the aio-20020619.diff
> > > over to 2.5.32 using the 2.5 aio API published so far. The changeset
> > > comments are below. The patch hasn't been tested. Its only guaranteed
> > > to compile.
> > > 
> > > I'd like to reiterate that this is not a fork of aio kernel code
> > > development or any attempt to question Ben's role as maintainer ! This
> > > was only an exercise in porting to enable a comparison of the older
> > > (2.4) approach with whatever's coming soon.
> > > 
> > > Comments are invited on all aspects of the design and implementation.
> > 
> > The generic aio <-> kvec functions were found to not work well, and 
> > the chunking code needs to actually pipeline data for decent io thruput.  
> > Short story: the raw device code must be rewritten using the dio code 
> > that akpm introduced.
> 
> How async (degree on non-blocking nature of steps in the async state 
> machine) do we want to be when we use the dio pipelining code ?
> (besides making the wait for dio completion bit async, of course)
> 
> Some key places where we can potentially block are when mapping 
> the user pages, as part of get_blocks, when alloc'ing a bio,
> when issuing submit_bio  (i.e. waiting for the request pipeline
> to drain out or free up slots). I guess, at least the last one
> would be addressed ... not sure what the plans for the rest
> are.

alloc_bio non-blocking can be done by caller himself, submit_bio
non-blocking can be assured with BIO_RW_AHEAD.

-- 
Jens Axboe

