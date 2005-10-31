Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVJaJKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVJaJKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVJaJKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:10:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37186 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932324AbVJaJKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:10:32 -0500
Date: Mon, 31 Oct 2005 10:11:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@mandriva.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][noop-iosched] don't reuse a freed request
Message-ID: <20051031091117.GP19267@suse.de>
References: <20051031023024.GC5632@mandriva.com> <20051031074022.GN19267@suse.de> <4365D01D.2040406@gmail.com> <20051031082354.GO19267@suse.de> <4365DCE6.9060809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4365DCE6.9060809@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31 2005, Tejun Heo wrote:
> >For now, we should add the former.
> 
> Yeap, also verified oops doesn't happen with the following patch.

Good

> I'll soon post a patch to convert noop such that it does proper 
> dispatching.  BTW, while I was looking at the code, I found something 

Sounds good.

> else, in elv_former/latter_request functions, if the iosched doesn't 
> supply the callbacks, it uses rq->queue_list.prev/next implicitly 
> (without this, this noop bug wouldn't have been triggered).  I think 
> this code is not necessary anymore.  What do you think?

Well that should still work for noop, if it has its own internal
queueing list. But I would be quite fine with removing that implicit
next/prev support and simply require io scheds to supply these functions
always if they require rq-to-rq merging. Noop is the only one that
relied on this in the past, now seems a good time to clean that up as
well.

Besides, as you note, with merging disallowed on the ->queue_head, they
don't work as expected anymore.

-- 
Jens Axboe

