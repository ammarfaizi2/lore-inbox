Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284322AbRLTLwr>; Thu, 20 Dec 2001 06:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284461AbRLTLwi>; Thu, 20 Dec 2001 06:52:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:27327 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284322AbRLTLwT>; Thu, 20 Dec 2001 06:52:19 -0500
Date: Thu, 20 Dec 2001 12:28:30 -0500
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: bcrl@redhat.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: aio
Message-ID: <20011220122830.A1748@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20011219.220247.101870714.davem@redhat.com> <Pine.LNX.4.33.0112192206400.19394-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112192206400.19394-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Dec 19, 2001 at 10:09:40PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 10:09:40PM -0800, Linus Torvalds wrote:
> Could we get back on track, and possibly discuss the patches themselves,
> ok? We want _constructive_ criticism of the interfaces.
> 
> I think it's clear that many people do want to have aio support. At least

Yes, to add to the lot, even though you probably don't need any more proof :)
we have at least 3 different products requiring this. Both for scalable 
communications aio (large no. of connections) as well as file/disk aio.  
In fact, one of the things that I've been worried about once 2.5 opened up
and the bio changes started flowing in (much as I was delighted to see
Jens' stuff finally getting integrated), was whether this would mean a 
longer timeframe before we can hope to see aio in a distribution (which is 
the question which I have to respond to our product groups about). 

> as far as I'm concerned, that's not the reason I want to have public
> discussion. I want to make sure that the interfaces are good for aio
> users, and that the design isn't stupid.
> 

My feeling about this is that we shouldn't necessarily need to
have the entire aio code in perfect shape and bring it in all in one shot.
The thing I like about the design is that it is quite possible to split
this up into smaller core patches and bring them in slowly. And I agree
with Ingo that we should be able to start stabilizing the basic internal
mechanisms or foundations on which aio is built before we freeze the 
external interfaces. In fact, these two things could happen parallely.
So I was hoping that an evolutionary approach would work. In the current 
design, the aio path is handled separately from the normal i/o paths, so the 
impact on existing interfaces is less. It mainly affects aio users. So it 
ought to be possible to integrate it in a way that doesn't hurt regular
operations, and it should be easier to change it once it is in without
breaking too many things.

Existing aio users on other platforms that I have come across seem to use 
either POSIX aio (for file /disk aio) or completion port style interfaces 
(mainly for communications aio), both of which seem to be possible with 
Ben's implementation. One has to explicitly associate each i/o with the 
completion queue (ctx), rather than associate an fd as a whole with it so 
that all completion events on that fd come to the ctx. That should be OK. 
Besides with async poll support we can have per-file readiness notification 
as well. I was hoping for the async poll piece being available early to 
exercise the top half or event handling side of aio, so we have scalable 
select/poll support, so was focussing on that part to start with.

Your point about some critical discussion of the interfaces and the design 
is well-taken. We have had a few discussions on the aio mailing and more on 
irc about some aspects, but not quite a thorough out and out analysis of 
pros and cons of the whole design. I just started writing some points here, 
but then realized that it is going to take much longer, so decided to do
that while working with Ben on the documentation, and discuss more after 
that.

Regards
Suparna
