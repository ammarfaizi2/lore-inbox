Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVJSLUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVJSLUF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVJSLUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:20:05 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:22676 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750708AbVJSLUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:20:01 -0400
Date: Wed, 19 Oct 2005 13:19:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@lysdexia.org>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, cc@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051019111943.GA31410@elte.hu>
References: <20051017160536.GA2107@elte.hu> <1129576885.4720.3.camel@cmn3.stanford.edu> <1129599029.10429.1.camel@cmn3.stanford.edu> <20051018072844.GB21915@elte.hu> <1129669474.5929.8.camel@cmn3.stanford.edu> <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@lysdexia.org> wrote:

> Hello,
> 
> Getting up to speed on the latest -rt changes again.  Just happened to 
> notice this warning with -rt8 and -rt9:
> 
> kernel/ktimers.c: In function `check_ktimer_signal': 
> kernel/ktimers.c:1209: warning: passing argument 1 of 
> `unlock_ktimer_base' from incompatible pointer type
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

indeed - and this could explain some of the lockups reported. I've 
uploaded -rt10 with your fix included.

	Ingo
