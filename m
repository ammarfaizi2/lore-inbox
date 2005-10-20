Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVJTUFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVJTUFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 16:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbVJTUFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 16:05:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:62098 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932520AbVJTUFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 16:05:17 -0400
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051020193214.GA21613@elte.hu>
References: <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain>
	 <20051020073416.GA28581@elte.hu>
	 <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
	 <20051020080107.GA31342@elte.hu>
	 <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
	 <20051020085955.GB2903@elte.hu>
	 <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
	 <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain>
	 <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain>
	 <1129826750.27168.163.camel@cog.beaverton.ibm.com>
	 <20051020193214.GA21613@elte.hu>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 13:05:13 -0700
Message-Id: <1129838714.27168.181.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-20 at 21:32 +0200, Ingo Molnar wrote:
> * john stultz <johnstul@us.ibm.com> wrote:
> 
> > > > John, would this cause any problems to keep cycle_t at s64?
> > > 
> > > I mean at u64.
> > 
> > Performance would be the only concern. It had been a u64 before I 
> > started optimizing the code a bit.
> 
> no, this is really a bad optimization that causes unrobustness. 
> Correctness and robustness comes first. It is so easy to cause a 
> 500-1000msec delay in the kernel, due to a bad driver or anything. The 
> timekeeping code should not break like that.

Eh, its an easy enough change, so I'll put it back to u64. We can
revisit it again later if needed. 

However making sure periodic_hook isn't starved for too long is
important for good timekeeping, since ntp and cpufreq adjustments are
made at that point. Steven's suggestion of moving it to use ktimers
sounds like a good plan, but let me know if you can see any other holes.

thanks
-john. 

