Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWGEUHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWGEUHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWGEUHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:07:24 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:34707 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964962AbWGEUHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:07:24 -0400
Date: Wed, 5 Jul 2006 22:02:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [patch] sched: fix macro -> inline function conversion bug
Message-ID: <20060705200245.GB13070@elte.hu>
References: <44A8567B.2010309@mbligh.org> <20060702164113.6dc1cd6c.akpm@osdl.org> <20060703052538.GB13415@elte.hu> <20060702224247.21e8aa8f.akpm@osdl.org> <20060703060320.GA15782@elte.hu> <20060703060832.GA15940@elte.hu> <20060705123629.A7271@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705123629.A7271@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5013]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> -		if (sd && sd->flags & flag)
> +		if (sd && !(sd->flags & flag))

use test_sd_flag() here, as i did in my fix patch.

> -#define test_sd_flag(sd, flag)	((sd && sd->flags & flag) ? 1 : 0)
> +#define test_sd_flag(sd, flag)	((sd && (sd->flags & flag)) ? 1 : 0)

remove the 'sd' check in test_sd_flag. In the other cases we know that 
there's an sd. (it's usually a sign of spaghetti code if tests like this 
include a check for the existence of the object checked)

	Ingo
