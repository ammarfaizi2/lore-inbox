Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132771AbRDQRFH>; Tue, 17 Apr 2001 13:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132772AbRDQRFA>; Tue, 17 Apr 2001 13:05:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9990 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132771AbRDQREb>;
	Tue, 17 Apr 2001 13:04:31 -0400
Date: Tue, 17 Apr 2001 19:03:59 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: block devices don't work without plugging in 2.4.3
Message-ID: <20010417190359.B523@suse.de>
In-Reply-To: <200104171640.f3HGeRb32326@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104171640.f3HGeRb32326@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Tue, Apr 17, 2001 at 06:40:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17 2001, Peter T. Breuer wrote:
> Well, anyway, as far as I can tell, the following has been lost from
> __make_request() in ll_rw_blk.c since the 2.4.0 days:
> 
>  out:
> -       if (!q->plugged)
> -               (q->request_fn)(q);
>         if (freereq)
> 
> The result appears to be that if a block device has called
> blk_queue_pluggable() to register a no-op plug_fn, then
> q->plugged will never be set (it's the duty of the plug_fn),
> and the devices registered request function wil never be called.
> 
> This behaviour is distinct from 2.4.0, where registering a 
> no-op made things work fine.
> 
> Is the policy now supposed to be that we do some more work
> in the "no-op"?  What am I supposed to do if I don't want
> plugging(1)(2)?
> 
> (1) goes away and looks ....
> (2) actually, I do want plugging, but I like to keep the
>     no-plug option around so that I can benchmark the difference
>     and also provide a very conservative option setting.

Not using plugging is dead, blk_queue_pluggable has been killed in the
current 2.4.4-pre tree.

-- 
Jens Axboe

