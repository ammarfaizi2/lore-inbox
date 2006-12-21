Return-Path: <linux-kernel-owner+w=401wt.eu-S1423140AbWLVAAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423140AbWLVAAb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 19:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423163AbWLVAAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 19:00:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53532 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423140AbWLVAAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 19:00:30 -0500
Date: Fri, 22 Dec 2006 00:57:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] change WARN_ON back to "BUG: at ..."
Message-ID: <20061221235732.GA32637@elte.hu>
References: <20061221124327.GA17190@elte.hu> <458AD71D.2060508@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458AD71D.2060508@goop.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> What's the intent of WARN_ON?  Presumably its different from BUG_ON, 
> otherwise you could just use BUG_ON.  Or if not, why not just have 
> BUG_ON?  I think in practice many WARN_ONs are clearly not intended to 
> be as serious as BUG_ON: [...]

you are quite wrong. For example i cannot remember the last time i added 
a BUG_ON() to the core kernel, because a BUG_ON() in core code only 
makes it harder to get the log output back to the developer! Often the 
system is still alive enough to get the information out but crashing it 
via BUG_ON() hides the messages . So for example i exclusively use 
WARN_ON() in core kernel code.

> [...] they warn about unimplemented things, transient hiccups, 
> clarifications of errno returns, etc. [...]

Your claims defy reality: i just checked the 200+ WARN_ON()s that are in 
linux/*/*.c, and /none/ is a 'transient' failure or hickup or 
'clarification'. Each one i checked signals a real kernel bug that i'd 
not want a production system to have. Non-fatal messages should and do 
get a normal KERN_ printk.

an no, i dont want to do a large-scale rename in either direction. Let 
it be up to the developer whether he wants to crash the kernel upon 
seeing a bug or not. But one thing is sure: a WARN_ON() is a kernel bug 
just as much as a BUG_ON(), in 99% of the cases.

here's the history of these primitives: BUG() used to be the only 
primitive back in the days, then came BUG_ON() and iirc i was the one 
who added WARN_ON() years ago, as a mechanism to signal kernel bugs in a 
less destructive way. And that's how it's used in the kernel. If you 
disagree and still understand it to be different, that's really your 
problem i think ...

	Ingo
