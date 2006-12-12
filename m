Return-Path: <linux-kernel-owner+w=401wt.eu-S932361AbWLLVGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWLLVGs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 16:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWLLVGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 16:06:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41526 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932363AbWLLVGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 16:06:48 -0500
Date: Tue, 12 Dec 2006 13:06:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: fix seqlock_init()
Message-Id: <20061212130644.5251e9f2.akpm@osdl.org>
In-Reply-To: <20061212205001.GA31445@elte.hu>
References: <20061212111028.GA13908@elte.hu>
	<20061212094820.1049a252.akpm@osdl.org>
	<20061212205001.GA31445@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 21:50:01 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Tue, 12 Dec 2006 12:10:28 +0100
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > +#define seqlock_init(x)					\
> > > +	do {						\
> > > +		(x)->sequence = 0;			\
> > > +		spin_lock_init(&(x)->lock);		\
> > > +	} while (0)
> > 
> > This does not have to be a macro, does it?
> 
> Maybe it could be an __always_inline inline function (it has to be 
> inlined to get the callsite based lock class key right)

the compiler darn better inline it, else we'll have an out-of-line copy of
everything in everywhere.

> - but i'm not 
> sure about the include file dependencies. Will probably work out fine as 
> seqlock.h is supposed to be a late one in the order of inclusion - but i 
> didnt want to make a blind bet.

seqlock.h already includes spinlock.h.
