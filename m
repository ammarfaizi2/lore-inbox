Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135914AbRD3VvM>; Mon, 30 Apr 2001 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135917AbRD3VvC>; Mon, 30 Apr 2001 17:51:02 -0400
Received: from fep01.swip.net ([130.244.199.129]:10891 "EHLO
	fep01-svc.swip.net") by vger.kernel.org with ESMTP
	id <S135914AbRD3Vut>; Mon, 30 Apr 2001 17:50:49 -0400
Date: Mon, 30 Apr 2001 23:45:53 +0200 (CEST)
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
X-X-Sender: <petero@ppro.localdomain>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 sluggish under fork load
In-Reply-To: <20010430195149.F19620@athlon.random>
Message-ID: <Pine.LNX.4.33.0104302330430.10480-100000@ppro.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Andrea Arcangeli wrote:

> please try to reproduce the bad behaviour with 2.4.4aa2. There's a bug
> in the parent-timeslice patch in 2.4 that I fixed while backporting it
> to 2.2aa and that I now forward ported the fix to 2.4aa. The fact
> 2.4.4 gives the whole timeslice to the child just gives more light to
> such bug. Unfortunately the fix doesn't apply cleanly to 2.4.4 (it's
> incremental with the numa-scheduler patch) and I need to finish a few
> more things before I can backport it myself.

I applied the 10_parent-timeslice-5 patch to 2.4.4 and tested. (If I
understood correctly, the idea of that patch is to give the remaining
child time-slice back to the parent when the child exits, but only if
there have been no time-slice recalculation since the child was created.)

It is somewhat better than plain 2.4.4, but not much. I still see
scheduling delays in the range 30-120ms when running "./fork 0.4". (fork
is a program that starts a child, the child busy waits some time (0.4s)
and then exits. The parent then immediately respawns another child, etc.
See one of my previous messages.)

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden


