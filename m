Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWGKQrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWGKQrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWGKQrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:47:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:34509 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751104AbWGKQry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:47:54 -0400
Date: Tue, 11 Jul 2006 09:48:08 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Darren Hart <dvhltc@us.ibm.com>,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Message-ID: <20060711164808.GA5157@w-mikek2.ibm.com>
References: <200606091701.55185.dvhltc@us.ibm.com> <200606102324.58932.dvhltc@us.ibm.com> <20060611073609.GA12456@elte.hu> <200606120838.25200.dvhltc@us.ibm.com> <20060615210658.GA19525@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615210658.GA19525@monkey.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

As you can see from the note below, we are still having issues with
this testcase.  As a reminder Darren's mail with a pointer to the
new testcase is at:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0606.1/0729.html

When run with the '-i' option it fails on a regular (aprox 50% on 4 way)
basis.  Any insight into what may be happening would be appreciated.

Thanks,
-- 
Mike

On Thu, Jun 15, 2006 at 02:06:58PM -0700, Mike Kravetz wrote:
> On Mon, Jun 12, 2006 at 08:38:24AM -0700, Darren Hart wrote:
> > I started running this version of the patch with prio-preemt in a loop
> > over 10 hours ago, and it's still running.  This seems to be the right fix.
> 
> Unfortunately, this test did eventually fail over in our environment.
> John Stultz added the concept of 'interrupter threads' to the testcase.
> These high priority RT interrupter threads, occasionally wake up and
> run for a short period of time.  Since these new threads are higher
> priority than any other, they theoretically should not impact the
> testcase.  This is because the primary purpose of the testcase is to
> ensure that lower priority tasks do not run while higher priority tasks
> are waiting for a CPU.
> 
> After adding these interrupter threads, the tetscase fails (on a system
> here) about 50% of the time.  An updated version of prio-preempt.c is
> attached.  It needs the same headers/makefile/etc as originally provided
> by Darren.
