Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267344AbTAUX32>; Tue, 21 Jan 2003 18:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbTAUX32>; Tue, 21 Jan 2003 18:29:28 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28349 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267344AbTAUX31>;
	Tue, 21 Jan 2003 18:29:27 -0500
Subject: Re: [RFC][PATCH] linux-2.5.59_lost-tick_A0
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <p731y36m6d0.fsf@oldwotan.suse.de>
References: <1043189962.15683.82.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
	 <p731y36m6d0.fsf@oldwotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1043191868.15688.93.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 21 Jan 2003 15:31:08 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 15:27, Andi Kleen wrote:
> Comments:
> 
> Basic idea is good. The x86-64 2.4 tree has a similar solution for the
> same problem. Especially with HZ=1000 this is really needed, because
> now lost ticks are far more common than with the HZ=100 in 2.4.
> I would consider some form of this patch as requirement for 2.6 release.
> 
> what happens when 1000000 does not evenly divide HZ? 
> I think some ports use HZ=1024

Then it comes out to close enough? I'm probably just not getting the
problem. Could you further explain?

> Why is the condition > and not >= ? Eactly two ticks offset is already
> one lost. In fact even >= 1.5*HZ would be dubious.

Exactly two, yes. However 1.5 wouldn't quite do it, as jiffies would be
incremented once and delay_at_last_interrupt should be set to .5*HZ,
thus loosing no time.

> I would like to have some statistics counter somewhere in /proc for lost 
> ticks, so that it can be checked for after bug reports. Perhaps even
> printk for the first 5 or so.

Yea, I had some printk code in there, but I have a card here that can
cause 30ms SMI stalls once per sec, so it was getting a bit verbose.
Although printing out for the first five, would be fine. I'll add that
right away. Thanks!

> Could you please add spaces after /* and before */

Doh, I read and read those style guidelines, but my fingers never seem
to take to em'. 

thanks again,
-john


