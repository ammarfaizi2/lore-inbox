Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbWEaPRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWEaPRB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 11:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWEaPRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 11:17:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965062AbWEaPRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 11:17:00 -0400
Date: Wed, 31 May 2006 08:13:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <447DAEDE.5070305@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au>
 <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au>
 <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au>
 <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <447DAEDE.5070305@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jun 2006, Nick Piggin wrote:
> 
> > And yes, we used to have explicit unplugging (a long long long time ago),
> > and IT SUCKED. People would forget, but even more importantly, people would
> > do it even when not 
> 
> I don't see what the problem is. Locks also suck if you forget to unlock
> them.

Locks are simple, and in fact are _made_ simple on purpose. We try very 
hard to unlock in the same function that we lock, for example. Because if 
we don't, bugs happen.

That's simply not _practical_ for IO. Think about it. Quite often, the 
waiting is done somewhere else than the actual submission.

> > needed because they didn't have a good place to do it because the waiter was
> > in a totally different path.
> 
> Example?

Pretty much all of them.

Where do you wait for IO?

Would you perhaps say "wait_on_page()"?

In other words, we really _do_ exactly what you think we should do.

> I don't know why you think this way of doing plugging is fundamentally
> right and anything else must be wrong... it is always heuristic, isn't
> it?

A _particular_ way of doing plugging is not "fundamentally right". I'm 
perfectly happy with chaning the place we unplug, if people want that. 
We've done it several times.

But plugging as a _concept_ is definitely fundamentally right, exactly 
because it allows us to have the notion of "plug + n*<random submit by 
different paths> + unplug".

And you were not suggesting moving unplugging around. You were suggesting 
removing the feature. Which is when I said "no f*cking way!".

		Linus
