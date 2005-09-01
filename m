Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbVIAVqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbVIAVqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbVIAVqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:46:50 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:53132 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1030419AbVIAVqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:46:48 -0400
Message-ID: <431776C5.9070709@cosmosbay.com>
Date: Thu, 01 Sep 2005 23:46:45 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Rick Warner <rick@microway.com>
Cc: linux-kernel@vger.kernel.org, eliot@microway.com
Subject: Re: latency doubled on tg3 device from 2.6.11 to 2.6.12
References: <200509011730.51990.rick@microway.com>
In-Reply-To: <200509011730.51990.rick@microway.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Warner a écrit :
> Hello,
>  We have been testing latency and bandwidth using our proprietary MPI link 
> checker tool (http://www.microway.com/mpilinkchecker.html) and have found 
> that the latency increased from ~25ms to ~45ms going from 2.6.11 to 2.6.12.  
> 2.6.13 has the same result.  We also tried the latest bcm5700 from broadcom 
> (8.2.18) and got the same ~45ms latencies.  This was tried on several 
> different opteron and em64t motherboards.
> 
>  We see 20-25ms latencies with the e1000 driver (with some module options) on 
> all 3 kernel versions.  For those interested, the e1000 options used are:
> 
>  InterruptThrottleRate=0 RxIntDelay=0 TxIntDelay=0 RxAbsIntDelay=0 
> TxAbsIntDelay=0
> 
>  Digging through source, it seems that a new locking mechanism for tg3 was put 
> in place in 2.6.12.  Is this the likely cause?  What can we do to restore our 
> lower latency?
> 
> 

Could you please define latency ?

tg3 driver was recently updated to use coalescing.

So when the nic receives one frame, it may delay up to XXXX us ( XXXX < 1024) 
the interrupt.

But 25 ms is far more than 1024 us, so I dont think this coalescing can 
explain your problem.

The HZ change from 1000 to 250 could be the root of the problem ?

Using a simple ping between 2 machines with tg3, I get less than 1ms time.

Eric
