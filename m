Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVHVVLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVHVVLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVHVVLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:11:01 -0400
Received: from fmr21.intel.com ([143.183.121.13]:32641 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751171AbVHVVLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:11:00 -0400
Date: Mon, 22 Aug 2005 14:10:19 -0700
From: tony.luck@intel.com
Message-Id: <200508222110.j7MLAJ0w020346@agluck-lia64.sc.intel.com>
In-Reply-To: <20050822.134226.35468933.davem@davemloft.net>
To: jasonuhl@sgi.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK_TIME woes
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050822203306.GA897956@dragonfly.engr.sgi.com>
References: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
	<20050822.132052.65406121.davem@davemloft.net>
	<20050822203306.GA897956@dragonfly.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I turn off VC logging, and I turn off disk sync'ing, so it goes
>straight to the page cache.
>
>I really do need sub-microsecond timings when I put a lot of
>printk tracing into the stack.

Right now you only have microsecond timing. Although printk() gets
"nanosecond" resolution from sched_clock() it throws away the low
order bits when it outputs the ".%06lu ... nanosec_rem/1000"

>This is a useful feature, please do not labotomize it just because
>it's difficult to implement on ia64.  Just make a
>"printk_get_timestamp_because_ia64_sucks()" interface or something
>like that :-)

I'm just trying to assess how much work is needed at the moment. Both
you and Andrew have come up with scenarios where higher than jiffies
resolution is needed ... so it seems unlikely that I'll be allowed
to do much damage here.  Andrew's proposed:

 __attribute__((weak)) unsigned long long printk_clock(void)

patch would provide the hooks I need.

-Tony
