Return-Path: <linux-kernel-owner+w=401wt.eu-S1762634AbWLKH5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762634AbWLKH5n (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 02:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762644AbWLKH5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 02:57:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41825 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762634AbWLKH5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 02:57:42 -0500
Date: Mon, 11 Dec 2006 08:56:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@osdl.org>, David Miller <davem@davemloft.net>,
       alan@lxorguk.ukuu.org.uk, lenb@kernel.org, linux-kernel@vger.kernel.org,
       ak@suse.de, torvalds@osdl.org
Subject: Re: [patch] net: dev_watchdog() locking fix
Message-ID: <20061211075605.GB4335@elte.hu>
References: <20061207210657.GA23229@gondor.apana.org.au> <20061208151902.4c8bb012.akpm@osdl.org> <20061208235952.GA4693@gondor.apana.org.au> <20061209.140205.126778911.davem@davemloft.net> <20061210234508.cd83a784.akpm@osdl.org> <20061211075111.GA24994@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211075111.GA24994@gondor.apana.org.au>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > It spits a nasty during bringup
> > 
> > e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> > forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
> > netconsole: device eth0 not up yet, forcing it
> > e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> > WARNING (!__warned) at kernel/softirq.c:137 local_bh_enable()
> 
> Normally networking isn't invoked with interrupts turned off, but I 
> suppose we don't have a choice here.  This is unique being a place 
> where you can get called with BH on, off, or IRQs off.
> 
> Given that this is only used for printk, the easiest solution is 
> probably just to disable local IRQs instead of BH.

yeah. local_bh_enable() can execute pending softirqs and that warning 
protects us against doing that from within irqs-off sections.

	Ingo
