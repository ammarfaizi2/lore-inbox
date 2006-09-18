Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWIRPvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWIRPvg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWIRPvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:51:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12768 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750911AbWIRPve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:51:34 -0400
Date: Mon, 18 Sep 2006 17:42:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mundt <lethal@linux-sh.org>,
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
Message-ID: <20060918154256.GA16448@elte.hu>
References: <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu> <1158594491.6069.125.camel@localhost.localdomain> <20060918154707.GJ3951@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918154707.GJ3951@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4949]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Frank Ch. Eigler <fche@redhat.com> wrote:

> > I think your implementation is questionable if it causes any kind of 
> > jumps and conditions, even marked unlikely. Just put the needed data 
> > in a seperate section which can be used by the debugging tools. 
> > [...] No need to actually mess with the code for the usual cases.
> 
> Trouble is that it is specifically the *unusual* cases that need 
> compiler assistance via static markers, otherwise we'd manage with 
> just k/djprobes & debuginfo type efforts.

i think it's all fine as long as it's just a single 5-byte NOP that we 
are inserting - because in the *usual* case the 'parameter access 
side-effects' should have no effect. They will have an effect in the 
*unusual* case though, but that's very much by design - and it's not a 
performance issue because it's 1) unusual, 2) at most means a bit 
different code organization by gcc. It very likely wont mean any extra 
branches even in the unusual case. Or do i underestimate the scope of 
the problem? ;-)

	Ingo
