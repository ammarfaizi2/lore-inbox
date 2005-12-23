Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030534AbVLWOYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030534AbVLWOYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 09:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030533AbVLWOYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 09:24:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28059 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030534AbVLWOYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 09:24:31 -0500
Date: Fri, 23 Dec 2005 09:24:17 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-reply-to: <20051222221311.2f6056ec.akpm@osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, mingo@elte.hu, lkml <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, arjanv@infradead.org, jes@trained-monkey.org,
       zwane@arm.linux.org.uk, oleg@tv-sign.ru, dhowells@redhat.com,
       bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Message-id: <Pine.LNX.4.64.0512230912220.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222114147.GA18878@elte.hu>
 <20051222035443.19a4b24e.akpm@osdl.org> <20051222122011.GA20789@elte.hu>
 <20051222050701.41b308f9.akpm@osdl.org>
 <1135257829.2940.19.camel@laptopd505.fenrus.org>
 <20051222054413.c1789c43.akpm@osdl.org>
 <1135260709.10383.42.camel@localhost.localdomain>
 <20051222153014.22f07e60.akpm@osdl.org> <20051222233416.GA14182@infradead.org>
 <20051222221311.2f6056ec.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Andrew Morton wrote:

> Christoph Hellwig <hch@infradead.org> wrote:
> > I really don't get why you hate mutex primitives so much.
> 
> I've just spelled out in considerable detail why this work is premature. 
> How can you not "get" it?  Why do I have to keep saying the same thing in
> different ways?  It's really quite simple.
> 
> 
> So here is permutation #4:
> 
> If we can optimise semaphores for speed and space, the mutexes are
> *unneeded*.

How can't you get the fact that semaphores could _never_ be as simple as 
mutexes?  This is a theoritical impossibility, which maybe turns out not 
to be so true on x86, but which is damn true on ARM where the fast path 
(the common case of a mutex) is significantly more efficient.

Semaphores _require_ an atomic decrement, mutexes do not.  On some 
architectures that makes a huge difference.

> And I think we _should_ optimise semaphores for speed and space.  Don't you?

No one disagrees with that.

> If we can do that, there is no point at all in adding a new lock type which
> has no speed advantage and no space advantage and which has less
> functionality than semaphores.

The very point is that mutexes will always have a speed advantage by 
nature.

> And, repeating myself yet again: if we can demonstrate that it is not
> feasible to optimise semaphores to the same performance and space efficiency
> of mutexes then (and only then) we have a reason for adding mutexes.

I spent the whole week making that demonstration repeatedly.  Why are 
you ignoring me?


Nicolas
