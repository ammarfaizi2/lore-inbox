Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWCUNLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWCUNLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWCUNLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:11:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:22760 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751665AbWCUNLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:11:54 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
In-Reply-To: <200603212253.03637.kernel@kolivas.org>
References: <200603090036.49915.kernel@kolivas.org>
	 <20060321111552.GA25651@w.ods.org> <20060321111850.GA2776@elte.hu>
	 <200603212253.03637.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 14:10:10 +0100
Message-Id: <1142946610.7807.43.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 22:53 +1100, Con Kolivas wrote:
> On Tuesday 21 March 2006 22:18, Ingo Molnar wrote:
> > great work by Mike! One detail: i'd like there to be just one default
> > throttling value, i.e. no grace_g tunables [so that we have just one
> > default scheduler behavior]. Is the default grace_g[12] setting good
> > enough for your workload?
> 
> I agree. If anything is required, a simple on/off tunable makes much more 
> sense. Much like I suggested ages ago with an "interactive" switch which was 
> rather unpopular when I first suggested it.

Let me try to explain why on/off is not sufficient.

You notice how Willy said that his notebook is more responsive with
tunables set to 0,0?  That's important, because it's absolutely true...
depending what you're doing.  Setting tunables to 0,0 cuts off the idle
sleep logic, and the sleep_avg divisor - both of which were put there
specifically for interactivity - and returns the scheduler to more or
less original O(1) scheduler.  You and I both know that these are most
definitely needed in a Desktop environment.  For instance, if Willy
starts editing code in X, and scrolls while something is running in the
background, he'll suddenly say hey, maybe this _ain't_ more responsive,
because all of a sudden the starvation added with the interactivity
logic will be sorely missed as my throttle wrings X's neck.

How long should Willy be able to scroll without feeling the background,
and how long should Apache be able to starve his shell.  They are one
and the same, and I can't say, because I'm not Willy.  I don't know how
to get there from here without tunables.  Picking defaults is one thing,
but I don't know how to make it one-size-fits-all.  For the general
case, the values delivered will work fine.  For the apache case, they
absolutely 100% guaranteed will not.

	-Mike

