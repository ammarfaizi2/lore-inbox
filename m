Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSCOK5d>; Fri, 15 Mar 2002 05:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCOK5Y>; Fri, 15 Mar 2002 05:57:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8464 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290184AbSCOK5E>;
	Fri, 15 Mar 2002 05:57:04 -0500
Date: Fri, 15 Mar 2002 11:56:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020315105621.GA22169@suse.de>
In-Reply-To: <20020314032801.C1273@dualathlon.random> <3C912ACF.AF3EE6F0@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C912ACF.AF3EE6F0@pp.inet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15 2002, Jari Ruusu wrote:
> - No more illegal sleeping in generic_make_request().

I've told you this before -- sleeping in make_request is not illegal,
heck it happens _all the time_. Safely sleeping requires a reserved pool
of the units you wish to allocate, of course. In fact I think that would
be much nicer than the path you are following here by delaying
allocations to the loop thread (and still not using a reserved pool).

Briefly looking through the patch.

- loop_put_buffer(), it looks racy to check waitqueue_active there.

-	if(!bh) return((struct buffer_head *)0);

eww!

- Also, please adher to the style. VaRiAbLe names can hurt the eyes, and
stuff like

	if (something) break;

	return(val);

etc don't belong too. Could you fix that up?

That said, thanks for fixing it!

-- 
Jens Axboe

