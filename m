Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWIUHxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWIUHxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWIUHxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:53:00 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:38338
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751013AbWIUHw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:52:59 -0400
Date: Thu, 21 Sep 2006 00:52:42 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921075242.GB11644@gnuppy.monkey.org>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <20060921065402.GA22089@elte.hu> <20060921071838.GA10337@gnuppy.monkey.org> <20060921072743.GB10337@gnuppy.monkey.org> <20060921072216.GB25835@elte.hu> <20060921073522.GD10337@gnuppy.monkey.org> <20060921073130.GB27280@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921073130.GB27280@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 09:31:30AM +0200, Ingo Molnar wrote:
> * Bill Huey <billh@gnuppy.monkey.org> wrote:
> > It was even problematic with the serial console on which is why I did 
> > that. Maybe it was an artifact of having both the serial console and 
> > video consoles on ?
> 
> perhaps the real problem was that you got 'intermixed' stackdumps from 
> multiple CPUs crashing at once? Or was it simply the myriads of 
> stackdumps? The myriads effect is easy to solve: only look at the first 
> one, and fix them one by one :-)

I don't think I have to tell you that things got "really weird" for a
while which is why I took the route of most severity and elected to use
extreme debugging methods. :)

I mean, some of those stack traces kept triggering a jumble of schedule()
calls, etc... I decided to hack the heads off of them one at at time and
stop the kernel immediately after one of those bugs. The immediate panic()
is what caught the tbl raw_spinlock issue and therefore my lock reversion
after auditing that portion of the lock graph.

bill

