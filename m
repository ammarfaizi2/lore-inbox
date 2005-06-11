Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVFKSSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVFKSSS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 14:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVFKSSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 14:18:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13719 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261771AbVFKSR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 14:17:57 -0400
Date: Sat, 11 Jun 2005 20:15:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050611181528.GA15019@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu> <42AAF5CE.9080607@opersys.com> <20050611145240.GA10881@elte.hu> <42AB2209.9080006@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AB2209.9080006@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> Here's the .config for 2.6.12-rc4-RT-V0.7.47-08:

Thanks. These PREEMPT_RT debugging features should be disabled:

> CONFIG_DEBUG_PREEMPT=y
> CONFIG_WAKEUP_TIMING=y
> CONFIG_PREEMPT_TRACE=y
> CONFIG_LATENCY_TIMING=y
> CONFIG_RT_DEADLOCK_DETECT=y

they all cause significant overhead.

I'd also disable these two security options:

> CONFIG_AUDIT=y
> CONFIG_SECURITY=y

unless you are running an selinux-enabled environment.

i've had not that good experiences with HPET:

> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y

so i'd disable it - but YMMV.

i'd also disable PAE and use CONFIG_NOHIGHMEM:

> CONFIG_HIGHMEM64G=y

unless you have more than 4GB of RAM. (if you have between 1GB and 4GB 
then use HIGHMEM4G)

then i'd disable stack-overflow checking as well:

> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_DEBUG_STACK_USAGE=y

since you are not running 4K stacks.

	Ingo
