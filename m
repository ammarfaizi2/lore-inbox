Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVCVKfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVCVKfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVCVKfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:35:20 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:38664 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262600AbVCVKfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:35:15 -0500
Date: Tue, 22 Mar 2005 02:34:49 -0800
To: Bill Huey <bhuey@lnxw.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050322103449.GA581@nietzsche.lynx.com>
References: <20050318160229.GC25485@elte.hu> <Pine.OSF.4.05.10503181750150.2466-100000@da410.phys.au.dk> <20050322100446.GA448@nietzsche.lynx.com> <20050322101727.GB448@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322101727.GB448@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 02:17:27AM -0800, Bill Huey wrote:
> > A notion of priority across a quiescience operation is crazy anyways[-,-] so
> > it would be safe just to use to the old rwlock-semaphore "in place" without
> > any changes or priorty handling add[i]tions. The RCU algorithm is only concerned
> > with what is basically a coarse data guard and it isn't time or priority
> > critical.
> 
> A little jitter in a quiescence operation isn't going to hurt things right ?. 

The only thing that I can think of that can go wrong here is what kind
of effect it would have on the thread write blocking against a bunch of
RCU readers. It could introduce a chain of delays into, say, a timer event
and might cause problems/side-effects for other things being processed.
RCU processing might have to decoupled processed by a different thread
to avoid some of that latency weirdness.

What do you folks think ?

bill

