Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbTJESdD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 14:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTJESdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 14:33:03 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:43318 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263344AbTJESdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 14:33:00 -0400
Date: Sun, 5 Oct 2003 14:32:39 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       pwaechtler@mac.com, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: POSIX message queues
Message-ID: <20031005143239.T26086@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.GSO.4.58.0310051047560.12323@ultra60> <3F80484A.3030105@redhat.com> <20031005181630.GA26958@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031005181630.GA26958@mail.shareable.org>; from jamie@shareable.org on Sun, Oct 05, 2003 at 07:16:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 07:16:30PM +0100, Jamie Lokier wrote:
> Ulrich Drepper wrote:
> > > In another words: is our implementation in the position
> > > of NGPT or better? ;-)
> > 
> > I don't understand.  Why NGPT and what about "position"?
> 
> He is asking if the work will be wasted effort that is dismissed or
> superceded, like NGPT was.
> 
> > If you mean
> > including a solution in the runtime (librt), sure, this will happen.
> > But not before I see a solution in the official kernel.
> 
> Speaking of librt - I should not have to link in pthreads and the
> run-time overhead associated with it (locking stdio etc.) just so I
> can use shm_open().  Any chance of fixing this?

That overhead is mostly gone in current glibcs (when using NPTL):
a) e.g. locking is done unconditionally even when libpthread is not present
   (it is just lock cmpxchgl, inlined)
b) things like cancellation aware syscall wrappers for cancellable syscalls
   and various other things are only done after first pthread_create has
   been called, it doesn't matter whether libpthread is loaded or not

	Jakub
