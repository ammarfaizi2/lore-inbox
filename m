Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946722AbWKAJYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946722AbWKAJYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946723AbWKAJYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:24:20 -0500
Received: from o-hand.com ([70.86.75.186]:21679 "EHLO o-hand.com")
	by vger.kernel.org with ESMTP id S1946722AbWKAJYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:24:19 -0500
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <45483020.9010607@yahoo.com.au>
References: <1161935995.5019.46.camel@localhost.localdomain>
	 <4541C1B2.7070003@yahoo.com.au>
	 <1161938694.5019.83.camel@localhost.localdomain>
	 <4542E2A4.2080400@yahoo.com.au>
	 <1162032227.5555.65.camel@localhost.localdomain>
	 <454348B4.60007@yahoo.com.au>
	 <1162209347.6962.2.camel@localhost.localdomain>
	 <45483020.9010607@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 09:24:04 +0000
Message-Id: <1162373044.5564.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 16:26 +1100, Nick Piggin wrote:
> > I can't work out the code path it happens in and until I do, I'm not
> > sure how I can track it down... 
> 
> Is your driver scribbling on the page memory when it encounters a write
> error, or is the SIGBUS coming from a subsequent pagefault attempt on
> that address? Stick a WARN_ON(1) in the VM_FAULT_SIGBUS case in
> arch/arm/mm/fault.c to check.

I'm 100% certain the driver doesn't touch the memory page. It would be a
serious problem if it did as I'd see see memory corruption in the cases
where the page wasn't read from disk but read from the swap cache (I
don't).

The error therefore has to be coming from a pagefault attempt on the
address...

> >>Still, something must be triggering it somewhere.
> > 
> > 
> > Something must be but I wish I knew what/where...
> 
> Let's try to find out :)

I'll see if I can work it out...

> Yes, I mean the other side of the writepage, ie. when page reclaim is
> about to attempt to swap it out.
> 
> The attached (very untested, in need of splitting up) patch attempts to
> solve these problems. Note that it is probably not going to prevent your
> SIGBUS, so that will have to be found and fixed individually.
> 
> In the meantime, I'll run this through some testing when I get half a
> chance.

Right, this is a nicer way to do it. I would have preferred to do
something like this in the first place but didn't as I didn't think I
could use PageError as a marker...

I'll try and work out why PageError is causing the problems and also
give the patch some testing.

Thanks,

Richard

