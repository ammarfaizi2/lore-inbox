Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751988AbWCEGzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbWCEGzA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 01:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCEGzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 01:55:00 -0500
Received: from mail.gmx.de ([213.165.64.20]:52359 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751988AbWCEGy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 01:54:59 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task
	throttling	patch 1 of 2
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: lkml <linux-kernel@vger.kernel.org>, mingo@elte.hu, kernel@kolivas.org,
       nickpiggin@yahoo.com.au, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <440A08AD.7050101@bigpond.net.au>
References: <1140183903.14128.77.camel@homer>
	 <1140812981.8713.35.camel@homer>  <20060224141505.41b1a627.akpm@osdl.org>
	 <1140834190.7641.25.camel@homer> <1141382609.8768.57.camel@homer>
	 <4408D823.50407@bigpond.net.au> <1141448075.7703.11.camel@homer>
	 <440A08AD.7050101@bigpond.net.au>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 07:54:53 +0100
Message-Id: <1141541693.8964.32.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 08:37 +1100, Peter Williams wrote:
> Mike Galbraith wrote:
> > On Sat, 2006-03-04 at 10:58 +1100, Peter Williams wrote:
> > 
> > 
> >>If you're going to manage the time slice in nanoseconds why not do it 
> >>properly?  I presume you've held back a bit in case you break something?
> >>
> > 
> > 
> > Do you mean the < NS_TICK thing?  The spare change doesn't go away.
> 
> Not exactly.  I mean "Why calculate time slice in jiffies and convert to 
> nanoseconds?  Why not just do the calculation in nanoseconds?"

Turns out that my first instinct was right, and there is a good reason
not to.  It doesn't improve readability nor do anything functional, it
only adds clutter.  I much prefer the look of plain old ticks, and
having nanoseconds only intrude where they're required.  I did change
NS_TICK to the less obfuscated (1000000000 / HZ), with task_timeslice()
returning a more readable ticks * NS_TICK conversion.

	-Mike

