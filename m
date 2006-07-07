Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWGGTkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWGGTkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWGGTkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:40:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15312 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750940AbWGGTkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:40:07 -0400
Subject: Re: auro deadlock
From: Arjan van de Ven <arjan@infradead.org>
To: David Miller <davem@davemloft.net>
Cc: davej@redhat.com, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060707.120936.98532669.davem@davemloft.net>
References: <20060707171916.GA16343@redhat.com>
	 <1152295989.3111.116.camel@laptopd505.fenrus.org>
	 <20060707.120936.98532669.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 21:39:55 +0200
Message-Id: <1152301195.3111.146.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 12:09 -0700, David Miller wrote:
> From: Arjan van de Ven <arjan@infradead.org>
> Date: Fri, 07 Jul 2006 20:13:09 +0200
> 
> > Now a question for netdev: what is the interrupt-or-softirq rules for
> > the sk_receive_queue.lock?
> > 
> > Anyway, the patch below fixes this deadlock; it may or may not be the
> > correct solution depending on the netdev answer, but the deadlock is
> > gone ;)
> 
> The lockdep fixes are starting to cause us to go in and start adding
> hard IRQ protection to many socket layer objects and I want this
> thinking to end quickly :)

that's why I asked the question ;)


> To reiterate, nothing socket or SKB level should be taking anything
> deeper than software IRQ locking.
> 
> If drivers manage local SKB queues in hard IRQ context, they need to
> use a seperate lockdep identifier for that queue's lock.

I'm not so sure that;s the case here, but.. if you have time today I
hope you can take a look at this one with a wider "network view" than I
can..


