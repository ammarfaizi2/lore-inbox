Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWEaQj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWEaQj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWEaQj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:39:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751719AbWEaQj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:39:57 -0400
Date: Wed, 31 May 2006 09:39:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <447DC22C.5070503@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605310937170.24646@g5.osdl.org>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au>
 <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au>
 <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au>
 <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <447DAEDE.5070305@yahoo.com.au>
 <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org> <447DB765.6030702@yahoo.com.au>
 <Pine.LNX.4.64.0605310840000.24646@g5.osdl.org> <447DC22C.5070503@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jun 2006, Nick Piggin wrote:
> 
> I keep telling you. Put the unplug after submission of IO. Not before
> waiting for IO.

And that's exactly where we have the lock_page().

And you ignored the list of _requirements_ I had, so you just missed the 
other place you _have_ to have the unplug, namely in the "found a page 
that was not yet up-to-date" case (look for the other lock_page()). 
Because the person who started the IO might be off doing something else, 
and may not be unplugging now (or ever, in the case of readahead).

In other words, when you start arguing, at least read my emails. Your 
suggestion would have introduced a bug by not waiting on that other place.

		Linus
