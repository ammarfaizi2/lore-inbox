Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVDEFee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVDEFee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 01:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDEFe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 01:34:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2016 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261483AbVDEFeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 01:34:21 -0400
Date: Tue, 5 Apr 2005 07:34:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
Message-ID: <20050405053410.GA18839@elte.hu>
References: <1112649296.5147.21.camel@localhost.localdomain> <Pine.OSF.4.05.10504050009080.8387-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10504050009080.8387-100000@da410.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > Now the question is, who will fix it? Preferably the maintainers, but I
> > don't know how much of a priority this is to them. I don't have the time
> > now to look at this and understand enough about the code to be able to
> > make a proper fix, and I'm sure you have other things to do too.
> 
> How about adding a
>  if(rt_task(current)) {
>         WARN_ON(1);
>         mutex_setprio(current, MAX_PRIO-1)
>  }
> ?
> 
> to find all calls to yields from rt-tasks. That will force the user 
> (aka the real-time developer) to either stop calling the subsystems 
> still using yield from his RT-tasks, or fix those subsystems.

i've added this to the -43-08 patch, so that we can see the scope of the 
problem. But any yield() use could become a problem due to priority 
inheritance. (which might eventually be expanded to userspace locking 
too)

	Ingo
