Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbTAJWHj>; Fri, 10 Jan 2003 17:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbTAJWHj>; Fri, 10 Jan 2003 17:07:39 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:62982 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S266528AbTAJWHf>; Fri, 10 Jan 2003 17:07:35 -0500
Date: Fri, 10 Jan 2003 17:16:16 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] IPC performance of recent kernels (ctxbench)
Message-ID: <Pine.LNX.4.44.0301101708380.1212-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sad to say, the IPC rates have been going down since 2.4.18, and I suspect 
that will show up in the performance of threaded and cooperating 
applications. To some extent the new pthread will help some of this, but 
comparing results with a new library vs. old is not useful for measuring 
what the kernel is doing.

The column avg/MHz is used for comparing the same system at several CPU 
speeds, and getting some feel for P-II, P-II, Athlon and P-IV performance 
normalized to clock speed. These test are all on one system at the same 
speed, so it's just a number. Likewise the spinlock test is not useful on 
uni machines and can be ignored here.

I will have similar results on other systems as I get the chance.

Config descriptions and results follow.



================================================================
    Run information
================================================================

Run: 2.4.18-5.out
  CPU_MHz              348.489
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           2.4.18-5
  Ncpu                 1
Run: 2.4.20.out
  CPU_MHz              348.492
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           2.4.20
  Ncpu                 1
Run: 2.5.52.out
  CPU_MHz              348.395
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           2.5.52
  Ncpu                 1
Run: 2.5.53.out
  CPU_MHz              348.404
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           2.5.53
  Ncpu                 1
Run: 2.5.54-mm3-1.out
  CPU_MHz              348.404
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           2.5.54-mm3
  Ncpu                 1
Run: 2.5.54.out
  CPU_MHz              348.444
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           2.5.54
  Ncpu                 1


================================================================
    Results by IPC type
================================================================

                                   loops/sec
SIGUSR1                     low       high    average    avg/MHz
  2.4.18-5.out            46246      47550      46728    134.087
  2.4.20.out              47304      47514      47424    136.083
  2.5.52.out              40961      41699      41290    118.517
  2.5.53.out              40567      41995      41434    118.926
  2.5.54-mm3-1.out        39406      39510      39449    113.228
  2.5.54.out              39573      39699      39647    113.785

                                   loops/sec
message queue               low       high    average    avg/MHz
  2.4.18-5.out            89631      90591      90027    258.336
  2.4.20.out              75206      83700      80822    231.920
  2.5.52.out              78427      79163      78675    225.823
  2.5.53.out              75709      75848      75759    217.448
  2.5.54-mm3-1.out        76276      76795      76598    219.854
  2.5.54.out              74131      75390      74969    215.156

                                   loops/sec
pipes                       low       high    average    avg/MHz
  2.4.18-5.out            86181      95386      91954    263.865
  2.4.20.out              87640      88381      87889    252.198
  2.5.52.out              77020      77586      77365    222.061
  2.5.53.out              67799      68893      68310    196.065
  2.5.54-mm3-1.out        73346      73981      73632    211.343
  2.5.54.out              70445      70572      70489    202.297

                                   loops/sec
semiphore                   low       high    average    avg/MHz
  2.4.18-5.out            98259      98479      98383    282.315
  2.4.20.out              92052      92569      92307    264.876
  2.5.52.out              84367      84639      84516    242.589
  2.5.53.out              77355      77724      77540    222.560
  2.5.54-mm3-1.out        81461      81732      81552    234.075
  2.5.54.out              77304      77521      77379    222.072

                                   loops/sec
spin+yield                  low       high    average    avg/MHz
  2.4.18-5.out           200889     203649     201999    579.644
  2.4.20.out             211801     211957     211855    607.921
  2.5.52.out             219279     219658     219470    629.947
  2.5.53.out             180547     180625     180584    518.319
  2.5.54-mm3-1.out       179318     179818     179519    515.261
  2.5.54.out             160157     178830     172598    495.341

                                   loops/sec
spinlock                    low       high    average    avg/MHz
  2.4.18-5.out                3          3          3      0.010
  2.4.20.out                  4          4          4      0.014
  2.5.52.out                  3          3          3      0.009
  2.5.53.out                  3          3          3      0.009
  2.5.54-mm3-1.out            3          3          3      0.010
  2.5.54.out                  3          3          3      0.009

-- 
bill davidsen <davidsen@tmr.com>

