Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVAXGkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVAXGkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVAXGhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:37:07 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:26281 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261452AbVAXGeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:34:50 -0500
Message-ID: <41F49735.5000400@kolivas.org>
Date: Mon, 24 Jan 2005 17:35:33 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org>	<877jm3ljo9.fsf@sulphur.joq.us> <41F44AC2.1080609@kolivas.org>	<87hdl7v3ik.fsf@sulphur.joq.us> <87651nv356.fsf@sulphur.joq.us> <87ekgbqr2a.fsf@sulphur.joq.us>
In-Reply-To: <87ekgbqr2a.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> I'll try building a SCHED_RR version of JACK.  I still don't think it
> will make any difference.  But my intuition isn't working very well
> right now, so I need more data.

Could be that despite what it appears, FIFO behaviour may be desirable 
to RR. Also the RR in SCHED_ISO is pretty fast at 10ms. However with 
nothing else really running it just shouldn't matter...

> I still wonder if some coding error might occasionally be letting a
> lower priority process continue running after an interrupt when it
> ought to be preempted.

That's one distinct possiblity. Preempt code is a particular problem.
You are not running into the cpu limits of SCHED_ISO so something else 
must be responsible. If we are higher priority than everything else and 
do no expire in any way there is no reason we shouldn't perform as well 
as SCHED_FIFO.

There is some sort of privileged memory handling when jackd is running 
as root as well, so I don't know how that features here. I can't imagine 
it's a real issue though.

Con


