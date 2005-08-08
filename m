Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVHHHit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVHHHit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 03:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVHHHit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 03:38:49 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:24253 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1750749AbVHHHis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 03:38:48 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 8 Aug 2005 00:38:23 -0700
From: Tony Lindgren <tony@atomide.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
Message-ID: <20050808073822.GF28070@atomide.com>
References: <200508031559.24704.kernel@kolivas.org> <200508060239.41646.kernel@kolivas.org> <20050806174739.GU4029@stusta.de> <200508071512.22668.kernel@kolivas.org> <20050807165833.GA13918@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807165833.GA13918@in.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Srivatsa Vaddagiri <vatsa@in.ibm.com> [050807 09:58]:
> On Sun, Aug 07, 2005 at 03:12:21PM +1000, Con Kolivas wrote:
> > Respin of the dynamic ticks patch for i386 by Tony Lindgen and Tuukka Tikkanen 
> > with further code cleanups. Are were there yet?
> 
> Con,
> 	I am afraid until SMP correctness is resolved, then this is not
> in a position to go in (unless you want to enable it only for UP, which
> I think should not be our target). I am working on making this work 
> correctly on SMP systems. Hopefully I will post a patch soon.

Hopefully you get something worked out that works for all. Please see my
amd76x_pm related comments earlier too.

> Another observation I have made regarding dynamic tick patch is that PIT is 
> being reprogrammed whenever the CPUs are coming out of sleep state (because of 
> an interrupt say). This can happen at any arbitary time, not necessarily on 
> jiffy boundaries. As a result, there will be an offset between when jiffy 
> interrupts will now occur vs when they would have originally occured had PIT 
> never been stopped. Not sure if having this offset is good, but atleast one 
> necessary change that I foresee if zeroing delay_at_last_interrupt when 
> disabling dynamic tick.  For that matter, it may be easier to disable the PIT 
> timer by just masking PIT interrupts (instead of changing its mode).

It should not matter when the PIT gets reprogrammed, as the system time is
not updated from PIT timer. Jiffies are calculated from a second timer, such
as ACPI PM timer or TSC.

Tony
