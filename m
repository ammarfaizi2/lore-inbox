Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWISPkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWISPkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWISPkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:40:06 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:40933 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751507AbWISPkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:40:03 -0400
Date: Tue, 19 Sep 2006 17:31:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919153107.GA16414@elte.hu>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451008AC.6030006@google.com>
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


* Martin J. Bligh <mbligh@google.com> wrote:

> You know ... it strikes me that there's another way to do this, that's 
> zero overhead when not enabled, and gets rid of the inflexibility in 
> kprobes. It might not work well in all cases, but at least for simple 
> non-inlined functions, it'd seem to.
> 
> Why don't we just copy the whole damned function somewhere else, and 
> make an instrumented copy (as a kernel module)? Then reroute all the 
> function calls through it, instead of the original version. OK, it's 
> not completely trivial to do, but simpler than kprobes (probably doing 
> the switchover atomically is the hard part, but not impossible). 
> There's NO overhead when not using, and much lower than probes when 
> you are.
> 
> That way we can do whatever the hell we please with internal 
> variables, however GCC optimises it, can write flexible instrumenting 
> code to just about anything, program in C as God intended, etc, etc. 
> No, it probably won't fix every case under the sun, but hopefully most 
> of them, and we can still use kprobes/djprobes/bodilyprobes for the 
> rest of the cases.

yeah, this would be nice - if it werent it for function pointers, and if 
all kernel functions were relocatable. But if you can think of a method 
to do this, it would be nice.

	Ingo
