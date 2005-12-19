Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVLSPtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVLSPtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVLSPtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:49:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10442 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964780AbVLSPtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:49:32 -0500
Date: Mon, 19 Dec 2005 10:49:31 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-reply-to: <20051219135453.GQ2361@parisc-linux.org>
X-X-Sender: nico@localhost.localdomain
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.64.0512191047220.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <14917.1134847311@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org>
 <20051218092616.GA17308@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0512181027220.4827@g5.osdl.org>
 <Pine.LNX.4.64.0512181657050.26663@localhost.localdomain>
 <20051219092743.GA9609@flint.arm.linux.org.uk>
 <20051219135453.GQ2361@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005, Matthew Wilcox wrote:

> On Mon, Dec 19, 2005 at 09:27:44AM +0000, Russell King wrote:
> > > 	mov	r0, #1
> > > 	swp	r1, r0, [%0]
> > > 	cmp	r1, #0
> > > 	bne	__contention
> 
> > That's over-simplified, and is the easy bit.  Now work out how you handle
> > the unlock operation.
> > 
> > You don't know whether the lock is contended or not in the unlock path,
> > so you always have to do the "wake up" thing.  (You can't rely on the
> > value of the lock since another thread may well be between this swp
> > instruction and entering the __contention function.  Hence you can't
> > use the value of the lock to determine whether there's anyone sleeping
> > on it.)
> 
> Here's a slightly less efficient way to determine if anyone else has
> swp'd behind your back (apologies if I get my ARM assembly wrong, it's
> been a few years):

No need to be less efficient.  See the mail I just sent with additional 
details.


Nicolas
