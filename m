Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261974AbSJKIXc>; Fri, 11 Oct 2002 04:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262114AbSJKIXb>; Fri, 11 Oct 2002 04:23:31 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:44265 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261974AbSJKIX2> convert rfc822-to-8bit; Fri, 11 Oct 2002 04:23:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Andrew Theurer <habanero@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Date: Fri, 11 Oct 2002 10:27:59 +0200
User-Agent: KMail/1.4.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200210091826.20759.efocht@ess.nec.de> <200210101234.34345.habanero@us.ibm.com> <200210110947.11714.efocht@ess.nec.de>
In-Reply-To: <200210110947.11714.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210111027.59589.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 October 2002 09:47, Erich Focht wrote:
> Hi Andrew,
>
> On Thursday 10 October 2002 19:34, Andrew Theurer wrote:
> > Thanks very much Erich.  I did come across another problem here on
> > numa-q. In task_to_steal() there is a divide by cache_decay_ticks, which
> > apparantly is 0 on my system.  This may have to do with notsc, but I am
> > not sure.  I set cache_decay_ticks to 8, (I cannot boot without using
> > notsc) which is probably not correct, but I can now boot 16 processor
> > numa-q on 2.5.40-mm1 with your patches!  I'll get some benchmark results
> > soon.
>
> oops... This is a bug in 2.5-i386. It means that the O(1) scheduler in
> 2.5 doesn't work well either because it doesn't take into account cache
> coolness. I'll post a fix to LKML in a few minutes.

Sorry, I thought the smp_tune_scheduling() call went lost during the
transition to the new cpu boot scheme. But it's there. And the problem
is indeed "notsc". So you'll have to fix it, I can't.

If you set the cache_decay_ticks to something non-zero, you should
_really_ do this for all the scheduler tests, otherwise your measurements
will not be comparable.

Regards,
Erich

