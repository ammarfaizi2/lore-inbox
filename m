Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132311AbQKKBSt>; Fri, 10 Nov 2000 20:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132310AbQKKBSj>; Fri, 10 Nov 2000 20:18:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31501 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131845AbQKKBSY>; Fri, 10 Nov 2000 20:18:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Wild thangs, was: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue
Date: 10 Nov 2000 17:18:13 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ui6ol$c4a$1@cesium.transmeta.com>
In-Reply-To: <3A0C427A.E015E58A@timpanogas.org> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <3A0C929B.EE6F7137@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A0C929B.EE6F7137@linux.com>
By author:    David Ford <david@linux.com>
In newsgroup: linux.dev.kernel
> 
> - Requires high load average allowance
>     Incorrect.  Same machine barely spiked a tenth of a point for this load and dropped
> back to .05.  Only time I adjusted the configured load average allowance was back in my
> naive days and we got hit with 80,000 in the queue at one time from multiple spammers.
> Part of this test's load came from numerous things running and the mail sending required
> spinup of the drive which blocked.
> 

Well, I think it does, but not because it itself is generating much of
a load.  I had it block traffic on my desktop machine while doing a
kernel compile; I run with high parallelism and the load occationally
spikes in the high 20's.  However, the machine is perfectly
responsive, and so I was a little taken back by this.

The way Linux computes the load average really does call for higher
limits than what BSD does.  This isn't inherently a "good" or "bad"
thing -- it's just a fact of life.  That being said, it probably would
be useful if the Sendmail people would provide higher default limits
in cf/ostype/linux.m4 than for other systems.

The one thing about load average that is making it a bit hard to deal
with is that workloads on modern machines tend to vary a little too
quickly for the standard load average time constants to deal well with
them.  It's probably fine for throttling down a machine that is
getting killed with requests, but not really enough to keep, say,
parallel make without a limit ("make -j" as opposed to "make -j5")
from forking the machine to the point where the make itself fails
before knowing what just hit it.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
