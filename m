Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261687AbREOXCI>; Tue, 15 May 2001 19:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261691AbREOXB6>; Tue, 15 May 2001 19:01:58 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:22626 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S261687AbREOXBo>; Tue, 15 May 2001 19:01:44 -0400
Date: Tue, 15 May 2001 19:01:24 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: David Wilson <davew@sai.co.za>
cc: linux-kernel@vger.kernel.org
Subject: Re: FW: I think I've found a serious bug in AMD Athlon page_alloc.c
 routines, where do I mail the developer(s) ?
In-Reply-To: <NEBBJFIIGKGLPEBIJACLEEHDDMAA.davew@sai.co.za>
Message-ID: <Pine.LNX.4.10.10105151853040.15328-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think I've found a serious bug in AMD Athlon page_alloc.c routines in

there's nothing athlon-specific there.

> correct on the DFI AK75-EC motherboard, if I set the CPU kernel type to 586
> everything is 100%, if I use "Athlon" kernel type I get:
> kernel BUG at page_alloc.c:73

when you select athlon at compile time, you're mainly 
getting Arjan's athlon-specific page-clear and -copy functions
(along with some relatively trivial alignment changes).
these functions are ~3x as fast as the generic ones,
and seem to cause dram/cpu-related oopes on some machines.

in short: faster code pushes the hardware past stability.
there's no reason, so far, to think that there's anything 
wrong with the code - Alan had a possible issue with prefetching
and very old Atlons, but the people reporting problems like this
are actually running kt133a and new fsb133 Athlons.

> I've changed RAM, Motherboard etc... still the same.

changed to a non-kt133a board?  how about running fsb and/or dram
at 100, rather than 133?

> Also the same system runs linux-2.2.16 100%

2.2 doesn't have the fast page-clear and -copy code afaik.

afaik, there are *no* problems on kt133 machines,
and haven't heard any pain from people who might have 
Ali Magic1, AMD 760 or KT266 boards, but they're still rare.

