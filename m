Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSLIPdf>; Mon, 9 Dec 2002 10:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265649AbSLIPdf>; Mon, 9 Dec 2002 10:33:35 -0500
Received: from trillium-hollow.org ([209.180.166.89]:650 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S265643AbSLIPde>; Mon, 9 Dec 2002 10:33:34 -0500
To: Mike Hayward <hayward@loup.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance 
In-Reply-To: Your message of "Mon, 09 Dec 2002 01:30:28 MST."
             <200212090830.gB98USW05593@flux.loup.net> 
Date: Mon, 09 Dec 2002 07:40:22 -0800
From: erich@uruk.org
Message-Id: <E18LQ18-0004Xu-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike Hayward <hayward@loup.net> wrote:

> I have been benchmarking Pentium 4 boxes against my Pentium III laptop
> with the exact same kernel and executables as well as custom compiled
> kernels.  The Pentium III has a much lower clock rate and I have
> noticed that system call performance (and hence io performance) is up
> to an order of magnitude higher on my Pentium III laptop.  1k block IO
> reads/writes are anemic on the Pentium 4, for example, so I'm trying
> to figure out why and thought someone might have an idea.
> 
> Notice below that the System Call overhead is much higher on the
> Pentium 4 even though the cpu runs more than twice the speed and the
> system has DDRAM, a 400 Mhz FSB, etc.  I even get pretty remarkable
> syscall/io performance on my Pentium III laptop vs. an otherwise idle
> dual Xeon.
> 
> See how the performance is nearly opposite of what one would expect:
...
> M-Pentium III 850Mhz Sys Call Rate   433741.8
>   Pentium 4     2Ghz Sys Call Rate   233637.8
>   Xeon x 2    2.4Ghz Sys Call Rate   207684.2
...[other benchmark deleted]...
> Any ideas?  Not sure I want to upgrade to the P7 architecture if this
> is right, since for me system calls are probably more important than
> raw cpu computational power.

You're assuming that ALL operations in a P4 are linearly faster than
a P-III.  This is definitely not the case.

A P4 has a much longer pipeline (for a many cases, considerably
longer than the diagrams imply) than the P-III, and in particular
it has a much longer latency in handling mode transitions.

The results you got don't surprise me whatsoever.  In fact the raw
system call transition instructions are likely 5x slower on the
P4.

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
