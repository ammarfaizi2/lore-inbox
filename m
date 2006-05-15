Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWEOXpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWEOXpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWEOXpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:45:38 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:32411 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750822AbWEOXpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:45:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Tue, 16 May 2006 09:45:12 +1000
User-Agent: KMail/1.9.1
Cc: tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       "Andrew Morton" <akpm@osdl.org>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com>
In-Reply-To: <4t16i2$12rqnu@orsmga001.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605160945.13157.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 05:01, Chen, Kenneth W wrote:
> Con Kolivas wrote on Sunday, May 14, 2006 9:03 AM
>
> > There would be no difference if the priority boost is done lower. The if
> > and else blocks both end up equating to the same amount of priority
> > boost, with the former having a ceiling on it, so yes it is the intent.
> > You'll see that the amount of sleep required to jump from lowest priority
> > to MAX_SLEEP_AVG - DEF_TIMESLICE is INTERACTIVE_SLEEP.
>
> I don't think the if and the else block is doing the same thing. In the if
> block, the p->sleep_avg is unconditionally boosted to ceiling for all
> tasks, though it will not reduce sleep_avg for tasks that already exceed
> the ceiling. Bumping up sleep_avg will then translate into priority boost
> of MAX_BONUS-1, which potentially can be too high.

Yes it's only designed to detect something that has been asleep for an 
arbitrary long time and "categorised as idle"; it is not supposed to be a 
priority stepping stone for everything, in this case at MAX_BONUS-1. Mike 
proposed doing this instead, but it was never my intent. Your comment is not 
quite correct as it just happens to be MAX_BONUS-1 at nice 0, and not any 
other nice value.

> But that's fine if it is the intent. At minimum, the comment in the source
> code should say so instead of fooling people who don't actually read the
> code.

Feel free to update it to how you understand it now :) I have this feeling 
we'll be seeing quite some action here soon...

> [patch] sched: update comments in priority calculation w.r.t.
> implementation.

-- 
-ck
