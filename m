Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131918AbQLIVh1>; Sat, 9 Dec 2000 16:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131931AbQLIVhR>; Sat, 9 Dec 2000 16:37:17 -0500
Received: from ja.ssi.bg ([193.68.177.189]:18436 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S131918AbQLIVhI>;
	Sat, 9 Dec 2000 16:37:08 -0500
Date: Sat, 9 Dec 2000 23:05:28 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: "Victor J. Orlikowski" <v.j.orlikowski@gte.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18pre25, S3, AMD K6-2, and MTRR....
Message-ID: <Pine.LNX.4.21.0012092218280.877-100000@u>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sat, 9 Dec 2000, Victor J. Orlikowski wrote:

>       However, in X I get *random* lock-ups (sometimes when gdm
>       starts, sometimes when using gmc, etc.)
>       Disabling MTRR seems to have cured the problem, for now (I
>       haven't *seen* anything random *yet*; I'll report back if I do.)
>       I'm using XFree 3.3.6, and the SVGA server.
>       Ideas?


	Huh, the same problem, lockups with K6-2 500MHz but with
another S3 card.

I have changed only the CPU from K6-2 266 (overclocked to 300, running
stable for more than 2 years) with a K6-2 500MHz model 8 stepping 12.
The change occured in 2.2.18pre19 but I tried with different kernels:

2.2.18pre19 - plain, no MTRR support
2.2.17 - plain, no MTRR support
2.2.18pre22 - with 2.2.18pre21aa2 and ide patches, with MTRR support
2.4.0-test11 - plain, with MTRR support

When MTRR support is compiled in, I don't put any settings in /proc/mtrr

Sometimes the lockups are forever (I don't wait them for more
than 15mins => power off) or for 3-5 seconds, mouse stops, vmstat
shows 100% user CPU busy in these 3-5 seconds, 17 blocks written:

 2  0  0      0  46664   8024  71316   0   0     0     0  607   919  39   3  58
 2  0  0      0  46660   8028  71316   0   0     0     0  565   146  99   1   0
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 3  0  0      0  46660   8028  71316   0   0     0    17  475   131 100   0   0
 								    ^^^
 2  0  0      0  46660   8028  71316   0   0     0     0  375   134 100   0   0
 3  0  0      0  46656   8032  71316   0   0     0     0  327   136  99   1   0
 2  0  0      0  46652   8032  71316   0   0     0     0  102   902  89   1  10
 2  0  0      0  46656   8032  71316   0   0     0     0  227   590   9   1  90
 1  0  0      0  46652   8032  71316   0   0     0    19  224  1181  16   4  80


	The CPU is cold. The problems occur when there is no big
CPU/disk activity. It can work without problems even when I make bzImage
or running benchmark software (nbench).

Tested on XFree 3.3.5 and 3.3.6: the same lockups. The lockups can occur
when I switch the virtual destktops from the KDE panel, when working
with the pine program or when starting new console terminal on the same
desktop. No problems in text consoles, only in KDE 1.1.2 and 2.0. Two
times I saw something strange: the video image was zoomed and showed
twice in the upper half of the screen. No lockups but switching to/from
text consoles solves the problem.

	Tested with Windows 95/98, works on the same hardware with no
problems!!!

The hardware:

Video S3 GX2 4MB AGP, Motherboard: Shuttle 591P Via MVP3,
BIOS image 591pwiqf, 192MB RAM

  Bus  1, device   0, function  0:
    VGA compatible controller: S3 Inc. ViRGE/GX2 (rev 6).
      Medium devsel.  IRQ 10.  Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xd0000000 [0xd0000000].


	So, is this a S3 problem with many different cards or this is a
K6-2 stepping 12 problem, kernel K6 support or XFree problem?


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
