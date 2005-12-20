Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVLTEZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVLTEZX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 23:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVLTEZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 23:25:23 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:59784 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750783AbVLTEZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 23:25:22 -0500
Date: Tue, 20 Dec 2005 05:24:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: 2.6.14-rt22 (and mainline) excessive latency
Message-ID: <20051220042442.GA32039@elte.hu>
References: <1135039244.28649.41.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135039244.28649.41.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> I captured this 3+ ms latency trace when killing a process with a few 
> thousand threads.  Can a cond_resched be added to this code path?

>     bash-17992 0.n.1   29us : eligible_child (do_wait)
> 
>     [ 3000+ of these deleted ]
> 
>     bash-17992 0.n.1 3296us : eligible_child (do_wait)

Atomicity of signal delivery is pretty much a must, so i'm not sure this 
particular latency can be fixed, short of running PREEMPT_RT. Paul E.  
McKenney is doing some excellent stuff by RCU-ifying the task lookup and 
signal code, but i'm not sure whether it could cover do_wait().

	Ingo
