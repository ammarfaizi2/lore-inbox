Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVIOLh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVIOLh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVIOLh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:37:26 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:33419 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751034AbVIOLh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:37:26 -0400
Date: Thu, 15 Sep 2005 13:37:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.13-rt6, ktimer subsystem
Message-ID: <20050915113753.GA25219@elte.hu>
References: <20050913100040.GA13103@elte.hu> <1126641589.13893.52.camel@mindpipe> <20050913201004.GA32608@elte.hu> <1126643809.13893.64.camel@mindpipe> <20050915075556.GA14567@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915075556.GA14567@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > it wont even build right now, due to the ktimer changes. I'll fix x64 up 
> > > once things have settled down a bit. (but if someone does patches i'll 
> > > sure apply them)
> > 
> > The problem apparently affected 2.6.13-rt4 too.  The users reported 
> > that it built OK (as long as realtime preemption is enabled) but then 
> > reboots as soon as grub loads the kernel.
> > 
> > Can this be worked around by disabling CONFIG_HIGH_RES_TIMERS?
> 
> on x64 HIGH_RES_TIMERS is disabled by default (no lowlevel support 
> code integrated yet). Where did the problems start, rt4? (i.e. rt3 
> works fine?)

ok, fixed a couple of bugs on x64, it boots on my box now. The main 
breakage was the elimination of the preemption-disabling soft irq flag 
in -53-05, that unearthed an irq-flags 32-bitness bug in the spinlock 
macros, which was there for ages. This resulted in the early reboot 
during bootup.

I've uploaded 2.6.13-rt12 with the fixes.

	Ingo
