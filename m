Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVCVJVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVCVJVI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVCVJVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:21:08 -0500
Received: from mx1.elte.hu ([157.181.1.137]:58787 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262582AbVCVJVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:21:02 -0500
Date: Tue, 22 Mar 2005 10:20:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050322092032.GA20240@elte.hu>
References: <20050322055327.GB1295@us.ibm.com> <Pine.OSF.4.05.10503220929500.5287-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10503220929500.5287-100000@da410.phys.au.dk>
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

> On the other hand with a rw-lock being unlimited - and thus do not
> keep track of it readers - the readers can't be boosted by the writer.
> Then you are back to square 1: The grace period can take a very long
> time.

btw., is the 'very long grace period' a real issue? We could avoid all
the RCU read-side locking latencies by making it truly unlocked and just
living with the long grace periods. Perhaps it's enough to add an
emergency mechanism to the OOM handler, which frees up all the 'blocked
by preemption' RCU callbacks via some scheduler magic. (e.g. such an
emergency mechanism could be _conditional_ locking on the read side -
i.e. new RCU read-side users would be blocked until the OOM situation
goes away, or something like that.)

your patch is implementing just that, correct? Would you mind redoing it
against a recent -RT base? (-40-04 or so)

also, what would be the worst-case workload causing long grace periods?

	Ingo
