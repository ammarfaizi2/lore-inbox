Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264792AbSKJKDb>; Sun, 10 Nov 2002 05:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264793AbSKJKDb>; Sun, 10 Nov 2002 05:03:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37315 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264792AbSKJKDa>;
	Sun, 10 Nov 2002 05:03:30 -0500
Date: Sun, 10 Nov 2002 11:09:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>,
       Marcelo <marcelo@conectiva.com.br>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021110100942.GG31134@suse.de>
References: <200211091300.32127.conman@kolivas.net> <200211100009.55844.conman@kolivas.net> <20021109135446.GA2551@suse.de> <200211100854.05713.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211100854.05713.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10 2002, Con Kolivas wrote:
> >The default is 2048. How long does the io_load test take, or rather how
> >many tests are appropriate to do? To get a good picture of how it looks
> >you should probably try: 0, 8, 16, 64, 128, 512. Once you get some of
> >these results, it will be easier to determine which area(s) would be
> >most interesting to further explore.
> 
> The io_load test takes as long as the time in seconds shown on the table. At 
> least 3 tests are appropriate to get a reasonable average [runs is in square 
> parentheses]. Therefore it takes about half an hour per run. Luckily I had 
> the benefit of a night to set up a whole lot of runs:
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2420rc1r0 [3]           489.3   15      36      10      6.85
> 2420rc1r8 [3]           485.5   15      35      10      6.80
> 2420rc1r16 [3]          570.4   12      43      10      7.99
> 2420rc1r32 [3]          570.1   12      42      10      7.98
> 2420rc1r64 [3]          575.0   12      43      10      8.05
> 2420rc1r128 [3]         611.4   11      46      10      8.56
> 2420rc1r256 [3]         646.2   11      49      10      9.05
> 2420rc1r512 [3]         603.7   12      45      10      8.46
> 2420rc1r1024 [3]        693.9   10      53      10      9.72
> 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
> 
> Test hardware is 1133Mhz P3 laptop with 5400rpm ATA100 drive. I don't doubt 
> the response curve would be different for other hardware.

That looks pretty good, the behaviour in 2.4.20-rc1 is no sanely tunable
unlike before. Could you retest the whole contest suite with 512 as the
default value? It looks like a good default for 2.4.20.

Marcelo, we probably need to make few tweaks here to get the read
passover value right. The algorithmic changes in 2.4.20-pre made it
impossible to guess a good default value, as we invalidated the previous
tests. Right now we are using 2048 which is a number I basically pulled
out of my ass, it looks as if it might be a bit high. So I'll be sending
you a one-liner correction once a decent default value is found.

-- 
Jens Axboe

