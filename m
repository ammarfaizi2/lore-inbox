Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVCVK44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVCVK44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVCVK44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:56:56 -0500
Received: from mx1.elte.hu ([157.181.1.137]:947 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262623AbVCVK4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:56:54 -0500
Date: Tue, 22 Mar 2005 11:56:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050322105640.GA28861@elte.hu>
References: <20050318171929.GC30310@elte.hu> <Pine.OSF.4.05.10503181836520.5287-200000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10503181836520.5287-200000@da410.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> +static inline void rcu_read_lock(void)
> +{	
> +	preempt_disable(); 
> +	__get_cpu_var(rcu_data).active_readers++;
> +	preempt_enable();
> +}

this is buggy. Nothing guarantees that we'll do the rcu_read_unlock() on
the same CPU, and hence ->active_readers can get out of sync.

	Ingo
