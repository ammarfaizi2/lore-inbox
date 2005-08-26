Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbVHZQnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVHZQnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbVHZQnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:43:22 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:49159 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965105AbVHZQnV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:43:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fx1731Yktee+iFEF2XjsoJbdV1a+2QKnKpH3hVcWKaWuW3jTfow9v9kivMbez82GP0H632OxSNnGoMwrl03MxMJivRu2zjjkno/zg7EXOJpZ8jGXejA8gp+KQaim8H9WH4jdknfSx9UKGlbFeqXikbbQdC/14iARW5eVELMovdQ=
Message-ID: <8783be6605082609432c6735a8@mail.gmail.com>
Date: Fri, 26 Aug 2005 09:43:20 -0700
From: Ross Biro <ross.biro@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: process creation time increases linearly with shmem
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Rik van Riel <riel@redhat.com>, Ray Fucillo <fucillo@intersystems.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0508261735360.7589@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
	 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
	 <430E6FD4.9060102@yahoo.com.au>
	 <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
	 <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
	 <8783be660508260915524e2b1e@mail.gmail.com>
	 <Pine.LNX.4.61.0508261735360.7589@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/05, Hugh Dickins <hugh@veritas.com> wrote:
> On Fri, 26 Aug 2005, Ross Biro wrote:
> > On 8/26/05, Hugh Dickins <hugh@veritas.com> wrote:
> > >
> > > The refaulting will hurt the performance of something: let's
> > > just hope that something doesn't turn out to be a show-stopper.
> >
> > Why not just fault in all the pages on the first fault. Then the performance
> > loss is a single page fault (the page table copy that would have happened a
> > fork time now happens at fault time) and you get the big win for processes
> > that do fork/exec.
> 
> "all" might be very many more pages than were ever mapped in the parent,
> and not be a win.  Some faultahead might work better.  Might, might, ...

If you reduce "all" to whatever would have been done in fork
originially, then you've got a big win in some cases and a minimal
loss in others, and it's easy to argue you've got something better.

Now changng "all" to something even less might be an even bigger win,
but that requires a lot of benchmarking to justify.

    Ross
