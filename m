Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWAOS3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWAOS3k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 13:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWAOS3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 13:29:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:24265 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750761AbWAOS3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 13:29:39 -0500
Subject: Re: Dual core Athlons and unsynced TSCs
From: Lee Revell <rlrevell@joe-job.com>
To: thockin@hockin.org
Cc: Zan Lynx <zlynx@acm.org>, David Lang <dlang@digitalinsight.com>,
       Andreas Steinmetz <ast@domdv.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060115182155.GA31941@hockin.org>
References: <Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz>
	 <20060113215609.GA30634@hockin.org>
	 <Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz>
	 <1137190698.2536.65.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0601131448150.9821@qynat.qvtvafvgr.pbz>
	 <43C848C7.1070701@domdv.de>
	 <Pine.LNX.4.62.0601131701590.9821@qynat.qvtvafvgr.pbz>
	 <1137315165.28041.12.camel@localhost> <20060115162516.GA21791@hockin.org>
	 <1137342817.25801.17.camel@mindpipe>  <20060115182155.GA31941@hockin.org>
Content-Type: text/plain
Date: Sun, 15 Jan 2006 13:29:36 -0500
Message-Id: <1137349777.25801.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-15 at 10:21 -0800, thockin@hockin.org wrote:
> On Sun, Jan 15, 2006 at 11:33:36AM -0500, Lee Revell wrote:
> > On Sun, 2006-01-15 at 08:25 -0800, thockin@hockin.org wrote:
> > > On Sun, Jan 15, 2006 at 01:52:44AM -0700, Zan Lynx wrote:
> > > > A laptop user could also bind a process to a single CPU, and use the
> > > > scaling min/max values to lock CPU speed to a single value.  The TSC may
> > > > still stop during HLT, but software must be handling that already.
> > > > 
> > > > Wouldn't that provide an accurate TSC?
> > > 
> > > monotonic but not linear.  Also remember that the OS will use rdtsc here
> > > and there, and you can't affine the OS :)
> > > 
> > 
> > So the options are either to fix the TSC handling on these systems (by
> > resyncing the TSCs when exiting from HLT), or eliminate the use of rdtsc
> > by the OS?
> 
> Or both.  You can trap rdtsc users in userland, you have to manually audit
> kernel users.
> 
> It should be abolished or properly wrapped in kernel code, as soon as a
> resync path is available.
> 

For the purposes of this discussion I was not considering direct use of
rdtsc from userland for timing, I've accepted the arguments that this is
a lost cause with today's hardware (although I maintain it was viable in
practice on previous generations of hardware).  Besides, rdtsc is
useless from userspace if the kernel traps it, because the whole point
of using it over gettimeofday() was that it was dirt cheap.

I'm content to make sure the kernel's internal timekeeping is solid.

Lee

