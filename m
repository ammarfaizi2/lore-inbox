Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946688AbWKAIDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946688AbWKAIDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946689AbWKAIDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:03:51 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:9355 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1946688AbWKAIDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:03:50 -0500
X-Originating-Ip: 72.57.81.197
Date: Wed, 1 Nov 2006 03:01:31 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Borislav Petkov <petkov@math.uni-muenster.de>,
       David Rientjes <rientjes@cs.washington.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched.c : correct comment for this_rq_lock() routine
In-Reply-To: <4547D23A.3090007@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0611010252460.28051@localhost.localdomain>
References: <Pine.LNX.4.64.0610301600550.12811@localhost.localdomain>
 <Pine.LNX.4.64N.0610301308290.17544@attu2.cs.washington.edu>
 <Pine.LNX.4.64.0610301623360.13169@localhost.localdomain>
 <20061031153021.GA14505@gollum.tnic> <Pine.LNX.4.64.0610311250500.22528@localhost.localdomain>
 <4547D23A.3090007@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006, Nick Piggin wrote:

> Robert P. J. Day wrote:
>
> > example, i was just poking around the source for the various
> > "atomic.h" files and noticed a couple possible cleanups:
> >
> >  1) make sure *everyone* uses "volatile" in the typedef struct (which
> > 	i actually submitted recently)
> >
>
> I don't see why. There is nothing in atomic (eg. atomic_read) that
> says there must be a compiler barrier around the operation.
>
> Have you checked that the architecture implementation actually needs
> the volatile where you've added it?

as just one example, you can read in include/asm-alpha/atomic.h:

/*
 * Counter is volatile to make sure gcc doesn't try to be clever
 * and move things around on us. We need to use _exactly_ the address
 * the user gave us, not some alias that contains the same information.
 */

now it may be that *some* architectures don't specifically require a
volatile counter but, AFAIK, it doesn't actually hurt if it isn't
necessary.  OTOH, if it isn't necessary *at all* for *any*
architecture, then that storage class should be *removed* in its
entirety.

in any event, all this is is another example of what appears to be
niggling and unnecessary differences between arch-specific header
files that could easily be turned into a single, standard definition
that would work for everyone with very little effort (and perhaps some
day be included from a single generic header file to avoid all that
duplication in the first place).

rday
