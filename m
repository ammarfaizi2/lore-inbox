Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263260AbVFXLnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbVFXLnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbVFXLno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 07:43:44 -0400
Received: from alog0030.analogic.com ([208.224.220.45]:25289 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263260AbVFXLnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 07:43:03 -0400
Date: Fri, 24 Jun 2005 07:42:40 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible spin-problem in nanosleep()
In-Reply-To: <1119546715.17066.20.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0506240733520.20914@chaos.analogic.com>
References: <Pine.LNX.4.61.0506230812160.15775@chaos.analogic.com>
 <jell516ymn.fsf@sykes.suse.de> <Pine.LNX.4.61.0506230841390.15910@chaos.analogic.com>
 <Pine.LNX.4.61.0506231058560.16531@chaos.analogic.com>
 <1119546715.17066.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, Alan Cox wrote:

> For most platforms the scheduler measured busy/idle time is from the
> timer tick. That means its sampled so you are limited to accurate
> information on sleep/wake changes occuring at 1/2 the clock rate or
> less.
>
> Alan
>

So, with a 100 ms sleep, I should see 100 +/- 1 ms, possibly 2 ms
difference in sleep between processes. Then they might not get the
CPU for a whole quantum? Wouldn't each task get the CPU for a whole
tick?

Are you saying that each might get the CPU from between 0 and 1
tick, i.e., asynchronous with the tick? If so, depending upon the
phase between the timer-tick and when a task gets awakened, a task
may never get any CPU time at all. If so, this is a bug.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
