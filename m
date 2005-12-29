Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVL2PoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVL2PoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 10:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVL2PoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 10:44:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64709 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750762AbVL2PoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 10:44:18 -0500
Date: Thu, 29 Dec 2005 10:42:41 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229154241.GY22293@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051229143846.GA18833@infradead.org> <1135868049.2935.49.camel@laptopd505.fenrus.org> <20051229153529.GH3811@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229153529.GH3811@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 04:35:29PM +0100, Adrian Bunk wrote:
> > You describe a nice utopia where only the most essential functions are
> > inlined.. but so far that hasn't worked out all that well ;) Turning
> > "inline" back into the hint to the compiler that the C language makes it
> > is maybe a cop-out, but it's a sustainable approach at least.
> >...
> 
> But shouldn't nowadays gcc be able to know best even without an "inline" 
> hint?

Only for static functions (and in -funit-at-a-time mode).
Anything else would require full IMA over the whole kernel and we aren't
there yet.  So inline hints are useful.  But most of the inline keywords
in the kernel really should be that, hints, because e.g. while it can be
beneficial to inline something on one arch, it may be not beneficial on
another arch, depending on cache sizes, number of general registers
available to the compiler, register preassure, speed of the call/ret
pair, calling convention and many other factors.

	Jakub
