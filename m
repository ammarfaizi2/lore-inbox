Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWIOUOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWIOUOM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbWIOUOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:14:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32461 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751676AbWIOUOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:14:10 -0400
Date: Fri, 15 Sep 2006 22:05:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915200559.GB30459@elte.hu>
References: <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609152111030.6761@scrub.home>
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


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Fri, 15 Sep 2006, Ingo Molnar wrote:
> 
> > > What Karim is sharing with us here (yet again) is the real in-field 
> > > experience of real users (ie: not kernel developers).
> > 
> > well, Jes has that experience and Thomas too.
> > 
> > > I mean, on one hand we have people explaining what they think a 
> > > tracing facility should and shouldn't do, and on the other hand we 
> > > have a guy who has been maintaining and shipping exactly that thing to 
> > > (paying!) customers for many years.
> > 
> > so does Thomas and Jes. So what's the point?
> 
> That only Karim's experience is being in question here?

i think you misunderstood, please read the paragraphs above. They 
suggest that there's "real in-field experience of real users" against 
"people explaining what they think a tracing facility should and 
shouldn't do". I only pointed out that those people (Thomas, Jes) dont 
just randomly express their opinion but have actual in-field experience 
too (of paying customers), about the very topic at hand.

> > i judge LTT by its current code quality, not by its proponents shouting 
> > volume - and that quality is still quite poor at the moment. (and then 
> > there are the conceptual problems too, outlined numerous times) I have 
> > quoted specific example(s) for that in this thread. Furthermore, LTT 
> > does this:
> > 
> >  246 files changed, 26207 insertions(+), 71 deletions(-)
> > 
> > and this gives me the shivers, for all the reasons i outlined.
> 
> Well, I'm first to admit that LTT needs improvement, but that has 
> never been the point.

that might not be your point, but that very much is my point. I do claim 
that LTT's problems arise out of its fundamental mistake on the kernel 
side: that it is a static tracer that tries to be too many things to too 
many people. SystemTap is available here and today on an unmodified 
upstream kernel. LTT has been in this shape for the past ~8 years. But 
if you wish you can certainly prove me wrong via for example cleaning up 
and shrinking LTT down to a size and impact that is not scary anymore, 
with the same functionality, and the clear future path for the removal 
of its dependencies. I tried to argue that in the abstract, but please 
by all means feel free to prove me wrong. (or argue against my specific 
points)

> We need to get to some kind of agreement what level of tracing Linux 
> should support in general, preferably something that is easy to 
> integrate and usable by everyone. Especially the latter means that 
> there is not one true solution, [...]

sorry, but i disagree. There _is_ a solution that is superior in every 
aspect: kprobes + SystemTap. (or any other equivalent dynamic tracer)

> At this point you've been rather uncompromising [...]

yes, i'm rather uncompromising when i sense attempts to push inferior 
concepts into the core kernel _when_ a better concept exists here and 
today. Especially if the concept being pushed adds more than 350 
tracepoints that expose something to user-space that amounts to a 
complex external API, which tracepoints we have little chance of ever 
getting rid of under a static tracing concept.

i'm also looking at it this way too: you already seem to be quite 
reluctant to add kprobes to your architecture today. How reluctant would 
you be tomorrow if you had static tracepoints, which would remove a fair 
chunk of incentive to implement kprobes?

	Ingo
