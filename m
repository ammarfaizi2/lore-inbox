Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbULIUBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbULIUBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbULIUBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:01:46 -0500
Received: from mail.timesys.com ([65.117.135.102]:960 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261597AbULIUBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:01:40 -0500
Message-ID: <41B8AE75.2090905@timesys.com>
Date: Thu, 09 Dec 2004 14:58:45 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Mark_H_Johnson@raytheon.com, Florian Schmidt <mista.tapas@gmx.net>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
References: <Pine.OSF.4.05.10412091907430.4626-100000@da410.ifa.au.dk>
In-Reply-To: <Pine.OSF.4.05.10412091907430.4626-100000@da410.ifa.au.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2004 19:54:10.0046 (UTC) FILETIME=[D963A1E0:01C4DE28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:

> Muteces are also an overhead. There must be a lot of locks in the system
> which can safely be transfered back to raw spinlocks as the locking time
> is in the same order of the locking time internally in a mutex. There is
> no perpose of using a mutex instead of a raw spinlock if the region being
> locked is shorter or about the same as the job of handling the mutex
> internals and rescheduling (twice)!

That will certainly be the case in some scenarios.  It seems
useful for the mutex user to have a means to advice of the
anticipated usage (hold time).

The other [perhaps additional] means of adaptation would be
Solaris-style where a failed mutex acquisition attempt would
spin rather than block the caller if the mutex owner is
currently running on some other cpu.  The rationale being the
spin wait time is less overhead compared with two context
switches.  Though I'd expect this ideal has been batted around
here before.

-john

-- 
john.cooper@timesys.com
