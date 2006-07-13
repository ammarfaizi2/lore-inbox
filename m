Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWGMJKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWGMJKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWGMJKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:10:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:15312 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964860AbWGMJKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:10:11 -0400
Date: Thu, 13 Jul 2006 11:04:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Move NTP related code to ntp.c
Message-ID: <20060713090434.GA7480@elte.hu>
References: <1152749914.11963.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152749914.11963.33.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5215]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> Hey all,
> 	I know I've been moving a bit slowly, but I wanted to get my current
> tree out there so folks could see where I'm heading w/ the timekeeping
> code now that the largest chunk of logical changes has landed.

looks good to me! A few minor nits:

> + * This code was mainly moved from kernel/timer.c and kerenl/time.c

s/kerenl/kernel

> + * Please see those files for relavent copyright info and historical

s/relavent/relevant

> +/*
> + * this routine handles the overflow of the microsecond field
> + *
> + * The tricky bits of code to handle the accurate clock support
> + * were provided by Dave Mills (Mills@UDEL.EDU) of NTP fame.
> + * They were originally developed for SUN and DEC kernels.
> + * All the kudos should go to Dave for this stuff.
> + *
> + */

remove the extra empty ' *' line above.

> +/* adjtimex mainly allows reading (and writing, if superuser) of
> + * kernel time-keeping variables. used by xntpd.
> + */
> +int do_adjtimex(struct timex *txc)
> +{
> +        long ltemp, mtemp, save_adjust;

whitespace damage.

suggestion for future cleanups: this function (do_adjtimex()) should be 
cleaned up further to conform to the kernel coding style standard. 
(currently it has 4-space tabs, etc.) I did that before - maybe some of 
those cleanups still apply?

[obviously that cleanup shouldnt be part of this move-the-code patch.]

	Ingo
