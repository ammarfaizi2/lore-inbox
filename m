Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUIHNFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUIHNFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUIHNCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:02:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33772 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267238AbUIHNAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:00:07 -0400
Date: Wed, 8 Sep 2004 15:01:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-smp.patch, 2.6.9-rc1-bk14
Message-ID: <20040908130136.GB20132@elte.hu>
References: <20040908111751.GA11507@elte.hu> <Pine.LNX.4.53.0409080814570.15087@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409080814570.15087@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> > In addition to the preemption latency problems, the _irq() variants in
> > the above list didnt do any IRQ-enabling while spinning - possibly
> > resulting in excessive irqs-off sections of code!
> 
> I had a patch for this
> http://www.ussg.iu.edu/hypermail/linux/kernel/0405.3/0578.html and it
> has been running for about 3 months now on a heavily used 4 processor
> box.  It's all a matter of whether Andrew is feeling brave ;)

at a quick glance your patch doesnt seem to cover the following locking
primitives: read_lock_irqsave(), read_lock_irq(), write_lock_irqsave,
write_lock_irq(). Also, i think your 2.6.6 patch doesnt apply anymore
because it clashes with your very nice out-of-line spinlocks patch that
went into -BK recently ;)

anyway, the preempt-smp.patch is a complete and systematic solution that
has been tested, measured and traced quite heavily.

	Ingo
