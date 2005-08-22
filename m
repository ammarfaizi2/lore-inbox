Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbVHVWeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbVHVWeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbVHVWeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:34:20 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:46218 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751468AbVHVWeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:34:15 -0400
Date: Mon, 22 Aug 2005 09:41:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
Message-ID: <20050822074139.GA19323@elte.hu>
References: <20050818060126.GA13152@elte.hu> <1124495303.23647.579.camel@tglx.tec.linutronix.de> <20050822073833.GB19022@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822073833.GB19022@elte.hu>
User-Agent: Mutt/1.4.2.1i
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

> > Quite contrary it makes the system more snappy and the overall test 
> > latencies go down.
> 
> we can undo that flag - it's indeed only a couple of cycles worth of 
> optimization, which wont count for most workloads. I've applied your 
> patch, but we need to do those cleanups and the fact needs to be 
> documented that !MUTEX_IRQS_OFF is not safe anymore. (most likely this 
> means that the MUTEX_IRQS_OFF flag and all related changes needs to be 
> gotten rid of)

your patch gets rid of the flag, but not of all side-effects: e.g.  
trace_local_irq_enable(ti) only takes a 'ti' parameter for 
!MUTEX_IRQS_OFF - which does not exist anymore.

	Ingo
