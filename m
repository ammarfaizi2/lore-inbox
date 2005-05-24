Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVEXMMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVEXMMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVEXMMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:12:21 -0400
Received: from berlioz.imada.sdu.dk ([130.225.128.12]:1513 "EHLO
	berlioz.imada.sdu.dk") by vger.kernel.org with ESMTP
	id S262006AbVEXMMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:12:14 -0400
From: Hans Henrik Happe <hhh@imada.sdu.dk>
To: DervishD <lkml@dervishd.net>
Subject: Re: Issues with INET sockets through loopback (lo)
Date: Tue, 24 May 2005 14:12:17 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200505231317.44716.hhh@imada.sdu.dk> <20050523120900.GA339@DervishD>
In-Reply-To: <20050523120900.GA339@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505241412.17887.hhh@imada.sdu.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 May 2005 14:09, DervishD wrote:
> With 3-1 I get an usage of 20% more or less. But with 16-1 the
> CPU usage is nearly 0! and with 16-16 the usage is 5% more or less.

That even worse than what I have experienced.
  
> > I have tried more regular communication patterns but this gives full CPU 
> > utilization as expected. For instance sending messages in a ring (attach: 
> > ring-inet.c). 
> 
> Not here. It uses 29% instead of 20% with 3-1, but drops to 6%
> when using 16 processes. Far from full CPU usage. A test with 16-160
> doesn't make the system slower or irresponsive, at least here...

Again, even worse.
 
> Not here. I haven't noticed any slow-down or latency increase
> using high number of messages. Using 16-160 only uses at most 7% of
> CPU per process, and I don't feel the system irresponsive.

That's strange. Maybe I should try an AMD system myself. Btw the number of 
processes is an upper bound of the number of messages. This is just a 
simplification in the code.

> If you want more accurate results, try to modify your test
> programs: make them run for a couple of minutes (you decide how much
> time, the longer, the better) and kill all children processes. After
> that, use getrusage() (with RUSAGE_CHILDREN) or wait3(). That should
> give more accurate results.

I could do that, but my point is that kernel goes into the idle state even 
though there always should be a runable process. Your tests supports this.
I don't believe that more accuracy would help because it is quite clear that 
CPU is in the idle state.
 
> Hope that helps. If you want to make any other test, tell me.
> I'll try to help.

Thanx. Your tests actually confirms the first issue, which also is the one 
that I have been most concerned about. 

I hope that someone with knowledge of how this part of the kernel work can 
confirm that this is a problem with the kernel or explain why it is supposed 
to behave in this manor.

Hans Henrik Happe
