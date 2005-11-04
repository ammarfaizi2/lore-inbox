Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbVKDCf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbVKDCf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 21:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbVKDCf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 21:35:28 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:12211 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1161112AbVKDCf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 21:35:27 -0500
Date: Fri, 4 Nov 2005 02:35:09 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <436AC07D.2070602@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0511040214460.9172@skynet>
References: <4366C559.5090504@yahoo.com.au>
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>
 <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]>
 <1131032422.2839.8.camel@laptopd505.fenrus.org>  <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
 <Pine.LNX.4.58.0511031613560.3571@skynet>  <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
 <309420000.1131036740@[10.10.2.4]>  <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
 <311050000.1131040276@[10.10.2.4]> <1131040786.2839.18.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org> <312300000.1131041824@[10.1!
 0.2.4]> <436AB241.2030403@yahoo.com.au> <Pine.LNX.4.64.0511031704590.27915@g5.osdl.org>
 <436AB7CA.6060603@yahoo.com.au> <Pine.LNX.4.58.0511040134460.9172@skynet>
 <436AC07D.2070602@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2005, Nick Piggin wrote:

> Mel Gorman wrote:
> > On Fri, 4 Nov 2005, Nick Piggin wrote:
> >
> > Todays massive machines are tomorrows desktop. Weak comment, I know, but
> > it's happened before.
> >
>
> Oh I wouldn't bet against it. And if desktops of the future are using
> 100s of GB then they probably would be happy to use 64K pages as well.
>

And would it not be nice to be ready when it happens, before it happens
even?

> >
> > > Maybe the solution is to bloat the kernel sources enough to make
> > > 64KB pages worthwhile?
> > >
> >
>
> Sorry this wasn't meant to be a dig at your patches - I guess it turned
> out that way though :\
>

Oh, I'll live. If I was going to take it personally and go into a big
sulk, I wouldn't be here.  This is linux-kernel, not the super-friends
club.

> But yes, if anybody is adding complexity or size to core code it
> obviously does need to be justified -- and by no means does this only
> apply to you.
>

I've tried to justify it with benchmarks that came with each release and
code reviews, particularly by Dave Hansen, showed that earlier versions
had significant problems that needed to be ironed out. I don't want to
hurt the normal case, because the fact of the matter is, my desktop
machine (which runs with these patches to see if there are any bugs)
runs the normal case and it will until we get much further because I'm not
configuring my machine for HugeTLB when it boots. If I'm hurting the
normal case, that's more time switching windows to see if the next test
kernel has built yet.

If we can do this and not regress in the standard case, then what is
wrong? I'm still waiting for figures that say this approach is slow and I
can only assume someone is trying considering the length of this thread.
If and when those figures show up, I'll put on the thinking hat and see
where I went wrong because regression performance is wrong. There is a
win-win solution somewhere, how hard could it possibly be :) ?

I'm looking at the zone approach. I want to see if it can work in a nice
fashion, not in a "if the sysadm can see the future and configure
correctly, it'll work just fine" fashion. I'm not confident, but it might
be bias.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
