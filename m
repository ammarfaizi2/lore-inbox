Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUCYWce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbUCYWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:31:48 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:394 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263677AbUCYW32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:29:28 -0500
Date: Thu, 25 Mar 2004 14:28:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <23100000.1080253728@flay>
In-Reply-To: <20040325214815.GA19060@elte.hu>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de> <20040325190944.GB12383@elte.hu> <10030000.1080242684@flay> <20040325214815.GA19060@elte.hu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Exec time balancing is a *lot* more efficient, it just doesn't work
>> for things that don't exec ... cloned threads would certainly be one
>> case.
> 
> yeah - exec-balancing is a clear thing. fork/clone time balancing is
> alot less clear.

OK, well it *looks* to me from a quick look at your patch like
sched_balance_context will rebalance at both fork *and* exec time.
That seems like a bad plan, but maybe I'm misreading it.

Can we hold off on changing the fork/exec time balancing until we've
come to a plan as to what should actually be done with it? Unless we're
giving it some hint from userspace, it's frigging hard to be sure if
it's going to exec or not - and the vast majority of things do. 

There was a really good reason why the code is currently set up that
way, it's not some random accident ;-)

Clone is a much more interesting case, though at the time, I consciously
decided NOT to do that, as we really mostly want threads on the same
node. The exception is the case where we have one app with lots of threads,
and nothing much else running on the system ... I tend to think of that
as an artificial benchmark situation, but maybe that's not fair. We 
probably need to just do a more conservative version of the cross-node
rebalance at fork time.

M.

