Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316606AbSFZOiR>; Wed, 26 Jun 2002 10:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSFZOiQ>; Wed, 26 Jun 2002 10:38:16 -0400
Received: from abricot.axialys.net ([217.146.226.10]:5360 "EHLO kiwi")
	by vger.kernel.org with ESMTP id <S316606AbSFZOiP>;
	Wed, 26 Jun 2002 10:38:15 -0400
Date: Wed, 26 Jun 2002 16:38:08 +0200
From: Nicolas Bougues <nbougues@axialys.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with wait queues
Message-ID: <20020626143808.GA6812@kiwi>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
References: <20020626140029.GA6310@kiwi> <Pine.LNX.3.95.1020626100928.25416A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020626100928.25416A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Organization: Axialys Interactive http://www.axialys.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

On Wed, Jun 26, 2002 at 10:17:45AM -0400, Richard B. Johnson wrote:
> 
> I am sure that you can have things look correct as well as run
> properly. However, you didn't show us the code.

It's quite large, and I didn't think I was "syntactically" wrong. But
the code is available, if somebody wants to have a look.

> You need to do something like:
> 
>             interruptible_sleep_on(&semaphore);
> 
> while your wake-up occurs with:
> 
>             wake_up_interruptible(&semaphore);
> 

That's what I do, although I use the wait_event_interruptible macro
instead of interruptible_sleep_on.

>
> Both ways (and others) will look fine with `top` and will sleep
> properly.
> 

If we're talking about %CPU times, right. If we're talking loadavg,
no. As I said in my previous message, I think it's because my
wake_up_interruptible() is *always* triggered during the timer
interrupt, just before the scheduler runs (new data is available every
100th/sec).

I'm not sure, but I think that the loadavg is computed at the
beginning of each scheduler run, thus, my task always looks "running"
at this time, even though it just runs for a few microseconds each
time.

--
Nicolas Bougues

