Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUI1CMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUI1CMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 22:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUI1CMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 22:12:37 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:1993 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S267469AbUI1CMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 22:12:34 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Date: Mon, 27 Sep 2004 22:12:33 -0400
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Paul Fulghum <paulkf@microgate.com>,
       Matt Heler <lkml@lpbproductions.com>, Andrew Morton <akpm@osdl.org>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <20040927204557.GA22542@elte.hu> <20040927230119.GA31278@elte.hu>
In-Reply-To: <20040927230119.GA31278@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409272212.33065.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [141.153.74.116] at Mon, 27 Sep 2004 21:12:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 19:01, Ingo Molnar wrote:
>could you try the patch below ontop of -mm4 and try again the
> .config that failed before? Does the bootup still hang?
>
>The early bootup stage is pretty fragile because the idle thread is
> not yet functioning as such and so we need preemption disabled.
> Whether the bootup fails or not seems to depend on timing details
> so e.g. the presence of SCHED_SMT makes it go away.
>
>disabling preemption explicitly has another advantage: the atomicity
>check in schedule() will catch early-bootup schedule() calls from
> now on.
>
>the patch also fixes another preempt-bkl buglet: interrupt-driven
>forced-preemption didnt go through preempt_schedule() so it resulted
> in auto-dropping of the BKL. Now we go through preempt_schedule()
> which properly deals with the BKL.
>
> Ingo
>

You talked me into it Ingo, and it works with the bkl preempt turned 
on now.  And nothing unusual in the dmesg log.  Make this one part of 
-mm5.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
