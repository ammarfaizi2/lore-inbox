Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVLUWOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVLUWOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVLUWOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:14:17 -0500
Received: from mail3.uklinux.net ([80.84.72.33]:6288 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S964815AbVLUWOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:14:16 -0500
Date: Wed, 21 Dec 2005 22:21:15 +0000
From: John Rigg <lk@sound-man.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: 2.6.15-rc5-rt4 fails to compile
Message-ID: <20051221222115.GA5043@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to compile 2.6.15-rc5-rt4 on x86_64 SMP but it failed with the
following error:

kernel/hrtimer.c: In function 'hrtimer_cancel':
kernel/hrtimer.c:673: error: 'HRTIMER_SOFTIRQ' undeclared (first use in this function)
kernel/hrtimer.c:673: error: (Each undeclared identifier is reported only once
kernel/hrtimer.c:673: error: for each function it appears in.)
make[1]: *** [kernel/hrtimer.o] Error 1
make: *** [kernel] Error 2

HRTIMER_SOFTIRQ is defined in include/linux/interrupt.h on line 24, but it's
dependent on
#ifdef CONFIG_HIGH_RES_TIMERS
which I haven't set in my .config. It's inside an enum so I can't
just remove the #ifdef and make it always defined without changing
the value of the following enum element (not sure what will break if
I try that).

John
