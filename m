Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWDVViZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWDVViZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWDVViZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:38:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43461 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751170AbWDVViY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:38:24 -0400
Date: Sat, 22 Apr 2006 23:37:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: dean gaudet <dean@arctic.org>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [PATCH] off-by-1 in kernel/power/main.c
Message-ID: <20060422213754.GA23981@elf.ucw.cz>
References: <Pine.LNX.4.64.0604212055390.24100@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604212055390.24100@twinlark.arctic.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> there's an off-by-1 in 2.6.16.9 (and 2.6.17-rc2) 
> kernel/power/main.c:state_store() ... if your kernel just happens to have 
> some non-zero data at pm_states[PM_SUSPEND_MAX] (i.e. one past the end of 
> the array) then it'll let you write anything you want to /sys/power/state 
> and in response the box will enter S5.
> 
> i randomly discovered this because i really wanted to put my box into S5 
> (for wake on lan) and tried "echo off >/sys/power/state" and was quite 
> happy that the box entered S5... happy until i compiled a different kernel 
> and this S5 trick stopped working :)
> 
> anyhow, this begs the question, what is the correct way to get a box to 
> shutdown into s5?  on a fc4 box i have here it does that happily, but 
> ubuntu boxes don't seem to go into s5... and i couldn't figure out from 
> fc4 patches if they'd changed anything in this area.  pointers 
> appreciated.
> 
> btw i can whip up a patch making "off" a valid value for /sys/power/state 
> ...

Looks okay to me. Can you add acked-by: Pavel Machek and mail it to
akpm?

Valid way to power off machine is by shutdown -o now, and there's a
syscall to do that. It should not be done by /sys/power/state.

								Pavel

-- 
Thanks for all the (sleeping) penguins.
