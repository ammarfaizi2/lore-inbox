Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVFFH6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVFFH6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 03:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVFFH6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 03:58:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29655 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261199AbVFFH55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 03:57:57 -0400
Date: Mon, 6 Jun 2005 09:57:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, plist fixes
Message-ID: <20050606075728.GA13088@elte.hu>
References: <F989B1573A3A644BAB3920FBECA4D25A037001B3@orsmsx407>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A037001B3@orsmsx407>
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


* Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:

> >From: Ingo Molnar [mailto:mingo@elte.hu]
> >
> >so the question is - can we have an extreme (larger than 140) number of
> >RT tasks? If yes, why are they all RT - they can have no expectation of
> >good latencies with a possible load factor of 140!
> 
> In practice, didn't we want most tasks to behave like RT? (for 
> interactivity purposes) -- I recall hearing that's basically what good 
> interactivity meant; short reponse times to events.

that's not what the current code does (and it's not what the non-plist 
code did either). We dont do PI handling for non-RT tasks. They 
basically have no RT expectations at all, and including them in the PI 
mechanism would only slow them down, and would increase the latencies of 
the RT tasks as well.

But indeed it could improve interactivity (but this has not been proven 
yet) - and also for testing purposes it would sure be useful, so we 
should perhaps make ALL_TASKS_PI default-on, as Daniel suggests. If that 
is done then plists are indeed a superior solution. But if in the end we 
decide to only include RT tasks in the PI mechanism (which could easily 
happen) then there seems to be little practical difference between 
sorted lists and plists.

	Ingo
