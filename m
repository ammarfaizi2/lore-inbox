Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbTBGVJW>; Fri, 7 Feb 2003 16:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266660AbTBGVJW>; Fri, 7 Feb 2003 16:09:22 -0500
Received: from ns.suse.de ([213.95.15.193]:15370 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266564AbTBGVJV>;
	Fri, 7 Feb 2003 16:09:21 -0500
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
References: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Feb 2003 22:19:01 +0100
In-Reply-To: john stultz's message of "7 Feb 2003 21:31:51 +0100"
Message-ID: <p73ptq3bxh6.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> writes:

> Joel, All,
> 
> 	This patch moves the get_cycles() implementation into the timer_opts
> subsystem. This patch corrects issues between the hangcheck-timer code
> and systems running with timer_cyclone. As an extra bonus, it removes
> the CONFIG_X86_TSC #ifdef in get_cycles replacing it with
> timer->get_cycles(). 
> 
> Comments flames and suggestions welcome.

Is this really a good idea? get_cycles is normally not used to get accurate
time, but just to get random numbers for /dev/random or quickly estimate
some code (scheduler used to use it for that). I think the TSC even when
unsynchronized is better for that than an external timer which potentially
lower resolution and long access time.

If you really added it I would at least change the random device to 
use the old macro.

-Andi
