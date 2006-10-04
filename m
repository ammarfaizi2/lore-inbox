Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030818AbWJDLCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030818AbWJDLCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030821AbWJDLCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:02:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57756 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030818AbWJDLCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:02:10 -0400
Date: Wed, 4 Oct 2006 12:53:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] clockevents: drivers for i386, fix #2
Message-ID: <20061004105315.GA24940@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <20061002210053.16e5d23c.akpm@osdl.org> <20061003084729.GA24961@elte.hu> <20061003103503.GA6350@elte.hu> <20061003203620.d85df9c6.akpm@osdl.org> <20061004064620.GA22364@elte.hu> <20061004003228.98ec3b39.akpm@osdl.org> <20061004075540.GA31415@elte.hu> <20061004011544.d49308de.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004011544.d49308de.akpm@osdl.org>
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

> > hm, do you have the NMI watchdog enabled by any chance? [in 
> > particular, do you have nmi_watchdog=2?] Although your bootlog does 
> > not show it.
> > 
> 
> There's no nmi_watchdog setting in the kernel boot command line and 
> the NMI counter isn't incrementing.

there's one material difference we just found: in the !hres case we'll 
do the timer IRQ handling mostly from the lapic vector - while in 
mainline we do it from the irq0 vector. So, how does your 
/proc/interrupts look like? How frequently does LOC increase, and how 
frequently does IRQ 0 increase?

(meanwhile we'll fix and restore things so that it matches mainline 
behavior.)

	Ingo
