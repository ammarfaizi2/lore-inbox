Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUIIVFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUIIVFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUIIVFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:05:05 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:35007 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266891AbUIIVDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:03:42 -0400
Date: Thu, 9 Sep 2004 17:03:35 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@Raytheon.com,
       scott@timesys.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Message-ID: <20040909210335.GB1014@yoda.timesys>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu> <1094758399.1362.268.camel@krustophenia.net> <1094762629.1362.320.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094762629.1362.320.camel@krustophenia.net>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 04:43:49PM -0400, Lee Revell wrote:
> On Thu, 2004-09-09 at 15:33, Lee Revell wrote:
> > I believe Scott Wood suggested a fix back when I first reported this,
> > have to check my mailbox.  Scott?
> > 
> 
> Nope, checking the original thread, Scott pointed out that any RT
> process will have mlockall'ed anyway and thus won't be affected by this
> latency.  So, this one would be cool to fix, but it's not a problem as
> such.

Though, if this is an actual lock latency (as opposed to merely being
a page-fault latency suffered by the task swapping something in), it
could affect mlockall'd processes as well due to some other task
swapping.

One way to fix the latency would be to turn the locks involved into
sleeping mutexes.  There's a comment in the code saying that swaplock
cannot be turned into a semaphore, but it does not say why; if this
is due to it nesting in other locks, those locks would need to be
converted as well.  It could turn into quite a mess doing it
manually, though turning all spinlocks into mutexes (except
hand-chosen exceptions) should take care of it.

-Scott
