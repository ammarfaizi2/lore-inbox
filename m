Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135344AbRDLVey>; Thu, 12 Apr 2001 17:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135347AbRDLVel>; Thu, 12 Apr 2001 17:34:41 -0400
Received: from dentin.eaze.net ([216.228.128.151]:54279 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S135344AbRDLVeZ>;
	Thu, 12 Apr 2001 17:34:25 -0400
Date: Thu, 12 Apr 2001 16:34:32 -0500
From: SodaPop <soda@xirr.com>
Message-Id: <200104122134.QAA24106@xirr.com>
To: linux-kernel@vger.kernel.org
Subject: Oscillations in disk write compaction, poor interactive performance
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject:  Oscillations in disk write compaction

The following data sets are the output of a small program that
reads a random 4k block from a large data file, makes a trivial
alteration to the block, and writes the block back into the
file (in place).  In all three cases the file is larger than
the physical memory of the machine.  In the first two cases,
the file is the exact same.

It appears that in 2.4, we are much more aggressive about ordering
and combining writes to disk - which is probably a good thing, as
it helps increase disk throughput.  But it is also a bad thing,
as it seems that this ties up the disk and rest of the system for
long periods of time.

It also seems that in the 2.4 kernels, we can get into a sort of
oscillation mode, where we can have long periods of disk activity
where nothing can get done - the low points, where only 2-3 writes
per second can occur, so completely screw up the interactive
performance that you simply have to take your hands off the
keyboard and go get coffee until the disk writes complete.  I know
we get better performance overall this way, but it can be
frustrating when this occurs in the middle of video capture.

More notes below.  Anyone got any ideas?  Or have I done something
horribly stupid here?

-dennis T





2.2.14 - 160 meg intel PII.  Relatively slow ide drive, 6 MB/sec
---------------------------------------------------------------
File size: 209715200  Blocks: 51200
57.10 writes/second (10 second average, 4096 byte blocks).
57.10 writes/second (10 second average, 4096 byte blocks).
56.70 writes/second (10 second average, 4096 byte blocks).
57.30 writes/second (10 second average, 4096 byte blocks).
60.40 writes/second (10 second average, 4096 byte blocks).
64.30 writes/second (10 second average, 4096 byte blocks).
65.70 writes/second (10 second average, 4096 byte blocks).
60.90 writes/second (10 second average, 4096 byte blocks).
44.60 writes/second (10 second average, 4096 byte blocks).
45.30 writes/second (10 second average, 4096 byte blocks).
56.40 writes/second (10 second average, 4096 byte blocks).
67.60 writes/second (10 second average, 4096 byte blocks).
69.40 writes/second (10 second average, 4096 byte blocks).
66.80 writes/second (10 second average, 4096 byte blocks).
70.80 writes/second (10 second average, 4096 byte blocks).
18.80 writes/second (10 second average, 4096 byte blocks).
74.90 writes/second (10 second average, 4096 byte blocks).
76.00 writes/second (10 second average, 4096 byte blocks).
75.70 writes/second (10 second average, 4096 byte blocks).
59.60 writes/second (10 second average, 4096 byte blocks).
42.70 writes/second (10 second average, 4096 byte blocks).
73.00 writes/second (10 second average, 4096 byte blocks).
50.60 writes/second (10 second average, 4096 byte blocks).
102.80 writes/second (10 second average, 4096 byte blocks).
64.10 writes/second (10 second average, 4096 byte blocks).
91.30 writes/second (10 second average, 4096 byte blocks).
29.70 writes/second (10 second average, 4096 byte blocks).
28.80 writes/second (10 second average, 4096 byte blocks).
95.60 writes/second (10 second average, 4096 byte blocks).
58.50 writes/second (10 second average, 4096 byte blocks).
131.90 writes/second (10 second average, 4096 byte blocks).
6.80 writes/second (10 second average, 4096 byte blocks).
118.00 writes/second (10 second average, 4096 byte blocks).
3.10 writes/second (10 second average, 4096 byte blocks).
73.70 writes/second (10 second average, 4096 byte blocks).
30.00 writes/second (10 second average, 4096 byte blocks).
87.80 writes/second (10 second average, 4096 byte blocks).
97.80 writes/second (10 second average, 4096 byte blocks).
54.60 writes/second (10 second average, 4096 byte blocks).
64.60 writes/second (10 second average, 4096 byte blocks).
6.40 writes/second (10 second average, 4096 byte blocks).
126.20 writes/second (10 second average, 4096 byte blocks).
23.50 writes/second (10 second average, 4096 byte blocks).
88.00 writes/second (10 second average, 4096 byte blocks).
85.00 writes/second (10 second average, 4096 byte blocks).
90.70 writes/second (10 second average, 4096 byte blocks).
12.90 writes/second (10 second average, 4096 byte blocks).
40.90 writes/second (10 second average, 4096 byte blocks).



2.4.3 - 160 meg intel PII.  Same machine as above, dual boot
---------------------------------------------------------------
File size: 209715200  Blocks: 51200
57.40 writes/second (10 second average, 4096 byte blocks).
69.20 writes/second (10 second average, 4096 byte blocks).
84.90 writes/second (10 second average, 4096 byte blocks).
58.70 writes/second (10 second average, 4096 byte blocks).
52.60 writes/second (10 second average, 4096 byte blocks).
36.60 writes/second (10 second average, 4096 byte blocks).
35.10 writes/second (10 second average, 4096 byte blocks).
65.80 writes/second (10 second average, 4096 byte blocks).
74.70 writes/second (10 second average, 4096 byte blocks).
88.90 writes/second (10 second average, 4096 byte blocks).
58.20 writes/second (10 second average, 4096 byte blocks).
45.20 writes/second (10 second average, 4096 byte blocks).
49.50 writes/second (10 second average, 4096 byte blocks).
59.20 writes/second (10 second average, 4096 byte blocks).
112.70 writes/second (10 second average, 4096 byte blocks).
72.70 writes/second (10 second average, 4096 byte blocks).
93.10 writes/second (10 second average, 4096 byte blocks).
27.80 writes/second (10 second average, 4096 byte blocks).
134.50 writes/second (10 second average, 4096 byte blocks).
6.90 writes/second (10 second average, 4096 byte blocks).
89.50 writes/second (10 second average, 4096 byte blocks).
61.00 writes/second (10 second average, 4096 byte blocks).
106.10 writes/second (10 second average, 4096 byte blocks).
149.50 writes/second (10 second average, 4096 byte blocks).
2.60 writes/second (10 second average, 4096 byte blocks).
168.40 writes/second (10 second average, 4096 byte blocks).
1.50 writes/second (10 second average, 4096 byte blocks).
33.30 writes/second (10 second average, 4096 byte blocks).
48.10 writes/second (10 second average, 4096 byte blocks).
114.20 writes/second (10 second average, 4096 byte blocks).
183.40 writes/second (10 second average, 4096 byte blocks).
97.10 writes/second (10 second average, 4096 byte blocks).
155.00 writes/second (10 second average, 4096 byte blocks).
2.10 writes/second (10 second average, 4096 byte blocks).
1.10 writes/second (10 second average, 4096 byte blocks).
1.90 writes/second (10 second average, 4096 byte blocks).
64.60 writes/second (10 second average, 4096 byte blocks).
195.30 writes/second (10 second average, 4096 byte blocks).
114.20 writes/second (10 second average, 4096 byte blocks).
97.50 writes/second (10 second average, 4096 byte blocks).
96.90 writes/second (10 second average, 4096 byte blocks).
3.30 writes/second (10 second average, 4096 byte blocks).
11.10 writes/second (10 second average, 4096 byte blocks).
39.40 writes/second (10 second average, 4096 byte blocks).
127.60 writes/second (10 second average, 4096 byte blocks).
154.20 writes/second (10 second average, 4096 byte blocks).
220.30 writes/second (10 second average, 4096 byte blocks).
221.90 writes/second (10 second average, 4096 byte blocks).
4.20 writes/second (10 second average, 4096 byte blocks).
3.60 writes/second (10 second average, 4096 byte blocks).
2.00 writes/second (10 second average, 4096 byte blocks).
2.70 writes/second (10 second average, 4096 byte blocks).
5.60 writes/second (10 second average, 4096 byte blocks).
217.40 writes/second (10 second average, 4096 byte blocks).
253.80 writes/second (10 second average, 4096 byte blocks).
240.30 writes/second (10 second average, 4096 byte blocks).
67.40 writes/second (10 second average, 4096 byte blocks).
2.60 writes/second (10 second average, 4096 byte blocks).
2.20 writes/second (10 second average, 4096 byte blocks).
2.30 writes/second (10 second average, 4096 byte blocks).
1.90 writes/second (10 second average, 4096 byte blocks).
80.60 writes/second (10 second average, 4096 byte blocks).
232.70 writes/second (10 second average, 4096 byte blocks).
218.40 writes/second (10 second average, 4096 byte blocks).
245.30 writes/second (10 second average, 4096 byte blocks).
13.60 writes/second (10 second average, 4096 byte blocks).



2.4.0 - 384 meg ppc machine (just for sanity, no idea what
hardware is in it.  Exhibits same behaviour as intel machine)
---------------------------------------------------------------
File size: 566231040  Blocks: 138240
161.10 writes/second (10 second average, 4096 byte blocks).
168.40 writes/second (10 second average, 4096 byte blocks).
170.10 writes/second (10 second average, 4096 byte blocks).
164.00 writes/second (10 second average, 4096 byte blocks).
90.90 writes/second (10 second average, 4096 byte blocks).
2.60 writes/second (10 second average, 4096 byte blocks).
0.90 writes/second (10 second average, 4096 byte blocks).
0.60 writes/second (10 second average, 4096 byte blocks).
0.30 writes/second (10 second average, 4096 byte blocks).
0.50 writes/second (10 second average, 4096 byte blocks).
0.50 writes/second (10 second average, 4096 byte blocks).
16.10 writes/second (10 second average, 4096 byte blocks).
51.30 writes/second (10 second average, 4096 byte blocks).
182.00 writes/second (10 second average, 4096 byte blocks).
136.90 writes/second (10 second average, 4096 byte blocks).
126.00 writes/second (10 second average, 4096 byte blocks).
20.60 writes/second (10 second average, 4096 byte blocks).
0.40 writes/second (10 second average, 4096 byte blocks).
0.50 writes/second (10 second average, 4096 byte blocks).
0.10 writes/second (10 second average, 4096 byte blocks).
0.40 writes/second (10 second average, 4096 byte blocks).
0.20 writes/second (10 second average, 4096 byte blocks).
0.50 writes/second (10 second average, 4096 byte blocks).
9.60 writes/second (10 second average, 4096 byte blocks).
19.90 writes/second (10 second average, 4096 byte blocks).
54.70 writes/second (10 second average, 4096 byte blocks).
88.80 writes/second (10 second average, 4096 byte blocks).
27.20 writes/second (10 second average, 4096 byte blocks).
49.50 writes/second (10 second average, 4096 byte blocks).
1.10 writes/second (10 second average, 4096 byte blocks).
0.20 writes/second (10 second average, 4096 byte blocks).
10.80 writes/second (10 second average, 4096 byte blocks).
16.30 writes/second (10 second average, 4096 byte blocks).
72.20 writes/second (10 second average, 4096 byte blocks).
136.90 writes/second (10 second average, 4096 byte blocks).
114.90 writes/second (10 second average, 4096 byte blocks).
89.00 writes/second (10 second average, 4096 byte blocks).
32.00 writes/second (10 second average, 4096 byte blocks).
0.10 writes/second (10 second average, 4096 byte blocks).
0.20 writes/second (10 second average, 4096 byte blocks).
0.10 writes/second (10 second average, 4096 byte blocks).
0.50 writes/second (10 second average, 4096 byte blocks).
4.80 writes/second (10 second average, 4096 byte blocks).
15.60 writes/second (10 second average, 4096 byte blocks).
28.00 writes/second (10 second average, 4096 byte blocks).
159.90 writes/second (10 second average, 4096 byte blocks).
54.40 writes/second (10 second average, 4096 byte blocks).
74.90 writes/second (10 second average, 4096 byte blocks).
2.00 writes/second (10 second average, 4096 byte blocks).
0.60 writes/second (10 second average, 4096 byte blocks).
