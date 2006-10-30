Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWJ3IZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWJ3IZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 03:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbWJ3IZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 03:25:12 -0500
Received: from brick.kernel.dk ([62.242.22.158]:27718 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161200AbWJ3IZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 03:25:10 -0500
Date: Mon, 30 Oct 2006 09:26:48 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] uml ubd driver: ubd_io_lock usage fixup
Message-ID: <20061030082643.GM4563@kernel.dk>
References: <200610292023.12980.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610292023.12980.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29 2006, Blaisorblade wrote:
> Add some comments about requirements for ubd_io_lock and expand its use.
> 
> When an irq signals that the "controller" (i.e. another thread on the host,
> which does the actual requests and is the only one blocked on I/O on the
>  host) has done some work, we call again the request function ourselves
> (do_ubd_request).
> 
> We now do that with ubd_io_lock held - that's useful to protect against
> concurrent calls to elv_next_request and so on.

Not only useful, required, as I think I complained about a year or more
ago :-)

> XXX: Maybe we shouldn't call at all the request function. Input needed on
>  this. Are we supposed to plug and unplug the queue? That code "indirectly"
>  does that by setting a flag, called do_ubd, which makes the request function
>  return (it's a residual of 2.4 block layer interface).

Sometimes you need to. I'd probably just remove the do_ubd check and
always recall the request function when handling completions, it's
easier and safe.

-- 
Jens Axboe

