Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbWEaOrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWEaOrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWEaOrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:47:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28609 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965040AbWEaOrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:47:09 -0400
Date: Wed, 31 May 2006 07:43:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <447D9A41.8040601@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au>
 <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au>
 <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 May 2006, Nick Piggin wrote:
> 
> Now having a mechanism for a task to batch up requests might be a
> good idea. Eg.
> 
> plug();
> submit reads
> unplug();
> wait for page

What do you think we're _talking_ about?

What do you think my example of sys_readahead() was all about?

WE DO HAVE EXACTLY THAT MECHANISM. IT'S CALLED PLUGGING!

> I'd think this would give us the benefits of corse grained (per-queue) 
> plugging and more (e.g. it works when the request queue isn't empty). 
> And it would be simpler because the unplug point is explicit and doesn't 
> need to be kicked by lock_page or wait_on_page

What do you think plugging IS?

It's _exactly_ what you're talking about. And yes, we used to have 
explicit unplugging (a long long long time ago), and IT SUCKED. People 
would forget, but even more importantly, people would do it even when not 
needed because they didn't have a good place to do it because the waiter 
was in a totally different path.

The reason it's kicked by wait_on_page() is that is when it's needed.

		Linus
