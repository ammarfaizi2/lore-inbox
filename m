Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbVLVRp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbVLVRp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVLVRp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:45:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965173AbVLVRpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:45:25 -0500
Date: Thu, 22 Dec 2005 09:44:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nicolas Pitre <nico@cam.org>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/10] mutex subsystem, -V5
In-Reply-To: <Pine.LNX.4.64.0512221134150.26663@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512220941320.4827@g5.osdl.org>
References: <20051222153717.GA6090@elte.hu> <Pine.LNX.4.64.0512221134150.26663@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Dec 2005, Nicolas Pitre wrote:

> On Thu, 22 Dec 2005, Ingo Molnar wrote:
> 
> > Changes since -V4:
> > 
> > - removed __ARCH_WANT_XCHG_BASED_ATOMICS and implemented
> >   CONFIG_MUTEX_XCHG_ALGORITHM instead, based on comments from
> >   Christoph Hellwig.
> > 
> > - updated ARM to use CONFIG_MUTEX_XCHG_ALGORITHM.
> 
> This is still not what I'd like to see, per my previous comments.
> 
> Do you have any strong reason for pursuing that route instead of going 
> with my suggested approach?

I'd just prefer a 

	<asm-generic/mutex-xchg-algo.h>

and then any architecture can do whatever they damn well want, and 
anybody who doesn't want to, can just include that header file.

No #ifdef's, no config options, no "generic fallback". Just 
unconditionally do the sane thing.

I'm with whoever HATES those stupid __ARCH_xxx #defines. It's a sign of 
bad design. Either it's a generic algorithm (and it can be in 
<asm-generic> or it's not). In no case should we ever have __ARCH_HAS_xxx 
(and yes, that includes cases where we _currently_ use __ARCH_HAS_xxx).

		Linus
