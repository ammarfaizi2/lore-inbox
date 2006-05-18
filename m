Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWERFnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWERFnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWERFnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:43:42 -0400
Received: from mail.gmx.de ([213.165.64.20]:10401 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751000AbWERFnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:43:41 -0400
X-Authenticated: #14349625
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, tim.c.chen@linux.intel.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200605181138.26399.kernel@kolivas.org>
References: <4t16i2$142pji@orsmga001.jf.intel.com>
	 <200605181138.26399.kernel@kolivas.org>
Content-Type: text/plain
Date: Thu, 18 May 2006 07:44:24 +0200
Message-Id: <1147931064.7514.39.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 11:38 +1000, Con Kolivas wrote:
> I just want to formalise the relationship between the ceiling, nice 
> value and INTERACTIVE_SLEEP and make the comment clear enough to be 
> understood.

Oh yeah, that reminded me...

INTERACTIVE_SLEEP(p) for nice(>=16) tasks is > NS_MAX_SLEEP_AVG.
CURRENT_BONUS(p) if it took the long sleep path can end up being 11,
which will lead to Ka-[fword]-BOOM in scheduler_tick() for an SMP box.
See TIMESLICE_GRANULARITY(p).  (btdt;) 

	-Mike

