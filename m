Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVKIMvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVKIMvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 07:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVKIMvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 07:51:51 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:36330 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750714AbVKIMvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 07:51:51 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.14-ck4 (staircase v13)
Date: Wed, 9 Nov 2005 23:51:41 +1100
User-Agent: KMail/1.8.3
Cc: ck@vds.kolivas.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart113161070.ImMU2gikkl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511092351.44024.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart113161070.ImMU2gikkl
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

Apply to 2.6.14
http://ck.kolivas.org/patches/2.6/2.6.14/2.6.14-ck4/patch-2.6.14-ck4.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.14-cks4.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:

Added:
 +patch-2.6.14.1
Latest stable patch

 +net-fix_zero-size_datagram_reception.patch
Bugfix queued for 2.6.14.2

 +sched-staircase12.2_13.patch
Major update in the staircase code. This now makes the interactive mode wor=
k=20
out a simple mathematical calculation to determine the cpu percentage of=20
entitled cpu a task uses and use that to determine what best dynamic priori=
ty=20
(and thus how low the latency is). This means that a low cpu using task can=
=20
have very low latency even in the presence of much less niced tasks. For=20
example a nice 0 task in the presence of a nice -20 task can still have low=
=20
latency if it uses very little cpu. This means that 'nice' is a determinant=
=20
of cpu entitlement, but no longer the prime determinant of latency. It is=20
thus possible to even run low cpu using audio apps at nice 19. Running audi=
o=20
at nice 19 would be unusual, though. However this does help for the opposit=
e=20
as well - there are kernel threads that run nice 0, -5 and even -20, when=20
normal user tasks run at nice 0. Some of these kernel threads and workqueue=
s=20
can use extraordinary amounts of cpu as well. These are real world examples=
=20
where it would help on normal desktops now. Interbench benchmarks demonstra=
te=20
this below.

 -2614ck3-version.diff
 +2614ck4-version.diff
Version update


=2D--


If you are new to interbench results, the order of importance is from right=
 to=20
left, where deadlines met and desired cpu should be as close to 100% as=20
possible, amd max latency and average latency as low as possible.=20


Asterisks have been placed to the right to indicate where one kernel=20
outperforms the other. Use a fixed font to be able to read this table!

Interbench 0.29 results on 3Ghz P4 uniprocessor:

Here is mainline 2.6.14, with the benchmarked interactive process running a=
t=20
nice 19:

=2D-- Benchmarking simulated cpu of Audio nice 19 in the presence of simula=
ted
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.004 +/- 0.00442    0.008		 100	        100
Video	  0.004 +/- 0.00491    0.009		 100	        100
X	   36.4 +/- 62.7         233		  96	       63.8
Burn	    673 +/- 699          701		0.568	      0.568
Write	   1.39 +/- 9.22         118		99.5	       99.5
Read	   0.01 +/- 0.0133     0.105		 100	        100
Compile	    774 +/- 803         1003		0.559	          0
Memload	   4.78 +/- 27.9         225		95.5	       95.5

=2D-- Benchmarking simulated cpu of Video nice 19 in the presence of simula=
ted=20
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.004 +/- 0.00493    0.026		 100	        100	*
X	   21.9 +/- 50           266		54.2	       48.8
Burn	    741 +/- 770          771		0.174	      0.174
Write	   2.58 +/- 11.2         140		96.1	       90.1
Read	  0.009 +/- 0.0176     0.182		 100	        100
Compile	    758 +/- 783          877		0.173	          0
Memload	   2.38 +/- 20.3         269		93.9	       92.9

=2D-- Benchmarking simulated cpu of X nice 19 in the presence of simulated =
=2D--
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.009 +/- 0.1            1		 100	         99	*
Video	     13 +/- 23.7          60		69.8	         53
Burn	    607 +/- 634          750		1.15	       1.15
Write	   6.48 +/- 17.4          90		80.5	       66.7
Read	  0.227 +/- 1.05           6		92.7	       89.6
Compile	    680 +/- 720          957		1.14	       1.14
Memload	   7.84 +/- 31.7         272		76.6	       66.4

Note the massive dropped deadlines even with something using just 5% cpu wh=
en=20
run at nice 19


Here is 2.6.14-ck4 running staircase v13:

=2D-- Benchmarking simulated cpu of Audio nice 19 in the presence of simula=
ted=20
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.004 +/- 0.00419    0.009		 100	        100
Video	  0.004 +/- 0.00457    0.008		 100	        100
X	  0.054 +/- 0.388          4		 100	        100	*
Burn	   3.27 +/- 18.8         136		  98	       97.4	*
Write	    1.3 +/- 11.7         120		  99	         99	*
Read	  0.011 +/- 0.0119     0.056		 100	        100
Compile	   2.81 +/- 16.6         126		  98	         98	*
Memload	   3.39 +/- 22           206		97.5	       97.5	*

=2D-- Benchmarking simulated cpu of Video nice 19 in the presence of simula=
ted=20
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.031 +/- 0.682       16.7		 100	       99.8
X	   9.87 +/- 25.5         133		74.8	       67.4	*
Burn	   6.33 +/- 31.7         483		85.8	       79.6	*
Write	   1.69 +/- 11.7         172		97.1	       94.6	*
Read	  0.011 +/- 0.0142     0.107		 100	        100
Compile	   7.17 +/- 46.4         617		78.3	       75.7	*
Memload	   2.46 +/- 20.8         245		92.9	       92.9

=2D-- Benchmarking simulated cpu of X nice 19 in the presence of simulated =
=2D--
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.237 +/- 2.3           23		 100	         98
Video	     13 +/- 23.6          60		69.8	         53
Burn	    327 +/- 659         1398		20.5	       16.4	*
Write	    2.9 +/- 13.4         108		73.3	       69.9	*
Read	  0.217 +/- 1.01           6		92.7	       89.6
Compile	    365 +/- 691         1519		19.3	       14.3	*
Memload	   8.42 +/- 19.8          92		80.8	       73.2	*


You can see here that the audio benchmark meets more than 97% of the deadli=
nes=20
even in extreme loads when run at nice 19, and interbench ignores the effec=
t=20
of buffering. With some buffering it is unlikely to skip sound even at nice=
=20
19. Now if you move on to video and then X you can see that the improvement=
=20
over mainline gets progressively less as each load uses more cpu. This is=20
because the latency is determined by cpu% of entitlement. Even so, the=20
deadlines met are significantly higher (especially for video which doesnt=20
drop below 67% compared to mainline which bottoms out at 1%).=20


=2D--


Moving on to the more "real world" example of nice 0 interactive task in th=
e=20
presence of background loads running at nice -5:

Mainline 2.6.14:
=2D-- Benchmarking simulated cpu of Audio in the presence of simulated nice=
 -5=20
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.004 +/- 0.00526    0.029		 100	        100
Video	  0.004 +/- 0.00484    0.007		 100	        100
X	     36 +/- 59.8         113		75.5	       63.3
Burn	   6.78 +/- 90.5        1200		88.1	         88
Write	   2.21 +/- 13.5         141		  99	         99
Read	   0.01 +/- 0.0146     0.111		 100	        100
Compile	   22.1 +/- 183         1600		69.7	       69.3
Memload	  0.191 +/- 0.957       7.07		 100	        100

=2D-- Benchmarking simulated cpu of Video in the presence of simulated nice=
 -5=20
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.004 +/- 0.00415     0.01		 100	        100	*
X	   21.4 +/- 51.1         417		53.7	       48.2
Burn	   23.6 +/- 186         1467		41.4	         41
Write	   3.11 +/- 16.9         315		93.7	       88.8
Read	  0.009 +/- 0.0145      0.12		 100	        100
Compile	   21.5 +/- 171         1400		43.7	       43.1
Memload	  0.292 +/- 2.08        28.3		 100	         99

=2D-- Benchmarking simulated cpu of X in the presence of simulated nice -5 =
=2D--
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.009 +/- 0.0995         1		 100	         99
Video	     13 +/- 23.7          60		69.8	         53	*
Burn	   77.5 +/- 306         1404		45.6	       43.8
Write	   9.71 +/- 28.4         224		76.2	       64.9
Read	  0.245 +/- 1.13           6		91.1	       88.9
Compile	   97.6 +/- 365         1564		41.1	       39.2
Memload	   4.31 +/- 12.7          72		57.6	       51.2

You can see that without any buffering, it is possible even at nice 0 for=20
audio to miss almost 40% of the deadlines under a nice -5 X load (or=20
equivalent load from kernel threads etc).


And here is 2.6.14-ck4:

=2D-- Benchmarking simulated cpu of Audio in the presence of simulated nice=
 -5=20
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.003 +/- 0.00351    0.009		 100	        100
Video	  0.004 +/- 0.00451    0.009		 100	        100
X	  0.287 +/- 1.43          10		 100	        100	*
Burn	  0.004 +/- 0.00457    0.008		 100	        100	*
Write	  0.009 +/- 0.0102     0.018		 100	        100	*
Read	  0.011 +/- 0.0128     0.069		 100	        100
Compile	  0.009 +/- 0.0107     0.039		 100	        100	*
Memload	  0.037 +/- 0.167          2		 100	        100

=2D-- Benchmarking simulated cpu of Video in the presence of simulated nice=
 -5=20
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.031 +/- 0.682       16.7		 100	       99.8
X	   3.43 +/- 8.46        27.7		 100	         83	*
Burn	  0.032 +/- 0.681       16.7		 100	       99.8	*
Write	  0.006 +/- 0.00846     0.07		 100	        100	*
Read	  0.011 +/- 0.0115      0.04		 100	        100
Compile	   0.04 +/- 0.683       16.7		 100	       99.8	*
Memload	  0.062 +/- 0.694       16.7		 100	       99.8	*

=2D-- Benchmarking simulated cpu of X in the presence of simulated nice -5 =
=2D--
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.009 +/- 0.0995         1		 100	         99
Video	   13.5 +/- 24.1          60		67.7	       50.8
Burn	  0.117 +/- 0.783          6		98.1	       96.1	*
Write	  0.147 +/- 0.751          4		94.4	       92.4	*
Read	  0.009 +/- 0.0995         1		 100	         99	*
Compile	  0.147 +/- 0.751          4		94.4	       92.4	*
Memload	  0.176 +/- 1.69          17		 100	         99	*

Whereas here audio does not drop a single deadline even without any bufferi=
ng.=20
Video and even X also show significant improvement.


Cheers,
Con

--nextPart113161070.ImMU2gikkl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDcfDfZUg7+tp6mRURAvLmAJ94OpEFyS3Ths3kdYp6MIoygXP14QCfdqAg
PS4YrBej9AfKNPHrhsQ/Blk=
=K+e+
-----END PGP SIGNATURE-----

--nextPart113161070.ImMU2gikkl--
