Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWEPBo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWEPBo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWEPBo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:44:26 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:48522 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751003AbWEPBoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:44:25 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Tue, 16 May 2006 11:44:00 +1000
User-Agent: KMail/1.9.1
Cc: tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       "Andrew Morton" <akpm@osdl.org>
References: <4t16i2$13154k@orsmga001.jf.intel.com>
In-Reply-To: <4t16i2$13154k@orsmga001.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161144.01521.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 11:22, Chen, Kenneth W wrote:
> Con Kolivas wrote on Monday, May 15, 2006 4:45 PM
>
> > On Tuesday 16 May 2006 05:01, Chen, Kenneth W wrote:
> > > I don't think the if and the else block is doing the same thing. In the
> > > if block, the p->sleep_avg is unconditionally boosted to ceiling for
> > > all tasks, though it will not reduce sleep_avg for tasks that already
> > > exceed the ceiling. Bumping up sleep_avg will then translate into
> > > priority boost of MAX_BONUS-1, which potentially can be too high.
> >
> > Yes it's only designed to detect something that has been asleep for an
> > arbitrary long time and "categorised as idle"; it is not supposed to be a
> > priority stepping stone for everything, in this case at MAX_BONUS-1. Mike
> > proposed doing this instead, but it was never my intent. Your comment is
> > not quite correct as it just happens to be MAX_BONUS-1 at nice 0, and not
> > any other nice value.
>
> Huh??
>
> sleep_avg is set at constant:
> p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG - DEF_TIMESLICE);
>
>
> The bonus calculation is:
>
> #define CURRENT_BONUS(p) \
>         (NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / MAX_SLEEP_AVG)
>
> bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
>
> None of the calculation that I see uses nice value.  Did I miss something?

My bad. You're correct, sorry.

-- 
-ck
