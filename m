Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSHJT0Y>; Sat, 10 Aug 2002 15:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317276AbSHJT0Y>; Sat, 10 Aug 2002 15:26:24 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:30661 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317269AbSHJT0X>; Sat, 10 Aug 2002 15:26:23 -0400
Date: Sat, 10 Aug 2002 20:30:04 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Dirty words on linux-kernel
Message-ID: <20020810203004.A666@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry folks, but I found this bounce from a message I sent to
linux-kernel both funny and slightly disturbing.  Note that the bounce
comes from a subscriber to linux-kernel, not the mailing list
management! (:-)

  Subject: ScanMail Message: To Sender, sensitive content found and action taken.
  From: System Attendant <WLVEXC01-SA@digitalinsight.com>

  Trend SMEX Content Filter has detected sensitive content.

  Place = Linus Torvalds; Andrew Morton; lkml;
  Sender = Jamie Lokier
  Subject = Re: [patch 6/12] hold atomic kmaps across generic_file_read
  Delivery Time = August 10, 2002 (Saturday) 10:59:18
  Policy = Dirty Words
  Action on this mail = Quarantine message

  Warning message from administrator:
  Sender, Content filter has detected a sensitive e-mail.

I wonder if anyone can spot "Dirty Words" in the text below!  (I don't
see any).  The bounce doesn't say which message; it must be one of the
two below.

enjoy,
-- Jamie

----------------- possible dirty talk #1 --------------------

Linus Torvalds wrote:
> Imagine doing a
>
>       fstat(fd..)
>       buf = aligned_malloc(st->st_size)
>       read(fd, buf, st->st_size);
>
> and having it magically populate the VM directly with the whole file
> mapping, with _one_ failed page fault. And the above is actually a fairly
> common thing. See how many people have tried to optimize using mmap vs
> read, and what they _all_ really wanted was this "populate the pages in
> one go" thing.

This will only provide the performance benefic when `aligned_malloc'
return "fresh" memory, i.e. memory that has never been written to.

Assuming most programs use plain old `malloc', which could be taught to
align nicely, then the optimisation might occur when a program starts
up, but later on it's more likely to return memory which has been
written to and previously freed.  So the performance becomes
unpredictable.

But it's a nice way to optimise if you are _deliberately_ optimising a
user space program.  First call mmap() to get some fresh pages, then
call read() to fill them.  Slower on kernels without the optimisation,
fast on kernels with it. :-)

-- Jamie

----------------- possible dirty talk #2 --------------------

Linus Torvalds wrote:
> For people like that, wouldn't it be nice to just be able to tell them: if
> you do X, we guarantee that you'll get optimal zero-copy performance for
> reading a file.

Don't forget to include the need for mmap(... MAP_ANON ...) prior to the
read.

Given the user will need to establish a new mapping anyway, why pussy
foot around with subtleties?  Just add a MAP_PREFAULT flag to mmap(),
which reads the whole file and maps it before returning.

-- Jamie
