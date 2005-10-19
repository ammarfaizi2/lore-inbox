Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbVJSGC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbVJSGC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 02:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbVJSGC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 02:02:26 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45563 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751536AbVJSGCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 02:02:25 -0400
Date: Wed, 19 Oct 2005 02:01:43 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: William Weston <weston@lysdexia.org>
cc: Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       cc@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
Message-ID: <Pine.LNX.4.58.0510190200001.20545@localhost.localdomain>
References: <20051017160536.GA2107@elte.hu>  <1129576885.4720.3.camel@cmn3.stanford.edu>
  <1129599029.10429.1.camel@cmn3.stanford.edu>  <20051018072844.GB21915@elte.hu>
 <1129669474.5929.8.camel@cmn3.stanford.edu> <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005, William Weston wrote:

>
> Getting up to speed on the latest -rt changes again.  Just happened
> to notice this warning with -rt8 and -rt9:
>
> kernel/ktimers.c: In function `check_ktimer_signal':
> kernel/ktimers.c:1209: warning: passing argument 1 of `unlock_ktimer_base' from incompatible pointer type
>
> And the obvious fix:
>
> --- linux/kernel/ktimers.c.orig	2005-10-18 14:10:48.000000000 -0700
> +++ linux/kernel/ktimers.c	2005-10-18 14:24:43.000000000 -0700
> @@ -1206,7 +1206,7 @@
>  		struct ktimer_base *base = lock_ktimer_base(timer, &flags);
>  		ktime_t now = base->get_time();
>
> -		unlock_ktimer_base(base, &flags);
> +		unlock_ktimer_base(timer, &flags);
>
>  		printk("\n");
>  		printk("expires:   %u/%u\n",
>
>

You beat me to the punch.  I noticed this yesterday on -rt8 but I was
already at my hotel and had no internet access (wasn't worth 3 euros to
send right away).

Acked:  Steven Rostedt <rostedt@goodmis.org>

-- Steve

