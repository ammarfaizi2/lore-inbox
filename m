Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbSLLME2>; Thu, 12 Dec 2002 07:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267491AbSLLME2>; Thu, 12 Dec 2002 07:04:28 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:5380 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S267490AbSLLME0>;
	Thu, 12 Dec 2002 07:04:26 -0500
To: linux-kernel@vger.kernel.org
Subject: ps and free disagree on swap usage
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 12 Dec 2002 06:23:55 -0500
Message-ID: <m3lm2v5vlg.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using procps from cvs at sources.redhat.com, up to date as of
wednesday night.

free(1) says:

             total       used       free     shared    buffers     cached
Mem:        514664     456576      58088          0      31988     173088
-/+ buffers/cache:     251500     263164
Swap:       538136      23016     515120

which looks correct compared to /proc/meminfo.

OTOH, ps(1) (and qps for that matter) show much higher aggregate swap
usage.  A couple of intersting lines from ps avxww --forest:

  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
 1402 ?        S      2:29    784  1336 100875 22308  4.3  \_ /usr/X11R6/bin/X :0 vt07 -auth /var/lib/xdm/authdir/authfiles/A:0-PNAkTo

 1717 ?        S      0:05   2692   454 100353 18608  3.6          \_ kppp
 1718 ?        S      0:00     34   454 14329 3752  0.7          |   \_ kppp

 3985 ?        S      0:39  13864   785 57238 37040  7.1          \_ /opt/mozilla/mozilla-bin

 4718 ?        S      0:01    747   204 10219 6348  1.2          \_ xterm -u8
 4720 pts/1    S      0:00    392   414  2393 1704  0.3          |   \_ bash


plus another 8 or so xterms all with similar DRS vs RSS numbers.  Qps
shows results similar to ps.

ps avxww|awk '{print $6 + $7 - $8}'|awk '{i += $1} END {print i}'

returned 470418 just now, when meminfo is claiming:

SwapTotal:      538136 kB
SwapFree:       515120 kB


Is this just a bug in /proc/meminfo?

-JimC


