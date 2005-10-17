Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVJQUNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVJQUNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVJQUNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:13:08 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:28314 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751292AbVJQUNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:13:07 -0400
Date: Mon, 17 Oct 2005 22:13:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tim Bird <tim.bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051017201330.GB8590@elte.hu>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com> <Pine.LNX.4.61.0510172138210.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510172138210.1386@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > Maybe for a more experienced kernel person such as
> > yourself, this distinction make sense.  But
> > "process timer" and "kernel timer" don't carry much
> > semantic value for me.  They seem to convey an
> > arbitrary expectation of usage patterns.  Maybe
> > they match the current usage patterns in the kernel,
> > but I'd prefer naming based on functionality or
> > behaviour of the API.
> 
> Let's say you want to implement a watchdog timer for a driver, which 
> runs about every second to do something. Now if you have the choice 
> between "timer API" vs. "timeout API" and "kernel timer" vs. "process 
> timer", what would you choose based on the name?

why you insist on ktimers being 'process timers'? They are totally 
separate entities, not limited to any process notion. One of their first 
practical use happens to be POSIX process timers (both itimers and 
ptimers) via them, but no way are ktimers only 'process timers'. They 
are very generic timers, usable for any kernel purpose.

so to answer your question: it is totally possible for a watchdog 
mechanism to use ktimers. In fact it would be desirable from a 
robustness POV too: e.g. we dont want a watchdog from being 
overload-able via too many timeouts in the timer wheel ...

	Ingo
