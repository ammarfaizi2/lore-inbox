Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWDOXXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWDOXXN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWDOXXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:23:12 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:3210 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932147AbWDOXXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:23:12 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Sun, 16 Apr 2006 09:22:59 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604151705.18786.kernel@kolivas.org> <200604152345.39850.a1426z@gawab.com>
In-Reply-To: <200604152345.39850.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604160923.00047.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 April 2006 06:45, Al Boldi wrote:
> Con Kolivas wrote:
> > Thanks for bringing this to my attention. A while back I had different
> > management of forked tasks and merged it with PF_NONSLEEP. Since then
> > I've changed the management of NONSLEEP tasks and didn't realise it had
> > adversely affected the accounting of forking tasks. This patch should
> > rectify it.
>
> Congrats!
>
> Much smoother, but I still get this choke w/ 2 eatm 9999 loops running:

> 9 MB 783 KB eaten in 130 msec (74 MB/s)
> 9 MB 783 KB eaten in 2416 msec (3 MB/s)		<<<<<<<<<<<<<
> 9 MB 783 KB eaten in 197 msec (48 MB/s)

> You may have to adjust the kb to get the same effect.

I've seen it. It's an artefact of timekeeping that it takes an accumulation of 
data to get all the information. Not much I can do about it except to have 
timeslices so small that they thrash the crap out of cpu caches and 
completely destroy throughput.

The current value, 6ms at 1000HZ, is chosen because it's the largest value 
that can schedule a task in less than normal human perceptible range when two 
competing heavily cpu bound tasks are the same priority. At 250HZ it works 
out to 7.5ms and 10ms at 100HZ. Ironically in my experimenting I found the 
cpu cache improvements become much less significant above 7ms so I'm very 
happy with this compromise.

Thanks!

-- 
-ck
