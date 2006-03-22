Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWCVMN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWCVMN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 07:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWCVMN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 07:13:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:16869 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750836AbWCVMNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 07:13:55 -0500
X-Authenticated: #14349625
Subject: [interbench numbers] Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, bugsplatter@gmail.com,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <1142999382.11047.34.camel@homer>
References: <1142592375.7895.43.camel@homer>
	 <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer>
	 <20060321064723.GH21493@w.ods.org> <1142927498.7667.34.camel@homer>
	 <20060321091353.GA25248@w.ods.org> <20060321091422.GA9207@elte.hu>
	 <20060321111552.GA25651@w.ods.org> <20060321111850.GA2776@elte.hu>
	 <1142942878.7807.9.camel@homer>  <20060321125900.GA25943@w.ods.org>
	 <1142947456.7807.53.camel@homer>  <44208355.1080200@bigpond.net.au>
	 <1142999382.11047.34.camel@homer>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 13:14:10 +0100
Message-Id: <1143029650.8298.18.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I was asked to do some interbench runs, with various throttle settings,
see below.  I'll not attempt to interpret results, only present raw data
for others to examine.

Tested throttling patches version is V24, because while I was compiling
2.6.16-rc6-mm2 in preparation for comparison, I found I'd introduced an
SMP buglet in V23.  Something good came from the added testing whether
the results are informative or not :)

	-Mike

1. virgin 2.6.16-rc6-mm2.

Using 1975961 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.16-rc6-mm2-smp at datestamp 200603221223

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.024 +/- 0.0486         1		 100	        100
Video	  0.996 +/- 1.31        6.05		 100	        100
X	  0.336 +/- 0.739       5.01		 100	        100
Burn	  0.028 +/- 0.0905      2.05		 100	        100
Write	  0.058 +/- 0.508       12.1		 100	        100
Read	  0.043 +/- 0.115       1.66		 100	        100
Compile	  0.047 +/- 0.126       2.55		 100	        100
Memload	  0.258 +/- 4.57         112		99.8	       99.8

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.031 +/- 0.396       16.7		 100	       99.9
X	  0.722 +/- 3.35        30.7		 100	         97
Burn	  0.531 +/- 7.42         246		99.1	         98
Write	  0.302 +/- 2.31        40.4		99.9	       98.5
Read	  0.092 +/- 1.11        32.9		99.9	       99.7
Compile	  0.428 +/- 2.77        36.3		99.9	       97.9
Memload	  0.235 +/- 3.3          104		99.5	       99.1

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	   1.25 +/- 6.46          70		85.8	       83.2
Video	   17.8 +/- 32            92		31.7	       22.3
Burn	   45.5 +/- 97.5         503		8.35	       4.22
Write	   3.55 +/- 12.2          66		79.9	       73.6
Read	  0.739 +/- 3.04          20		87.4	         83
Compile	   51.9 +/- 122          857		10.7	       5.34
Memload	   1.81 +/- 6.67          54		85.1	       78.3

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU
None	   8.65 +/- 14.8         116		  92
Video	   77.9 +/- 78.5         107		56.2
X	   64.2 +/- 72.9         124		60.9
Burn	    301 +/- 317          524		24.9
Write	   26.8 +/- 45.6         135		78.9
Read	   13.1 +/- 16.8        67.9		88.4
Compile	    478 +/- 519          765		17.3
Memload	   21.1 +/- 28.8         148		82.6


2. 2.6.16-rc6-mm2x with no throttling.

Using 1975961 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.16-rc6-mm2x-smp at datestamp 200603220914

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.062 +/- 0.11        1.09		 100	        100
Video	   1.15 +/- 1.53        11.4		 100	        100
X	  0.223 +/- 0.609       6.09		 100	        100
Burn	  0.039 +/- 0.258       6.01		 100	        100
Write	  0.194 +/- 0.837         14		 100	        100
Read	   0.05 +/- 0.202       3.01		 100	        100
Compile	  0.216 +/- 1.36          19		 100	        100
Memload	  0.218 +/- 2.22        51.4		 100	       99.8

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.185 +/- 1.6         18.8		 100	       99.1
X	   1.27 +/- 4.47          27		 100	       94.3
Burn	   1.57 +/- 13.3         345		98.1	         93
Write	  0.819 +/- 3.76        34.7		99.9	         96
Read	  0.301 +/- 2.05        18.7		 100	       98.5
Compile	   4.22 +/- 12.9         233		92.4	       80.2
Memload	  0.624 +/- 3.46        66.7		99.6	         97

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	   2.57 +/- 7.94          43		74.6	       67.7
Video	   17.6 +/- 32.2          99		31.2	       22.3
Burn	   40.1 +/- 79.4         716		12.9	       6.65
Write	   6.03 +/- 16.6          80		75.1	       64.6
Read	   2.52 +/- 7.49          42		74.8	       66.7
Compile	   54.1 +/- 79.3         410		15.6	       6.56
Memload	   2.08 +/- 6.93          48		77.3	       71.7

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU
None	   12.3 +/- 16.6        65.3		  89
Video	   78.7 +/- 79.4         109		  56
X	   70.6 +/- 78.2         128		58.6
Burn	    468 +/- 492          737		17.6
Write	   36.6 +/- 52.7         300		73.2
Read	   18.3 +/- 20.6        47.9		84.5
Compile	    468 +/- 486          802		17.6
Memload	   21.4 +/- 27           132		82.4


3. 2.6.16-rc6-mm2x with default settings.

Using 1975961 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.16-rc6-mm2x-smp at datestamp 200603221006

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.033 +/- 0.0989      1.05		 100	        100
Video	  0.859 +/- 1.17        7.45		 100	        100
X	  0.239 +/- 0.662        7.1		 100	        100
Burn	   0.06 +/- 0.382       7.86		 100	        100
Write	  0.123 +/- 0.422       4.12		 100	        100
Read	  0.045 +/- 0.103       1.18		 100	        100
Compile	  0.292 +/- 2.9         65.8		 100	       99.8
Memload	  0.256 +/- 3.78        91.8		 100	       99.8

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.101 +/- 1.06        16.7		 100	       99.6
X	   1.13 +/- 4.38        33.7		99.9	       95.2
Burn	   10.7 +/- 47.1         410		67.2	       64.7
Write	   1.17 +/- 10.9         417		98.2	       94.8
Read	  0.127 +/- 1.13        16.8		 100	       99.6
Compile	    8.6 +/- 32.6         200		70.7	       63.6
Memload	  0.512 +/- 3.32        83.5		99.7	       97.6

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	    2.2 +/- 7.75          51		81.9	       74.9
Video	   15.8 +/- 29.4          81		  33	       23.9
Burn	   74.1 +/- 124          406		18.5	       9.57
Write	    4.6 +/- 14            86		  55	       48.5
Read	   1.75 +/- 5.16          26		80.7	       73.1
Compile	   71.2 +/- 124          468		21.8	       12.2
Memload	   2.95 +/- 9.31          70		75.6	       69.1

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU
None	   13.7 +/- 17.9        56.4		87.9
Video	   74.6 +/- 75.4        98.5		57.3
X	   68.2 +/- 76.1         128		59.4
Burn	    515 +/- 526          735		16.3
Write	   35.5 +/- 58.3         505		73.8
Read	   15.7 +/- 17.8        45.8		86.4
Compile	    436 +/- 453          863		18.7
Memload	   22.3 +/- 30.1         227		81.8


4. 2.6.16-rc6-mm2x with max throttling.

Using 1975961 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.16-rc6-mm2x-smp at datestamp 200603220938

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.035 +/- 0.118       2.01		 100	        100
Video	  0.043 +/- 0.231       5.02		 100	        100
X	  0.109 +/- 0.737       12.3		 100	        100
Burn	  0.072 +/- 0.574       9.78		 100	        100
Write	   0.11 +/- 0.367       4.14		 100	        100
Read	  0.052 +/- 0.141       2.02		 100	        100
Compile	    0.5 +/- 4.84         112		99.8	       99.8
Memload	  0.093 +/- 0.461       9.13		 100	        100

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.187 +/- 1.59        16.7		 100	       99.1
X	    2.4 +/- 6.26        32.8		99.9	         90
Burn	   59.7 +/- 130          478		27.1	       23.8
Write	   2.08 +/- 9.24         208		98.3	       90.5
Read	  0.154 +/- 1.3         18.8		 100	       99.4
Compile	   57.9 +/- 130          714		28.3	       22.4
Memload	  0.743 +/- 3.7         66.7		99.8	       96.3

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	   1.73 +/- 6.46          42		74.4	         70
Video	   13.3 +/- 24.5          74		39.8	       29.2
Burn	    142 +/- 206          579		9.11	       4.69
Write	   4.51 +/- 14.1        88.4		61.4	       55.5
Read	   1.38 +/- 4.38          24		85.3	       78.3
Compile	    126 +/- 190          619		12.4	       6.51
Memload	   3.61 +/- 11.7          70		61.7	       55.8

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU
None	   12.9 +/- 16.5        67.6		88.6
Video	   67.7 +/- 69          97.3		59.6
X	   70.7 +/- 77.7         130		58.6
Burn	    355 +/- 367          625		  22
Write	   35.6 +/- 61.3         545		73.8
Read	   23.1 +/- 28.4         115		81.3
Compile	    467 +/- 485          793		17.6
Memload	   25.6 +/- 32.9         138		79.6





