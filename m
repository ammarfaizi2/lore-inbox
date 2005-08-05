Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVHEXU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVHEXU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVHEXU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:20:28 -0400
Received: from waste.org ([216.27.176.166]:13710 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262013AbVHEXUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:20:25 -0400
Date: Fri, 5 Aug 2005 16:20:15 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: John B?ckstrand <sandos@home.se>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: lockups with netconsole on e1000 on media insertion
Message-ID: <20050805232015.GX8074@waste.org>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <20050805201215.GG7425@waste.org> <20050805215650.GH8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805215650.GH8266@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 11:56:50PM +0200, Andi Kleen wrote:
> > I still don't like this fix. Yes, you're right, it should eventually
> > give up. But here it gives up way too easily - 5 could easily
> > translate to 5 microseconds. This is analogous to giving up on serial
> > transmit if CTS is down for 5 loops.
> > 
> > I'd be much happier if there were some udelay or the like in here so
> > that we're not giving up on such a short timeframe.
> 
> Problem is that it could translate to a long aggregate delay
> e.g. when the kernel tries to dump the backlog after console_init.
> That is why I made the delay so short.

But why are we in a hurry to dump the backlog on the floor? Why are we
worrying about the performance of netpoll without the cable plugged in
at all? We shouldn't be optimizing the data loss case.

My primary concern here is that the loop have a non-negligible extent
in time. 5 loops is effectively equal to none. I'd be very surprised
if it was even enough for deglitching.

With serial console, we do polled I/O that runs at the serial rate -
milliseconds per line of output.

> Longer delay would be possible, but then it would need some logic
> to detect down links and don't delay on them and then retry later etc. 
> Would be all far more complicated.

I think we could probably have subsequent failures be much shorter
without too much added complexity. But I'm not sure it matters.

-- 
Mathematics is the supreme nostalgia of our time.
