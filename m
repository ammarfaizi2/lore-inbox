Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754244AbWKRH3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbWKRH3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 02:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756233AbWKRH3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 02:29:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1478 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754244AbWKRH3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 02:29:24 -0500
Date: Sat, 18 Nov 2006 08:28:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Mike Galbraith'" <efault@gmx.de>, Andrew Morton <akpm@osdl.org>,
       nickpiggin@yahoo.com.au, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [rfc patch] Re: sched: incorrect argument used in task_hot()
Message-ID: <20061118072832.GA4234@elte.hu>
References: <1163801933.23357.33.camel@Homer.simpson.net> <000501c70aa8$01bc4e50$2880030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501c70aa8$01bc4e50$2880030a@amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0576]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> -	if (sd->nr_balance_failed > sd->cache_nice_tries)
> +	if (sd->nr_balance_failed > sd->cache_nice_tries) {
> +		#ifdef CONFIG_SCHEDSTATS
> +		if (task_hot(p, rq->most_recent_timestamp, sd))
> +			schedstat_inc(sd, lb_hot_gained[idle]);
> +		#endif
>  		return 1;
> +	}

minor nit: preprocessor directives should be aligned to the first 
column.

	Ingo
