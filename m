Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbULGLWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbULGLWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 06:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbULGLWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 06:22:05 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:56009 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261787AbULGLVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 06:21:49 -0500
Date: Tue, 7 Dec 2004 12:21:39 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: P@draigBrady.com
Cc: "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041207112139.GA3610@soohrt.org>
References: <20041206205305.GA11970@soohrt.org> <20041206134849.498bfc93.davem@davemloft.net> <20041206224107.GA8529@soohrt.org> <41B58A58.8010007@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <41B58A58.8010007@draigBrady.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* P@draigBrady.com wrote:
> Karsten Desler wrote:
> >* David S. Miller wrote:
> >
> >>It's spending nearly half of it's time in iptables.
> >>Try to consolidate your rules if possible.  This is the
> >>part of netfilter that really doesn't scale well at all.
> >>
> >
> >Removing the iptables rules helps reducing the load a little, but the
> >majority of time is still spent somewhere else.
> 
> Well with NAPI it can be hard to tell CPU usage.
> You may need to use something like cyclesoak to get
> a true idea of CPU left.

Thanks, I'll look into it.

> Also have a look at http://www.hipac.org/ as netfilter
> has silly scalability properties.

I did before, but I read on Harald Weltes' weblog that 2.4 gives
slightly worse pps results than 2.6, and since the cpu usage is as high
as it is, I didn't want to take any more performance hits.
I'll try to see what performance impact the netfilter rules have during
peak load.

> I also notice that a lot of time is spent allocating
> and freeing the packet buffers (and possible hidden
> time due to cache misses due to allocating on one
> CPU and freeing on another?).
> How many [RT]xDescriptors do you have configured by the way?

256. I increased them to 1024 shortly after the profiling run, but
didn't notice any change in the cpu usage (will try again with cyclesoak).

> Anyway attached is a small patch that I used to make the e1000
> "own" the packet buffers, and hence it does not alloc/free
> per packet at all. Now this has only been tested in one
> configuration where I was just sniffing the packets, so
> definitely YMMV.

Thanks, I'll give it a spin.

Cheers,
 Karsten
