Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVLTOKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVLTOKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVLTOKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:10:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64358 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751054AbVLTOKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:10:23 -0500
Date: Tue, 20 Dec 2005 09:10:22 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
 add-atomic-call-func-x86_64.patch
In-reply-to: <43A7BCE1.7050401@yahoo.com.au>
X-X-Sender: nico@localhost.localdomain
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Message-id: <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051219013507.GE27658@elte.hu>
 <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain>
 <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
 <43A7BCE1.7050401@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Nick Piggin wrote:

> Nicolas Pitre wrote:
> > On Tue, 20 Dec 2005, Ingo Molnar wrote:
> > 
> > 
> > > * David Woodhouse <dwmw2@infradead.org> wrote:
> > > 
> > > 
> > > > On Mon, 2005-12-19 at 09:49 -0800, Zwane Mwaikambo wrote:
> > > > 
> > > > > Hi Ingo,
> > > > >        Doesn't this corrupt caller saved registers?
> > > > 
> > > > Looks like it. I _really_ don't like calling functions from inline asm.
> > > > It's not nice. Can't we use atomic_dec_return() for this?
> > > 
> > > we can use atomic_dec_return(), but that will add one more instruction to
> > > the fastpath. OTOH, atomic_dec_return() is available on every
> > > architecture, so it's a really tempting thing. I'll experiment with it.
> > 
> > 
> > Please consider using (a variant of) xchg() instead.  Although atomic_dec()
> > is available on all architectures, its implementation is far from being the
> > most efficient thing to do for them all.  For example, see my discussion
> > about swp on ARM:
> > 
> 
> Considering that on UP, the arm should not need to disable interrupts
> for this function (or has someone refuted Linus?), how about:

Kernel preemption.


Nicolas
