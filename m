Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbUJ3TwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbUJ3TwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbUJ3TwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:52:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44977 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261288AbUJ3TwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:52:07 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041030214738.1918ea1d@mango.fruits.de>
References: <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu>
	 <1099091566.1461.8.camel@krustophenia.net> <20041030115808.GA29692@elte.hu>
	 <1099158570.1972.5.camel@krustophenia.net> <20041030191725.GA29747@elte.hu>
	 <20041030214738.1918ea1d@mango.fruits.de>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 15:52:04 -0400
Message-Id: <1099165925.1972.22.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 21:47 +0200, Florian Schmidt wrote:
> Hi, in the meantime i also booted into P9 again and the results differ
> dramatically. Much better in P9. Anyways, i reuploaded the tarball. The
> program tries to detect missed irq's now and counts the total number of
> irq's delivered by /dev/rtc. Since the program does not recover from missed
> irq's the "statistical" data for these runs is useless [except for the
> knowledge of the fact that one or more irq was missed :)]

Yup there is definitely something not right:

rlrevell@mindpipe:~/cvs/wakeup$ ./rt_wakeup 1024 100000
freq: 1024 #: 100000
setting up /dev/rtc.
locking memory...
turning irq on, beginning measurement (might take a while).
done.

total # of irqs: 100065. missed irq's: 4

mean cycle difference betweem two wakeups: 586332 cycles

min. cycle difference betweem two wakeups: 25184 cycles (#: 28766)
 diff from mean diff: 561148

max. cycle difference betweem two wakeups: 2.78432e+07 cycles (#: 98195)
 diff from mean diff: 2.72569e+07

mean difference from mean difference: 3759.45 cycles

You should modify the program to print something when it sees a big
miss.  This would make it easier to figure out what kind of system
activity triggers the problem.

Lee


