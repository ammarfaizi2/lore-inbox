Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWHHO6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWHHO6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWHHO6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:58:38 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:60307 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932602AbWHHO6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:58:37 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] add basic accounting fields to taskstats
Date: Tue, 8 Aug 2006 17:57:58 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200608081757.58340.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Jay Lan wrote:
> > I figured this out. The tsk->stime (and utime as well) are
> > charged by 1 tick (or cputime) from the timer interrupt handler
> > through update_process_times->account_{user,system}_time.
> >
> > The clock resolution is a tick. Any short process less than
> > 1 tick will the counter being 0. It can be from 0 to 0.99999...
> > tick. A half tick is the average value.
>
> But the scheduling happens in the granularity of a tick, so the minimum
> each task gets is a tick.
>
> > I think it makes more sense to assign a half tick than assign
> > 1 usec to the stime. What do you think? Certainly the code need
> > better explanation.
>
> Can't we leave these values as zero in case both stime and utime are zero.

FYI, see "Incorrect CPU process accounting using CONFIG_HZ=100" thread.

IMHO, in-lined process accounting is probably critical for successful 
scheduling.

Thanks!

--
Al

