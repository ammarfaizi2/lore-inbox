Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317342AbSG1VZB>; Sun, 28 Jul 2002 17:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSG1VZB>; Sun, 28 Jul 2002 17:25:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18447 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317342AbSG1VZA>;
	Sun, 28 Jul 2002 17:25:00 -0400
Message-ID: <3D4463F1.F6981B0@zip.com.au>
Date: Sun, 28 Jul 2002 14:36:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: inlines in kernel/sched.c
References: <3D445F53.BDE6B754@zip.com.au> <Pine.LNX.4.44.0207282309430.5116-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Sun, 28 Jul 2002, Andrew Morton wrote:
> 
> > Ingo, could you please review the use of inlines in the
> > scheduler sometime?  They seem to be excessive.
> >
> > For example, this patch reduces the sched.d icache footprint
> > by 1.5 kilobytes.
> 
> the patch also hurts context-switch latencies - it went
> from 1.35 usecs to 1.42 usecs - a 5% drop.
> 

It will hurt with benchmarks, because with benchmarks
all of the scheuler is in L1 all the time.

This stuff's hard.  I don't know what the right answer
is, really.

To optimise for scheduler-intensive workloads we should
optimise for the all-in-cache case.  To optimise for
other workloads we should aim to reduce the cache footprint.

Perhaps.  Dunno.


-
