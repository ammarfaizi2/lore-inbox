Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWFFICz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWFFICz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 04:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWFFICz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 04:02:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58022 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751141AbWFFICy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 04:02:54 -0400
Date: Tue, 6 Jun 2006 10:01:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] misroute-irq: Don't call desc->chip->end because of edge interrupts
Message-ID: <20060606080156.GA427@elte.hu>
References: <20060603215323.GA13077@devserv.devel.redhat.com> <1149374090.14408.4.camel@localhost.localdomain> <1149413649.3109.92.camel@laptopd505.fenrus.org> <1149426961.27696.7.camel@localhost.localdomain> <1149437412.23209.3.camel@localhost.localdomain> <1149438131.29652.5.camel@localhost.localdomain> <1149456375.23209.13.camel@localhost.localdomain> <1149456532.29652.29.camel@localhost.localdomain> <20060604214448.GA6602@elte.hu> <1149564830.16247.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149564830.16247.11.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hit the following BUG with irqpoll.  The below patch fixes it.

> -		if (work)
> +		if (work && disc->chip && desc->chip->end)
>  			desc->chip->end(i);

typo - plus shouldnt this call ->eoi() as well if available?

	Ingo
