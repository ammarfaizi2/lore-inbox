Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSKIVsH>; Sat, 9 Nov 2002 16:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSKIVsH>; Sat, 9 Nov 2002 16:48:07 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:1664 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S262708AbSKIVsG> convert rfc822-to-8bit; Sat, 9 Nov 2002 16:48:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Date: Sun, 10 Nov 2002 08:53:41 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
References: <200211091300.32127.conman@kolivas.net> <200211100009.55844.conman@kolivas.net> <20021109135446.GA2551@suse.de>
In-Reply-To: <20021109135446.GA2551@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211100854.05713.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>On Sun, Nov 10 2002, Con Kolivas wrote:
>> >On Sat, Nov 09 2002, Con Kolivas wrote:
>> >> >You're showing a big shift in behaviour between 2.4.19 and 2.4.20-rc1.
>> >> >Maybe it doesn't translate to worsened interactivity.  Needs more
>> >> >testing and anaysis.
>> >>
>> >> Sounds fair enough. My resources are exhausted though. Someone else
>> >> have any thoughts?
>> >
>> >Try setting lower elevator passover values. Something ala
>> >
>> ># elvtune -r 64 /dev/hda
>> >
>> >(or whatever your drive is)
>>

>> That's it then. Should I run a family of different values and if so
>> over what range?
>
>The default is 2048. How long does the io_load test take, or rather how
>many tests are appropriate to do? To get a good picture of how it looks
>you should probably try: 0, 8, 16, 64, 128, 512. Once you get some of
>these results, it will be easier to determine which area(s) would be
>most interesting to further explore.

The io_load test takes as long as the time in seconds shown on the table. At 
least 3 tests are appropriate to get a reasonable average [runs is in square 
parentheses]. Therefore it takes about half an hour per run. Luckily I had 
the benefit of a night to set up a whole lot of runs:

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2420rc1r0 [3]           489.3   15      36      10      6.85
2420rc1r8 [3]           485.5   15      35      10      6.80
2420rc1r16 [3]          570.4   12      43      10      7.99
2420rc1r32 [3]          570.1   12      42      10      7.98
2420rc1r64 [3]          575.0   12      43      10      8.05
2420rc1r128 [3]         611.4   11      46      10      8.56
2420rc1r256 [3]         646.2   11      49      10      9.05
2420rc1r512 [3]         603.7   12      45      10      8.46
2420rc1r1024 [3]        693.9   10      53      10      9.72
2.4.20-rc1 [2]          1142.2  6       90      10      16.00

Test hardware is 1133Mhz P3 laptop with 5400rpm ATA100 drive. I don't doubt 
the response curve would be different for other hardware.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9zYPmF6dfvkL3i1gRAlgQAJ9wbCJUc6OesGsuR+S2YHi2+zzRuACePEPJ
MIVeNptM2zdnvEFPZXCWMO8=
=7M4k
-----END PGP SIGNATURE-----

