Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274864AbRIZHgg>; Wed, 26 Sep 2001 03:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274865AbRIZHg0>; Wed, 26 Sep 2001 03:36:26 -0400
Received: from [213.97.45.174] ([213.97.45.174]:63748 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S274864AbRIZHgM>;
	Wed, 26 Sep 2001 03:36:12 -0400
Date: Wed, 26 Sep 2001 09:36:18 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: Rik van Riel <riel@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roberto Orenstein <roberto@brsat.com.br>,
        Francois Romieu <romieu@cogenit.fr>
Subject: Re: [PATCH]  Re: 2.4.9-ac15 painfully sluggish
In-Reply-To: <Pine.LNX.4.33L.0109251628460.26091-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109260931410.1887-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Rik van Riel wrote:

> On Tue, 25 Sep 2001, Pau Aliagas wrote:
>
> I've made a small patch to 2.4.9-ac15 which should make
> page_launder() smoother, make some (very minor) tweaks
> to page aging and updates various comments in vmscan.c

Ok, things improve vastly and the system is usable again. I cannot
"notice" any difference with ac10 in terms of speed.

I attach the top and vmstat outputs while running updatedb (reads all
the files in the filesystems) and starting evolution for the first time
(touches all the mail folders, that's hundreths of files). It starts
smoothly in seconds.

  9:30am  up 52 min,  5 users,  load average: 2,83, 2,35, 1,87
125 processes: 121 sleeping, 4 running, 0 zombie, 0 stopped
CPU states: 16,2% user,  7,9% system, 75,8% nice,  0,0% idle
Mem:   127072K av,  123336K used,    3736K free,    2360K shrd,    7988K buff
Swap:  401536K av,   54092K used,  347444K free                   33952K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1008 setiatho  20  19 15348  14M   708 R N  76,2 11,4  38:28 setiathome
 1045 root       9   0 29740  12M  4076 S     7,3  9,6   9:05 X
 2238 pau        9   0  8876 8876  6764 D     4,1  6,9   0:00 evolution-mail
 1278 pau        9   0  4276 3776  3444 S     2,5  2,9   0:45 deskguide_apple
 2192 pau        9   0 16272  15M  6064 S     1,9 12,8   0:01 evolution
 1176 pau        9   0  1784 1456  1352 R     1,5  1,1   0:01 xscreensaver
    4 root       9   0     0    0     0 SW    0,9  0,0   0:02 kswapd
 2189 pau       13   0  1096 1096   840 R     0,9  0,8   0:00 top
 2258 pau        9   0  6024 6024  4632 S     0,9  4,7   0:00 evolution-pine-
 2198 pau        9   0  5616 5616  4360 D     0,7  4,4   0:00 wombat
 1127 pau        9   0  3424 3208  2032 S     0,3  2,5   0:03 sawfish
 1188 pau        9   0  5428 4972  4172 S     0,3  3,9   0:02 panel
 2265 pau        9   0  5372 5372  4216 S     0,3  4,2   0:00 evolution-gnome
  944 xfs        9   0  4748 2160  1768 D     0,1  1,6   0:01 xfs
 1198 pau        9   0  5232 3992  3472 S     0,1  3,1   0:02 gnome-terminal
 1944 root      19  19   716  676   496 R N   0,1  0,5   0:01 updatedb
 2093 pau        9   0   524  496   444 S     0,1  0,3   0:00 vmstat

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 4  1  0  57552   3620  14280  42892   9  18    78    28  124   881  95   3   2
 1 11  0  54756   8220  14452  40896 386 115   614   163  244   560  96   4   0
 3  0  0  54660   7208  14720  41432 234   0   394     0  180   358  97   3   0
 5  0  0  54660   4952  15196  42508  74   0   381     0  162   295  98   2   0
 3  2  0  53856   5680  13244  42476 197   2   428    14  205   443  95   5   0
 2  4  0  53856   3668  13668  43212 170   0   395     6  180   399  97   3   0
 1  3  0  54004   5852  10324  42724 114   0   368     1  176   841  93   6   1
 4  0  0  54000   2800  10640  41908  19   0   314     2  151   764  95   5   0
 3  0  0  54024   6788   7568  39048   1   0   350     6  172   497  95   5   0
 1  2  0  54024   4656   7780  40192  78   0   347    11  163   524  96   4   0
 4  0  0  53972   2936   7944  38844 230   0   420     4  193  1370  94   6   0
 3  0  0  53972  12944   8420  39136  63   0   285    11  198  1262  96   4   0
 4  0  0  53972  11816   8836  39644  19   0   242    14  164   426  97   3   0
 4  0  0  53972  10532   9216  40252  31   0   222    17  215   834  96   4   0
 3  1  0  53972   8628   9504  40944  42   0   235     4  212   514  96   4   0
 2  1  0  53972   4040   9732  41636   0   0   173     2  210   798  95   5   0
 4  2  0  54160   3096   7188  40800  32   0   207    32  134  1502  87  13   0
 3  0  0  54332   3732   6412  35452  10   0   242    16  178   773  96   4   0
 4  0  0  54332   2800   7060  33908   0   0   232    16  204   506  96   4   0
 4  0  0  54072   4616   7096  34748   0 572   211   679  207   436  97   3   0
 3  2  0  54024   2800   7280  35364   0  12   244    18  216   726  97   3   0
 7  0  0  54020   3104   7644  34116  41   0   229     0  175   954  93   7   0
 3  1  0  54000   3744   7888  33852  62   0   374     0  193   722  97   3   0
 2  4  0  54092   4952   7988  33856   8   0   118   180  170  2934  91   9   0
 4  1  0  54036   2992   8024  34312  38   0   102   444  237  1684  92   8   0
 2  0  0  54036   3580   8216  35092   0   0   208     0  173   356  97   3   0
 3  0  0  55016   3820   8444  34912   3  67   293   136  165   279  90   2   8
 3  0  0  55016   2800   8724  34820   0   0   202    15  177   385  98   2   0
 4  0  0  55016   2948   9008  34704   0   0   258    14  175   372  98   2   0


Pau

