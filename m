Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWAPOqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWAPOqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 09:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWAPOqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 09:46:04 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:53221 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1750837AbWAPOqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 09:46:01 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ktimer not firing ?
Date: Mon, 16 Jan 2006 09:45:46 -0500
User-Agent: KMail/1.8
Cc: Steven Rostedt <rostedt@goodmis.org>, kernelnewbies@nl.linux.org,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
References: <200511171639.27565.cloud.of.andor@gmail.com> <1132248488.10522.4.camel@localhost.localdomain>
In-Reply-To: <1132248488.10522.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601160945.47973.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I know that ktimer is not yet part of the main tree of the Linux
kernel...

I need an high precision timer in a kernel module for 2.6.14, so I chose to 
use ktimers.

My timer must be stopped and reprogrammed very frequently.

This is how I initialize the timer:

struct ktimer mytimer;
ktimer_init(&mytimer);
mytimer.function = myfunction;
mytimer.data = NULL;


This is how I stop the timer:

ktimer_cancel(&mytimer);


This is how I restart the timer:

ktime_t mytime = ktime_set(...,...);
ktimer_start(&mytimer, &mytime, KTIMER_REL)


However, the timer never fires. I checked the return value of the start and 
it's correct (0 = success). Any idea of why the timer does not fire ?

I tried also by directly using ktimer_restart instead of ktimer_cancel + 
ktimer_start, but the timer does not fire either.
The module has also another ktimer which works perfectly...


Many thanks for your help,

                     Claudio

