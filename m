Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUJNVnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUJNVnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbUJNVm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:42:29 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:62010 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267164AbUJNVji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:39:38 -0400
Message-ID: <69304d1104101414395cd36206@mail.gmail.com>
Date: Thu, 14 Oct 2004 23:39:38 +0200
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: Antonio Vargas <windenntw@gmail.com>
To: Kevin Puetz <puetzk@puetzk.org>, linux-kernel@vger.kernel.org
Subject: Re: single linked list header in kernel?
In-Reply-To: <ckkum3$i0b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <416C1F48.4040407@nortelnetworks.com>
	 <pan.2004.10.13.05.50.46.937470@smurf.noris.de>
	 <416D4255.9080501@nortelnetworks.com>
	 <pan.2004.10.13.18.25.41.367757@smurf.noris.de>
	 <20041014001619.GA19436@thundrix.ch> <ckkum3$i0b$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 23:18:10 -0500, Kevin Puetz <puetzk@puetzk.org> wrote:
> 
> 
> Tonnerre wrote:
> 
> > Salut,
> >
> > On Wed, Oct 13, 2004 at 08:25:43PM +0200, Matthias Urlichs wrote:
> >> I dunno, though -- open-coding a singly-linked list isn't that much of a
> >> problem; compared to a doubly-linked one, there's simply fewer things
> >> that can go horribly wrong. :-/
> >
> > The problem is that
> >
> > 1. you have to use circular lists
> >
> > 2. going forward is  O(1), going backward is O(N).  This doesn't sound
> >    like a problem,  but deleting from lists and  alike requires you to
> >    go back in the list.
> >
> > I guess  that if  you have lists  that you  edit a lot,  double linked
> > lists should be  less overhead. However, if you only  walk the lists a
> > lot, both models should perform equally well.
> >
> > Insertion is faster, but that's the only good news..
> >
> > I'm all against them, though. ;)
> >
> > Tonnerre
> 
> And of course there's the ever-infamous 'two-half-linked list' (for want of
> a better name).  If you really need O(1) access in both directions but the
> constant factor isn't terribly important, it *is* (surprisingly) possible
> to achieve this without any size overhead in the list elements, though the
> code and iterator sizes will be a little higher and the "number of things
> that can go horribly wrong will swell impressively".
> 
> Read on only if you a) already know what I have in mind, but want to tell my
> I described it wrong or b) genuinely enjoy disgustingly clever trickery, or
> c) the previous, plus have some specific need to make an uncorrupted
> programmer's head explode. Do NOT read on if you are intending to implement
> what I describe, unless you have a damned good reason not to use a sane
> doubly-linked list :-)
> 
> What you do is take advantage of the fact that when iterating, it's usually
> pretty straightforward to make your 'iterator' keep track of of the
> previous node as the current one. Then, instead of storing a 'next' pointer
> or a 'previous' pointer in the node, you store the two XORed together (or
> choose your favorite mixing function, there are many viable choices). Then,
> when you are at a node, you can recover the pointer for whichever direction
> you are travelling in by XORing the mix from the node with your stored
> 'previous' pointer, thus giving you whichever neighbor you didn't already
> know. Then you can move to the next node (prev=current, current=neighbor)
> and do it again. Or just swap prev and current if you want to go the other
> direction.
> 
> So, you end up with:
> O(1) forward and reverse iteration
> only 1 pointer of overhead per node
> 
> but, you pay for it with:
> 2 pointers of size for a moveable iterator pointing to a node
> an extra fetch (though probably still in a register if you're in a tight
> loop) and an XOR for every step along the chain.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Some links for the intrigued ones:

http://www.google.com/search?q=xor+linked+list

http://www.fact-index.com/x/xo/xor_linked_list.html

http://www.greatsnakes.com/savannah/xlist.asp

-- 
Greetz, Antonio Vargas
