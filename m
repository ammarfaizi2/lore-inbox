Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVKECgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVKECgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 21:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVKECgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 21:36:05 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:24040 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S1750819AbVKECgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 21:36:04 -0500
Subject: Re: 2.6.14-rt1 (now rt6)
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20051030133316.GA11225@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 18:35:24 -0800
Message-Id: <1131158124.4834.24.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-30 at 14:33 +0100, Ingo Molnar wrote:
> i have released the 2.6.14-rt1 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this release is mainly about ktimer fixes: it updates to the latest 
> ktimer tree from Thomas Gleixner (which includes John Stultz's latest 
> GTOD tree), it fixes TSC synchronization problems on HT systems, and 
> updates the ktimers debugging code.
> 
> These together could fix most of the timer warnings and annoyances 
> reported for 2.6.14-rc5-rt kernels. In particular the new 
> TSC-synchronization code could fix SMP systems: the upstream TSC 
> synchronization method is fine for 1 usec resolution, but it was not 
> good enough for 1 nsec resolution and likely caused the SMP bugs 
> reported by Fernando Lopez-Lezcano and Rui Nuno Capela.
> 
> Please re-report any bugs that remain.

I've been running 2.6.14-rt6 fine in my smp system the whole day and
suddenly, just a moment ago, I suddenly started getting key repeats and
screensaver bliiiinks [not my typo]. No HIGH_RES_TIMERS, with
PREEMPT_RT. No messages in the logs or dmesg. 

Doing a loop with "sleep 10" bbracketed by calls to date gives me
sporadic results:

--- Fri Nov  4 18:30:25 PST 2005
10
---
--- Fri Nov  4 19:43:53 PST 2005
10
---
--- Fri Nov  4 19:44:03 PST 2005
3
---
--- Fri Nov  4 18:30:48 PST 2005
10
---
--- Fri Nov  4 18:30:58 PST 2005
0
---
--- Fri Nov  4 18:30:58 PST 2005
2
---
--- Fri Nov  4 18:31:00 PST 2005
10
---
--- Fri Nov  4 18:31:10 PST 2005
10
---

-- Fernando


