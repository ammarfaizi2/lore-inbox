Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVCRJxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVCRJxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVCRJxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:53:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3489 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261482AbVCRJxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:53:40 -0500
Date: Fri, 18 Mar 2005 10:53:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318095327.GA15190@elte.hu>
References: <20050318002026.GA2693@us.ibm.com> <20050318091303.GB9188@elte.hu> <20050318092816.GA12032@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318092816.GA12032@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> there's one detail on PREEMPT_RT though (which i think you noticed too). 
> 
> Priority inheritance handling can be done in a pretty straightforward
> way as long as no true read-side nesting is allowed for rwsems and
> rwlocks - i.e. there's only one owner of a lock at a time. So
> PREEMPT_RT restricts rwsem and rwlock concurrency: readers are
> writers, with the only exception that they are allowed to 'self-nest'.
> [...]

this does not affect read-side RCU, because read-side RCU can never
block a higher-prio thread. (as long as callback processing is pushed
into a separate kernel thread.)

so RCU will be pretty much the only mechanism (besides lock-free code)
that allows reader concurrency on PREEMPT_RT.

	Ingo
