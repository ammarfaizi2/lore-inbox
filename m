Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271569AbRIBDvd>; Sat, 1 Sep 2001 23:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271572AbRIBDvW>; Sat, 1 Sep 2001 23:51:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57354 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271569AbRIBDvJ>; Sat, 1 Sep 2001 23:51:09 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sat, 1 Sep 2001 20:48:12 -0700
Message-Id: <200109020348.f823mCs01183@penguin.transmeta.com>
To: andy@spylog.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre3 - bug report
Newsgroups: linux.dev.kernel
In-Reply-To: <20010902053338.A26119@spylog.ru>
In-Reply-To: <Pine.LNX.4.33.0109011212380.922-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010902053338.A26119@spylog.ru> you write:
>
>		run
>		test:/spylog/test/tiobench-0.3.1 # ./tiobench.pl 
>		No size specified, using 1792 MB
>	
>    syslog level "kern.*":
>	
>ep  2 05:20:18 test kernel: Inspecting /boot/System.map
>Sep  2 05:20:18 test kernel: Loaded 12509 symbols from /boot/System.map.
>Sep  2 05:20:18 test kernel: Symbols match kernel version 2.4.10.
>Sep  2 05:20:18 test kernel: No module symbols loaded - kernel modules not enabled. 
>Sep  2 05:24:52 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
>Sep  2 05:24:54 test last message repeated 77 times
>Sep  2 05:24:54 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).

These are bounce buffer allocations - they do fail, but the failures
should be temporary and the machine should make progress. 

There are some nasty issues with HIGHMEM that will be seriously improved
during 2.5.x when we start doing IO directly from highmem for
controllers that can handle it, but that 2.4.x is not likely to really
fix.  So you should expect to see messages like the above that are about
"we couldn't allocate memory for bounce buffers", and they _will_ imply
that performance isn't going to be as good as it possibly should be, but
at the same time it shouldn't be a real problem either.

Does the machine stay up and perform reasonably well?

(Where "reasonable" doesn't necessarily mean "really well", but means
"it's not absolutely horrible").

		Linus
