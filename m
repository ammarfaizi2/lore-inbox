Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273028AbRIRRbB>; Tue, 18 Sep 2001 13:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273047AbRIRRan>; Tue, 18 Sep 2001 13:30:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:8458 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273028AbRIRRaW>; Tue, 18 Sep 2001 13:30:22 -0400
Date: Tue, 18 Sep 2001 13:06:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918084006.O698@athlon.random>
Message-ID: <Pine.LNX.4.21.0109181254200.7152-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

> On Tue, Sep 18, 2001 at 02:02:37AM -0300, Marcelo Tosatti wrote:
> > Try to run several memory hungry threads (thus hiding more pages).
> 
> I did that indeed, not sure why I didn't reproduced (I guess the hogs
> were sligthly different). (and of course they were killed but only after
> the box was truly oom)

Easy reproducible way: 

Boot with 64M, start 4 setiathome processes, then start mtest (from
memtest suite) with a lot of threads (I'm using 40 readers and 4 writers
in this case, and a 100MB heap)

[root@matrix memtest-0.0.4]# ./mtest -m 100 -r 40 -w 4
Starting test run with 100 megabyte heap.
Setting up 25600 4096kB pages for test...
 done.
Child 00 started with pid 00935, readonly
Child 01 started with pid 00936, readonly
Child 02 started with pid 00937, readonly
Child 03 started with pid 00938, readonly
Child 04 started with pid 00939, readonly


Sep 18 14:28:31 matrix kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c012c3be
Sep 18 14:28:31 matrix kernel: VM: killing process setiathome

