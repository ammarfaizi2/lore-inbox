Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVCRQBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVCRQBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVCRQAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:00:01 -0500
Received: from mx1.elte.hu ([157.181.1.137]:55698 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261665AbVCRP7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:59:10 -0500
Date: Fri, 18 Mar 2005 16:58:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Bill Huey <bhuey@lnxw.com>, dipankar@in.ibm.com, shemminger@osdl.org,
       akpm@osdl.org, torvalds@osdl.org, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, manfred@colorfullife.com, gh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318155844.GB25485@elte.hu>
References: <20050318002026.GA2693@us.ibm.com> <20050318125641.GA5107@nietzsche.lynx.com> <20050318155418.GC1299@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318155418.GC1299@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> > > 		preempt_disable();
> > > 		if (current->rcu_read_lock_nesting++ == 0) {
> > > 			current->rcu_read_lock_ptr =
> > > 				&__get_cpu_var(rcu_data).lock;
> > > 			read_lock(current->rcu_read_lock_ptr);
> > > 		}
> > > 		preempt_enable();

> My current thought is that the preempt_disable()/preempt_enable() can
> be dropped entirely.  Messes up any tool that browses through
> ->rcu_read_lock_nesting, but don't see any other problem.  Yet,
> anyway!

yeah - this sounds good. (We are not aiming for irq-safe RCU anyway, on
PREEMPT_RT.)

	Ingo
