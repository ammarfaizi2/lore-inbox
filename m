Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUJaTH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUJaTH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 14:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUJaTH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 14:07:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:21997 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261624AbUJaTHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 14:07:00 -0500
X-Authenticated: #4399952
Date: Sun, 31 Oct 2004 20:06:21 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031200621.212ee044@mango.fruits.de>
In-Reply-To: <20041031165913.2d0ad21e@mango.fruits.de>
References: <1099165925.1972.22.camel@krustophenia.net>
	<20041030221548.5e82fad5@mango.fruits.de>
	<1099167996.1434.4.camel@krustophenia.net>
	<20041030231358.6f1eeeac@mango.fruits.de>
	<1099171567.1424.9.camel@krustophenia.net>
	<20041030233849.498fbb0f@mango.fruits.de>
	<20041031120721.GA19450@elte.hu>
	<20041031124828.GA22008@elte.hu>
	<1099227269.1459.45.camel@krustophenia.net>
	<20041031131318.GA23437@elte.hu>
	<20041031134016.GA24645@elte.hu>
	<20041031162059.1a3dd9eb@mango.fruits.de>
	<20041031165913.2d0ad21e@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004 16:59:13 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> p.s. new rtc_wakeup version uploaded, which shows the percentage converted
> to usecs (always positive, you need the sign?). btw: with V0.6.2 i sometimes
> see jitter > 100% but still no lost irq (/dev/rtc still reports only 1
> delivered irq on next wakeup). I cannot provke lost irqs with -f up to 2048.
> With -f 8192 i do get lost irq's [not amazing though].

another update upped. small bugfix (still depended on jack, should work now
w/o jack installed) plus minor cosmetic corrections. Here's example output
for 2.6.8.1-P9 (under heavy load (multiple finds plus kernel compile plus UI
artistics):

~/source/my_projects/rtc_wakeup$ ./rtc_wakeup 
rtc_wakeup - press ctrl-c to stop
freq:             1024
max # of irqs:    0 (run until stopped)
jitter threshold: 5% (48 usec)
output filename:  /dev/null
rt priority:      90(91)
getting cpu speed
1194913254.155 Hz (1194.913 MHz)
# of cycles for "perfect" period: 1166907 (976 usec)
setting up ringbuffer
setting up consumer thread
setting up /dev/rtc
locking memory
turning irq on, beginning measurement
new max. jitter: 1.6% (15 usec)
new max. jitter: 1.9% (18 usec)
new max. jitter: 2.6% (25 usec)
new max. jitter: 2.9% (28 usec)
new max. jitter: 3.2% (31 usec)
new max. jitter: 3.3% (31 usec)
new max. jitter: 3.3% (32 usec)
new max. jitter: 3.5% (34 usec)
new max. jitter: 3.5% (34 usec)
new max. jitter: 3.7% (35 usec)
new max. jitter: 4.3% (41 usec)
new max. jitter: 4.9% (47 usec)
threshold violated: 5.6% (54usec)
new max. jitter: 5.6% (54 usec)
threshold violated: 5.3% (51usec)
done.
total # of irqs:      168072
missed irqs:          0
threshold violations: 2
max jitter:           5.6% (54 usec)

So basically like lee said, 7% seems to be a normal upper limit for VP
boxes (there might be spikes though). 

V0.6.2 looked good, too, until it locked up again (under heavy load with
rtc_wakeup running) ;) Will build one with debugging enabled tomorrow. 

flo
