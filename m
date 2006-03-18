Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWCRM5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWCRM5w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 07:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWCRM5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 07:57:52 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:23770
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751638AbWCRM5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 07:57:51 -0500
Subject: Re: 2.6.16-rc6-rt7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tom Rini <trini@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>,
       Martin Ridgeway <mridge@users.sourceforge.net>
In-Reply-To: <20060318125425.GA32662@smtp.west.cox.net>
References: <20060316095607.GA28571@elte.hu>
	 <20060317233636.GB26253@smtp.west.cox.net>
	 <1142678240.17279.76.camel@localhost.localdomain>
	 <20060318125425.GA32662@smtp.west.cox.net>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 13:58:01 +0100
Message-Id: <1142686681.17279.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 05:54 -0700, Tom Rini wrote:
> On Sat, Mar 18, 2006 at 11:37:19AM +0100, Thomas Gleixner wrote:
> > On Fri, 2006-03-17 at 16:36 -0700, Tom Rini wrote:
> > > On Thu, Mar 16, 2006 at 10:56:08AM +0100, Ingo Molnar wrote:
> > > 
> > > > i have released the 2.6.16-rc6-rt7 tree, which can be downloaded from 
> > > > the usual place:
> > > > 
> > > >    http://redhat.com/~mingo/realtime-preempt/
> > > 
> > > I was wondering, is it normal for the nanosleep02 and alarm02 LTP tests
> > > to fail?  For sometime I've seen these tests fail from time to time with
> > > the -RT patch but not the regular kernel.
> > 
> > The nanosleep02 failure is incorrect due to rounding errors in the test
> > code.
> [snip]
> > This never happens on vanilla, as the nanosleep is rounded to the next
> > jiffie. -rt has high resolution timers which are delivered accurate, so
> > the rounding errors of the testcode surface.
> 
> Thanks!  Any ideas about the alarm02 test?

Yes. Its due (unsigned int) -> long conversion and a missing check.

That one affects mainline as well. I'm fixing this one right now. Patch
follows.

	tglx





