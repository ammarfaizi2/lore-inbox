Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934321AbWKULLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934321AbWKULLy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934349AbWKULLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:11:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31722 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934321AbWKULLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:11:54 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061121100642.GA580@infradead.org> 
References: <20061121100642.GA580@infradead.org>  <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com> <1164040326.5700.46.camel@lade.trondhjem.org> 
To: Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] WorkStruct: Shrink work_struct by two thirds 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 21 Nov 2006 11:08:46 +0000
Message-ID: <9685.1164107326@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > Why not simply add a timer argument to 'queue_delayed_work()' and
> > 'cancel_delayed_work()'? That may allow you to reuse an existing timer
> > struct if you already have it embedded somewhere else.
>
> I doubt we can really reuse an existing timer,

I have to agree with Christoph on that.  I don't think reusing an existing
timer is going to work in most of the cases - in many cases there isn't an
existing timer to reuse, and even if there is, it's usually there for some
other purpose.

> but this seems to be the cleanest way despite that.  Let's follow the
> philosophy of builing from small building blocks for our kernel APIs aswell.

I'm not so sure of that.  Currently the rest of the kernel is unaware there's a
timer there and doesn't have to do anything about it directly.

> As a second benefit it also makes handling the case of having both delayed
> and immediate items on a single workqueue trivial.

It's pretty straightforward as it is now.  The worst bit is that we have to
have several functions that do the same or a similar thing but with different
names because they take different arguments.

The benefit of what we have at the moment is that there is only one timer
callback routine required and everything uses that - not that we can't just
export that, but it's cleaner to set things up since the rest of the kernel
doesn't know there's a timer involved.

David
