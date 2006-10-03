Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWJCI4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWJCI4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 04:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWJCI4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 04:56:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32164 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932549AbWJCI4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 04:56:08 -0400
Date: Tue, 3 Oct 2006 10:47:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
Message-ID: <20061003084729.GA24961@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <20061002210053.16e5d23c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002210053.16e5d23c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
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


* Andrew Morton <akpm@osdl.org> wrote:

> These patches make my Vaio run really really slowly.  Maybe a quarter 
> of the normal speed or lower.  Bisection shows that the bug is 
> introduced by 
> clockevents-drivers-for-i386.patch+clockevents-drivers-for-i386-fix.patch
> 
> With all patches applied, the slowdown happens with 
> CONFIG_HIGH_RES_TIMERS=n and also with CONFIG_HIGH_RES_TIMERS=y && 
> CONFIG_NO_HZ=y.  So something got collaterally damaged.

yeah, i suspect it works again if you disable:

 CONFIG_X86_UP_APIC=y
 CONFIG_X86_UP_IOAPIC=y
 CONFIG_X86_LOCAL_APIC=y
 CONFIG_X86_IO_APIC=y

as the slowdown has the feeling of a runaway lapic timer irq.

from code review so far we can only see an udelay(10) difference in the 
initialization sequence of the PIT - we'll send a fix for that but i 
dont think that's the cause of the bug.

investigating it.

	Ingo
