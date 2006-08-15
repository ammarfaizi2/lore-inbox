Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWHOPIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWHOPIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWHOPIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:08:04 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:52897 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030337AbWHOPID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:08:03 -0400
Date: Tue, 15 Aug 2006 19:07:44 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060815150744.GA27124@2ka.mipt.ru>
References: <1155558313.5696.167.camel@twins> <20060814123530.GA5019@2ka.mipt.ru> <1155639302.5696.210.camel@twins> <20060815112617.GB21736@2ka.mipt.ru> <1155643405.5696.236.camel@twins> <20060815123438.GA29896@2ka.mipt.ru> <1155649768.5696.262.camel@twins> <20060815141501.GA10998@2ka.mipt.ru> <1155653339.5696.282.camel@twins> <20060815150507.GA9734@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060815150507.GA9734@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 15 Aug 2006 19:07:46 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 07:05:07PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> > > So network allocator reserves above megabyte and works with it in a
> > > smart way (without too much overhead).
> > > Then system goes into OOM and requires to swap a page, which
> > > notification was sent to remote swap storage.
> > > Swap storage then sends an ack for that data, since network allocations
> > > are separated from main system ones, network allocator easily gets 60
> > > (or 4k, since it has a reserve, which exeeds maximum allowed TCP memory
> > > limit) bytes for ack and process than notification thus "freeing" acked
> > > data and main system can work with that free memory.
> > > No need to detect OOM or something other - it just works.
> > > 
> > > I expect you will give me an example, when all above megabyte is going
> > > to be stuck somewhere.
> > > But... If it is not acked, each new packet goes slow path since VJ header 
> > > prediction fails and falls into memory limit check which will drop that
> > > packet immediately without event trying to select a socket.
> 
> I mean without trying to queue data into socket.
> 
> > Not sure on the details; but you say: when we reach the threshold all
> > following packets will be dropped. So if you provide enough memory to
> > exceed the limit, you have some extra. If you then use that extra bit to
> > allow ACKs to pass through, then you're set.
> > 
> > Sounds good, but you'd have to carve a path for the ACKs, right? Or is
> > that already there?
> 
> Acks with or without attached data are processed before data queueing.
> See tcp_rcv_established().

Just for clarification: we are talking about slow path above.

-- 
	Evgeniy Polyakov
