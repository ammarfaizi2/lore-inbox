Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132125AbRDCBrv>; Mon, 2 Apr 2001 21:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132337AbRDCBrl>; Mon, 2 Apr 2001 21:47:41 -0400
Received: from central.caverock.net.nz ([210.55.207.1]:16134 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id <S132328AbRDCBrj>; Mon, 2 Apr 2001 21:47:39 -0400
Date: Tue, 3 Apr 2001 12:56:40 +1200 (NZST)
From: Eric Gillespie <viking@flying-brick.caverock.net.nz>
To: linux-kernel@vger.kernel.org
Subject: More about 2.4.3 timer problems
Message-ID: <Pine.LNX.4.21.0104031038070.4158-100000@brick.flying-brick.caverock.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First off, CC: back to me, as my machine can't handle an estimated 200
messages a day for me to sign up to the list 8-( - Anyway..

I updated my kernel to 2.4.3 when the patch was released. As I said earlier, I
noticed my timer losing a few seconds over the space of a couple of
hours.  Well, I have since found out that the amount of time lost is
proportional to the load on the machine: the heavier the load, the more time
lost.

I found this out while I was compiling a kernel, incidentally:

kernel-2.4.3 (and I am trying this without the TSC enabled, but it hasn't
made any difference that I've noticed), other details as before.
I really DON'T want to be running a cron job to re-read the CMOS
clock every minute or so - that's a patch, not a fix.


Output from "time make -j 3 bzImage"

VESA fb mode 1280x1024x16, clock lost 1m 35s in time
996.52 user 166.82 system 23:19.40 elapsed 83% CPU 
(0 avgtext+0 avgdata 0 maxresident)k 
0 inputs+0 outputs (471222 major+583276 minor) pagefaults 0swaps

Same command, fbmode 640x480x24, clock lost 19s in time
751.42 user 89.47 system 18:40.79 elapsed 75% CPU 
(0 avgtext+0 avgdata 0 maxresident)k
0inputs+0outputs (468926 major+578877 minor) pagefaults 0 swaps

Same command, normal (non-fb mode) lost no time off clock.
991.13 user 160.44 system 22:38.15 elapsed 84% CPU 
(0 avgtext+0 avgdata 0 maxresident)k 0 inputs+0 outputs 
(468051 major+577233 minor) pagefaults 0 swaps

Hope this helps out, and by the way, thank you to Mark Hahn & Gerhard Mack for
their suggestions.

-- 
 /|   _,.:*^*:.,   |\           Cheers from the Viking family, 
| |_/'  viking@ `\_| |            including Pippin, our cat
|    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
 \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!



