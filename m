Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbTHSWmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbTHSWmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:42:36 -0400
Received: from zero.aec.at ([193.170.194.10]:21766 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261306AbTHSWlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:41:49 -0400
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
From: Andi Kleen <ak@muc.de>
Date: Wed, 20 Aug 2003 00:41:20 +0200
In-Reply-To: <mmZK.Q4.11@gated-at.bofh.it> ("Pallipadi, Venkatesh"'s message
 of "Wed, 20 Aug 2003 00:20:12 +0200")
Message-ID: <m37k59s227.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <mmZK.Q4.11@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> writes:

>  /*
> + * Default initialization for 8254 timers. If we use other timers like HPET,
> + * we override this later 
> + */
> +void (*wait_timer_tick)(void) = wait_8254_wraparound;

It would be much cleaner to just poll the generic monotonic time source here,
not add more special cases.

> diff -purN linux-2.6.0-test1/arch/i386/kernel/time_hpet.c linux-2.6.0-test1-hpet/arch/i386/kernel/time_hpet.c
> --- linux-2.6.0-test1/arch/i386/kernel/time_hpet.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.0-test1-hpet/arch/i386/kernel/time_hpet.c	2003-08-18 20:22:06.000
000000 -0700

Shouldn't that be in arch/i386/kernel/timers/hpet.c ? 

Also I suspect it should be made an generic timer object there with
a timer_ops structure. If some hook for that is missing it could be added to 
timer_ops and timers/timer.c

When there is already a generic framework to add new timers it would be a shame
not to use it.

-Andi
