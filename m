Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWEQEYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWEQEYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 00:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWEQEYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 00:24:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:30180 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750903AbWEQEYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 00:24:41 -0400
X-Authenticated: #14349625
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Mike Galbraith <efault@gmx.de>
To: tim.c.chen@linux.intel.com
Cc: Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1147822331.4859.37.camel@localhost.localdomain>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com>
	 <200605160945.13157.kernel@kolivas.org>
	 <1147822331.4859.37.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 17 May 2006 06:25:13 +0200
Message-Id: <1147839913.8335.35.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 16:32 -0700, Tim Chen wrote:
> On Tue, 2006-05-16 at 09:45 +1000, Con Kolivas wrote:
> 
> > 
> > Yes it's only designed to detect something that has been asleep for an 
> > arbitrary long time and "categorised as idle"; it is not supposed to be a 
> > priority stepping stone for everything, in this case at MAX_BONUS-1. Mike 
> > proposed doing this instead, but it was never my intent. 
> 
> It seems like just one sleep longer than INTERACTIVE_SLEEP is needed
> kick the priority of a process all the way to MAX_BONUS-1 and boost the
> sleep_avg, regardless of what the prior sleep_avg was.
> 
> So if there is a cpu hog that has long sleeps occasionally, once it woke
> up, its priority will get boosted close to maximum, likely starving out
> other processes for a while till its sleep_avg gets reduced.  This
> behavior seems like something to avoid according to the original code
> comment.  Are we boosting the priority too quickly?  

The answer to that is, sometimes yes, and when it bites, it bites hard.
Happily, most hogs don't sleep much, and we don't generally have lots of
bursty sleepers.

	-Mike

