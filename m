Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271121AbTHQXKd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 19:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271124AbTHQXKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 19:10:32 -0400
Received: from octopus.com.au ([61.8.3.8]:39394 "EHLO octopus.com.au")
	by vger.kernel.org with ESMTP id S271121AbTHQXKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 19:10:30 -0400
Message-ID: <3F400B57.2090806@octopus.com.au>
Date: Mon, 18 Aug 2003 09:10:15 +1000
From: Duraid Madina <duraid@octopus.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux ia64; en-US; rv:1.3.1) Gecko/20030619 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-ia64@linuxia64.org
Cc: linux-kernel@vger.kernel.org
Subject: kswapd is having a party
Content-Type: multipart/mixed;
 boundary="------------060103060401070206020300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060103060401070206020300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

My question for today: does anyone know what kswapd actually does?

This morning, my workstation (linux ia64 2.6.0-test3) was fairly lightly 
loaded:

08:28:50 up 2 days,  1:49,  4 users,  load average: 1.77, 1.79, 1.20
Mem:   2062032k total,  1916368k used,   145664k free,   119952k buffers
Swap:  2016112k total,     1984k used,  2014128k free,   697920k cached

As you can see, there was gobs of RAM I wasn't using.

Anyway, as I was enjoying my tasty breakfast cereal, I noticed kswapd 
decided to wake up and say hello:

29109 duraid    25   0  400m 394m 6272 R 95.0 19.6   3:07.09 lsh
29108 duraid    19   0  404m 399m 6272 R 48.3 19.8   3:15.89 lsh
    13 root      15   0     0    0    0 R 17.2  0.0   0:26.47 kswapd0

29148 duraid    25   0  400m 394m 6272 R 93.9 19.6   3:13.23 lsh
29147 duraid    20   0  404m 399m 6272 S 21.1 19.8   3:12.16 lsh
    13 root      15   0     0    0    0 R 18.1  0.0   0:38.02 kswapd0

29148 duraid    25   0  400m 394m 6272 R 75.9 19.6   5:32.66 lsh
29147 duraid    18   0  404m 399m 6272 S 62.0 19.8   4:08.49 lsh
    13 root      16   0     0    0    0 R 16.4  0.0   0:50.08 kswapd0

29147 duraid    25   0  404m 397m 6272 R 93.9 19.7   6:23.87 lsh
29148 duraid    25   0  400m 392m 6272 R 75.4 19.5   9:00.72 lsh
    13 root      15   0     0    0    0 R 21.0  0.0   1:03.84 kswapd0

	It seems I can make kswapd use fairly nontrivial amounts of CPU time by 
running a perfectly innocent userland program. lsh is a raytracer I'm 
starting to work on. It's a standard C program, which uses MPI (I'm 
using LAM 7.0). The parallelism is trivial - each process renders a 
section of the image (divided vertically), line-at-a-time. The imbalance 
in CPU time between the processes is due to some sections of the scene 
being less interesting than others and finishing more quickly.

	Does anyone have _any_ idea what kswapd might actually be doing? I 
checked: not a single page was swapped in our out througout the duration 
of this test. Is there a chance that spinning on some lock (I have no 
idea how LAM does its synchronization), or perhaps even just idling, 
might be counted as kswapd0?

	Curious,

	Duraid

Attached: a snap of gkrellm. the light blue is kswapd, the dark blue is 
my program, the black is idle time.


--------------060103060401070206020300
Content-Type: image/png;
 name="kswapd.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kswapd.png"

iVBORw0KGgoAAAANSUhEUgAAAEIAAAB7CAIAAABPQ8HaAAAACXBIWXMAAA85AAAPOQE6gPqv
AAAAB3RJTUUH0wgRFjUcLjD+IQAAAB10RVh0Q29tbWVudABDcmVhdGVkIHdpdGggVGhlIEdJ
TVDvZCVuAAAFJElEQVR42u1bPYwbRRT+ZuxUuTtSoNAkKCENVa5AREdjS0cUCksUEUiIiCJS
hNFJIK6LTkK6JpJTpEAQIo4CEOXS0AOSU6EgpPNV11GcQijok7P3bArbe7szs7MznjfrtTVP
p9PbmTc/375573l83wFBghALO1UvdgHgqHmqyyL0zmCst7c1nprVFQunFc3+5Me8Jf0LV7aO
RqNEydMFhVgs30hdj4ExlrQIetJbBVF4w2RzYzB2SKyPHMuEriaqld4oHMkYn4IZAmw0GiYt
Rfvg2um5+Hjhd0Pjem7fWGc1RS/jAEbDmPH6aDRMfksr1RRrX/gtH0dNh8oUxsYhomHq3AzH
ASBHRcrmZIxnom8cZlaK4sm06RbBJmM/yBoPio2P8uqGkL/1pYDQWO7VG2dzvSo26mfzE5vU
VV/JNT6zUtyS6V3VPdomXMWZ1h33mulZB8C0GUWYSjezEQxuA4Nro9AlU9VK9AbPN+Y1EQav
VcQb3JfrFDB4id4AVSBReSNJ0tG/uQk7eiaVgmf5xv8AQOsw09LSlIKnWeOnOuNJwpVh/PG6
WpdF6J2XccGhWrmUa756ubhFZ/yabi9C7+oVt/uGPjbMT/C5H+yOe3mZCtxj8iHOVJrs/tJ3
dslnbc+ibgi9vObtUDka2943nOZd+cYXjAJj2rphJ1uA8cCoh7c1dWM/0xvtY9OxbvgTP3WD
o0w5v2HRe/4topgr62sx94RbLgxvH9TLhcHKTLgeYSysN5qdhjGM2S+xqUvm+9/Sg/jrVwB4
4/q0FLQtVjExjtpl1I1m5+Ox0r37uNlpdKO23Sr+6kbmkNiOKvr6bGzW7DSanQZefbeydcPm
NVU3UxEWmYWBEX9WCRi2UWRorzTjeUGmD0HlvCb7mM1Y1idpQFE3Lr+HhZO/f0aQIL5l88bz
zRvPXZR3Wi8AtFovbt48BvDBreMPPzoGcPtO//adPoD2Vr+9NVE+/bwPYHu7v73dB7CzM9jZ
GQDY3R3s7g4A3LsX378fA3jwIP7yqxjAw4fxo0cxgL29kx9/ihekbpDdKgOMIDNdKxPt6tU3
F273Bwd/hthYbhi93pPxT96jrCR6VWD0ek/W16+tr19LN45blHtN7EmQcEIMydbLP1R1r7NT
nZk5wJiLZ2hgGB7xtE0yhARqKH/V/DACvLyA+/9vWb2RUO0F3iLMyPF5LV6NdVR7mWevYd6n
uwLVXpRAtZ+GiyeqPWVSdariJlR7ZvHKbP6CoTemptpbsUbhAwYJ1T46yWdQxgouvjnfRsm8
PzKsGzCjvJPXDcOZp+le8pSCTH+WJlEqmPcWZHqcWbPJVLYcYAtxm1lrbJA9GNHnLsU+yEJc
6nvlF1/e4DY0fVdvWI53ep3Mnzc8wvAYGwaUSQ2Z3kpknr2eeS8OVzHv7SiTVKwYeR4iJozB
oVq9RINB5tnrmfeCrF1xiw0Qxca5792iriKZyjL5UGcq7g2G1czc1Rvevj1hi1j+HKPOuW4c
6PjxTpVk32bmTxScft2/9i6Q5N43FlMCjAAjwDiVNNdwSbzh/i9aWRG49eajbIcA3S++Pq2N
5nWj2Wl07z7WPGbWSHXpZ0sGCkOE+dUz3GJkh0qgxCpR5fWaU471lnzmqKKNUcflqk7uVrpa
NuaOW6T1z8yA+dzfN8mi3DBwCd+6LcneZEig2gcJUiSBah/uGwHGEkrgGobYqDQMW6o96GjT
c6Pag5T6PU+qPSH1O1DtST1TCRgzUO1D+Vve8vc/B5u7EbA9wxcAAAAASUVORK5CYII=
--------------060103060401070206020300--

