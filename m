Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWITIt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWITIt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 04:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWITIt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 04:49:28 -0400
Received: from mga05.intel.com ([192.55.52.89]:51321 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750738AbWITIt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 04:49:28 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,190,1157353200"; 
   d="scan'208"; a="133613889:sNHT18881709"
Message-ID: <4511008E.5090005@linux.intel.com>
Date: Wed, 20 Sep 2006 16:49:18 +0800
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rtc: lockdep fix
References: <1158695676.28174.21.camel@lappy> <20060920082135.GB12517@elte.hu>
In-Reply-To: <20060920082135.GB12517@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
>> BUG: warning at kernel/lockdep.c:1816/trace_hardirqs_on() (Not tainted)
>>  [<c04051ee>] show_trace_log_lvl+0x58/0x171
>>  [<c0405802>] show_trace+0xd/0x10
>>  [<c040591b>] dump_stack+0x19/0x1b
>>  [<c043abee>] trace_hardirqs_on+0xa2/0x11e
>>  [<c06143c3>] _spin_unlock_irq+0x22/0x26
>>  [<c0541540>] rtc_get_rtc_time+0x32/0x176
>>  [<c0419ba4>] hpet_rtc_interrupt+0x92/0x14d
>>  [<c0450f94>] handle_IRQ_event+0x20/0x4d
>>  [<c0451055>] __do_IRQ+0x94/0xef
>>  [<c040678d>] do_IRQ+0x9e/0xbd
>>  [<c0404a49>] common_interrupt+0x25/0x2c
> 
> ouch! That is a scenario that could lead to real lockups. Fix looks good 
> and necessary for v2.6.18 to me.
> 

btw this entire code path is evil; the rtc_get_rtc_time() function can do really long delays
which is unsuitable for being called in interrupt context!
