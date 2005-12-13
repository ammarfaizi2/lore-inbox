Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVLMNc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVLMNc7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVLMNc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:32:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932110AbVLMNc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:32:58 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1134479118.11732.14.camel@localhost.localdomain> 
References: <1134479118.11732.14.camel@localhost.localdomain>  <dhowells1134431145@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 13 Dec 2005 13:32:39 +0000
Message-ID: <3874.1134480759@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> >  (5) Redirects the following to apply to the new mutexes rather than the
> >      traditional semaphores:
> > 
> > 	down()
> ...
> 
> And you've audited every occurence ?

Outside of the arch directories, yes; but I don't know that I've made the
correct decision in 100% of the cases.

I've changed some of the uses into completions, and found about a dozen or so
uses of counting semaphores; but the vast majority of occurrences seem to be
wanting mutex behaviour.

> It seems to me it would be far far saner to define something like
> 
> 	sleep_lock(&foo)
> 	sleep_unlock(&foo)
> 	sleep_trylock(&foo)

Which would be a _lot_ more work. It would involve about ten times as many
changes, I think, and thus be more prone to errors.

> Its then obvious what it does, you don't randomly break other drivers you've
> not reviewed and the interface is intuitive rather than obfuscated.

I've attempted to review everything in 2.6.15-rc5 outside of most of the archs.
I can't easily modify any driver not contained in that tarball, but at least
the compiler will barf and force a review.

> It won't take long for people to then change the name of the performance
> critical cases and the others will catch up in time.

It took about ten hours to go through the declarations of struct semaphore and
review them; I hate to think how long it'd take to go through all the ups and
downs too.

> It also saves breaking every piece of out of tree kernel code for now
> good reason.

But my patch means the changes required are in the most cases minimal: just
changing struct semaphore to struct mutex is sufficient for the vast majority
of cases.

Your way requires a lot more work, both in the tree and out of it.

David
