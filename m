Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289339AbSAJF2h>; Thu, 10 Jan 2002 00:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289340AbSAJF21>; Thu, 10 Jan 2002 00:28:27 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:31623 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S289339AbSAJF2K>; Thu, 10 Jan 2002 00:28:10 -0500
Date: Thu, 10 Jan 2002 00:31:48 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020110003148.A6964@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a fan of the fans of low latency. :)
A version of Andrew Morton's patch is in 2.4.18pre2aa2.

A test on 2.4.18pre2aa2 that lasted 57 minutes:

Simultaneously:

Loop that allocates and writes to 85% of VM with mtest01.
Create and copy 10 330 MB files.
Start nice -19 setiathome half way through.
Listen to 9 mp3s.

This is similar to something I did on 2.4.17rc2aa2, but
I added mp3blaster and setiathome this time.

Results:
Allocated 125.5 GB of VM.
All mtest01 allocations passed.  (no OOM)
6.6 GB of file copying took place.
For the first 10-15 seconds of each mp3, there was some skipping 
from mp3blaster.  After 15 seconds, the mp3 played smoothly.
Adding setiathome to the load did not make mp3blaster skip more.

There is 880MB of RAM in machine and 1027 MB swap, so I
calculate each mtest01 iteration wrote about 680MB to swap.

6600 MB copy + (680 * 84) MB swapping = 63,720MB disk activity.
Divide by 57 minutes = 18.6 MB / second to the disk.


Comments:
>From 2.4.10 - 2.4.17pre I was testing just playing mp3blaster
and running an 80% VM allocation loop.  There was a lot of 
improvement during that time.  Adding I/O and CPU bound jobs
to the load makes the results above quite amazing to me.

There's a lot of magic in 2.4.18pre2aa2 that hasn't made it
into the other mainline kernels yet.

BTW: Some more changelog details on 2.4.18pre2aa2 are at
http://home.earthlink.net/~rwhron/kernel/2.4.18pre2aa2.html

System is Athlon 1333 with 1 40GB 7200 rpm IDE disk.
-- 
Randy Hron

