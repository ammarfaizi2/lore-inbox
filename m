Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315412AbSFEM5q>; Wed, 5 Jun 2002 08:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSFEM5p>; Wed, 5 Jun 2002 08:57:45 -0400
Received: from dsl-213-023-039-098.arcor-ip.net ([213.23.39.98]:16831 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315412AbSFEM5p>;
	Wed, 5 Jun 2002 08:57:45 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 14:56:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: J Sloan <joe@tmsusa.com>, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206041418460.2614-100000@waste.org> <E17FS6T-0001UR-00@starship> <3CFDF2CE.3070307@loewe-komp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E17FaLM-0001Xl-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 13:15, Peter Wächtler wrote:
> > Improving the average latency of systems is a worthy goal, and there's
> > no denying that 'sorta realtime' has its place, however it's no substitute
> > for the real thing.  A soft realtime system screws up only on occasion,
> > but - bugs excepted - a hard realtime system *never* does.
> 
> Yes, in theory. You define hard realtime system in a clean room.
> Even QNX4 couldn't provide hard realtime when creating new processes.
> You had to start them beforehand - so you needed good system design.

With Adeos, you'd make the non-realtime OS do all the hard work of
starting the process, such as allocating the memory and locking it down,
then (one of) the realtime OS(es) just inserts the process into its
queue.  Once in the queue, the new process can exhibit realtime behavior,
but until that time there are no deadline guarantees and the realtime
application should not rely on any.  In other words, forking a realtime
process to handle an event in real time is a poor idea.

Similarly, loading a realtime driver to control some device that just
came online is not in general going to be a realtime process, but we
don't really care.  A machine starts when it starts (think about your
car in the winter) but once running, we expect it to keep running
without a hiccup.

> The OS is just a small part of that.
> 
> Even vxworks had problems with priority inversion ... and so on.

Here, the Adeos pipeline design exhibits a really nice property: you
can stack realtime OSes one on top of one another, so you could for
example, have one RTOS entirely optimized for microsecond-scale events,
another for millisecond-scale events, and a third for events with
timings measured in seconds.  Each has a completely independent set of
locks.  Alternatively, a slower-scale process can be forbidden from
acquiring a lock of a faster-scale process, but the reverse can be
permitted.

-- 
Daniel
