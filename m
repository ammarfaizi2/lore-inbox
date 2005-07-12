Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVGLLOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVGLLOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVGLLMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:12:23 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:51868 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261334AbVGLLKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:10:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
Date: Tue, 12 Jul 2005 21:10:41 +1000
User-Agent: KMail/1.8.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1557115.hKOGQWqYNT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507122110.43967.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1557115.hKOGQWqYNT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

	Interbench - The Linux Interactivity Benchmark v0.20

http://interbench.kolivas.org

direct download link:
http://ck.kolivas.org/apps/interbench/interbench-0.20.tar.bz2

	Introduction

This benchmark application is designed to benchmark interactivity in Linux.

	Interactivity, what is it?

There has been a lot of talk about what makes up a nice feeling desktop und=
er
linux. It comes down to two different but intimately related parameters whi=
ch
are not well defined. We often use the terms responsiveness and interactivi=
ty
in the same sentence, but I'd like to separate the two. As there is no form=
al
definition I prefer to define them as such:

Responsiveness: The rate at which your workloads can proceed under different
load conditions.

Interactivity: The scheduling latency and jitter present in tasks where the=
=20
user would notice a palpable deterioration under different load conditions.

Responsiveness would allow you to continue using your machine without too m=
uch
interruption to your work, whereas interactivity would allow you to play au=
dio
or video without any dropouts, or drag a gui window across the screen and h=
ave
it render smoothly across the screen without jerks .

Contest was a benchmark originally written by me to test system=20
responsiveness, and interbench is a benchmark I wrote as a sequel to contes=
t=20
to test interactivity.

It is designed to measure the effect of changes in Linux kernel design or=20
system
configuration changes such as cpu, I/O scheduler and filesystem changes and
options. With careful benchmarking, different hardware can be compared.


	What does it do?

It is designed to emulate the cpu scheduling behaviour of interactive tasks=
=20
and
measure their scheduling latency and jitter. It does this with the tasks on
their own and then in the presence of various background loads, both with
configurable nice levels and the benchmarked tasks can be real time.


	How does it work?

=46irst it benchmarks how best to reproduce a fixed percentage of cpu usage=
 on=20
the machine currently being used for the benchmark. It saves this to a file=
=20
and then uses this for all subsequent runs to keep the emulation of cpu usa=
ge=20
constant.

It runs a real time high priority timing thread that wakes up the thread or
threads of the simulated interactive tasks and then measures the latency in=
=20
the time taken to schedule. As there is no accurate timer driven scheduling=
=20
in linux the timing thread sleeps as accurately as linux kernel supports, a=
nd=20
latency is considered as the time from this sleep till the simulated task=20
gets scheduled.


	What interactive tasks are simulated and how?

X:
X is simulated as a thread that uses a variable amount of cpu ranging from =
0=20
to 100%. This simulates an idle gui where a window is grabbed and then=20
dragged across the screen.

Audio:
Audio is simulated as a thread that tries to run at 50ms intervals that then
requires 5% cpu. This behaviour ignores any caching that would normally be=
=20
done by well designed audio applications, but has been seen as the interval=
=20
used to write to audio cards by a popular linux audio player. It also ignor=
es=20
any of the effects of different audio drivers and audio cards. Audio can al=
so=20
be run as a real time SCHED_FIFO task.

Video:
Video is simulated as a thread that tries to receive cpu 60 times per second
and uses 40% cpu. This would be quite a demanding video playback at 60fps.=
=20
Like the audio simulator it ignores caching, drivers and video cards. As pe=
r=20
audio, video can be run SCHED_FIFO.


	What loads are simulated?

None:
Otherwise idle system.

Video:
The video simulation thread is also used as a background load.

X:
The X simulation thread is used as a load.

Burn:
A configurable number of threads fully cpu bound (4 by default).

Write:
A streaming write to disk repeatedly of a file the size of physical ram.

Read:
Repeatedly reading a file from disk the size of physical ram (to avoid any
caching effects).

Compile:
Simulating a heavy 'make -j4' compilation by running Burn, Write and Read
concurrently.

Memload:
Simulating heavy memory and swap pressure by repeatedly accessing 110% of
available ram and moving it around and freeing it.


	What is measured and what does it mean?

1. The average scheduling latency (time to requesting cpu till actually=20
getting
it) of deadlines met during the test period.=20
2. The scheduling jitter is represented by calculating the standard deviati=
on
of the latency
3. The maximum latency seen during the test period
4. Percentage of desired cpu
5. Percentage of deadlines met.

This data is output to console and saved to a file which is stamped with the
kernel name and date. Use fixed font for clarity:

	Sample:
=2D-- Benchmarking X in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.495 +/- 0.495         45		 100	         96
Video	   11.7 +/- 11.7        1815		89.6	       62.7
Burn	   27.9 +/- 28.1        3335		78.5	         44
Write	   4.02 +/- 4.03         372		  97	       78.7
Read	   1.09 +/- 1.09         158		99.7	         88
Compile	   28.8 +/- 28.8        3351		78.2	       43.7
Memload	   2.81 +/- 2.81         187		98.7	         85

What can be seen here is that never during this test run were all the so=20
called deadlines met by the X simulator, although all the desired cpu was=20
achieved under no load. In X terms this means that every bit of window=20
movement was drawn while moving the window, but some were delayed and there=
=20
was enough time to catch up before the next deadline. In the 'Burn' column =
we=20
can see that only 44% of the deadlines were met, and only 78.5% of the=20
desired cpu was achieved. This means that some deadlines were so late=20
(%deadlines met was low) that some redraws were dropped entirely to catch u=
p.=20
In X terms this would translate into jerky movement, in audio it would be a=
=20
skip, and in video it would be a dropped frame. Note that despite the massi=
ve=20
maximum latency of >3seconds, the average latency is still less than 30ms.=
=20
This is because redraws are dropped in order to catch up usually by these=20
sorts of applications.


	What is relevant in the data?

The results pessimise quite a lot what happens in real world terms because=
=20
they ignore the reality of buffering, but this allows us to pick up subtle=
=20
differences more readily. In terms of what would be noticed by the end user,
dropping deadlines would make noticable clicks in audio, subtle visible fra=
me
time delays in video, and loss of "smooth" movement in X. Dropping desired =
cpu
would be much more noticeable with audio skips, missed video frames or jerks
in window movement under X. The magnitude of these would be best represente=
d=20
by the maximum latency. When the deadlines are actually met, the average=20
latency represents how "smooth" it would look. Average humans' limit of=20
perception for jitter is in the order of 7ms. Trained audio observers might=
=20
notice much less.


	How to use it?

In response to critisicm of difficulty in setting up my previous benchmark,=
=20
contest, I've made this as simple as possible.

	Short version:
make
=2E/interbench

	Longer version:
Build with 'make'. It is a single executable once built so if you desire to
install it simply copy the interbench binary wherever you like.

To get good reproducible data from it you should boot into runlevel one so
that nothing else is running on the machine. All power saving (cpu throttli=
ng,
cpu frequency modifications) must be disabled on the first run to get an
accurate measurement for cpu usage. You may enable them later if you are
benchmarking their effect on interactivity on that machine. Root is almost
mandatory for this benchmark, or real time privileges at the very least. You
need free disk space in the directory it is being run in the order of 2* yo=
ur
physical ram for the disk loads. A default run in v0.20 takes about 15
minutes to complete, longer if your disk is slow.

Command line options supported:
interbench [-l <int>] [-L <int>] [-t <int] [-B <int>] [-N <int>] [-b] [-c]=
=20
[-h] [-n] [-r]
 -l     Use <int> loops per sec (default: use saved benchmark)
 -L     Use cpu load of <int> with burn load (default: 4)
 -t     Seconds to run each benchmark (default: 30)
 -B     Nice the benchmarked thread to <int> (default: 0)
 -N     Nice the load thread to <int> (default: 0)
 -b     Benchmark loops_per_ms even if it is already known
 -c     Output to console only (default: use console and logfile)
 -r     Perform real time scheduling benchmarks (default: non-rt)
 -h     Show this help

There is one hidden option which is not supported by default, -u
which emulates a uniprocessor when run on an smp machine. The support for c=
pu
affinity is not built in by default because there are multiple versions of
the sched_setaffinity call in glibc that not only accept different variable
types but across architectures take different numbers of arguments. For x86
support you can change the '#if 0' in interbench.c to '#if 1' to enable the
affinity support to be built in. The function on x86_64 for those very keen
does not have the sizeof argument.


So how does -ck perform? As much as I'd like to say it was a walkover I hav=
e=20
to admit you need to squint hard to be convinced that -ck is better overall=
=2E=20
Both mainline and -ck perform better in different load settings:

The SCHED_NORMAL nice 0 runs are as below, performed on a pentium M 1.7Ghz:

Benchmarking kernel 2.6.13-rc1 with datestamp 200507121411

=2D-- Benchmarking Audio in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.003 +/- 0          0.005		 100	        100
Video	   1.02 +/- 0.487       1.68		 100	        100
X	   1.32 +/- 2.22          10		 100	        100
Burn	  0.518 +/- 306004        52		 100	         99
Write	  0.031 +/- 0.209       2.58		 100	        100
Read	  0.006 +/- 0.00173     0.01		 100	        100
Compile	   4.59 +/- 5.74         426		96.5	         94
Memload	  0.021 +/- 0.0697     0.659		 100	        100

=2D-- Benchmarking Video in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.003 +/- 0          0.005		 100	        100
X	   3.27 +/- 3.2         41.3		88.8	       77.7
Burn	  0.003 +/- 0.001      0.005		 100	        100
Write	  0.151 +/- 0.67          50		99.5	         99
Read	  0.004 +/- 0.00173    0.037		 100	        100
Compile	  0.025 +/- 0.248       4.81		 100	        100
Memload	  0.018 +/- 0.0572     0.715		 100	        100

=2D-- Benchmarking X in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.009 +/- 0.0966         1		 100	         99
Video	   4.46 +/- 4.43         572		91.9	         66
Burn	   1.58 +/- 1.58         156		 100	         98
Write	  0.002 +/- 0.0237         4		 100	         98
Read	  0.008 +/- 0.0797        15		 100	         96
Compile	  0.009 +/- 0.0896         2		 100	         99
Memload	  0.108 +/- 0.13          10		 100	         98


Benchmarking kernel 2.6.12-rc6-ck1 with datestamp 200507121345

=2D-- Benchmarking Audio in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.003 +/- 0          0.005		 100	        100
Video	  0.003 +/- 0          0.004		 100	        100
X	   2.53 +/- 3.01          11		 100	        100
Burn	  0.294 +/- 1.47          11		 100	        100
Write	  0.025 +/- 0.116       1.02		 100	        100
Read	  0.007 +/- 0.001       0.01		 100	        100
Compile	  0.393 +/- 1.68          11		 100	        100
Memload	  0.095 +/- 0.545          6		 100	        100

=2D-- Benchmarking Video in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.003 +/- 0.00245    0.052		 100	        100
X	   3.57 +/- 3.21        22.7		95.7	       91.3
Burn	  0.837 +/- 2.49          50		97.7	       95.5
Write	  0.094 +/- 0.596       16.7		 100	       99.8
Read	  0.005 +/- 0.00872    0.169		 100	        100
Compile	  0.543 +/- 1.91        33.3		98.8	       97.7
Memload	   0.21 +/- 0.836       16.7		99.7	       99.3

=2D-- Benchmarking X in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.009 +/- 0.0964         1		 100	         99
Video	   2.31 +/- 2.27         754		90.9	         65
Burn	  0.129 +/- 0.151         12		 100	         98
Write	  0.069 +/- 0.112          6		 100	         98
Read	  0.009 +/- 0.0896         1		 100	         99
Compile	  0.039 +/- 0.102          3		 100	         98
Memload	  0.004 +/- 0.0408         1		 100	         99


The full logs are available here (including niced runs and real time runs):
http://ck.kolivas.org/apps/interbench/2.6.13-rc1.log
http://ck.kolivas.org/apps/interbench/2.6.12-rc6-ck1.log

Thanks:
=46or help from Zwane Mwaikambo, Bert Hubert, Seth Arnold, Rik Van Riel, =20
Nicholas Miell and John Levon. Aggelos Economopoulos for contest code, and
Bob Matthews for irman (mem_load) code.

This was quite some time in the making... I realise there's so much more th=
at=20
could be done trying to simulate the interactive tasks and the loads, but=20
this is a start, it's quite standardised and the results are reproducible.=
=20
Adding more code to simulate loads and threads to benchmark is quite easy i=
f=20
someone wishes to suggest or code up something I'm all ears. Of course=20
bugfixes, comments and suggestions are most welcome.

Cheers,
Con Kolivas

--nextPart1557115.hKOGQWqYNT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC06UzZUg7+tp6mRURAj7kAJ9W8nOJ//NidNW+5Ja2AR8HDeyAQACePYi8
176FLIGuk130kF3Ei6n2NMU=
=osFz
-----END PGP SIGNATURE-----

--nextPart1557115.hKOGQWqYNT--
