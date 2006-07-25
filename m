Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWGYUtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWGYUtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWGYUtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:49:20 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38590 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751580AbWGYUtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:49:20 -0400
Date: Tue, 25 Jul 2006 22:43:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com
Subject: Re: + spinlock_debug-dont-recompute-jiffies_per_loop.patch added to -mm tree
Message-ID: <20060725204306.GA22547@elte.hu>
References: <200607251910.k6PJASfo006168@shell0.pdx.osdl.net> <20060725204228.GE13829@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725204228.GE13829@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Jones <davej@redhat.com> wrote:

>  > iteration limit, gets recomputed every time.  Caching it explicitly 
>  > prevents that.
> 
> What is the purpose of those __delays being there at all ? Seems odd 
> to be waiting that long when the spinlock could become available a lot 
> sooner.  (These also make spinlock debug really painful on boxes with 
> huge numbers of CPUs).

the debug code has to figure out when to trigger a deadlock warning 
message. If we are looping in a deadlock with irqs disabled on all CPUs, 
there's nothing that advances jiffies. The TSC is not reliable. The 
thing that remains is to use __delay(1). We could calibrate the loop 
separately perhaps?

	Ingo
