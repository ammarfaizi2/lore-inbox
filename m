Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVIBN4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVIBN4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 09:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVIBN4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 09:56:42 -0400
Received: from mail.microway.com ([64.80.227.22]:23221 "EHLO mail.microway.com")
	by vger.kernel.org with ESMTP id S1751322AbVIBN4l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 09:56:41 -0400
From: Rick Warner <rick@microway.com>
Organization: Microway, Inc.
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: latency doubled on tg3 device from 2.6.11 to 2.6.12
Date: Fri, 2 Sep 2005 09:56:00 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, eliot@microway.com
References: <200509011730.51990.rick@microway.com> <431776C5.9070709@cosmosbay.com>
In-Reply-To: <431776C5.9070709@cosmosbay.com>
Message-Id: <200509020956.00690.rick@microway.com>
X-Sanitizer: Advosys mail filter
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 September 2005 05:46 pm, Eric Dumazet wrote:
> Rick Warner a écrit :
> > Hello,
> >  We have been testing latency and bandwidth using our proprietary MPI
> > link checker tool (http://www.microway.com/mpilinkchecker.html) and have
> > found that the latency increased from ~25ms to ~45ms going from 2.6.11 to
> > 2.6.12. 2.6.13 has the same result.  We also tried the latest bcm5700
> > from broadcom (8.2.18) and got the same ~45ms latencies.  This was tried
> > on several different opteron and em64t motherboards.
> >
> >  We see 20-25ms latencies with the e1000 driver (with some module
> > options) on all 3 kernel versions.  For those interested, the e1000
> > options used are:
> >
> >  InterruptThrottleRate=0 RxIntDelay=0 TxIntDelay=0 RxAbsIntDelay=0
> > TxAbsIntDelay=0
> >
> >  Digging through source, it seems that a new locking mechanism for tg3
> > was put in place in 2.6.12.  Is this the likely cause?  What can we do to
> > restore our lower latency?
>
> Could you please define latency ?
>
> tg3 driver was recently updated to use coalescing.
>
> So when the nic receives one frame, it may delay up to XXXX us ( XXXX <
> 1024) the interrupt.
>
> But 25 ms is far more than 1024 us, so I dont think this coalescing can
> explain your problem.
>
> The HZ change from 1000 to 250 could be the root of the problem ?
>
> Using a simple ping between 2 machines with tg3, I get less than 1ms time.
>
> Eric

Our mpi link checker tool does a 1 way transfer of a 0 byte message (+ header) 
and times it to each system (in addition to other tests).  All systems in a 
cluster are showing the same high latency.  The numbers I gave were supposed 
to be us, I used the wrong unit by accident.

Low latency is often essential to clustered applications.  While a delay of up 
to 1024 us doesn't affect regular communications too much, it may severely 
affect mpi jobs.

Thanks.

-- 
Richard Warner
Lead Systems Integrator
Microway, Inc
(508)732-5517
