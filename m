Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316469AbSEOSsi>; Wed, 15 May 2002 14:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316470AbSEOSsh>; Wed, 15 May 2002 14:48:37 -0400
Received: from holomorphy.com ([66.224.33.161]:1955 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316469AbSEOSsh>;
	Wed, 15 May 2002 14:48:37 -0400
Date: Wed, 15 May 2002 11:46:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
Message-ID: <20020515184646.GH27957@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20020515183004.GG27957@holomorphy.com> <Pine.LNX.4.44L.0205151533060.32261-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 03:33:58PM -0300, Rik van Riel wrote:
> Well, with the amount of memory you have in the machine
> I expect the time spent in idle and iowait to be fairly
> limited during a repetitive kernel compile ;)
> If everything "looks" normal in top and vmstat things
> should be ok.

On Wed, May 15, 2002 at 03:33:58PM -0300, Rik van Riel wrote:
$ vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
17  0  0      0 182880  32364  55180   0   0     2    77   29   229  84   6  10
17  0  0      0 178840  32380  55268   0   0     0  1240  169   766  95   5   0
16  0  0      0 168056  32380  55480   0   0     0     0  104   829  95   5   0
20  0  0      0 197960  32380  55616   0   0     0     0  105  1156  94   6   0
16  0  0      0 179416  32380  55632   0   0     0     0  108   994  95   5   0
18  0  0      0 184428  32380  55692   0   0     0     0  109   954  94   6   0
16  0  0      0 165684  32396  55720   0   0     0  1148  182  1069  96   4   0
17  0  0      0 155572  32396  55732   0   0     0     0  104   854  96   4   0
17  0  0      0 181108  32400  56636   0   0     0     0  104   853  95   5   0
18  0  0      0 194772  32400  56692   0   0     0     0  103   955  94   6   0
16  0  0      0 185068  32400  56856   0   0     0     0  104  1006  95   5   0
18  1  0      0 191744  32408  56972   0   0     0  1808  286  1062  95   5   0
16  0  0      0 202512  32408  57092   0   0     0     0  103   956  94   6   0
17  0  0      0 191116  32408  57140   0   0     0     0  103  1143  91   9   0
17  0  0      0 202032  32408  57288   0   0     0     0  103   899  93   7   0
17  0  0      0 187764  32408  57320   0   0     0     0  103   928  92   8   0
18  1  0      0 198048  32408  57400   0   0     0  1776  294  1026  94   6   0
16  1  0      0 205108  32408  57436   0   0     0     0  104   842  96   4   0
16  0  0      0 181964  32408  57488   0   0     0     0  103  1028  95   5   0
16  0  0      0 175224  32408  57524   0   0     0     0  104   961  95   5   0

All good there. OTOH:

$ top
fscanf failed on /proc/stat for cpu 1
fscanf failed on /proc/stat for cpu 2
fscanf failed on /proc/stat for cpu 3

... and it proceeds thus:

 11:45am  up  2:00,  4 users,  load average: 17.18, 16.86, 16.94
52 processes: 50 sleeping, 2 running, 0 zombie, 0 stopped
CPU0 states: 72.2% user, 27.1% system,  0.0% nice,  0.2% idle
fscanf failed on /proc/stat for cpu 1
Mem:   499088K av,  174936K used,  324152K free,       0K shrd,   32684K buff
Swap: 1052248K av,       0K used, 1052248K free                   61812K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
26200 wli       25   0 13780  13M  2204 R    10.0  2.7   0:01 cc1
26246 wli       15   0  1060 1060   804 R     0.1  0.2   0:00 top
    1 root      15   0   492  492   428 S     0.0  0.0   0:00 init
    2 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU0
    3 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU1
    4 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU2
    5 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU3
    6 root      15   0     0    0     0 SW    0.0  0.0   0:00 keventd
    7 root      34  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    8 root      34  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU1
    9 root      34  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU2
   10 root      34  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU3
   11 root      25   0     0    0     0 SW    0.0  0.0   0:00 kswapd
   12 root      25   0     0    0     0 SW    0.0  0.0   0:00 pdflush



... i.e. a little bit of recurring fscanf stuff.

Cheers,
Bill
