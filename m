Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWIRDaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWIRDaA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 23:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWIRDaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 23:30:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38629 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751289AbWIRD37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 23:29:59 -0400
Date: Mon, 18 Sep 2006 05:21:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918032120.GA13076@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918024343.GA23149@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918024343.GA23149@Krystal>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> * Ingo Molnar (mingo@elte.hu) wrote:
> > Karim, i dont usually reply if you insult me (and you've grown a habit 
> > of that lately ), but this one is almost parodic. To understand my 
> > point, please consider this simple example of a static in-source markup, 
> > to be used by a dynamic tracer:
> > 
> >   static int x;
> > 
> >   void func(int a)
> >   {
> >        ...
> >        MARK(event, a);
> >        ...
> >   }
> > 
> > if a dynamic tracer installs a probe into that MARK() spot, it will have 
> > access to 'a', but it can also have access to 'x'. While a static 
> > in-source markup for _static tracers_, if it also wanted to have the 'x' 
> > information, would also have to add 'x' as a parameter:
> > 
> > 	MARK(event, a, x);
> > 
> 
> Hi,
>
> If I may, if nothing marks the interest of the tracer in the "x" 
> variable, what happens when a kernel guru changes it for y (because it 
> looks a lot better). The code will not compile anymore when the markup 
> marks the interest for x, when your "dynamic tracer" markup will 
> simply fail to find the information. My point is that the markup of 
> the interesting variables should follow code changes, otherwise it 
> will have to be constantly updated elsewhere (hmm ? Documentation/ 
> someone ?)

yeah - but it shows (as you have now recognized it too) that even static 
markup for dynamic tracers _can_ be fundamentally different, just 
because dynamic tracers have access to information that static tracers 
dont.

(Karim still disputes it, and he is still wrong.)

> I would say that not marking a static variable just because it is less 
> visually intrusive is a not such a good thing to do. That's not 
> because we *can* that we *should*.

yeah. But obviously the (small but present) performance advantage is 
there too, so it shouldnt be rejected out of hand. If a parameter is not 
mentioned then it does not have to be prepared for function paramter 
passing, etc. So it's 1-2 instructions less. So if this is in some 
really stable area of code then it's a valid optimization.

	Ingo
