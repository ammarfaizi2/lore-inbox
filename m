Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267477AbTAXBzR>; Thu, 23 Jan 2003 20:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267479AbTAXBzQ>; Thu, 23 Jan 2003 20:55:16 -0500
Received: from fmr04.intel.com ([143.183.121.6]:41438 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267477AbTAXBzP>; Thu, 23 Jan 2003 20:55:15 -0500
Message-Id: <200301240204.h0O24Kr04239@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Austin Gonyou <austin@coremetrics.com>, linux-kernel@vger.kernel.org
Subject: Re: Using O(1) scheduler with 600 processes.
Date: Thu, 23 Jan 2003 18:05:59 -0800
X-Mailer: KMail [version 1.3.1]
References: <1043367029.28748.130.camel@UberGeek>
In-Reply-To: <1043367029.28748.130.camel@UberGeek>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should definitely give it a try.

However; boosts in Oracle throughput by going to the O(1) scheduler may end 
up being dependent on your I/O setup.

I was helping out with a TPCC benchmark effort last fall for Itanium Oracle 
through put on Red Hat AS.  For the longest time the guys with the big iron 
hardware would not move to the newer kernels with the O(1) scheduler.  They 
had a silly rule of only accepting changes that improved TPCC throughput.  
(oh, this work was on 4-way Itanium 2's with 32Gig of ram, and a large number 
of clarion fiber channel disk array towers)

Anyway, for the longest time the old 2.4.18 kernel with the 4/10/04 ia-64 
patch was 10% better than the a kernel with O(1) scheduler.  I never quite 
figured out what the problem was.  I think the difference was in the way 
Oracle likes to be on a Round Robbin scheduler, and the O(1) scheduler tended 
to get unlucky more often than the old scheduler, for those drive arrays.

However; when we updated the clarion towers to have more drives and to 18K 
RPM drives from the 15K drives, all of a sudden the O(1) scheduler beat the 
the old scheduler.

Your milage will vary.

Give it a try.

--mgross



On Thursday 23 January 2003 04:10 pm, Austin Gonyou wrote:
> I've heard some say that O(1) sched can only really help on systems with
> lots and lots of processes.
>
> But my systems run about 600 processes max, but are P4 Xeons with HT,
> and we kick off several hundred processes sometimes. (sleeping to
> running then back) based on things happening in the system.
>
> I am possibly going to forgo putting O(1)sched in production *right now*
> until I've got my patch solid. But I got to thinking, do I need it at
> all on a Oracle VLDB?
>
> I think yes, but I wanted to get some opinions/facts before making that
> choice to go without O(1) sched.
