Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbTCSJbX>; Wed, 19 Mar 2003 04:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262960AbTCSJbX>; Wed, 19 Mar 2003 04:31:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:8373 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262959AbTCSJbV>;
	Wed, 19 Mar 2003 04:31:21 -0500
Date: Wed, 19 Mar 2003 01:42:30 -0800
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: tim@physik3.uni-rostock.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nanosleep() granularity bumps
Message-Id: <20030319014230.3412298e.akpm@digeo.com>
In-Reply-To: <3E78384A.6040406@mvista.com>
References: <Pine.LNX.4.33.0303190832430.32325-100000@gans.physik3.uni-rostock.de>
	<3E78384A.6040406@mvista.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 09:42:09.0995 (UTC) FILETIME=[CFE041B0:01C2EDFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> The attached patch is for 2.5.65.  As of this moment, the bk patch has 
> not been posted to the snapshots directory.  I will wait for that to 
> update.

Don't use the snapshots directory.  Use

	http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/

It is more up to date.

> For what its worth, can someone explain how the add_timer call from 
> run_timers was causing a problem.  The code looks right to me, unless 
> the caller is so nasty as to continue to do the same thing (which 
> would loop forever).

That was the problem.

> In this case, the simple fix is to bump the 
> base->timer_jiffies at the beginning of the loop rather than the end. 
>    This would cause the new timer to be put in the next jiffie instead 
> of the current one AND it is free!

Didn't think of that - I just ported up Andrea's fix.


