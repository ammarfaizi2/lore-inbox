Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSLBALR>; Sun, 1 Dec 2002 19:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSLBALQ>; Sun, 1 Dec 2002 19:11:16 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:46276 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S262876AbSLBALP>;
	Sun, 1 Dec 2002 19:11:15 -0500
Message-ID: <1038788321.3deaa6e126a0c@kolivas.net>
Date: Mon,  2 Dec 2002 11:18:41 +1100
From: Con Kolivas <conman@kolivas.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] 2.4.20-rmap15a
References: <Pine.LNX.4.44L.0212011921420.15981-200000@imladris.surriel.com> <200212012236.17431.m.c.p@wolk-project.de>
In-Reply-To: <200212012236.17431.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc-Christian Petersen <m.c.p@wolk-project.de>:

> On Sunday 01 December 2002 22:25, you wrote:
> 
> Hi Rik,
> 
> > That was my gut feeling as well, but I guess it's a good thing
> > to quantify how much of a difference it makes.  I wonder if we
> > could convince Con to test a kernel both with and without this
> > patch and look at the difference.
> yep, would be a good idea. Con: *wake up ;)*
> 
> > > So, here my patch proposal. Ontop of 2.4.20-rmap15a.
> > Looks good, now lets test it.  If the patch is as needed as you
> > say we should push it to marcelo ;)
> yep, Andrew should do it. Anyway, all those patches do _not_ get rid of those
> 
> I/O pauses/stops since 2.4.19-pre6. Andrea did a good approach with his 
> lowlatency elevator, even if it drops throughput (needs more testing to 
> become equivalent to throughput w/o it) and also Con and me did a Mini 
> Lowlatency Elevator + Config option, so you can decide weather you are 
> building for serverusage where interactive "desktop performance" is not 
> needed ;) or not.

Ok here are the contest results on the SMP machine with the read latency 2 patch
(rl2) and my 3 line disk latency hack (dlh) which almost disables the elevator
on vanilla 2.4.20:

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              162.3   45      28      19      4.48
2.4.20 [5]              164.9   45      31      21      4.55
2.4.20-dlh [3]          47.3    157     0       1       1.31
2.4.20-rl2 [3]          101.8   76      19      22      2.81

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              62.3    117     11      20      1.72
2.4.20 [5]              89.6    86      17      21      2.47
2.4.20-dlh [3]          45.0    159     0       1       1.24
2.4.20-rl2 [3]          51.8    142     10      21      1.43

Note no mention of throughput here - but implied drop off with dlh! My guess is
the drop in throughput with dlh is much worse during kernel compilation than
when the machine is idle. Nonetheless the dlh hack makes a significant
improvement in responsivenss under IO load on a desktop.

Con
