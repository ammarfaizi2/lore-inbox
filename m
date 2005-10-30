Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVJ3RRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVJ3RRp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 12:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVJ3RRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 12:17:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49806 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932196AbVJ3RRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 12:17:44 -0500
Date: Sun, 30 Oct 2005 18:17:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.14-rt1
Message-ID: <20051030171736.GA17262@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu> <20051030133316.GA11225@elte.hu> <4364DFA5.3000109@cybsft.com> <Pine.LNX.4.58.0510301037520.2819@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510301037520.2819@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > >  - tracing fix (reported by Florian Schmidt)
> > >
> > >  - rtc histogram fixes (K.R. Foley)
> >
> > Actually it doesn't look like these made it into the patch. :)
> 
> Yeah, I noticed that there isn't even a check anymore in 
> get_monotonic_clock_ts for time warping backwards.  I guess John's new 
> updates and Ingo's "smarter" code makes it unnecessary ;-)

well, the nsec_offset check was bogus (since it was relative to the last 
tick) - but still your fundamental fix for disabling interrupts is 
present, via the tsc_lock. I have moved the remaining checks to 
__get_nsec_offset(), so they are still there.

	Ingo
