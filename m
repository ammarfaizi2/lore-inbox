Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313510AbSDQTMU>; Wed, 17 Apr 2002 15:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313540AbSDQTMT>; Wed, 17 Apr 2002 15:12:19 -0400
Received: from synapse.t30.physik.tu-muenchen.de ([129.187.186.221]:6083 "EHLO
	synapse.t30.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S313510AbSDQTMQ>; Wed, 17 Apr 2002 15:12:16 -0400
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: Andrea Arcangeli <andrea@suse.de>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
In-Reply-To: <rxxadshj1rh.fsf@synapse.t30.physik.tu-muenchen.de>
	<20020416165358.E29747@dualathlon.random>
	<200204162114.09589.roger.larsson@skelleftea.mail.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Date: 17 Apr 2002 21:12:07 +0200
Message-ID: <rxx3cxuta0o.fsf@synapse.t30.physik.tu-muenchen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roger Larsson <roger.larsson@skelleftea.mail.telia.com> writes:

> In an other recent thread "PROMBLEM: CD burning at 16x uses excessive CPU, 
> although DMA is enabled" it was found out that writing to CD-R did not use 
> DMA. This resulted in lots of wasted CPU cycles.

> > But even though 50% is quite high, CPU load is not the problem as such,
> > the problem is getting data to the writer fast enough. And it's not
> > happening. Even a single audio track that is completely cached so that
> > there is no HD access has problems. It's like somehow accessing the CD
> > writer hogs the system for such long periods that there is insufficient
> > time to fill the writing program's buffer.
> 
> Might this be part of the problem in this case too? Moritz please time your 
> commands 

I have timed the new benchmarks. User time is 0, system time is 3% in
the worst case.

> and use vmstat too... (time spent in interrupt while running the
> idle process - does not always show up)

'vmstat 1' during benchmark 2 (reading from 130GB HDD, writing to
DVD-RAM), kernel 2.4.19-pre5, default bdflush parameters.

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  5  2  10120   2932   7040 182276   0   6   344   501  135   217   4   2  94
 1  0  2  10120   2184   7056 182976   0   0     8     0  116   115   2   2  96
 0  1  2  10120   2244   7068 182932   0   0     0  3944  125   129   0   1  99
 0  1  2  10120   2220   7072 182944   0   0     0     0  111    97   1   0  99
 1  0  2  10120   2608   7080 182548   0   0     0  4032  136   123   1   0  99
 1  0  3  10120   2676   7112 182448   0   0     4    40  168   155   1   1  98
 1  1  2  10120   2180   7124 182928   0   0     4     0  112   104   1   2  97
 0  1  2  10120   2192   7128 182924   0   0     0  4026  112   124   1   1  98
 1  1  2  10120   2288   7132 182816   0   0     0     0  111   109   1   0  99
 1  1  2  10120   2408   7136 182692   0   0     0     0  111   117   1   0  99
 1  1  3  10120   2276   7160 182796   0   0     0  4044  116   142   1   1  98
 1  1  2  10120   2216   7164 182840   0   0     4    12  108    92   1   0  99
 1  1  2  10120   2320   7172 182744   0   0     0     0  115   132   1   1  98
 1  0  2  10120   3168   7180 181888   0   0     0  4032  151   186   1   1  98
 0  2  2  10120   2180   7188 182868   0   0     0     0  111   122   1   2  97
 0  1  2  10120   2876   7188 182164   0   0     0  4032  111   113   1   4  95
 0  2  3  10120   2772   7220 182244   0   0     0    40  113   133   1   3  96
 0  1  2  10120   2192   7228 182824   0   0     0     0  116   123   1   2  97
 0  1  2  10120   2300   7232 182704   0   0     0     0  111   116   1   0  99

[reading from HDD starts about here]

 2  1  2  10120   2304   7256 181616   0   0  1172  4032  311   372   0   1  99
 0  6  3  10120   2876   7272 180992   0   0   144  4048  113   124   0   0 100
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  2  3  10120   2284   7276 181672   0   0  1520   638  144   227   2   2  96
 2  0  3  10120   2544   7284 181424   0   0  1020     0  161   177   1   1  98
 3  0  3  10120   2820   7284 181216   0   0  1392  3876  186   209   1   1  98
 0  3  3  10120   2504   7288 181536   0   0   980     0  127   133   0   1  99
 2  0  3  10120   3124   7288 180972   0   0  1236  3890  220   258   2   0  98
 0  2  3  10120   2596   7296 181564   0   0     0     0  113   137   1   1  98
 0  2  3  10120   2204   7304 181992   0   0   516     0  122   127   1   2  97
 0  2  3  10120   2416   7308 181816   0   0   240  3922  117   133   1   0  99
 0  3  3  10120   2176   7312 182108   0   0   652     0  122   135   1   1  98
 0  2  3  10120   2296   7316 181984   0   0   400     0  118   130   1   0  99
 4  0  3  10120   2956   7316 181252   0   0    24  3930  173   200   1   1  98
 0  4  3  10120   2184   7320 182048   0   0  1956     0  148   200   0   4  96
 0  3  3  10120   2432   7324 181892   0   0     0  3968  111   133   0   1  99
 2  0  3  10120   2544   7332 181804   0   0  1092     0  138   187   1   1  98
 0  2  3  10120   2180   7336 182200   0   0   388     0  121   143   1   2  97
 0  2  3  10120   2236   7340 182144   0   0   640  3968  121   148   1   1  98
 0  3  3  10120   2560   7340 181760   0   0   616     0  124   138   1   3  96
 0  2  3  10120   2484   7344 181932   0   0    76     0  113   128   1   2  97
 5  0  3  10120   2640   7348 181780   0   0   832  3968  157   174   1   2  98
 0  2  3  10120   2432   7352 182012   0   0   240     0  116   135   1   1  98
 2  0  3  10120   2420   7360 182036   0   0  1348  3720  173   185   1   1  98


'vmstat 1' during benchmark 2 (reading from 130GB HDD, writing to
DVD-RAM), kernel 2.4.19-pre5, 
'echo 2 500 0 0 500 3000 3 1 0 >/proc/sys/vm/bdflush'

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  1  1  11020 110372   6956  78828   0   0     8  6946  116    88   1  10  89
 0  1  2  11020 110344   6980  78832   0   0     0    44  120    96   1   0  99
 0  1  1  11020 110344   6980  78832   0   0     0  3686  128    75   1   2  97
 0  1  1  11020 110344   6980  78832   0   0     0     0  111    72   1   1  98
 0  1  1  11020 110344   6980  78832   0   0     0     0  107    79   1   1  98
 0  1  1  11020 110344   6980  78832   0   0     0     0  105    71   1   0  99
 0  1  1  11020 110344   6980  78832   0   0     0     0  103    79   1   0  99
 0  1  1  11020 102688   6996  86472   0   0     0  3942  111    93   1   5  94
 0  1  1  11020 102688   6996  86472   0   0     0     0  114    79   0   1  99
 0  1  1  11020 102684   6996  86476   0   0     0  3486  131    78   0   0 100
 0  1  1  11020 102684   6996  86476   0   0     0     0  112    81   1   0  99
 0  1  1  11020  94968   6996  94192   0   0     0  4372  111    84   1   5  94
 1  1  2  11020  75780   7020 112368   0   0 18176    40  403   638   1  15  84
 1  1  1  11020  46204   7028 141936   0   0 29576     0  582   971   1  23  76
 3  1  1  11020  17368   7064 170736   0   0 28836     0  574   928   2  25  73
 1  1  2  11020   4336   7092 186864   0   0 28188  3810  570  1024   1  22  77
 1  1  1  11020   4436   7096 186760   0   0 27548     0  553  1155   1  19  80
 1  1  1  11020   4388   5860 189088   0 1088 28704  1088  587  1190   2  25  73
 1  1  1  11020   4460   5892 188984   0   0 29856    40  590  1243   1  24  75
 1  1  1  11020   3204   5936 190232   0   0 27032  3540  550  1126   1  26  73
 1  1  2  11020   3572   5964 189848   0   0 28828     0  570  1232   1  19  80
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  1  1  11020   4440   5992 188952   0   0 27292  3636  563  1147   1  21  78
 1  1  1  11052   4416   6028 190044   0 824 28584   824  588  1225   1  26  73
 0  2  3  11052   2256   6060 192168   0   0 16068    12  375   685   1  11  88

[reading and writing takes place concurrently at normal speed, but
there are still some "dropouts"]

 0  2  1  11052   2276   6060 192120   0   0     0  2686  110    97   1   2  97
 5  0  1  11052   2592   6060 191720   0   0     0     0  417   208   0   1  99
 1  1  1  11052   3248   6132 191192   0   0 26472  5260  542  1212   1  31  68
 2  1  1  11052   4384   6160 190040   0   0 28572     0  572  1173   1  20  79
 2  1  1  11052   3716   6188 190680   0   0 27548  3844  570  1171   1  23  76
 1  1  1  11052   4460   6216 189912   0   0 28316     0  570  1197   1  17  82
 1  1  1  11704   2244   6244 192928   0 280 29096   280  595  1011   1  28  71
 1  1  2  11704   3208   6300 191932   0   0 27678  4478  564  1123   1  25  74
 1  1  2  11704   3332   6304 191828   0   0 29468     8  585  1229   1  27  72
 1  1  2  11704   3416   6332 191700   0   0 30236     0  589  1253   1  19  80
 0  2  2  11704   4400   6364 190676   0 444 29080   444  589  1241   1  24  75
 1  1  1  12956   4372   6384 190968   0 508 28708  3450  588  1204   1  25  74
 1  1  1  12956   4348   6412 190972   0   0 27296     0  569  1133   1  20  79
 1  1  1  12956   3312   6416 192012   0   0 19092     0  417   801   1  15  84
 1  1  1  12956   3308   6444 192012   0   0 28572     0  571  1181   1  25  74
 1  1  1  12956   3284   6472 192012   0   0 28444     0  568  1178   1  26  73
 1  1  1  12956   3284   6576 192312   0  68 26524  8276  548  1228   1  30  69
 1  1  1  13944   4396   6600 191672   0 1060 29468  1060  599  1243   1  23  76


Moritz


-- 
Dipl.-Phys. Moritz Franosch
http://Franosch.org
