Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVFLVPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFLVPv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 17:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFLVPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 17:15:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10127 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261231AbVFLVPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 17:15:45 -0400
Date: Sun, 12 Jun 2005 22:59:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050612205902.GA31928@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu> <42AB662B.4010104@opersys.com> <20050612061108.GA4554@elte.hu> <42AC8D00.4030809@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AC8D00.4030809@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> Ingo Molnar wrote:
> > ok, this method should work fine. I suspect you increased the parport 
> > IRQ's priority to the maximum on the PREEMPT_RT kernel, correct? Was 
> > there any userspace thread on the target system (receiving the parport 
> > request and sending the reply), or was it all done in a kernelspace 
> > parport driver?
> 
> This is all done in kernelspace. I'll check with Kristian for the 
> rest. In the mean time, let me know if you have any recommendations 
> based on the fact that it's indeed in the kernel.

if you want to measure hw-interrupt delays then under PREEMPT_RT you'll 
need to use an SA_NODELAY interrupt handler. (which is a PREEMPT_RT 
specific flag) If you use normal request_irq() or some parport driver 
then the driver function will run in an interrupt thread and what you 
are measuring is not interrupt latency but rescheduling latency.

	Ingo
