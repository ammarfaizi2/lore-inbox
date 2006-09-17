Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWIQIum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWIQIum (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 04:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWIQIum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 04:50:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54762 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932312AbWIQIuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 04:50:40 -0400
Date: Sun, 17 Sep 2006 10:42:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060917084207.GA8738@elte.hu>
References: <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609170310580.6761@scrub.home>
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

> > On the other side there is the main kernel, which, if it ever 
> > accepted static tracepoints, could probably never get rid of them.
> 
> If they are useful and not hurting anyone, why should we?

FYI, whether it is true that "they not hurting anyone" is one of those 
"secondary issues" that I analyzed in great detail in the emails 
yesterday, and which you opted not to "further dvelve into":

   Message-ID: <20060916082347.GG6317@elte.hu>:

    ' That is a constant kernel maintainance drag that i feel 
      uncomfortable about. '

   Message-ID: <20060916082107.GB6317@elte.hu>:

    'That's far from "virtually no maintainance overhead".'

   Message-ID: <20060916082054.GA6317@elte.hu>:

    'static tracepoints are a maintainance problem: once added _they can 
     not be removed without breaking static tracers_.'

I still very much opine that your claim that static tracepoints are not 
hurting anyone is false: they can cause significant maintainance 
overhead in the long run that we cannot remove, and these costs 
integrate over a long period of time.

We have statements from two people who have /used and hacked/ LTT in 
products and have seen LTT's use, indicating that the maintainance 
overhead is nonzero and that the combined number of tracepoints in use 
by actual customers is much larger than posited in this thread. We also 
have LTT proponents disputing that and suggesting that the long-term 
maintainance overhead is very low. So even taking my opinion out of the 
picture, the picture is far from clear. If we put my opinion back into 
the picture: i base it on my first-hand experience with tracers. [**]

so at least to me the rule in such a situation is clear: if we have the 
choice between two approaches that are useful in similar ways [*] but 
one has a larger flexibility to decrease the total maintainance cost, 
then we _must_ pick that one.

This really isnt rocket science, we do such decisions every day. We did 
that decision for STREAMS too. (which STREAMS argument you ignored for a 
number of times.) STREAMS was a similar situation: people wanted "just a 
few unintrusive hooks which you could compile out" for external STREAMS 
functionality to hook into.

and unlike STREAMS, in the LTT case it's not the totality of the project 
that is being disputed: i only dispute the static tracing aspect of it, 
which is a comparatively small (but intrusive) portion of a project that 
consists of a 26,000 lines kernel patchset and a large body of userspace 
tools.

	Ingo

[*] furthermore, dynamic tracing is not only "similarly useful", it is
    _more useful_ because it allows alot more than static tracing does. 
    That's why i analyzed the "secondary issue" of the usefulness of 
    dynamic tracers: the decision gets easier if one of the technologies 
    is fundamentally more capable.

[**] Also, just yesterday i tried to merge the 2.6.17 version of the LTT 
     patchset to 2.6.18, and it created non-trivial rejects left and 
     right. That is a further objective indicator to me - if something 
     has low maintainance cost, how come its patchset is so intrusive 
     that it cannot survive 3 months of kernel development flux? If it's 
     intrusive, shouldnt we have the fundamental option to shift that 
     maintainance overhead out of the core kernel, back to the people 
     that want those features?
