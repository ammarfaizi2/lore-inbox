Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbTFQXAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 19:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264998AbTFQXAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 19:00:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:28351 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264997AbTFQXAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 19:00:20 -0400
Date: Wed, 18 Jun 2003 01:14:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: davidm@hpl.hp.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, Riley Williams <Riley@Williams.Name>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Message-ID: <20030618011411.A23198@ucw.cz>
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name> <16111.37901.389610.100530@napali.hpl.hp.com> <20030618002146.A20956@ucw.cz> <16111.38768.926655.731251@napali.hpl.hp.com> <20030618004233.B21001@ucw.cz> <16111.40816.147471.84610@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16111.40816.147471.84610@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Tue, Jun 17, 2003 at 04:08:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 04:08:32PM -0700, David Mosberger wrote:

> >>>>> On Wed, 18 Jun 2003 00:42:33 +0200, Vojtech Pavlik <vojtech@suse.cz> said:
> 
>   >> so if a legacy speaker is present, it assumes a particular
>   >> frequency.  In other words: it's a driver issue.  On ia64, this
>   >> frequency certainly has nothing to do with time-keeping and
>   >> therefore doesn't belong in timex.h.
> 
>   Vojtech> I'm quite fine with that. However, different (sub)archs,
>   Vojtech> for example the AMD Elan CPUs have a slightly different
>   Vojtech> base frequency. So it looks like an arch-dependent #define
>   Vojtech> is needed. I don't care about the location (timex.h indeed
>   Vojtech> seems inappropriate, maybe the right location is pcspkr.c
>   Vojtech> ...), or the name, but something needs to be done so that
>   Vojtech> the beeps have the same sound the same on all archs.
> 
> Sounds much better to me.  Wouldn't something along the lines of this
> make the most sense:
> 
>   #ifdef __ARCH_PIT_FREQ
>   # define PIT_FREQ	__ARCH_PIT_FREQ
>   #else
>   # define PIT_FREQ	1193182
>   #endif
> 
> After all, it seems like the vast majority of legacy-compatible
> hardware _do_ use the standard frequency.

Now, if this was in some nice include file, along with the definition of
the i8253 PIT spinlock, that'd be great. Because not just the beeper
driver uses the PIT, also some joystick code uses it if it is available.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
