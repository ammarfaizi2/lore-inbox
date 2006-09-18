Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWIRQXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWIRQXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWIRQXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:23:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20096 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751824AbWIRQXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:23:52 -0400
Date: Mon, 18 Sep 2006 18:15:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918161511.GA21204@elte.hu>
References: <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu> <1158594491.6069.125.camel@localhost.localdomain> <20060918152230.GA12631@elte.hu> <1158596341.6069.130.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158596341.6069.130.camel@localhost.localdomain>
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


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Llu, 2006-09-18 am 17:22 +0200, ysgrifennodd Ingo Molnar:
> > yeah - but i think to make it easier for SystemTap to insert a 
> > low-overhead probe there needs to be a 5-byte NOP inserted. There wont 
> > be any function call or condition at that place. At most there will be 
> > some minimal impact on the way gcc compiles the code in that function,
> 
> And more L1 misses. It seems that this problem should be solved by 
> jprobes and your int3 optimisation work.

Do you consider a single 5-byte NOP for a judiciously chosen 50 places 
in the kernel unacceptable? Note that the argument has shifted from 
static tracers to dynamic tracers: this _is_ about SystemTap: it adds 
points to the kernel where we can _guarantee_ that a dynamic probe can 
be inserted. In general there is no guarantee from gcc that any probe 
can be inserted into a function (djprobes and int3 optimization 
nonwithstanding) and this is a real practical problem for SystemTap. 
Frank can attest to that.

	Ingo
