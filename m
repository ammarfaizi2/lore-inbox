Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVJRVld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVJRVld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVJRVlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:41:32 -0400
Received: from unused.mind.net ([69.9.134.98]:2967 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S932150AbVJRVlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:41:32 -0400
Date: Tue, 18 Oct 2005 14:31:49 -0700 (PDT)
From: William Weston <weston@lysdexia.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, cc@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <1129669474.5929.8.camel@cmn3.stanford.edu>
Message-ID: <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
References: <20051017160536.GA2107@elte.hu>  <1129576885.4720.3.camel@cmn3.stanford.edu>
  <1129599029.10429.1.camel@cmn3.stanford.edu>  <20051018072844.GB21915@elte.hu>
 <1129669474.5929.8.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Getting up to speed on the latest -rt changes again.  Just happened 
to notice this warning with -rt8 and -rt9:

kernel/ktimers.c: In function `check_ktimer_signal':
kernel/ktimers.c:1209: warning: passing argument 1 of `unlock_ktimer_base' from incompatible pointer type

And the obvious fix:

--- linux/kernel/ktimers.c.orig	2005-10-18 14:10:48.000000000 -0700
+++ linux/kernel/ktimers.c	2005-10-18 14:24:43.000000000 -0700
@@ -1206,7 +1206,7 @@
 		struct ktimer_base *base = lock_ktimer_base(timer, &flags);
 		ktime_t now = base->get_time();
 
-		unlock_ktimer_base(base, &flags);
+		unlock_ktimer_base(timer, &flags);
 
 		printk("\n");
 		printk("expires:   %u/%u\n",


Cheers
--ww
