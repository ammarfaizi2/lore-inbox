Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbUKTLvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbUKTLvu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 06:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbUKTLvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 06:51:50 -0500
Received: from imap.gmx.net ([213.165.64.20]:36321 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262728AbUKTLuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 06:50:17 -0500
X-Authenticated: #4399952
Date: Sat, 20 Nov 2004 12:50:57 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041120125057.03b3d8c4@mango.fruits.de>
In-Reply-To: <1100920963.1424.1.camel@krustophenia.net>
References: <20041108091619.GA9897@elte.hu>
	<20041108165718.GA7741@elte.hu>
	<20041109160544.GA28242@elte.hu>
	<20041111144414.GA8881@elte.hu>
	<20041111215122.GA5885@elte.hu>
	<20041116125402.GA9258@elte.hu>
	<20041116130946.GA11053@elte.hu>
	<20041116134027.GA13360@elte.hu>
	<20041117124234.GA25956@elte.hu>
	<20041118123521.GA29091@elte.hu>
	<20041118164612.GA17040@elte.hu>
	<1100920963.1424.1.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004 22:22:42 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2004-11-18 at 17:46 +0100, Ingo Molnar wrote:
> > i have released the -V0.7.29-0 Real-Time Preemption patch, which can be
> > downloaded from the usual place:
> > 
> > 	http://redhat.com/~mingo/realtime-preempt/
> 
> I tried this with CONFIG_PREEMPT_VOLUNTARY (which should theoretically
> work like the earlier VP patches, right?) to test for regressions.  The
> boot process hung after initializing my IDE controller.

I thought so, too, until ingo set me straight (quote ingo):

here are the different layers of preemption:

 - !PREEMPT
 - PREEMPT_VOLUNTARY
 - PREEMPT
 - PREEMPT_RT

each step forward decreases latencies, at the cost of more runtime 
overhead.

so PREEMPT_VOLUNTARY is not "the" feature anymore, it's "a" feature down
the hierarchy. In fact the focus is mostly on PREEMPT_RT now.

quote end..

So with RP kernels, PREEMPT is what gives best latency when full realtime
preemption is not an option

flo
