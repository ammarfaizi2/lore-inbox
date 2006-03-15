Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751938AbWCONr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbWCONr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 08:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCONr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 08:47:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7629 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750819AbWCONrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 08:47:55 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4417FFC2.8040909@yahoo.com.au> 
References: <4417FFC2.8040909@yahoo.com.au>  <44110E93.8060504@yahoo.com.au> <16835.1141936162@warthog.cambridge.redhat.com> <14886.1142421018@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, alan@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 15 Mar 2006 13:47:34 +0000
Message-ID: <17625.1142430454@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > Ah, but if the cache is on the CPU side of the dotted line, does that then
> > mean that a write memory barrier guarantees the CPU's cache to have
> > updated memory?
> 
> I don't think it has to[*]. It would guarantee the _order_ in which "global
> memory" of this model ie. visibility for other "CPUs" see the writes,
> whether that visibility ultimately be implemented by cache coherency
> protocol or something else, I don't think matters (for a discussion of
> memory ordering).

It does matter, because I have to make it clear that the effect of the memory
barrier usually stops at the cache, and in fact memory barriers may have no
visibility at all on another CPU because it's all done inside a CPU's cache,
until that other CPU tries to observe the results.

> If anything it confused the matter for the case of Alpha.

Nah... Alpha is self-confusing:-)

> All the programmer needs to know is that there is some horizon (memory)
> beyond which stores are visible to other CPUs, and stores can travel there
> at different speeds so later ones can overtake earlier ones. And likewise
> loads can come from memory to the CPU at different speeds too, so later
> loads can contain earlier results.

They also need to know that memory barriers don't imply an ordering on the
cache.

> [*] Nor would your model require a smp_wmb() to update CPU caches either, I
> think: it wouldn't have to flush the store buffer, just order it.

Exactly.

But in your diagram, given that it doesn't show the cache, you don't know that
the memory barrier doesn't extend through the cache and all the way to memory.

David
