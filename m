Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVAXGfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVAXGfs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVAXGco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:32:44 -0500
Received: from mail.joq.us ([67.65.12.105]:32728 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261454AbVAXG0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:26:38 -0500
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
	<87hdl7v3ik.fsf@sulphur.joq.us> <87651nv356.fsf@sulphur.joq.us>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 24 Jan 2005 00:28:13 -0600
In-Reply-To: <87651nv356.fsf@sulphur.joq.us> (Jack O'Quin's message of "Sun,
 23 Jan 2005 22:53:41 -0600")
Message-ID: <87ekgbqr2a.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin <joq@io.com> writes:

> Will post the correct numbers shortly.  Sorry for the screw-up.

Here they are...

  http://www.joq.us/jack/benchmarks/sched-isoprio
  http://www.joq.us/jack/benchmarks/sched-isoprio+compile

I moved the previous runs to the sched-fifo* directories where they
belong.  For convenience, I moved all the summary data logs here...

  http://www.joq.us/jack/benchmarks/.SUMMARY

Unfortunately, these corrected tests do not compare favorably with the
earlier sched-fifo runs (mistaken or otherwise).  I wanted to believe
the problem was just a matter of priorities, but evidently it is not.

In fact, for this test the priority scheduler does not really help at
all (though I believe it will for other things).  The max delay
numbers are still all over the place...

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
...benchmarks/sched-isoprio...
Delay Maximum . . . . . . . . : 37071   usecs
Delay Maximum . . . . . . . . : 98193   usecs
Delay Maximum . . . . . . . . : 36935   usecs
...benchmarks/sched-isoprio+compile...
Delay Maximum . . . . . . . . : 59662   usecs
Delay Maximum . . . . . . . . : 151624   usecs
Delay Maximum . . . . . . . . : 39250   usecs

I'll try building a SCHED_RR version of JACK.  I still don't think it
will make any difference.  But my intuition isn't working very well
right now, so I need more data.

I still wonder if some coding error might occasionally be letting a
lower priority process continue running after an interrupt when it
ought to be preempted.
-- 
  joq
