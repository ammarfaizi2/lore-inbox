Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289326AbSAIKpK>; Wed, 9 Jan 2002 05:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289322AbSAIKox>; Wed, 9 Jan 2002 05:44:53 -0500
Received: from [194.234.65.222] ([194.234.65.222]:58315 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S289325AbSAIKoo>; Wed, 9 Jan 2002 05:44:44 -0500
Date: Wed, 9 Jan 2002 11:44:37 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Error reading multiple large files
In-Reply-To: <Pine.LNX.4.21.0201072100310.18722-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0201091141140.5649-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roy,
>
> I suspect this is a use-once effect.
>
> Could you please try http://surriel.com/patches/2.4/2.4.17-pre8-2ndchance
> ?

I tried it, but without any success. The vmstat output below indicate what
happens. As it shows, the 'bi' is quite stable (but slightly falling)
around 30-35 megs per sec. After the buffer memory is filled up/used, it
tries to swap out a little, works itself downwards before stabalizing at
~900kB/sec - from two 120G IDE drives in RAID-0 !!!

thanks for any help.

roy

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 99  0      0 583376   7456 191076   0   0 34822     0  669   391   0   6  94
 0 99  0      0 513392   7540 258720   0   0 33864     0  657   458   0   9  91
 0 99  0      0 447432   7608 322484   0   0 31916     0  639   417   0   6  93
 0 99  0      0 379816   7692 387836   0   0 32718     0  666   354   1   7  92
 0 99  0      0 308704   7784 456560   0   0 34408     0  673   410   0   7  93
 0 99  0      0 237428   7876 525444   0   0 34486     0  670   407   1   7  92
 0 99  0      0 171460   7988 589172   0   0 31920     0  630   387   0   6  93
 0 99  0      0 110328   8080 648240   0   0 29582     0  634   295   1   4  95
 0 99  0      0  41876   8172 714392   0   0 33118     0 1076   552   0  13  87
 0 99  1    376   2340   1612 760852   0   0 33836     6  661   313   0  14  86
 0 99  1    376   3312   1288 760240   0   0 29870     0 1018   595   1  11  88
 0 99  2    376   3252   1260 760428   0   0 30616    22  667   447   1  11  88
 0 99  0    376   3268   1296 760344   0   0 25324     0  647   414   0   8  91
 0 99  1    376   3316   1320 760140   0   0 28272     0  700   500   0   6  93
 0 99  0    376   2564   1352 760920   0   0 25960     0  758   455   1   7  91
 0 99  0    376   3276   1372 760236   0   0 19910     0  746   415   0   6  93
 0 99  0    376   3264   1404 760108   0   0 18396     0  824   454   1   7  92
 0 99  0    376   3272   1444 760056   0   0 16324     0  846   480   0   6  94
 0 99  0    376   3268   1472 760024   0   0 14414     0  886   493   0   6  94
 0 99  0    376   3304   1500 759964   0   0 10630     0  891   463   0   6  94
 0 99  0    376   3244   1532 759984   0   0  7198     0  913   449   0   6  94
 0 99  0    376   3276   1564 759924   0   0  4730     0  920   488   0   4  96
 0 99  0    376   3264   1568 759924   0   0  4102     0  966   479   0   6  94
 0 99  0    376   3332   1584 759872   0   0   942     0  936   486   0   4  96
 0 99  0    376   3288   1584 759884   0   0   902     0  948   464   1   4  94
 0 99  0    376   3268   1584 759904   0   0   970     0  956   499   0   3  97


--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

