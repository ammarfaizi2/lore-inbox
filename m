Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWEaWAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWEaWAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWEaWAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:00:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:30156 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965193AbWEaWAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:00:36 -0400
Date: Thu, 1 Jun 2006 00:00:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c disable_irq()
Message-ID: <20060531220055.GD4059@elte.hu>
References: <20060531200236.GA31619@elte.hu> <1149107500.3114.75.camel@laptopd505.fenrus.org> <20060531214139.GA8196@devserv.devel.redhat.com> <1149111838.3114.87.camel@laptopd505.fenrus.org> <20060531214729.GA4059@elte.hu> <1149112582.3114.91.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149112582.3114.91.camel@laptopd505.fenrus.org>
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


* Arjan van de Ven <arjan@infradead.org> wrote:

> > couldnt most of these problems be avoided by tracking whether a handler 
> > _ever_ returned a success status? That means that irqpoll could safely 
> > poll handlers for which we know that they somehow arent yet matched up 
> > to any IRQ line?
> 
> I suspect the real solution is to have a
> 
> disable_irq_handler(irq, handler) 
> 
> function which does 2 things
> 1) disable the irq at the hardware level
> 2) mark the handler as "don't call me"
> 
> it matches the semantics here; what these drivers want is 1) not get 
> an irq handler called and 2) not get an irq flood

ok, this would work. But there is a practical problem: only in drivers/* 
there's 310 disable_irq() calls - each would have to be changed to 
disable_irq_handler() [and i dont see any good way to automate that 
conversion] ...

	Ingo
