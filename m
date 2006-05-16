Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWEQAIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWEQAIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWEQAIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:08:43 -0400
Received: from fmr18.intel.com ([134.134.136.17]:34239 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750993AbWEQAIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:08:42 -0400
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Con Kolivas <kernel@kolivas.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Andrew Morton <akpm@osdl.org>,
       Mike Galbraith <efault@gmx.de>
In-Reply-To: <200605160945.13157.kernel@kolivas.org>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com>
	 <200605160945.13157.kernel@kolivas.org>
Content-Type: text/plain
Organization: Intel
Date: Tue, 16 May 2006 16:32:11 -0700
Message-Id: <1147822331.4859.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 09:45 +1000, Con Kolivas wrote:

> 
> Yes it's only designed to detect something that has been asleep for an 
> arbitrary long time and "categorised as idle"; it is not supposed to be a 
> priority stepping stone for everything, in this case at MAX_BONUS-1. Mike 
> proposed doing this instead, but it was never my intent. 

It seems like just one sleep longer than INTERACTIVE_SLEEP is needed
kick the priority of a process all the way to MAX_BONUS-1 and boost the
sleep_avg, regardless of what the prior sleep_avg was.

So if there is a cpu hog that has long sleeps occasionally, once it woke
up, its priority will get boosted close to maximum, likely starving out
other processes for a while till its sleep_avg gets reduced.  This
behavior seems like something to avoid according to the original code
comment.  Are we boosting the priority too quickly?  

Tim

