Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVAXEot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVAXEot (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 23:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVAXEot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 23:44:49 -0500
Received: from mail.joq.us ([67.65.12.105]:16569 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261434AbVAXEop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 23:44:45 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org>
	<877jm3ljo9.fsf@sulphur.joq.us> <41F44AC2.1080609@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Sun, 23 Jan 2005 22:45:39 -0600
In-Reply-To: <41F44AC2.1080609@kolivas.org> (Con Kolivas's message of "Mon,
 24 Jan 2005 12:09:22 +1100")
Message-ID: <87hdl7v3ik.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

>>>Second the patch I sent you is fine for testing; I was hoping you
>>>would try it. What you can't do with it is spawn lots of userspace
>>>apps safely SCHED_ISO with it - it will crash, but it not take down
>>>your hard disk. I've had significantly better results with that
>>>patch so far. Then we cn take it from there.

> It was for mm2, but should patch on an iso2 patched kernel.

It does apply to 2.6.11-rc1 (on top of your previous patch) with just
some minor chunk offsets.

The results are excellent...

  http://www.joq.us/jack/benchmarks/sched-isoprio
  http://www.joq.us/jack/benchmarks/sched-isoprio+compile

I updated the summary information to include them...

  http://www.joq.us/jack/benchmarks/cycle_max.log
  http://www.joq.us/jack/benchmarks/delay_max.log
  http://www.joq.us/jack/benchmarks/xrun_count.log

These results are indistinguishable from SCHED_FIFO...

...benchmarks/sched-fifo...
Delay Maximum . . . . . . . . :   347   usecs
Delay Maximum . . . . . . . . :   277   usecs
Delay Maximum . . . . . . . . :   246   usecs
...benchmarks/sched-fifo+compile...
Delay Maximum . . . . . . . . :   285   usecs
Delay Maximum . . . . . . . . :   269   usecs
Delay Maximum . . . . . . . . :   277   usecs
Delay Maximum . . . . . . . . :   569   usecs
Delay Maximum . . . . . . . . :   461   usecs

...benchmarks/sched-isoprio...
Delay Maximum . . . . . . . . :   199   usecs
Delay Maximum . . . . . . . . :   261   usecs
Delay Maximum . . . . . . . . :   305   usecs
...benchmarks/sched-isoprio+compile...
Delay Maximum . . . . . . . . :   405   usecs
Delay Maximum . . . . . . . . :   286   usecs
Delay Maximum . . . . . . . . :   579   usecs

...benchmarks/sched-iso...
Delay Maximum . . . . . . . . : 21410   usecs
Delay Maximum . . . . . . . . : 36830   usecs
Delay Maximum . . . . . . . . :  4062   usecs
...benchmarks/sched-iso+compile...
Delay Maximum . . . . . . . . : 98909   usecs
Delay Maximum . . . . . . . . : 39414   usecs
Delay Maximum . . . . . . . . : 40294   usecs
Delay Maximum . . . . . . . . : 217192   usecs
Delay Maximum . . . . . . . . : 156989   usecs

So, thread priorities clearly do matter, even in this relatively
simple test.  It's amazing how much is going on there, when you look
at it closely.

Is there any chance of these patches working with Ingo's latest RP
patchset?  I just downloaded realtime-preempt-2.6.11-rc2-V0.7.36-02,
but haven't built it yet.
-- 
  joq
