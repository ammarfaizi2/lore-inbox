Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWAJSpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWAJSpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWAJSpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:45:22 -0500
Received: from mail.gmx.net ([213.165.64.21]:8626 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751147AbWAJSpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:45:20 -0500
X-Authenticated: #1490710
Date: Tue, 10 Jan 2006 19:45:11 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Martin Langhoff <martin.langhoff@gmail.com>,
       Luben Tuikov <ltuikov@yahoo.com>, "Brown, Len" <len.brown@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Git Mailing List <git@vger.kernel.org>
Subject: Re: git pull on Linux/ACPI release tree
In-Reply-To: <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org>
Message-ID: <Pine.LNX.4.63.0601101938420.26999@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
 <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
 <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com> <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 10 Jan 2006, Linus Torvalds wrote:

> 
> On Tue, 10 Jan 2006, Kyle Moffett wrote:
> >
> > On Jan 10, 2006, at 01:38, Martin Langhoff wrote:
> > > 
> > > The more complex your tree structure is, the more the interactions are
> > > likely to be part of the problem. Is git-bisect not useful in this scenario?
> > 
> > IIRC git-bisect just does an outright linearization of the whole tree anyways,
> > which makes git-bisect work everywhere, even in the presence of difficult
> > cross-merges.
> 
> It's not really a linearization - at no time does git-bisect _order_ the 
> commits. After all, no linear order actually exists. 
> 
> Instead, it really cuts the tree up into successively smaller parts. 
> 
> Think of it as doing a binary search in a 2-dimensional surface - you 
> can't linearize the plane, but you can decide to test first one half of 
> the surface, and then depending on whether it was there, you can halve 
> that surface etc.. 

How?

If you bisect, you test a commit. If the commit is bad, you assume *all* 
commits before that as bad. If it is good, you assume *all* commits after 
that as good.

Now, if you have a 2-dimensional surface, you don't have a *point*, but 
typically a *line* separating good from bad.

Further, the comparison with 2 dimensions is particularly bad. You 
*have* partially linear development lines, it got *nothing* to do with 
an area. The commits still make up a *list*, and it depends how you 
*order* that list for bisect. (And don't tell me they are not ordered: 
they are.)

If you order the commits by date, you don't get anything meaningful point 
before which it is bad, and after which it is good.

So, how is bisect supposed to work if you don't have one straight 
development line from bad to good?

Ciao,
Dscho


