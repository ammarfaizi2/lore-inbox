Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317902AbSGKUho>; Thu, 11 Jul 2002 16:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317905AbSGKUhn>; Thu, 11 Jul 2002 16:37:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18437 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317902AbSGKUhl>; Thu, 11 Jul 2002 16:37:41 -0400
Date: Thu, 11 Jul 2002 16:34:25 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@zip.com.au>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <3D2DBB7B.9020600@evision-ventures.com>
Message-ID: <Pine.LNX.3.96.1020711162333.5732C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2002, Martin Dalecki wrote:

> vmstat.c:
> 
> hz = sysconf(_SC_CLK_TCK);	/* get ticks/s from system */
> 
> And yes I know the libproc is *evil* in this area.
> The rest should be an implementation detail of sysconf().

Yes, any of the changes need to make the dynamic value available to
programs. Alas, too many programs grab the HZ value and compile it in, and
don't work right on a kernel with a modified rate. I don't know if the
CLK_TCK macro is dynamic or not, I sure hope so.

I'd like to see it set at boot time, and available in /proc/sys for easy
use by scripts. As noted by others, there are a lot of uses in the kernel
source which assume that arithmetic will happen at compile time, and even
if you ignore the overhead it would take a lot of rewriting to make it
dynamic. Setting it a boot time gets most of the gain and none of the
pain (boot time = pick a kernel, not a parameter).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

