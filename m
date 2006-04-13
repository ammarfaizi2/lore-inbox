Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWDMLve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWDMLve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 07:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWDMLve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 07:51:34 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:9856 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964881AbWDMLve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 07:51:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Thu, 13 Apr 2006 21:51:21 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604122127.20322.kernel@kolivas.org> <200604121825.55054.a1426z@gawab.com>
In-Reply-To: <200604121825.55054.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604132151.22359.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 01:25, Al Boldi wrote:
> Con Kolivas wrote:
> > Nvidia driver; all separate tasks in top.
>
> On a 400MhzP2 i810drm w/ kernel HZ=1000 it stutters.
> You may want to compensate for nvidia w/ a few cpu-hogs.

I tried adding cpu hogs and it gets extremely slow very soon but still doesn't 
stutter here.

> How many gears fps do you get?

When those 3 are running concurrently (without any other cpu hogs) gears is 
showing 317 fps.

> > range 63-73 seconds.
>
> Could this 10s skew be improved to around 1s to aid smoothness?

I'm happy to try... but I doubt it. 10% difference over 10 tasks over 10 mins 
of tasks of that wake/sleep nature is pretty good IMO. I'll see if there's 
anywhere else I can make the cpu accounting any better. 

As an aside, note that sched_clock and nanosecond timing with TSC isn't 
actually used if you use the pm timer which undoes any high res accounting 
the cpu scheduler can do (I noticed this when playing with pm timer that 
sched_clock just returns jiffies resolution instead of real nanosecond res). 
This could undo any smoothness that good cpu accounting can do.

-- 
-ck
