Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269233AbUKASHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269233AbUKASHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S285009AbUKASHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:07:17 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:2984
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S284923AbUKASGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:06:41 -0500
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
In-Reply-To: <1099331723.3647.32.camel@krustophenia.net>
References: <20041031120721.GA19450@elte.hu>
	 <20041031124828.GA22008@elte.hu>
	 <1099227269.1459.45.camel@krustophenia.net>
	 <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu>
	 <20041031162059.1a3dd9eb@mango.fruits.de>
	 <20041031165913.2d0ad21e@mango.fruits.de>
	 <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu>
	 <20041101135358.GA19718@elte.hu>  <20041101140630.GA20448@elte.hu>
	 <1099324040.3337.32.camel@thomas>
	 <1099331723.3647.32.camel@krustophenia.net>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 01 Nov 2004 18:58:22 +0100
Message-Id: <1099331902.3337.45.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 12:55 -0500, Lee Revell wrote:
> I think there might even be a _very_ rare errant irq disable in T3 even.
> On my 2-day test runs with 100s of millions of samples, I got 2 or 3
> outliers in each graph.  Jow Gwinn from LKML (thanks Joe) ran a
> statistical analysis that showed these to be independent from the 4 or 5
> underlying exponential distributions (each corresponding to a known or
> suspected nonpreemptible section).  Our theory was that these were very
> rare code paths or race conditions that left IRQs off.  Unfortunately
> this seems impossible to debug unless you have a way to make the machine
> crash dump immediately when it detects the situation.
> 
> Anyway, the clearest way to demonstrate the problem with the -V series
> here is to run the version of Florian's tool that tells you how many
> interrupts were missed.  If I spin my (USB, not sharing irq with
> soundcard) trackball as fast as I can I can get it up to 54 or 55 in a
> row.  If I move it just the right way I can see the humps appear - 2,
> then 15, then 50 then 15 then 2 missed interrupts in a row.  This is at
> 1024Hz - at 2048 I can get it to miss several hundred IRQs, but this
> inevitably locks the machine.
> 
> I suspect the lockups and the latencies are same bug.

Until now there was no output on lockup. No I got one.
The command was: cat /proc/interrupts

Hope that helps

tglx

cat/1488: BUG in down_mutex
at /work/thomas/Linux/2.6.9-mm1-RT/lib/rwsem-generic.c:1059
 [<c01ca9e2>] down_mutex+0x72/0x80 (8)
 [<c012db9a>] __mutex_lock+0x2a/0x40 (36)
 [<c012dbc7>] _mutex_lock+0x17/0x20 (12)
 [<c013fd62>] kfree+0x52/0xf0 (8)
 [<c013fd62>] kfree+0x52/0xf0 (4)
 [<c01774a2>] single_release+0x32/0x40 (32)
 [<c01571ba>] __fput+0x13a/0x150 (20)
 [<c0155899>] filp_close+0x59/0x90 (32)
 [<c015593f>] sys_close+0x6f/0xa0 (24)
 [<c010603b>] syscall_call+0x7/0xb (28)


