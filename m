Return-Path: <linux-kernel-owner+w=401wt.eu-S964992AbWL1JTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWL1JTA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWL1JTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:19:00 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48817 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964992AbWL1JS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:18:59 -0500
Date: Thu, 28 Dec 2006 10:15:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] change WARN_ON back to "BUG: at ..."
Message-ID: <20061228091548.GA24765@elte.hu>
References: <20061221124327.GA17190@elte.hu> <458AD71D.2060508@goop.org> <20061221235732.GA32637@elte.hu> <20061222120422.eb28953b.akpm@osdl.org> <20061224141625.GA4071@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061224141625.GA4071@ucw.cz>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > But lots of people have now written downstream log-parsing tools 
> > which might break due to this change, so I'm inclined to go with 
> > Ingo's patch, and restore the old (il)logic.
> 
> People should not be parsing syslog. If they do, they deserve 
> occassional breakage.

so what other method do you propose to those who are working on 
increasing the reliability of the kernel by running automatic regression 
tests and boot allyesconfig kernels, to figure out whether out of the 
tons of kernel logs there was any problem? Right now "^BUG: " is a 
pretty universal filter, and i dont see a problem in preserving that.

(for lockdep there's a 'debug_locks' line in /proc/lockdep_stats that 
tells us whether any lock related assert was printed by the kernel, and 
my scripts monitor that. Along that line we could introduce a 
/proc/sys/kernel/bugs counter for tools to monitor. But even after that, 
you have to find the place in the syslog so having a text signature for 
kernel bugs is still a good idea.)

	Ingo
