Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287607AbSAIPp0>; Wed, 9 Jan 2002 10:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287658AbSAIPpR>; Wed, 9 Jan 2002 10:45:17 -0500
Received: from mustard.heime.net ([194.234.65.222]:3277 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S287607AbSAIPo5>; Wed, 9 Jan 2002 10:44:57 -0500
Date: Wed, 9 Jan 2002 16:44:27 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Jens Axboe <axboe@suse.de>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Error reading multiple large files (analyzing... ?)
In-Reply-To: <20020109145952.D19814@suse.de>
Message-ID: <Pine.LNX.4.30.0201091641270.7451-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bad news for Andrew's patch, however I really don't think it would have
> helped you much in the first place. The problem seems to be down to
> loosing read-ahead when cache ends up eating all of available memory,
> I've seen this effect myself too. Maybe the vm needs to be more
> aggressive about tossing out pages when this happens, I'm quite sure
> that would help tremendously for this workload.

I just wanted to tell I've tried this on 2.4.9 (as a beleive is before the new
vm came in)with the same result. What's interesting, is that the error shows up,
not at the time the buffer memory is used, but seemingly after it's been used
_twice_ (or three times?).

Can this help anyone getting a clue what the h... happens here?

The computer's got 1GB memory. Highmem is disabled.

roy

vmstat output:
---
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 100  0      0 511448   2492 244828   0   0 29938     0 1970   882   1  15  84
 0 100  0      0 440652   2516 313320   0   0 34258     0  407   338   1   6  93
 0 100  0      0 367956   2608 383576   0   0 35164     0  433   355   0   6  93
 0 100  0      0 298868   2696 450348   0   0 34382     0  414   363   1   6  93
 0 100  0      0 229452   2876 517344   0   0 32620     0 1037   560   1  12  87
 0 100  0      0 158716   3040 585636   0   0 34238     0  429   353   0   7  93
 0 100  0      0  88372   3156 653596   0   0 34034     0  436   278   0   7  92
 0 100  0      0  19068   3204 720616   0   0 33550     0  444   219   0   9  91
 0 100  0      0   2560   3284 737580   0   0 38622     0  468  1282   1  24  75
 0 100  0      0   2768   3360 737340   0   0 36626     0  664  2763   1  23  76
 0 100  0      0   2816   3440 737120   0   0 35466     0  559  2262   1  18  81
 0 100  0      0   3056   3500 736716   0   0 36492     0  486  1963   1  19  80
 0 100  0      0   3056   3548 736708   0   0 39018     0  543  2101   1  14  86
 0 100  0      0   3056   3628 736508   0   0 36868     0  875  1707   1  17  83
 0 100  0      0   2856   3688 736728   0   0 29708     0  493  1793   0  14  86
 0 100  0      0   3056   3716 736448   0   0 32000    34  526  1888   1  16  83
 0 100  0      0   3056   3740 736448   0   0 29102     0  563  1400   1  14  85
 0 100  0      0   3056   3764 736396   0   0 24992     0  618  1266   1   9  90
 0 100  0      0   3056   3780 736384   0   0 24678     0  671  1184   1  13  86
 2  98  0      0   3004   3792 736464   0   0 20288     0 1071  1537   1  16  82
 0 100  0      0   3008   3804 736376   0   0 14620     0  932   812   0  10  90
 0 100  0      0   3008   3804 736372   0   0  6776     0 1122   726   1   8  90
 0 100  0      0   3056   3812 736328   0   0  4326     0 1195   714   0   6  93
 0 100  0      0   3056   3812 736352   0   0  1826     0 1142   623   0   4  96
 0 100  0      0   3056   3812 736364   0   0  1026     0 1093   563   0   5  95
 0 100  0      0   3056   3812 736364   0   0  1058     0 1114   567   1   3  96
 0 100  0      0   3056   3812 736360   0   0  1066     0 1124   586   0   3  96
 0 100  0      0   3056   3816 736356   0   0  2474     0 1112   574   0   4  96


--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

