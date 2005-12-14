Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVLNOFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVLNOFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 09:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVLNOFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 09:05:05 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:20971 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964782AbVLNOFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 09:05:02 -0500
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution
	patches
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       john stultz <johnstul@us.ibm.com>, tglx@linutronix.de
In-Reply-To: <1134568080.18921.42.camel@localhost.localdomain>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
	 <1134568080.18921.42.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 09:04:38 -0500
Message-Id: <1134569078.18921.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 08:48 -0500, Steven Rostedt wrote:

> And going into gdb, I get:
> 
> (gdb) li *0xc0136b98
> 0xc0136b98 is in hrtimer_cancel (kernel/hrtimer.c:671).
> 666     int hrtimer_cancel(struct hrtimer *timer)
> 667     {
> 668             for (;;) {
> 669                     int ret = hrtimer_try_to_cancel(timer);
> 670
> 671                     if (ret >= 0)
> 672                             return ret;
> 673             }
> 674     }
> 675
> 
> So it may not really be locked, and if I waited a couple of hours, it
> might actually finish (the test usually takes a couple of minutes to
> run, and I let it run here for about 20 minutes).

Nope, looking at my test code again, I forgot that I set the program to
max prio, so this would never finish.

-- Steve


