Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161330AbWJ3Rya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161330AbWJ3Rya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161289AbWJ3Rya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:54:30 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36813 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161257AbWJ3Ry3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:54:29 -0500
Date: Mon, 30 Oct 2006 18:54:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Mark Lord <liml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Message-ID: <20061030175400.GA31581@elte.hu>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030175224.GB14055@kernel.dk>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <jens.axboe@oracle.com> wrote:

> > > things may be allocated from that path, so we pass gfp_mask around. I'll
> > > double check it tonight, but I don't currently see what could be wrong.
> > > Would lockdep complain about:
> > > 
> > >         spin_lock_irqsave(lock, flags);
> > >         ...
> > >         spin_unlock_irq(lock);
> > >         ...
> > >         spin_lock_irq(lock);
> > >         ...
> > >         spin_unlock_irqrestore(lock, flags);
> > 
> > this is fine for lockdep IF and only IF there is no "out lock" held
> > around this that requires irqs to be off. So if you do
> > 
> > spin_lock_irqsave(lock1, flags);
> > ...
> > spin_lock_irqsave(lock2, flags);
> > spin_unlock_irq(lock2)
> > ...
> > 
> > then lockdep WILL complain, and rightfully so, about a violation since
> > lock1 gets violated here ;)
> 
> Naturally, that is a bug fair and simple, nothing to do with lockdep.

well, finding such locking bugs is the main purpose of lockdep, so there 
is at least some connection i'd say ;-)

	Ingo
