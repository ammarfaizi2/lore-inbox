Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274897AbRIZJnM>; Wed, 26 Sep 2001 05:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274898AbRIZJnB>; Wed, 26 Sep 2001 05:43:01 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:56335 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S274897AbRIZJmu>; Wed, 26 Sep 2001 05:42:50 -0400
X-Envelope-From: mmokrejs
Posted-Date: Wed, 26 Sep 2001 11:43:07 +0200 (MET DST)
Date: Wed, 26 Sep 2001 11:43:07 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page aging + launder 2.4.9-ac15
In-Reply-To: <Pine.LNX.4.33L.0109251454010.26091-101000@duckman.distro.conectiva>
Message-ID: <Pine.OSF.4.40.0109261134240.21943-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  is this expected change in memory usage after your patch?:
(in init 5 stage, please note dipslayed the MemShared: memory value)

fresh boot with -ac15:
jerboas:~# free
             total       used       free     shared    buffers     cached
Mem:       1028656      43168     985488          0       3584      17640
-/+ buffers/cache:      21944    1006712
Swap:      2097136          0    2097136
jerboas:~# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1053343744 44437504 1008906240        0  3670016 18063360
Swap: 2147467264        0 2147467264
MemTotal:      1028656 kB
MemFree:        985260 kB
MemShared:           0 kB
Buffers:          3584 kB
Cached:          17640 kB
SwapCached:          0 kB
Active:           3424 kB
Inact_dirty:     17800 kB
Inact_clean:         0 kB
Inact_target:      440 kB
HighTotal:      131072 kB
HighFree:       102220 kB
LowTotal:       897584 kB
LowFree:        883040 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB

fresh boot with -ac15+page_launder_patch:
jerboas:~# free
             total       used       free     shared    buffers     cached
Mem:       1027280      56776     970504         48      15656      16480
-/+ buffers/cache:      24640    1002640
Swap:      2097136          0    2097136
jerboas:~# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1051934720 58195968 993738752    49152 16031744 16875520
Swap: 2147467264        0 2147467264
MemTotal:      1027280 kB
MemFree:        970448 kB
MemShared:          48 kB
Buffers:         15656 kB
Cached:          16480 kB
SwapCached:          0 kB
Active:          31356 kB
Inact_dirty:       828 kB
Inact_clean:         0 kB
Inact_target:   262144 kB
HighTotal:      131072 kB
HighFree:       102788 kB
LowTotal:       896208 kB
LowFree:        867660 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB
jerboas:~#

I have to say the -ac15+page_launder_patch kernel has turned on the extra debugging options
 in Kernel hacking menu. Otherwise all kernel params are same with the -ac15.

I was not able to reproduce memeory allocation errors during 20h run
yesterday with -ac15 kernel using mysql tests and benchmarks.
I'll try to do same today with this patched -ac15 kernel.

-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany



