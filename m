Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUIIUSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUIIUSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUIIUPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:15:20 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53210 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266885AbUIIUN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:13:29 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@Raytheon.com
In-Reply-To: <20040909192924.GA1672@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <20040906110626.GA32320@elte.hu>
	 <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu>
Content-Type: text/plain
Message-Id: <1094760812.1362.294.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 16:13:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 15:29, Ingo Molnar wrote:
> yep, the get_swap_page() latency. I can easily trigger 10+ msec
> latencies on a box with alot of swap by just letting stuff swap out. I
> had a quick look but there was no obvious way to break the lock. Maybe
> Andrew has better ideas? get_swap_page() is pretty stupid, it does a
> near linear search for a free slot in the swap bitmap - this not only is
> a latency issue but also an overhead thing as we do it for every other
> page that touches swap.
> 
> rationale: this is pretty much the only latency that we still having
> during heavy VM load and it would Just Be Cool if we fixed this final
> one. audio daemons and apps like jackd use mlockall() so they are not
> affected by swapping.

Considering that the default swappiness behavior is to swap out idle
apps to get more page cache, this would indeed be nice to fix.  If the
default behavior were to not swap until someone actually asks for more
memory than we have, it would be less of a concern.

Lee

