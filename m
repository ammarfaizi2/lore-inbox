Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWJRINm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWJRINm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWJRINm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:13:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:21425 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751442AbWJRINl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:13:41 -0400
Date: Wed, 18 Oct 2006 10:05:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: dwalker@mvista.com, Clark Williams <williams@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: hrtimers bug message on 2.6.18-rt4
Message-ID: <20061018080519.GA4235@elte.hu>
References: <45214EDC.6060706@redhat.com> <1159811130.5873.5.camel@localhost.localdomain> <1159921845.1979.9.camel@dwalker1.mvista.com> <1159922315.14866.2.camel@localhost> <20061018075654.GA1514@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018075654.GA1514@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * john stultz <johnstul@us.ibm.com> wrote:
> 
> > > With ltpstess . It has a settimeofday test which can trigger it. It 
> > > gets called with wild values.
> > 
> > Hmmm... That sounds like a false positive, where Ingo's time warp 
> > checking code isn't resetting on settimeofday() calls.
> 
> that's weird - clock_was_set() does call time_warp_clock_was_set().

found it: clock_was_set() is a NOP on !hres, so it doesnt call 
warp_check_clock_was_changed().

	Ingo
