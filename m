Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWFFVvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWFFVvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWFFVvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:51:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:51087 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751169AbWFFVvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:51:14 -0400
Date: Tue, 6 Jun 2006 23:50:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] misroute-irq: Don't call desc->chip->end because of edge interrupts
Message-ID: <20060606215034.GA19419@elte.hu>
References: <1149426961.27696.7.camel@localhost.localdomain> <1149437412.23209.3.camel@localhost.localdomain> <1149438131.29652.5.camel@localhost.localdomain> <1149456375.23209.13.camel@localhost.localdomain> <1149456532.29652.29.camel@localhost.localdomain> <20060604214448.GA6602@elte.hu> <1149564830.16247.11.camel@localhost.localdomain> <20060606080156.GA427@elte.hu> <1149591019.16247.35.camel@localhost.localdomain> <20060606144823.1de58b9c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606144823.1de58b9c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 06 Jun 2006 06:50:19 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 2006-06-06 at 10:01 +0200, Ingo Molnar wrote:
> > > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > Hit the following BUG with irqpoll.  The below patch fixes it.
> > > 
> > > > -		if (work)
> > > > +		if (work && disc->chip && desc->chip->end)
> > > >  			desc->chip->end(i);
> > > 
> 
> Why is this change necessary?  2.6.17-rc6 doesn't have it, and it 
> doesn't oops.  So somebody changed something.  What?  Why?  Was it 
> intentional?  Was it correct?

that's due to the irqchips change on x86 and x86_64. So it's not 
something in -rc6 or some other unknown effect.

	Ingo
