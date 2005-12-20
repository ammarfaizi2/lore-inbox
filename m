Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVLTT6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVLTT6H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbVLTT6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:58:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24330 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932066AbVLTT6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:58:05 -0500
Date: Tue, 20 Dec 2005 19:57:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nicolas Pitre <nico@cam.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
Message-ID: <20051220195747.GE24199@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	Nicolas Pitre <nico@cam.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
References: <20051220043109.GC32039@elte.hu> <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au> <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au> <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain> <43A81DD4.30906@yahoo.com.au> <Pine.LNX.4.64.0512201049310.26663@localhost.localdomain> <20051220192018.GB24199@flint.arm.linux.org.uk> <Pine.LNX.4.58.0512201437120.11245@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512201437120.11245@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 02:43:30PM -0500, Steven Rostedt wrote:
> So what's wrong with having the generic code, and for those with a fast
> semapore add an arch specific?
> 
> #define mutex_lock down
> #define mutex_unlock up
> #define mutex_trylock(x) (!down_trylock(x))
> 
> Until the mutex code is updated to a fast arch specific implementation.
> 
> Let me restate, that the generic code should not be this, but each arch
> can have this if they already went through great lengths in making a fast
> semaphore.

I have no problem with this since we can then use Nico's swp-based
implementation.  Great!  What seems to be happening though is that
there's a move to make these operations be generic across all
architectures.

What both Nico and myself have demonstrated is that if architectures
are placed into the generic strait-jacket, any alleged performance
benefit of mutexes is completely swamped, which in turn makes the
whole mutex idea entirely pointless.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
