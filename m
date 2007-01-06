Return-Path: <linux-kernel-owner+w=401wt.eu-S1751196AbXAFHLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbXAFHLz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbXAFHLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:11:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36394 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbXAFHLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:11:54 -0500
Date: Sat, 6 Jan 2007 08:08:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] paravirt: isolate module ops
Message-ID: <20070106070807.GA11232@elte.hu>
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com> <1168064710.20372.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168064710.20372.28.camel@localhost.localdomain>
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


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> diff -r 48f31ae5d7b5 arch/i386/kernel/paravirt.c
> --- a/arch/i386/kernel/paravirt.c	Sat Jan 06 10:32:24 2007 +1100
> +++ b/arch/i386/kernel/paravirt.c	Sat Jan 06 17:23:12 2007 +1100
> @@ -596,6 +596,154 @@ static int __init print_banner(void)
>  	return 0;
>  }
>  core_initcall(print_banner);
> +
> +unsigned long paravirt_save_flags(void)
> +{
> +	return paravirt_ops.save_fl();
> +}
> +EXPORT_SYMBOL(paravirt_save_flags);

ok, i like this one too - i agree that it's better than mine because it 
isolates on a per-API level not on a per-lowlevel-paravirt-op level. But 
this doesnt do the most crutial step: the removal of the paravirt_ops 
export. Without that the module build test is pointless.

btw., your patch does not apply to current -git - could you please 
rebase this patch to the head of your queue so that upstream can pick it 
up?

	Ingo
