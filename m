Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVAXG4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVAXG4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVAXG4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:56:36 -0500
Received: from mail.joq.us ([67.65.12.105]:58772 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261460AbVAXG4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:56:10 -0500
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
	<87ekgbqr2a.fsf@sulphur.joq.us> <41F49735.5000400@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 24 Jan 2005 00:57:43 -0600
In-Reply-To: <41F49735.5000400@kolivas.org> (Con Kolivas's message of "Mon,
 24 Jan 2005 17:35:33 +1100")
Message-ID: <873bwrpb4o.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Jack O'Quin wrote:
>> I'll try building a SCHED_RR version of JACK.  I still don't think it
>> will make any difference.  But my intuition isn't working very well
>> right now, so I need more data.
>
> Could be that despite what it appears, FIFO behaviour may be desirable
> to RR. Also the RR in SCHED_ISO is pretty fast at 10ms. However with
> nothing else really running it just shouldn't matter...

That's the way I see it, too.

> There is some sort of privileged memory handling when jackd is running
> as root as well, so I don't know how that features here. I can't
> imagine it's a real issue though.

We use mlockall() to avoid page faults in the audio path.  That should
be happening in all these tests.  The JACK server would complain if
the request were failing, and it doesn't.

How can I verify that the pages are actually locked?  (Even without
mlock(), I don't think I would run out of memory.)
-- 
  joq
