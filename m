Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264244AbUEXKnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbUEXKnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 06:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUEXKnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 06:43:35 -0400
Received: from unthought.net ([212.97.129.88]:14751 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264244AbUEXKnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 06:43:33 -0400
Date: Mon, 24 May 2004 12:43:32 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Phy Prabab <phyprabab@yahoo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <20040524104332.GH30687@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Phy Prabab <phyprabab@yahoo.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040524075024.84699.qmail@web90001.mail.scd.yahoo.com> <40B1AB68.40209@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B1AB68.40209@yahoo.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 05:59:36PM +1000, Nick Piggin wrote:
> Phy Prabab wrote:
> >NO HT, disabled in bios and did not enable in kernel:
> >cat /proc/cpuinfo|grep processor|wc -l
> >  2
> >grep SMT .config (2.6.7-rc1)
> ># CONFIG_SCHED_SMT is not set
> >
> >On 2.4.21 I also include "append=noht"
> >
> 
> OK good, that makes things simpler.
> 
> I'm out of ideas though. The kernel just doesn't seem to be
> the problem here. Can you put together a testcase that causes
> the problem and that we can download and reproduce it?

You could try running your program with 'strace -T' to see which system
calls are causing the slowdown.

If you make a lot of system calls, this can be a little tedious to go
thru though...  But it should reveal to you where your program is
waiting.

Note; if you use gprof and compile with the '-pg' switch, the profiler
will show you a profile of CPU time, not wall-clock time.  Your
performance problem is wall-clock time, and if your program actually
spends a lot of time waiting in some system call, this will *NOT* show
up in a normal gprof profile.

 / jakob

