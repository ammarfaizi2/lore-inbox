Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbUJ3UQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbUJ3UQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 16:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbUJ3UQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 16:16:08 -0400
Received: from pop.gmx.net ([213.165.64.20]:51176 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261307AbUJ3UPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 16:15:52 -0400
X-Authenticated: #4399952
Date: Sat, 30 Oct 2004 22:15:48 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030221548.5e82fad5@mango.fruits.de>
In-Reply-To: <1099165925.1972.22.camel@krustophenia.net>
References: <20041029172243.GA19630@elte.hu>
	<20041029203619.37b54cba@mango.fruits.de>
	<20041029204220.GA6727@elte.hu>
	<20041029233117.6d29c383@mango.fruits.de>
	<20041029212545.GA13199@elte.hu>
	<1099086166.1468.4.camel@krustophenia.net>
	<20041029214602.GA15605@elte.hu>
	<1099091566.1461.8.camel@krustophenia.net>
	<20041030115808.GA29692@elte.hu>
	<1099158570.1972.5.camel@krustophenia.net>
	<20041030191725.GA29747@elte.hu>
	<20041030214738.1918ea1d@mango.fruits.de>
	<1099165925.1972.22.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 15:52:04 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> Yup there is definitely something not right:

[snip]

> You should modify the program to print something when it sees a big
> miss.  This would make it easier to figure out what kind of system
> activity triggers the problem.

right, i just wanted to avoid doing that from the process that polls itself,
because a std::cout << "ugh!" << std::endl; might already be enough to skew
the following irq's, right?

anyways, this new version [just upped] prints a line when a missed irq was
detected. Also this version understands a third parameter which acts as an
upper threshold. A line is printed when the difference of the cycle count of
two consecutive wakeups is greater than the threshold.

run it once w/o threshold on an idle system to see what a useful thresh
would be.

i use it like this for example:

./rt_wakeup 1024 50000 1200000

What's the best way to find out the cycles/s of the cpu? This way the
input/output could become a little nicer [because then i can calculate
programatically how long a "perfect" period should be in cycles].

flo
