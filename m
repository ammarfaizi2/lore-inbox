Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310816AbSDFQDr>; Sat, 6 Apr 2002 11:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293306AbSDFQDq>; Sat, 6 Apr 2002 11:03:46 -0500
Received: from ECE.CMU.EDU ([128.2.136.200]:9120 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S312526AbSDFQDp>;
	Sat, 6 Apr 2002 11:03:45 -0500
Date: Sat, 6 Apr 2002 11:03:42 -0500 (EST)
From: Nilmoni Deb <ndeb@ece.cmu.edu>
Reply-To: Nilmoni Deb <ndeb@ece.cmu.edu>
To: Andre Pang <ozone@algorithm.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Summary of KL133/KM133 problems w/2.4.18
In-Reply-To: <1017970316.478570.13925.nullmailer@bozar.algorithm.com.au>
Message-ID: <Pine.LNX.3.96L.1020406104443.13531C-100000@d-alg.ece.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andre,
	Consider this as one more positive feedback, though slightly
unorthodox. The graphics corruption problem on my KM133 chipset
(revision 81) is gone, thanks to ur solution.

Since I had problems compiling the 2.4.18 kernel, I took the easy way out.

% lspci -s 00:00.0 -xxx                          
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
81)
00: 06 11 05 03 06 00 10 22 81 00 00 06 00 08 00 00
10: 08 00 00 d8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 90 09
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 16 f4 6b b4 47 08 10 10 80 00 08 10 10 10 10 10
60: 03 2a 00 20 d6 d4 d4 c4 50 5c 86 0f 08 21 00 00
70: de 88 4c 0c 0e 81 92 00 01 05 11 02 00 00 00 00
80: 0f 40 00 00 c0 00 00 00 02 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 c0 20 00 07 02 00 1f 00 00 00 00 2f 02 04 00
b0: ff ec 1a 48 f7 a1 40 00 07 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 81 00 32 42 00 b0 00 00 00 00

The byte at location 0x55 has the hex value 08 which means bit 5 is 0.
Bit 5 will be 1 if the value is hex 08 | 20 = 28.

% setpci -v -s 00:00.0 55.b=28
00:00.0:55 08

The setpci command does the job.

In fact, now I can turn this bit on and off whenever I want to and see the
graphics corruption appearing/disappearing within seconds. I suggest that
folks try this out _first_ before going thru the process of compiling,
installing and running a patched kernel. This way any special cases for
the various target chipsets will be identified beforehand. Also, this is
convenient and the only way out when kernel compilation fails.

thanks
- Nil

