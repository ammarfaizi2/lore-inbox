Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbTBAAfe>; Fri, 31 Jan 2003 19:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbTBAAfe>; Fri, 31 Jan 2003 19:35:34 -0500
Received: from mail018.syd.optusnet.com.au ([210.49.20.176]:14534 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S264001AbTBAAfe> convert rfc822-to-8bit; Fri, 31 Jan 2003 19:35:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [BENCHMARK] 2.5.59-mm7 with contest
Date: Sat, 1 Feb 2003 11:44:54 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
References: <200302010930.54538.conman@kolivas.net> <3E3B16CF.9050806@cyberone.com.au>
In-Reply-To: <3E3B16CF.9050806@cyberone.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302011144.54554.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 Feb 2003 11:37 am, Nick Piggin wrote:
> Con Kolivas wrote:
> >Seems the fix for "reads starves everything" works. Affected the tar loads
> >too?
>
> Yes, at the cost of throughput, however for now it is probably
> the best way to go. Hopefully anticipatory scheduling will provide
> as good or better kernel compile times and better throughput.
>
> Con, tell me, are "Loads" normalised to the time they run for?
> Is it possible to get a finer grain result for the load tests?

No, the load is the absolute number of times the load successfully completed. 
We battled with the code for a while to see if there were ways to get more 
accurate load numbers but if you write a 256Mb file you can only tell if it 
completes the write or not; not how much has been written when you stop the 
write. Same goes with read etc. The load rate is a more meaningful number but 
we haven't gotten around to implementing that in the result presentation.

Load rate would be:

loads / ( load_compile_time - no_load_compile_time )

because basically if the load compile time is longer, more loads are 
completed. Most of the time the loads happen at the same rate, but if the 
load rate was different it would be a more significant result than just a 
scheduling balance change which is why load rate would be a useful addition.

Con
