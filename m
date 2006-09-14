Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWINWYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWINWYB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWINWYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:24:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:56285 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751096AbWINWYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:24:00 -0400
Date: Fri, 15 Sep 2006 00:15:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Daniel Walker <dwalker@mvista.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914221521.GA23371@elte.hu>
References: <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <Pine.LNX.4.64.0609142038570.6761@scrub.home> <20060914202452.GA9252@elte.hu> <Pine.LNX.4.64.0609142248360.6761@scrub.home> <1158268113.17467.38.camel@c-67-180-230-165.hsd1.ca.comcast.net> <Pine.LNX.4.64.0609142324181.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609142324181.6761@scrub.home>
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
> On Thu, 14 Sep 2006, Daniel Walker wrote:
> 
> > > Ingo, so far you have made not a single argument why they can't coexist 
> > > except for your personal dislike.
> > 
> > Not to put to fine a point on it, but I think there's not a small number
> > of us that "prefer" the best solution.
> 
> You can have it.
> OTOH I would also like to know what's going in my m68k kernel without 
> having to implement some rather complex infrastructure, which I don't 
> need otherwise. There hasn't been a single argument so far, why we 
> can't have both.

the argument is very simple: LTT creates strong coupling, it is almost a 
set of 350+ system-calls, moved into the heart of the kernel. Once moved 
in, it's very hard to remove it. "Why did you remove that trace 
information, you broke my LTT script!"

While with SystemTap the coupling is alot smaller. With dynamic tracing 
there's no _fundamental requirement_ for _any_ tracepoint to be in the 
source code, hence we have the present and future flexibility to 
eliminate most of them. So my point is: shape all the static tracepoints 
in a "provide data to dynamic tracers" way. If they are removed (which 
we should have the freedom to do), the removal is not a showstopper.

Flexibility of future choices, especially for user/developer-visible 
features, is one of the most important factors of kernel maintainance.

	Ingo
