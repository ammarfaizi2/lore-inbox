Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319684AbSIMQEI>; Fri, 13 Sep 2002 12:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319685AbSIMQEI>; Fri, 13 Sep 2002 12:04:08 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:52382 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S319684AbSIMQEG>;
	Fri, 13 Sep 2002 12:04:06 -0400
Message-ID: <1031933335.3d820d97a13c6@kolivas.net>
Date: Sat, 14 Sep 2002 02:08:55 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: System response benchmarks in performance patches
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I came up with a very simple way of measuring responsiveness that gives me
numbers that are meaningful to me. What I've done is the old faithful kernel
compile and measured it under different loads to simulate the pc's ability to
perform under various loads. I have so far benchmarked 2.4.19 versus 2.4.19-ck7,
 2.4.19-ck7-rmap and 2.4.18-6mdk(mandrake's kernel in 8.2). 2.5.34 has a dead
keyboard for me so I'm unable to test it as yet.

Here is the story so far:

No Load
Kernel			Time		%CPU
2.4.19			1:49.17		98%
2.4.19-ck7		1:47.66		97%
2.4.19-ck7-rmap		1:48.58		98%
2.4.18-6mdk             1:48.18         98%

Memory Load
Kernel			Time		%CPU
2.4.19			2:15.21		78%
2.4.19-ck7		1:55.88		92%
2.4.19-ck7-rmap		2:18.55		79%
2.4.18-6mdk             2:15.68         79%

IO Load
Kernel			Time		%CPU
2.4.19			3:00.76		58%
2.4.19-ck7		2:01.68		86%
2.4.19-ck7-rmap		2:05.95		83%
2.4.18-6mdk             3:01.48         58%

Process Load
Kernel			Time		%CPU
2.4.19			2:09.42		80%
2.4.19-ck7		1:53.52		92%
2.4.19-ck7-rmap		1:54.39		93%
2.4.18-6mdk             2:10.57         80%

Kernel compiles were done on the same config kernel, fresh boot etc.. on a
single PIII 1133 with make -j 4

The loads were taken from BMatthew's iman found here:
http://people.redhat.com/bmatthews/irman/

Unlike the original program I am not looking at average latencies (which by the
way are <.01 msecs)

A brief description of the loads follows:

Memory load - Repeatedly reference 110% of RAM in a pattern designed to cause
cache misses
IO load - Read and write 1K chunks from random places in a file using multiple
processes
Process load - Fork and exec N processes, connected in a unidirectional ring by
pipes. Insert M<<N chunks of data into the ring and pass them around

I certainly feel these numbers represent the "feel" of the various kernels to
respond under different loads which I've had trouble quantifying. As you can see
under different loads the kernels vary in their ability to devote enough cpu
time because they're too busy. Obviously the way the memory is "loaded" will
affect different VM patches differently.

The -ck kernels are from my merged patchsets here:
http://kernel.kolivas.net

I have yet to merge compressed cache fully without bugs, so -ck8 is still not
finished but R. De Castro is working hard to help me do it :)

Please send me your comments and please cc me to ensure I get your email.

Con Kolivas
