Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSEVBRe>; Tue, 21 May 2002 21:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSEVBRd>; Tue, 21 May 2002 21:17:33 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:7305 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S316821AbSEVBRc>; Tue, 21 May 2002 21:17:32 -0400
Message-Id: <5.1.0.14.2.20020522110621.03098bf8@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 22 May 2002 11:18:13 +1000
To: Andrea Arcangeli <andrea@suse.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: O_DIRECT on 2.4.19pre8aa2 md device
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020521155115.GK21806@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:51 PM 21/05/2002 +0200, Andrea Arcangeli wrote:
...
>In any real usage where I/O is combined with CPU and mem bus utilization
>for computations, not only to move data from disk to userspace memory
>O_DIRECT is an _huge_ win as you found out. You have 100000 more usable
>ticks for computations over 150000 total ticks.
...

no disagreement there.

however, there is still an enormous difference between 
access-/dev/sdX-via-block-layer and access-dev/sdX-via-mmap (127mbyte/sec 
versus 175+mbyte/sec) that for many "disk intensive" applications is a huge 
difference.

if we _could_ produce superior performance with something like:
  (a) additional improvements to O_DIRECT (say, a mmap() hack for O_DIRECT)
      whereby i/o can go direct-to-userspace or 
userspace-can-mmap(readonly)-into-
      kernel-space
or
  (b) O_DIRECT with async-i/o
or
  (c) /dev/rawN-like interface (eg. /dev/directN) within a fixed disk 
buffer in kernel
      (eg. physical memory allocated at bootup) that is populated readonly into
      user-space)
would such a hack be accepted in the 2.5 tree?

it sure isn't your "average desktop" setup where you hit these things as 
performance limitations, but many folk (myself included) have very specific 
applications which are essentially bottlenecked on PC hardware 
limitations.  these limitations are a side-effect of how the linux kernel 
works.
that doesn't mean that other OSes don't suffer from the same thing -- since 
no-other mainstream OS does the right thing, that doesn't mean that we 
cannot make linux even better.

obviously, many of the above would only be suitable for disk-read 
operations and less-so for disk-write -- but its probably easier to tackle 
these one by one.


cheers,

lincoln.

