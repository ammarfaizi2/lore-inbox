Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVCRIpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVCRIpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVCRIpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:45:41 -0500
Received: from mx1.elte.hu ([157.181.1.137]:51132 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261499AbVCRIpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:45:32 -0500
Date: Fri, 18 Mar 2005 09:44:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318084445.GA8475@elte.hu>
References: <20050318002026.GA2693@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318002026.GA2693@us.ibm.com>
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

> 	[I believe that the real-time preemption patch moves code
> 	from softirq/interrupt to process context, but could easily be
> 	missing something.  If need be, there are ways of handling cases
> 	were realtime RCU is called from softirq and interrupt contexts,
> 	for an example approach, see the Quick Quiz answers.]

correct, on PREEMPT_RT, IRQ processing is (and must be) in process
context.

(it's pretty much a must-have thing to enable the preemption of irq
handlers and softirq processing: if irq/softirq contexts nested on the
kernel stack then irq contexts would 'pin down' the process context that
was interrupted, so even if irq preemption was possible, the underlying
process context couldnt be freely scheduled.)

still, it's nice that your #5 design does not rely on it - it's a sign
of fundamental robustness, plus we could (in theory) offer preemptable
RCU on PREEMPT_DESKTOP (== current PREEMPT) as well - just like there is
PREEMPT_BKL.

	Ingo
