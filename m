Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWITI3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWITI3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 04:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWITI3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 04:29:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57308 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751347AbWITI3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 04:29:24 -0400
Date: Wed, 20 Sep 2006 10:21:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] rtc: lockdep fix
Message-ID: <20060920082135.GB12517@elte.hu>
References: <1158695676.28174.21.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158695676.28174.21.camel@lappy>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> BUG: warning at kernel/lockdep.c:1816/trace_hardirqs_on() (Not tainted)
>  [<c04051ee>] show_trace_log_lvl+0x58/0x171
>  [<c0405802>] show_trace+0xd/0x10
>  [<c040591b>] dump_stack+0x19/0x1b
>  [<c043abee>] trace_hardirqs_on+0xa2/0x11e
>  [<c06143c3>] _spin_unlock_irq+0x22/0x26
>  [<c0541540>] rtc_get_rtc_time+0x32/0x176
>  [<c0419ba4>] hpet_rtc_interrupt+0x92/0x14d
>  [<c0450f94>] handle_IRQ_event+0x20/0x4d
>  [<c0451055>] __do_IRQ+0x94/0xef
>  [<c040678d>] do_IRQ+0x9e/0xbd
>  [<c0404a49>] common_interrupt+0x25/0x2c

ouch! That is a scenario that could lead to real lockups. Fix looks good 
and necessary for v2.6.18 to me.

> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
