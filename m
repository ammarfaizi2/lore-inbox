Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424645AbWKPVYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424645AbWKPVYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424641AbWKPVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:24:54 -0500
Received: from mail.timesys.com ([65.117.135.102]:50088 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1424639AbWKPVYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:24:53 -0500
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Stern <stern@rowland.harvard.edu>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <20061116132058.4c541bde.akpm@osdl.org>
References: <1163707250.10333.24.camel@localhost.localdomain>
	 <20061116201531.GA31469@elte.hu>  <20061116132058.4c541bde.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 22:27:36 +0100
Message-Id: <1163712457.10333.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 13:20 -0800, Andrew Morton wrote:
> >  
> > -core_initcall(cpufreq_tsc);
> > +/*
> > + * init_cpufreq_transition_notifier_list() should execute first,
> > + * which is a core_initcall, so mark this one core_initcall_sync:
> > + */
> > +core_initcall_sync(cpufreq_tsc);
> 
> Would prefer that we not use the _sync levels.  They're there as a
> synchronisation for MULTITHREAD_PROBE and might disappear at any time.

Works also fine with postcore_init, but I'm more concerned about the
delayed notification (after the actual change) which is introduced by
this srcu change.

	tglx


