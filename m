Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWAOSh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWAOSh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 13:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWAOSh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 13:37:57 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:62175 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1750727AbWAOSh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 13:37:56 -0500
Date: Sun, 15 Jan 2006 10:49:10 -0800
From: thockin@hockin.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Zan Lynx <zlynx@acm.org>, David Lang <dlang@digitalinsight.com>,
       Andreas Steinmetz <ast@domdv.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
Message-ID: <20060115184910.GA1047@hockin.org>
References: <Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz> <1137190698.2536.65.camel@localhost.localdomain> <Pine.LNX.4.62.0601131448150.9821@qynat.qvtvafvgr.pbz> <43C848C7.1070701@domdv.de> <Pine.LNX.4.62.0601131701590.9821@qynat.qvtvafvgr.pbz> <1137315165.28041.12.camel@localhost> <20060115162516.GA21791@hockin.org> <1137342817.25801.17.camel@mindpipe> <20060115182155.GA31941@hockin.org> <1137349777.25801.29.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137349777.25801.29.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 01:29:36PM -0500, Lee Revell wrote:
> > Or both.  You can trap rdtsc users in userland, you have to manually audit
> > kernel users.
> > 
> > It should be abolished or properly wrapped in kernel code, as soon as a
> > resync path is available.
> 
> For the purposes of this discussion I was not considering direct use of
> rdtsc from userland for timing, I've accepted the arguments that this is
> a lost cause with today's hardware (although I maintain it was viable in
> practice on previous generations of hardware).  Besides, rdtsc is
> useless from userspace if the kernel traps it, because the whole point
> of using it over gettimeofday() was that it was dirt cheap.
> 
> I'm content to make sure the kernel's internal timekeeping is solid.

You only need to trap rdtsc if you know that some unsyncronizing event has
happened.  E.g. 'hlt' or some other sleep state.  If we sync every time we
hlt, then we don't need to trap.  But we can maybe be lazier about it.

The sync operation itself may not be cheap, and it may be useful to skip
it if possible.
