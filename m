Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933017AbWFWLGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017AbWFWLGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933031AbWFWLGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:06:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:203 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933017AbWFWLGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:06:17 -0400
Date: Fri, 23 Jun 2006 13:01:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 61/61] lock validator: enable lock validator in Kconfig
Message-ID: <20060623110119.GS4889@elte.hu>
References: <20060529212812.GI3155@elte.hu> <Pine.LNX.4.64.0605301525510.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605301525510.17704@scrub.home>
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


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > +config PROVE_SPIN_LOCKING
> > +	bool "Prove spin-locking correctness"
> > +	default y
> 
> Could you please keep all the defaults in a separate -mm-only patch, 
> so it doesn't get merged?

yep - the default got removed.

> There are also a number of dependencies on DEBUG_KERNEL missing, it 
> completely breaks the debugging menu.

i have solved this problem in current -mm by making more advanced 
versions of lock debugging (allocation/exit checks, validator) depend on 
more basic lock debugging options. All the basic lock debugging options 
have a DEBUG_KERNEL dependency, which thus gets inherited by the other 
options as well.

> > +config LOCKDEP
> > +	bool
> > +	default y
> > +	depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING || PROVE_MUTEX_LOCKING || PROVE_RWSEM_LOCKING
> 
> This can be written shorter as:
> 
> config LOCKDEP
> 	def_bool PROVE_SPIN_LOCKING || PROVE_RW_LOCKING || PROVE_MUTEX_LOCKING || PROVE_RWSEM_LOCKING

ok, done. (Btw., there's tons of other Kconfig code though that uses the 
bool + depends syntax though, and def_bool usage is quite rare.)

	Ingo
