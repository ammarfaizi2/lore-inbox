Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317320AbSGIG5b>; Tue, 9 Jul 2002 02:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317324AbSGIG5a>; Tue, 9 Jul 2002 02:57:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56844 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317320AbSGIG53>;
	Tue, 9 Jul 2002 02:57:29 -0400
Message-ID: <3D2A8B81.42042058@zip.com.au>
Date: Tue, 09 Jul 2002 00:06:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: readprofile from 2.5.25 web server benchmark
References: <3D2A8152.7040200@us.ibm.com> <3D2A863D.DC0AF866@zip.com.au> <3D2A8779.9070104@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> ...
> > I'd be interested in the effect of the latter.  It's very 2.4-able.
> 
> Do you mean 2.5-able?
> http://www.google.com/search?hl=en&ie=UTF-8&oe=UTF-8&q=smptimers+2.5
> 
> I found a couple of 2.5.*teen patches, but they're miles away from
> applying cleanly.  Work for tomorrow, sigh...
> 

Nah.  I mean this technological gem:


--- 2.5.25/kernel/timer.c~timer-speedup	Tue Jul  9 00:04:33 2002
+++ 2.5.25-akpm/kernel/timer.c	Tue Jul  9 00:06:09 2002
@@ -211,6 +211,9 @@ int mod_timer(struct timer_list *timer, 
 	int ret;
 	unsigned long flags;
 
+	if (timer_pending(timer) && timer->expires == expires)
+		return 1;
+
 	spin_lock_irqsave(&timerlist_lock, flags);
 	timer->expires = expires;
 	ret = detach_timer(timer);

-
