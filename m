Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277276AbRJEACm>; Thu, 4 Oct 2001 20:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277282AbRJEACc>; Thu, 4 Oct 2001 20:02:32 -0400
Received: from mccammon.ucsd.edu ([132.239.16.211]:10124 "EHLO
	mccammon.ucsd.edu") by vger.kernel.org with ESMTP
	id <S277276AbRJEACP>; Thu, 4 Oct 2001 20:02:15 -0400
Date: Thu, 4 Oct 2001 17:03:05 -0700 (PDT)
From: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>
X-X-Sender: <apodtele@chemcca18.ucsd.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
Message-ID: <Pine.LNX.4.33.0110041618450.2582-100000@chemcca18.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I've already expressed my concern about using srand(1) in private e-mails.
I think it's unscientific to use one particular random sequence. Since 
no one checked if that matters, I changed srand(1) to srand(time(NULL)) 
and I'm posting my results. I don't do testing of Alan or Linus's kernels, 
but use recent Red Hat kernel. I think I've shown that it does matter.

Six quick consecutive runs of modified qs on a small set of 8 million 
integers (obviously no swap activity):

> time ./a.out 8000000
0 errors.
24.250u 0.310s 0:24.55 100.0%   0+0k 0+0io 116pf+0w
0 errors.
24.290u 0.260s 0:24.55 100.0%   0+0k 0+0io 116pf+0w
0 errors.
24.300u 0.260s 0:24.55 100.0%   0+0k 0+0io 116pf+0w
0 errors.
24.270u 0.300s 0:24.57 100.0%   0+0k 0+0io 116pf+0w
0 errors.
24.290u 0.270s 0:24.56 100.0%   0+0k 0+0io 116pf+0w
0 errors.
24.280u 0.280s 0:24.55 100.0%   0+0k 0+0io 116pf+0w

Apparently, no significant deviations in computing times.

Six runs of modified qs on a large set of 80 million integers (a lot of 
swapping!)

> time ./a.out 80000000
0 errors.
261.580u 4.250s 11:09.21 39.7%  0+0k 0+0io 17379pf+0w
0 errors.
260.460u 3.660s 9:09.72 48.0%   0+0k 0+0io 13194pf+0w
0 errors.
260.620u 4.510s 10:39.80 41.4%  0+0k 0+0io 16714pf+0w
0 errors.
261.790u 4.150s 10:09.58 43.6%  0+0k 0+0io 16331pf+0w
0 errors.
260.400u 4.140s 9:23.46 46.9%   0+0k 0+0io 13722pf+0w
0 errors.
259.980u 3.940s 9:10.22 47.9%   0+0k 0+0io 14240pf+0w

mean = 9m57s; standard deviation = 50s.

Apparently, the random sequence does matter (to the Rik's algorithm at 
least since it's in RH kernel).

I wonder how big the deviation is for official and AC trees.
Now Lorenzo's results seem inconclusive.

Regards,
Alexei

