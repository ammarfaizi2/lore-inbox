Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262645AbSITOHr>; Fri, 20 Sep 2002 10:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262654AbSITOHr>; Fri, 20 Sep 2002 10:07:47 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:45959 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262645AbSITOHq>;
	Fri, 20 Sep 2002 10:07:46 -0400
Message-ID: <1032531169.3d8b2ce16fb26@kolivas.net>
Date: Sat, 21 Sep 2002 00:12:49 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] Greater resolution mem_load from contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some results you may find informative.

I adjusted the mem_load module of contest (http://contest.kolivas.net) to vary
the memory load from 10 to 110% in increments of 10% and performed the test on
the following kernels.

What I found is that performance regardless of the kernel was constant (for that
kernel) up to 70% (presumably the critical number for my 256Mb machine).

What happened beyond this point, however, was quite different between kernels.

Here are the results:

Kernel:		2.4.19	rmap14b	2.5.36	2.5.36-mm1

Mem%
60		76.34	76.98	66.62	69.12
70		76.22	77.14	67.21	67.28
80		79.20	80.14	68.24	70.29
90		82.59	115.51	148.63	92.96
100		84.21	108.61	107.54	95.50
110		92.49	114.51	132.45	95.32

As you can see, in absoute performance the 2.5 kernels at low mem loads are better.

rmap14b (2.4.19-rmap14b) performance is identical to vanilla till 80%.
Beyond this point it starts to deteriorate rapidly.
2.5.36 exhibits this same behaviour (presumably for the same reason?).
Note the dip at exactly 100% and the peak either side of it?
-mm1 seems to do better than vanilla 2.5.36
Overall, vanilla 2.4.19 seems to respond more graded.

A quick reminder what these numbers are;
the data value is the time taken to compile a kernel, and the mem% is a
background memory load that continually asks for x% of the memory.

I'd like to include the ability to test this into a newer version of contest;
however the critical point when the results start to deteriorate, and the
absolute resolution required to show the difference will be dependent on the
test machine's memory. I haven't resolved the best way around this.

Con.
