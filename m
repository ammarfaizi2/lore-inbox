Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbSLOIfg>; Sun, 15 Dec 2002 03:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSLOIfg>; Sun, 15 Dec 2002 03:35:36 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:36504
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S266286AbSLOIfc> convert rfc822-to-8bit; Sun, 15 Dec 2002 03:35:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: scott thomason <scott-kernel@thomasons.org> (by way of scott
	thomason <scott-kernel@thomasons.org>)
Reply-To: scott-kernel@thomasons.org
Subject: Re: Intel P6 vs P7 system call performance
Date: Sun, 15 Dec 2002 02:43:25 -0600
User-Agent: KMail/1.4.3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212150243.25765.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 December 2002 11:48 am, Mike Dresser wrote:
> On Sat, 14 Dec 2002, Dave Jones wrote:
> > Note that there are more factors at play than raw cpu speed in a
> > kernel compile. Your time here is slightly faster than my 2.8Ghz
> > P4-HT for example.  My guess is you have faster disk(s) than I
> > do, as most of the time mine seems to be waiting for something to
> > do.
>
> Quantum Fireball AS's in that machine.  My main comment was that
> his Althon MP at 1.8 was half or less the speed of a single P4.
> Even with compiler changes, I wouldn't think it would make THAT
> much of a difference?

I've been doing a lot of benchmarking with "contest" lately, and one
thing I can state emphatically is that the kernel that you are
running while performing a compile can be a large factor, especially
if you are maxing out the machine with a large "make -jN". Some
kernel versions vary enormously in their ability to handle I/O load
(an area I've been paying close attention to). Sounds like you have
some decent SMP hardware, and probably a good chunk of memory to go
with it, so you might want to experiment with these kernels, which
have given good I/O performance in my tests:

linux-2.4.19-rmap14c
linux-2.4.19-rmap15a
linux-2.4.18-rml-O1 (slow at creating tarballs, fast everwhere else)

And if you you don't mind bleeding edge, just go with a more recent
2.5 kernel that you can make work. You simply can't get comparable
performance out of 2.4.

I've attached some contest numbers for tests I've run to-date below. 
Please note that while I use contest as the benchmarking tool, I use 
qmail compiles as the actual load, not kernel compiles (I don't have 
the patience--qmail compiles take about 35-40% the time as a kernel 
compile. Now if we can get Con to work on speeding up "Killing the 
the load process..." <g>).
---scott

sorry for the html table to text pasting conversion :(

noload
process_load
ctar_load
xtar_load
read_load
list_load
mem_load

linux-2.4.18
16.73
22.61
244.52
78.84
108.52
18.58
53.12

linux-2.4.18-ac3
19.01
25.64
99.52
94.23
314.29
23.34
119.95

linux-2.4.18-rc1-akpm-low-latency
16.69
21.92
335.62
79.10
122.34
18.39
104.80

linux-2.4.18-rc4-aa1
16.43
93.85
179.12
100.29
46.64
17.15
96.91

linux-2.4.18-rmap12h
18.84
24.72
143.12
95.11
298.85
23.17
121.22

linux-2.4.18-rml-O1
16.83
31.42
266.28
77.98
77.15
18.18
63.03

linux-2.4.18-rml-preempt
16.93
21.87
334.08
84.22
116.30
18.46
60.30

linux-2.4.18-rml-preempt+lockbreak
16.85
22.42
271.52
74.37
229.96
19.57
45.21

linux-2.4.19
16.99
22.42
261.69
103.61
163.55
18.44
66.16

linux-2.4.19-ac4
19.08
30.32
176.03
89.38
288.53
22.79
102.09

linux-2.4.19-akpm-low-latency
16.90
21.87
230.92
111.37
179.63
18.36
87.47

linux-2.4.19-ck14
-
-
-
-
-
-
176.41

linux-2.4.19-rc5-aa1
18.37
27.18
931.45
154.94
372.73
22.01
125.92

linux-2.4.19-rmap14c
17.84
24.56
74.81
76.73
121.86
20.57
165.10

linux-2.4.19-rmap15
18.27
24.09
71.32
77.05
146.68
18.99
102.56

linux-2.4.19-rmap15-splitactive
17.28
23.09
69.16
79.49
140.15
20.27
129.84

linux-2.4.19-rmap15a
17.10
23.00
62.44
78.12
138.96
18.46
133.32

linux-2.4.19-rml-O1
16.61
25.45
314.24
90.43
124.27
18.32
72.90

linux-2.4.19-rml-preempt
16.88
21.80
238.80
86.46
155.89
18.45
56.74

linux-2.4.20
16.62
21.84
191.12
101.06
100.35
18.22
70.47

linux-2.4.20-aa1
18.23
29.03
331.96
137.70
96.88
22.22
143.22

linux-2.4.20-ac1
20.24
28.41
776.73
138.35
221.55
22.06
171.13

linux-2.4.20-rc2-aa1
18.44
28.39
255.79
156.30
86.78
21.98
139.04

linux-2.5.49
17.66
22.39
36.73
26.85
19.91
20.29
57.34

linux-2.5.50
17.80
24.19
32.81
25.87
21.43
21.17
45.96
