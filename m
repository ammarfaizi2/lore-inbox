Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754112AbWKGIZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbWKGIZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 03:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbWKGIZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 03:25:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11397 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754112AbWKGIZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 03:25:28 -0500
Date: Tue, 7 Nov 2006 09:24:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061107082434.GA13585@elte.hu>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <1162830033.4715.201.camel@localhost.localdomain> <20061106205825.GA26755@rhlx01.hs-esslingen.de> <200611070141.16593.len.brown@intel.com> <20061107081839.GA26290@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107081839.GA26290@rhlx01.hs-esslingen.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:

> The results are (waited for values to settle down each time):
> 
> -dyntick4, C1, CONFIG_NO_HZ:
>      83.9W KDE idle, 95.2W bash while 1
> -dyntick4, C2 (C1-only hack disabled, kernel rebuilt), CONFIG_NO_HZ off:
>      84.4W KDE idle, 95.4W bash while 1
> -dyntick4, acpi=off (i.e. APM active), -dynticks:
>      85.5W KDE idle, 95.5W bash while 1
> 
> Bet you didn't see this coming...

interesting that there's any savings from dynticks in this workload. 
When the CPU is busy then dynticks generates the usual HZ scheduler 
tick.

could you try the same measurement with a completely idle system too? 
That is where dynticks has its true effects: longer idle intervals. (but 
even on an idle system dynticks might not make a difference unless the 
hardware can utilize the much larger and more predictable idle times 
that dynticks offers.)

	Ingo
