Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266063AbRGGIGX>; Sat, 7 Jul 2001 04:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266066AbRGGIGN>; Sat, 7 Jul 2001 04:06:13 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:47312 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266063AbRGGIGH>; Sat, 7 Jul 2001 04:06:07 -0400
Message-ID: <3B46C342.A27D6C50@uow.edu.au>
Date: Sat, 07 Jul 2001 18:07:30 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Henry <henry@borg.metroweb.co.za>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS (kswapd) in 2.4.5 and 2.4.6
In-Reply-To: <01070516412506.06182@borg> <3B457835.F06E49CF@uow.edu.au>,
		<3B457835.F06E49CF@uow.edu.au> <01070708085101.00793@borg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henry wrote:
> 
> ...
> So far, so good.  There has not been a single oops on the two principle
> servers I patched.
> 
> uptime1:                8:04am  up 18:22,  1 user,  load average: 0.09, 0.15, 0.11
> uptime2:                8:04am  up 18:25,  1 user,  load average: 0.15, 0.20, 0.15

OK, that looks good.

> Andrew my china, you are the _MAN_!

Not only that - I have great legs!

>  We should know by monday afternoon
> (the monday morning/midday crunch should provide some valuable
> feedback).

I wonder why it only affects you.  Is the drive which holds
your swap partition running in PIO mode?  `hdparm' will tell
you.  If it is, then that could easily cause the page to come
unlocked before brw_page() has finished touching the buffer
ring.  Then all it takes is a parallel try_to_free_buffers
on the other CPU.

There's a similar bug in __block_write_full_page().  I'll
send a patch...

-
