Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRJaAKz>; Tue, 30 Oct 2001 19:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJaAKq>; Tue, 30 Oct 2001 19:10:46 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40075 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S274757AbRJaAKj>;
	Tue, 30 Oct 2001 19:10:39 -0500
Date: Tue, 30 Oct 2001 16:11:06 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011030161106.F1097@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011030092834.A16050@watson.ibm.com> <Pine.LNX.4.40.0110300914450.1495-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0110300914450.1495-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Tue, Oct 30, 2001 at 09:19:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide,

We had an 8 way sitting idle, so I ran some benchmarks comparing your
scheduler to Vanilla and also to the MQ scheduler at LSE.  When I get
a chance, I'd also like to run TPC-H with your scheduler.  Here are
the results for what they are worth.

-- 
Mike


--------------------------------------------------------------------
reflex - Similar to lat_ctx of LMbench but much more agressive.
         Keeps more than a single task active.  # active tasks
         is 1/2 total number of tasks.  Result is 'round trip'
         time.  Less is better.
--------------------------------------------------------------------
# tasks       Vanilla Sched   MQ Sched         Xsched
--------------------------------------------------------------------
2        	 6.521		7.429		8.865
4               11.304		8.581		3.187
8        	13.501		6.907		2.425
16 		15.855		5.299		1.641
32 		17.742		3.267		2.049
64 		20.613		2.960		2.236
128 		26.234		2.983		2.527

--------------------------------------------------------------------
Chat - VolanoMark simulator.  Result is a measure of throughput.
       Higher is better.
--------------------------------------------------------------------
Configuratoin Parms	Vanilla		MQ Sched	Xsched
--------------------------------------------------------------------
10 rooms, 100 messages	 69465		400055		229301
10 rooms, 200 messages 	 86868		354468		187775
10 rooms, 300 messages 	103715		363141		205799
10 rooms, 400 messages 	133385		380603		195987
20 rooms, 100 messages 	 50936		396710		216406
20 rooms, 200 messages 	 74200		385996		197076
20 rooms, 300 messages 	 95509		402232		210225
20 rooms, 400 messages 	101305		437776		215118
30 rooms, 100 messages 	 42019		376442		247781
30 rooms, 200 messages 	 42315		384598		222258
30 rooms, 300 messages 	 52948		413984		231298
30 rooms, 400 messages 	  6564		 46316		 24879


--------------------------------------------------------------------
lat_ctx - Context switching component of LMbench.  Result is 'round
          trip' time.  Less is better.
--------------------------------------------------------------------
Size/# tasks     Vanilla         MQ Sched         Xsched
--------------------------------------------------------------------
"size=0k 	 ovr=2.30 	 ovr=2.33 	 ovr=2.41
2 		 2.79 2.96 	 4.74 4.83 	 11.29 11.30

"size=0k 	 ovr=2.34 	 ovr=2.36 	 ovr=2.35
4 		 2.88 3.78 	 5.51 6.72 	 6.77 8.50

"size=0k 	 ovr=2.36 	 ovr=2.38 	 ovr=2.38
8 		 3.08 4.16 	 5.70 6.27 	 7.19 8.40

"size=0k 	 ovr=2.43 	 ovr=2.35 	 ovr=2.37
16 		 3.08 3.69 	 7.54 8.34 	 8.30 8.92

"size=0k 	 ovr=2.46 	 ovr=2.47 	 ovr=2.42
32 		 3.28 4.54 	 6.58 7.99 	 8.61 8.63

"size=0k 	 ovr=2.48 	 ovr=2.46 	 ovr=2.47
64 		 3.78 4.72 	 7.16 7.54 	 8.48 8.48

"size=0k 	 ovr=2.53 	 ovr=2.42 	 ovr=2.50
128 		 6.60 7.28 	 7.49 7.96 	 8.20 8.25

"size=0k 	 ovr=2.59 	 ovr=2.56 	 ovr=2.53
256 		 9.91 10.08 	 8.02 8.29 	 8.44 8.47

"size=4k 	 ovr=3.93 	 ovr=3.83 	 ovr=3.92
2 		 3.31 4.21 	 5.08 5.13 	 5.36 10.82

"size=4k 	 ovr=3.95 	 ovr=3.84 	 ovr=3.84
4 		 3.95 4.46 	 6.17 8.66 	 11.97 11.98

"size=4k 	 ovr=3.91 	 ovr=3.90 	 ovr=3.98
8 		 4.45 5.28 	 6.55 7.51 	 8.63 8.88

"size=4k 	 ovr=3.95 	 ovr=3.91 	 ovr=3.91
16 		 4.60 5.49 	 9.40 9.61 	 9.53 9.67

"size=4k 	 ovr=3.96 	 ovr=3.92 	 ovr=3.90
32 		 4.87 5.82 	 8.59 9.17 	 9.96 9.97

"size=4k 	 ovr=3.98 	 ovr=4.01 	 ovr=3.95
64 		 13.99 14.06 	 8.77 9.59 	 9.93 9.94

"size=4k 	 ovr=4.02 	 ovr=3.94 	 ovr=3.98
128 		 13.26 18.27 	 9.28 10.11 	 9.84 9.85

"size=4k 	 ovr=4.07 	 ovr=3.99 	 ovr=4.07
256 		 15.40 16.46 	 11.02 11.52 	 10.22 10.26

"size=8k 	 ovr=5.39 	 ovr=5.35 	 ovr=5.33
2 		 4.54 5.40 	 6.51 6.62 	 11.71 11.72

"size=8k 	 ovr=5.41 	 ovr=5.45 	 ovr=5.41
4 		 5.83 6.50 	 6.19 7.26 	 8.80 11.26

"size=8k 	 ovr=5.39 	 ovr=5.36 	 ovr=5.41
8 		 5.81 6.98 	 8.18 8.81 	 10.15 10.17

"size=8k 	 ovr=5.42 	 ovr=5.31 	 ovr=5.37
16 		 6.86 7.57 	 9.80 10.20 	 11.69 11.71

"size=8k 	 ovr=5.42 	 ovr=5.41 	 ovr=5.41
32 		 6.77 7.85 	 10.28 10.90 	 11.46 11.47

"size=8k 	 ovr=5.48 	 ovr=5.48 	 ovr=5.45
64 		 17.32 17.49 	 10.60 11.24 	 11.45 11.51

"size=8k 	 ovr=5.51 	 ovr=5.40 	 ovr=5.45
128 		 14.74 20.35 	 11.43 11.97 	 11.52 11.53

"size=8k 	 ovr=5.54 	 ovr=5.47 	 ovr=5.54
256 		 16.36 18.89 	 13.77 14.46 	 12.59 12.61

"size=16k 	 ovr=8.30 	 ovr=8.37 	 ovr=8.32
2 		 8.47 9.62 	 8.63 8.86 	 7.11 9.29

"size=16k 	 ovr=8.33 	 ovr=8.30 	 ovr=8.29
4 		 8.76 9.36 	 9.42 10.07 	 11.83 13.28

"size=16k 	 ovr=8.33 	 ovr=8.35 	 ovr=8.30
8 		 9.22 10.14 	 13.78 14.21 	 13.30 13.49

"size=16k 	 ovr=8.34 	 ovr=8.29 	 ovr=8.35
16 		 9.39 10.08 	 12.57 12.98 	 14.30 14.31

"size=16k 	 ovr=8.39 	 ovr=8.36 	 ovr=8.35
32 		 26.91 28.87 	 13.26 13.64 	 14.26 14.35

"size=16k 	 ovr=8.40 	 ovr=8.47 	 ovr=8.45
64 		 28.82 31.86 	 13.62 13.79 	 14.62 14.63

"size=16k 	 ovr=8.41 	 ovr=8.38 	 ovr=8.42
128 		 21.35 24.18 	 14.65 15.51 	 14.59 14.62

"size=16k 	 ovr=8.47 	 ovr=8.47 	 ovr=8.46
256 		 28.84 30.53 	 20.76 22.94 	 25.63 25.79

"size=32k 	 ovr=14.27 	 ovr=14.19 	 ovr=14.14
2 		 13.80 14.74 	 15.96 16.10 	 21.87 21.89

"size=32k 	 ovr=14.25 	 ovr=14.16 	 ovr=14.19
4 		 13.77 14.48 	 16.49 18.04 	 21.99 22.00

"size=32k 	 ovr=14.26 	 ovr=14.19 	 ovr=14.24
8 		 13.91 14.90 	 18.63 19.01 	 20.99 21.00

"size=32k 	 ovr=14.26 	 ovr=14.20 	 ovr=14.27
16 		 43.47 43.87 	 18.44 19.40 	 20.37 20.38

"size=32k 	 ovr=14.29 	 ovr=14.24 	 ovr=14.30
32 		 40.37 52.34 	 19.14 19.77 	 19.48 19.50

"size=32k 	 ovr=14.33 	 ovr=14.29 	 ovr=14.31
64 		 42.02 46.30 	 19.84 20.58 	 20.44 20.52

"size=32k 	 ovr=14.30 	 ovr=14.30 	 ovr=14.30
128 		 50.81 55.60 	 28.88 30.81 	 31.83 31.84

"size=32k 	 ovr=14.38 	 ovr=14.35 	 ovr=14.41
256 		 98.82 99.65 	 88.38 90.05 	 82.76 83.08

"size=64k 	 ovr=26.01 	 ovr=26.03 	 ovr=26.00
2 		 24.00 24.59 	 26.08 26.21 	 32.00 32.01

"size=64k 	 ovr=26.09 	 ovr=26.04 	 ovr=26.05
4 		 23.98 24.70 	 26.71 26.86 	 32.21 32.24

"size=64k 	 ovr=26.00 	 ovr=26.05 	 ovr=26.09
8 		 78.16 78.41 	 28.97 30.39 	 31.07 31.10

"size=64k 	 ovr=26.03 	 ovr=26.03 	 ovr=26.04
16 		 127.98 136.30 	 28.90 29.52 	 30.55 30.61

"size=64k 	 ovr=26.11 	 ovr=26.08 	 ovr=26.31
32 		 97.96 104.32 	 31.65 33.72 	 31.19 31.31

"size=64k 	 ovr=26.15 	 ovr=26.08 	 ovr=26.20
64 		 99.31 111.11 	 48.61 53.92 	 47.59 47.62

"size=64k 	 ovr=26.16 	 ovr=26.09 	 ovr=26.12
128 		 175.26 179.98 	 149.98 152.29 	 166.18 166.44

"size=64k 	 ovr=26.21 	 ovr=26.17 	 ovr=26.23
256 		 238.61 244.75 	 227.39 227.64 	 224.67 224.73

