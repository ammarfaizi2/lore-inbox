Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTHZEEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 00:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTHZEEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 00:04:51 -0400
Received: from anumail5.anu.edu.au ([150.203.2.45]:49878 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S262574AbTHZEEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 00:04:49 -0400
Message-ID: <3F4ADC56.9010900@cyberone.com.au>
Date: Tue, 26 Aug 2003 14:04:38 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v7
References: <3F48B12F.4070001@cyberone.com.au> <29760000.1061744102@[10.10.2.4]> <3F497BB6.90100@cyberone.com.au> <3F49E7D1.4000309@cyberone.com.au> <3070000.1061868247@[10.10.2.4]>
In-Reply-To: <3070000.1061868247@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>>I didn't miss 5 revisions, I'll just stick to using my internal
>>numbering for releases.
>>
>>This one has a few changes. Children now get a priority boost
>>on fork, and parents retain more priority after forking a child,
>>however exiting CPU hogs will now penalise parents a bit.
>>
>>Timeslice scaling was tweaked a bit. Oh and remember raising X's
>>priority should _help_ interactivity with this patch, and IMO is
>>not an unreasonable thing to be doing.
>>
>>Please test. I'm not getting enough feedback!
>>
>
>Well, it's actually a bit faster than either mainline or your previous
>rev whilst running SDET:
>
>SDET 128  (see disclaimer)
>                           Throughput    Std. Dev
>              2.6.0-test4       100.0%         0.3%
>         2.6.0-test4-nick       102.9%         0.3%
>       2.6.0-test4-nick7a       105.1%         0.5%
>
>But kernbench is significantly slower. The increase in sys time has 
>dropped from last time, but user time is up.
>
>Kernbench: (make -j vmlinux, maximal tasks)
>                              Elapsed      System        User         CPU
>              2.6.0-test4       45.87      116.92      571.10     1499.00
>         2.6.0-test4-nick       49.37      131.31      611.15     1500.75
>       2.6.0-test4-nick7a       49.48      125.95      617.71     1502.00
>

Thanks Martin. OK, so the drop in kernbench is quite likely to be what
I thought - elevated priorities (caused by eg. make waiting for children)
causing timeslices to shrink. As long as its not a fundamental problem,
this should be able to be tweaked back.

Yeah, I guess the random kernel and user times are probably due to cache.



