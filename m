Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWGEVVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWGEVVj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWGEVVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:21:39 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59369 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965002AbWGEVVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:21:38 -0400
Date: Wed, 5 Jul 2006 23:17:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [patch] sched: fix macro -> inline function conversion bug
Message-ID: <20060705211702.GA24961@elte.hu>
References: <44A8567B.2010309@mbligh.org> <20060702164113.6dc1cd6c.akpm@osdl.org> <20060703052538.GB13415@elte.hu> <20060702224247.21e8aa8f.akpm@osdl.org> <20060703060320.GA15782@elte.hu> <20060703060832.GA15940@elte.hu> <20060705123629.A7271@unix-os.sc.intel.com> <20060705200245.GB13070@elte.hu> <20060705140948.B7271@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705140948.B7271@unix-os.sc.intel.com>
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


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> On Wed, Jul 05, 2006 at 10:02:45PM +0200, Ingo Molnar wrote:
> > 
> > * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> > 
> > > -		if (sd && sd->flags & flag)
> > > +		if (sd && !(sd->flags & flag))
> > 
> > use test_sd_flag() here, as i did in my fix patch.
> > 
> > > -#define test_sd_flag(sd, flag)	((sd && sd->flags & flag) ? 1 : 0)
> > > +#define test_sd_flag(sd, flag)	((sd && (sd->flags & flag)) ? 1 : 0)
> > 
> > remove the 'sd' check in test_sd_flag. In the other cases we know that 
> > there's an sd. (it's usually a sign of spaghetti code if tests like this 
> > include a check for the existence of the object checked)
> 
> In other cases, we are passing sd->parent as the first argument to 
> test_sd_flag(). We know that there is a 'sd' but not sure about 
> sd->parent or sd->child.

ok. But the first issue above should be fixed.

	Ingo
