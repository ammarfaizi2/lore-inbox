Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131153AbRALNOn>; Fri, 12 Jan 2001 08:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131451AbRALNOd>; Fri, 12 Jan 2001 08:14:33 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:56219 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131153AbRALNO0>; Fri, 12 Jan 2001 08:14:26 -0500
Message-ID: <3A5F04BC.1BD5981C@uow.edu.au>
Date: Sat, 13 Jan 2001 00:21:00 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jayts@bigfoot.com, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca,
        mcrichto@mpp.ecs.umass.edu
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <3A5D994A.1568A4D5@uow.edu.au> (message from Andrew Morton on
		Thu, 11 Jan 2001 22:30:18 +1100),
		<3A57DA3E.6AB70887@uow.edu.au> from "Andrew Morton" at Jan 07, 2001 01:53:50 PM <200101110312.UAA06343@toltec.metran.cx> <3A5D994A.1568A4D5@uow.edu.au> <200101110519.VAA02784@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> ...
> Bug:    In the tcp_minisock.c changes, if you bail out of the loop
>         early (ie. max_killed=1) you do not decrement tcp_tw_count
>         by killed, which corrupts the state of the TIME_WAIT socket
>         reaper.  The fix is simple, just duplicate the tcp_tw_count
>         decrement into the "if (max_killed)" code block.

Well that was moderately stupid.  Thanks.  It doesn't seem to cause
problems in practice though.  Maybe in the longer term...

I believe the tcp_minisucks.c code needs redoing irrespective
of latency stuff.  It can spend several hundred milliseconds
in a timer handler, which is rather unsociable.

There are a number of moderately complex ways of smoothing out
its behaviour, but I'm inclined to just punt the whole thing
up to process context via schedule_task().

We'll see...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
