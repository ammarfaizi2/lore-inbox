Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSJJMYd>; Thu, 10 Oct 2002 08:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262318AbSJJMYc>; Thu, 10 Oct 2002 08:24:32 -0400
Received: from iris.mc.com ([192.233.16.119]:25570 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S262317AbSJJMYb>;
	Thu, 10 Oct 2002 08:24:31 -0400
Message-Id: <200210101229.IAA24535@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
Date: Thu, 10 Oct 2002 08:34:14 -0400
X-Mailer: KMail [version 1.3.1]
References: <3DA4CED6.1BD30A2F@kegel.com>
In-Reply-To: <3DA4CED6.1BD30A2F@kegel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 October 2002 20:50, Dan Kegel wrote:
> line rate.   Now, I'm way far from the code, but I suspect that
> the interrupt overhead needed to get the precision the customer
> is calling for would be totally prohibitive.  I dunno if we'll

only in a fixed interval tick system.  Early in george's design process I 
argued for a tickless system,(which I had implemented in my company's 
proprietary real-time OS)  which has _no_ extra overhead and does away with 
the 10ms tick entirely.  the precision attained is whatever the highest 
resolution interrupting counter on the system is capable of.

george did extensive benchmarking of candidate implementations of both 
designs and came to the conclusion that the 10ms jiffie fixed interval tick 
plus on demand higher resolution ticks was more suitable for general purpose 
uses than the tickless system, particularly under high load when there are 
many low resolution timed events in the system (as in a server situation).

it turned out that the tickless system was appropriate for embedded systems 
(my focus) which tend to have small numbers of well coordinated tasks running 
and not so good in environments with a lot of things going on, such as a 
multimedia desktop or big honkin server.

whith the hybrid system that george developed, you get the batching benefits 
of low resolution fixed interval timers, which provides all the capability 
most timer services customers need while at the same time, and for minimal 
overhead providing the high resolution timers that the embedded world needs.




-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
**************************************************/
