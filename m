Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132829AbRDXGqZ>; Tue, 24 Apr 2001 02:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132831AbRDXGqQ>; Tue, 24 Apr 2001 02:46:16 -0400
Received: from chiara.elte.hu ([157.181.150.200]:11533 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132829AbRDXGqJ>;
	Tue, 24 Apr 2001 02:46:09 -0400
Date: Tue, 24 Apr 2001 07:44:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Szabolcs Szakacsits <szaka@f-secure.com>
Subject: [patch] swap-speedup-2.4.3-B3
In-Reply-To: <Pine.LNX.4.30.0104231707350.31693-200000@elte.hu>
Message-ID: <Pine.LNX.4.30.0104240714200.1227-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the latest swap-speedup patch can be found at:

  http://people.redhat.com/mingo/swap-speedup/swap-speedup-2.4.3-B3

(the patch is against 2.4.4-pre6 or 2.4.3-ac13.)

-B3 includes Marcelo's patch for another area that blocks unnecesserily on
locked swapcache pages: async swapcache readahead. Marcello did some tests
which shows that this fix brought some nice improvements too.

"make -j32 bzImage" using 128MB mem, 128MB swap, 4 CPUs:

  stock 2.4.3-ac13
  ----------------
  real    4m0.678s
  user    4m2.870s
  sys     0m38.920s

  swap-speedup-A2
  ---------------
  real    3m24.190s
  user    4m1.070s
  sys     0m31.950s

  swap-speedup-B3 (A2 + Marcelo's swapin-readahead non-blocking patch)
  ---------------
  real    3m7.410s
  user    4m0.940s
  sys     0m28.680s

ie. for this kernel compile test:

   swap-speedup-A2 is a 18% speedup relative to stock 2.4.3-ac13
   swap-speedup-B3 is a 28% speedup relative to stock 2.4.3-ac13

and the amount of CPU time spent in the kernel has been reduced
significantly as well.

I believe all the correctness and SMP-locking issues have been taken care
of in -B3 as well.

	Ingo

