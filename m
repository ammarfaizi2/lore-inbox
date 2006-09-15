Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWIOMr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWIOMr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 08:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWIOMr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 08:47:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:61642 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751352AbWIOMr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 08:47:27 -0400
Date: Fri, 15 Sep 2006 14:38:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915123856.GA32076@elte.hu>
References: <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org> <20060914203430.GB9252@elte.hu> <4509C1D0.6080208@mbligh.org> <20060914213113.GA16989@elte.hu> <4509D6E6.5030409@mbligh.org> <20060914223607.GB25004@elte.hu> <4509DEC3.70806@mbligh.org> <20060914231956.GB29229@elte.hu> <4509FC15.6020407@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509FC15.6020407@mbligh.org>
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


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> >i.e. we should have macros to prepare local information, with macro 
> >arities of 2, 3, 4 and 5:
> >
> >    _(name, data1);
> >   __(name, data1, data2);
> >  ___(name, data1, data2, data3);
> > ____(name, data1, data2, data3, data4);
> 
> Personally I think that's way more visually offensive that something 
> that looks like a function call, but still ;-) We do it as a caps 
> macro
> 
> KTRACE(foo, bar)
> 
> internally, which I suppose makes it not look like a function call. 
> But at the end of the day, it's all just a matter of visual taste, 
> what's actually in there is way more important.

i disagree with the naming, for the reasons stated before: if we add any 
static info to the kernel, it's a "easier data extraction" thing (for 
the purposes of speeding up dynamic tracing), not a tracepoint. That way 
there's no dispute whether what i remove is a tracepoint (on which 
static tracers might rely in a hard way), or just a speedup for 
SystemTap. So a better name would be what SystemTap has implemented 
today:

  STAP_MARK_NN(kernel_context_switch, prev, next);

or what makes this even more explicit:

  DEBUG_DATA(kernel_context_switch, prev, next);

(but i'm flexible about the naming - as long as it doesnt say 'trace' 
and as long as there are no guarantees at all that those points remain, 
when a better method of accessing the same data for dynamic tracers is 
implemented.)

	Ingo
