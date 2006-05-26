Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWEZRjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWEZRjg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWEZRjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:39:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20879 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751204AbWEZRje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:39:34 -0400
Date: Fri, 26 May 2006 19:39:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mark Knecht <markknecht@gmail.com>,
       Clark Williams <williams@redhat.com>,
       Robert Crocombe <rwcrocombe@raytheon.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH -rt 2/2] Fix condition in default_idle
Message-ID: <20060526173937.GC30208@elte.hu>
References: <20060526160651.870725515@goodmis.org> <20060526161036.915977618@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526161036.915977618@goodmis.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> The condition statement in default_idle had the conjunctions 
> backwards. Instead of && it had || so the idle thread would never be 
> preempted.

> -	while (!need_resched() || !need_resched_delayed()) {
> +	while (!need_resched() && !need_resched_delayed()) {
>  		local_irq_disable();
> -		if (!need_resched() || !need_resched_delayed())
> +		if (!need_resched() && !need_resched_delayed())

doh! Good catch - applied.

	Ingo
