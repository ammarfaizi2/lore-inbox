Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWFOWNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWFOWNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 18:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWFOWNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 18:13:44 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:47034 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750737AbWFOWNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 18:13:43 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Date: Thu, 15 Jun 2006 15:13:36 -0700
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>
References: <200606091701.55185.dvhltc@us.ibm.com> <200606120838.25200.dvhltc@us.ibm.com> <20060615210658.GA19525@monkey.ibm.com>
In-Reply-To: <20060615210658.GA19525@monkey.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606151513.37670.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 June 2006 14:06, Mike Kravetz wrote:
> On Mon, Jun 12, 2006 at 08:38:24AM -0700, Darren Hart wrote:
> > I started running this version of the patch with prio-preemt in a loop
> > over 10 hours ago, and it's still running.  This seems to be the right
> > fix.
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

Thanks for the update Mike!  I have incorporated the interrupter threads using 
a command line argument, -i, they are disabled by default.  Grab the latest 
here:

http://linux.dvhart.com/tests/

To run the test on a 4 way machine with interrupter threads enabled, use:

$ ./prio-preempt -n 4 -i

>
> Any help figuring out what is happening here would be appreciated.

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
Phone: 503 578 3185
  T/L: 775 3185
