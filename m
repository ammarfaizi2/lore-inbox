Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWEPBW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWEPBW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWEPBW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:22:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:17569 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750997AbWEPBWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:22:25 -0400
Message-Id: <4t16i2$13154k@orsmga001.jf.intel.com>
X-IronPort-AV: i="4.05,131,1146466800"; 
   d="scan'208"; a="36738196:sNHT14419272"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>
Cc: <tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Mon, 15 May 2006 18:22:24 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZ4eaTBRAuBdrtjRUuDyKrPi9nXWAADMAuA
In-Reply-To: <200605160945.13157.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Monday, May 15, 2006 4:45 PM
> On Tuesday 16 May 2006 05:01, Chen, Kenneth W wrote:
> > I don't think the if and the else block is doing the same thing. In the if
> > block, the p->sleep_avg is unconditionally boosted to ceiling for all
> > tasks, though it will not reduce sleep_avg for tasks that already exceed
> > the ceiling. Bumping up sleep_avg will then translate into priority boost
> > of MAX_BONUS-1, which potentially can be too high.
> 
> Yes it's only designed to detect something that has been asleep for an 
> arbitrary long time and "categorised as idle"; it is not supposed to be a 
> priority stepping stone for everything, in this case at MAX_BONUS-1. Mike 
> proposed doing this instead, but it was never my intent. Your comment is not 
> quite correct as it just happens to be MAX_BONUS-1 at nice 0, and not any 
> other nice value.

Huh??

sleep_avg is set at constant:
p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG - DEF_TIMESLICE);


The bonus calculation is:

#define CURRENT_BONUS(p) \
        (NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / MAX_SLEEP_AVG)

bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;

None of the calculation that I see uses nice value.  Did I miss something?

- Ken
