Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266082AbRGGK12>; Sat, 7 Jul 2001 06:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266086AbRGGK1R>; Sat, 7 Jul 2001 06:27:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22029 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266082AbRGGK1J>;
	Sat, 7 Jul 2001 06:27:09 -0400
Date: Sat, 7 Jul 2001 12:27:00 +0200
From: Jens Axboe <axboe@suse.de>
To: gopi krishna <mgopi@indiainfo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: device plugging
Message-ID: <20010707122700.C16505@suse.de>
In-Reply-To: <web-26606962@indiainfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <web-26606962@indiainfo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07 2001, gopi krishna wrote:
> Why do we need a dummy req for plugging.
> As i understood only thing plugging does is to, on arrival of new req if
> the dev queue is empty, puts a dummy req on the queue, and schedules the
> unplug routine on tq_disk, which on being scheduled calls the strategy
> routine.

You are reading 2.2 sources, maybe try the 2.4 sources as they are
easier to follow in this regard IMHO.

What happens is that we assign dev->current_request &dev->plug, so that
the front request is recognizable as the 'plug' and not a valid request.
You seem to completely misunderstand plugging -- if we just put the new
request on the queue and scheduled tq_disk, then there would be no
plugging going on at all. What we do instead is add this specific 'plug
request' and queue lots of stuff behind that. Not until someone needs
the data on the queue is the 'plug request' removed and the request_fn
run. This happens for instance if _someone else_ calls tq_disk,
typically __wait_on_buffer.

> So we can as well put the new req on the queue without dummy req.

Wrong

> If i'm incorrect please explain what's exact process and the reason

See?

-- 
Jens Axboe

