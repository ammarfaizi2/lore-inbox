Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbUJaMNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbUJaMNf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUJaMMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:12:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43685 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261565AbUJaMKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 07:10:03 -0500
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
In-Reply-To: <20041031110039.4575e49c@mango.fruits.de>
References: <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu>
	 <1099091566.1461.8.camel@krustophenia.net> <20041030115808.GA29692@elte.hu>
	 <1099158570.1972.5.camel@krustophenia.net> <20041030191725.GA29747@elte.hu>
	 <20041030214738.1918ea1d@mango.fruits.de>
	 <1099165925.1972.22.camel@krustophenia.net>
	 <20041030221548.5e82fad5@mango.fruits.de>
	 <1099167996.1434.4.camel@krustophenia.net>
	 <20041030231358.6f1eeeac@mango.fruits.de>
	 <1099189225.1754.1.camel@krustophenia.net>
	 <20041031110039.4575e49c@mango.fruits.de>
Content-Type: text/plain
Date: Sun, 31 Oct 2004 07:09:57 -0500
Message-Id: <1099224598.1459.28.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 11:00 +0100, Florian Schmidt wrote:
> thanks for the patch (it has a little problem, since it uses prio 99 which
> is always equal or greater than the rtc thread prio. i changed it in my
> local version to accept a parameter).

OK good idea.  As in the JACK case, the relative priorities of the RTC
irq thread and the test program should not matter as these two should
never contend - something is seriously wrong if both are ever runnable
at the same time.

Actually this raises an interesting point.  Maybe all IRQ threads should
get the same RT priority by default, so we get FIFO scheduling among IRQ
threads.  It seems like this would make it harder for IRQ threads to
starve each other.  Then we only have to elevate the priority of the IRQ
thread(s) we are interested in.

Another idea is to allow SCHED_FIFO processes of equal priority to
preempt one another on a LIFO basis.  Wouldn't this be very close to the
traditional Linux interrupt model, where interrupts can interrupt each
other and we handle the most recent interrupt first?

Lee



