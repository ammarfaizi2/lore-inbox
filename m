Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130070AbRAHSlU>; Mon, 8 Jan 2001 13:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130324AbRAHSlK>; Mon, 8 Jan 2001 13:41:10 -0500
Received: from [207.113.109.32] ([207.113.109.32]:3590 "HELO cih.com")
	by vger.kernel.org with SMTP id <S130070AbRAHSk6>;
	Mon, 8 Jan 2001 13:40:58 -0500
Date: Mon, 8 Jan 2001 13:40:57 -0500 (EST)
From: "Craig I. Hagan" <hagan@cih.com>
To: Tim Sailer <sailer@bnl.gov>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        jfung@bnl.gov
Subject: Re: Network Performance?
In-Reply-To: <20010108090644.A12440@bnl.gov>
Message-ID: <Pine.LNX.4.20.0101081324430.30022-100000@www.cih.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 101 packets transmitted, 101 packets received, 0% packet loss
> round-trip min/avg/max = 109.6/110.3/112.2 ms
> 
> > Does the problem occur in both directions?
> 
> Good question. I'll find out.
> 
> > Are you _sure_ the window size is being set correctly? How
> > is it being set?
> 
> I'm fairly sure. We echo the value to the file. catting it back
> shows the correct value. If we go lower than default, it slows
> down even more.

what are you setting it to on the solaris machine? what window
sizes have you tried?

Your pipe looks like it will have quite a few bits in flight due to its
latency. From my quick guess math, which sucks, it appears that you can fit 1.2
to 1.5 megabytes on the wire (100mbit machine<-> machine) times 100-120ms wire
time. This is a rather large number, so you may want to see what hosts really
support, perhaps starting with 64k or 128k and work up. Make sure that you have
window scaling turned on if you go with very large windows.

Also, have you upped your socket buffers to match your window sizes?

Last, solaris tends to have poorly tuned tcp values out of the box, look at
this link and tune the solaris stack to better reflect reality.
http://www.google.com/search?q=cache:www.rvs.uni-hannover.de/people/voeckler/tune/EN/tune.html+%2Bwan+%2Bwindow+%2Bscale+%2Bsize+%2Bnetwork&hl=en

linux tuning has a decent amount of data in the docs section of the kernel
sources.

-- craig

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
