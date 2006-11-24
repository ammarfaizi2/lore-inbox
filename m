Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934619AbWKXOGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934619AbWKXOGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 09:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934621AbWKXOGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 09:06:00 -0500
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:412 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S934619AbWKXOF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 09:05:59 -0500
Message-ID: <4566FC45.5020602@comcast.net>
Date: Fri, 24 Nov 2006 09:05:57 -0500
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: "Martin A. Fink" <fink@mpe.mpg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA Performance with Intel ICH6
References: <200611241407.01210.fink@mpe.mpg.de>
In-Reply-To: <200611241407.01210.fink@mpe.mpg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin A. Fink wrote:
> Dear all,
>
> I found out, that writing to a SATA harddisk costs around 20% of the
> computers cpu time. I write blocks of 1MB size to a file. Write performance
> is around 51MB/s what I think is really good. My computer has an Intel ICH6
> chipset and a 3.2GHz Pentium 4 processor.
> If I understand the design of this chipset correctly, then I would have
> expected, that the CPU needs to do only few work, instead I found out, that
> writing to disk seems to be really hard work for the CPU.
>
> Can I do anything to optimize writing from memory to disk?
>
> My final aim is to get around 140MB/s of data from 3 different Gigabit
> Ethernet cards and store it on 3 harddisk drives that perform 50MB/s.
> >From the SATA bus side there should be no problem. Each of the 4 SATAs on
> this ICH6 chipset are capable of 150MB/s.
>
> So what makes my CPU that slow? Is it a hardware problem or a problem of
> SATA driver of my operating system?
>
> time dd if=/dev/zero of=test.zero bs=1M count=1000
> results in
>
> real 0m52.561s
> user 0m0.003s
> sys  0m7.407s
>
> and strace dd... gives among other information
> 6.84s 1004calls syscall: write
>
> So I spend 45s of 52s within the kernel. Why so long?
>   
forgetting the fact that you're only writing 0's and that makes me 
wonder if the filesystems are cheating because the data it's writing is 
all the same, you aren't syncing that data.  You're not benchmarking the 
actual write speed, you have buffer being used still with uncommitted data.

try using iozone or something a little more stressful on the system.  


If you rerun the "benchmark" and your scores are much better (like with 
your example the second run gets 260MB/sec for me) then it's not a good 
benchmark.   It should be consistantly the same no matter how many times 
you run it.


> By the way: I'm working with SuSE Linux 9.2 on a Dell Desktop PC, 1GB RAM
>
> Thank you for answers,
>
> Martin
>   
