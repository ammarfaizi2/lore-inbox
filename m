Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVCVKSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVCVKSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVCVKSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:18:05 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:2312 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262610AbVCVKR5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:17:57 -0500
Date: Tue, 22 Mar 2005 02:17:27 -0800
To: Bill Huey <bhuey@lnxw.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050322101727.GB448@nietzsche.lynx.com>
References: <20050318160229.GC25485@elte.hu> <Pine.OSF.4.05.10503181750150.2466-100000@da410.phys.au.dk> <20050322100446.GA448@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322100446.GA448@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 02:04:46AM -0800, Bill Huey wrote:
> RCU isn't write deterministic like typical RT apps are[, so] we can... (below :-))
... 
> Just came up with an idea after I thought about how much of a bitch it
> would be to get a fast RCU multipule reader semantic (our current shared-
> exclusive lock inserts owners into a sorted priority list per-thread which
> makes it very expensive for a simple RCU case[,] since they are typically very
> small batches of items being altered). Basically the RCU algorithm has *no*
> notion of writer priority and to propagate a PI operation down all reader[s]
> is meaningless, so why not revert back to the original rwlock-semaphore to
> get the multipule reader semantics ?

The original lock, for those that don't know, doesn't strictly track read owners
so reentrancy is cheap.

> A notion of priority across a quiescience operation is crazy anyways[-,-] so
> it would be safe just to use to the old rwlock-semaphore "in place" without
> any changes or priorty handling add[i]tions. The RCU algorithm is only concerned
> with what is basically a coarse data guard and it isn't time or priority
> critical.

A little jitter in a quiescence operation isn't going to hurt things right ?. 

> What do you folks think ? That would make Paul's stuff respect multipule
> readers which reduces contention and gets around the problem of possibly
> overloading the current rt lock implementation that we've been bitching
> about. The current RCU development track seem wrong in the first place and
> this seem like it could be a better and more complete solution to the problem.

Got to get rid of those typos :)

bill

