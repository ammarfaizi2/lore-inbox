Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130434AbRCCJcY>; Sat, 3 Mar 2001 04:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130435AbRCCJcF>; Sat, 3 Mar 2001 04:32:05 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:58629 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130434AbRCCJcA>;
	Sat, 3 Mar 2001 04:32:00 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103030931.f239Vvo124697@saturn.cs.uml.edu>
Subject: Re: RFC: changing precision control setting in initial FPU context
To: buhr@stat.wisc.edu (Kevin Buhr)
Date: Sat, 3 Mar 2001 04:31:57 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, adam@yggdrasil.com, drepper@cygnus.com
In-Reply-To: <vbaelwfwcky.fsf@mozart.stat.wisc.edu> from "Kevin Buhr" at Mar 03, 2001 01:12:13 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Buhr writes:

> It boils down to the fact that, under i386 Linux, the FPU control word
> has its precision control (PC) set to 3 (for 80-bit extended
> precision) while under i386 FreeBSD, NetBSD, and others, it's set to 2
> (for 64-bit double precision).  On other architectures, I assume
> there's usually no mismatch between the C "double" precision and the
> FPU's default internal precision.
...
> Initially, I was quick to dismiss the whole thing as symptomatic of a
> severe floating-point-related cluon shortage.  However, the more I
> think about it, the better the case seems for changing the Linux
> default:
> 
> 1.  First, PC=3 is a dangerous setting.  A floating point program
>     using "double"s, compiled with GCC without attention to
>     FPU-related compilation options, won't do IEEE arithmetic running
>     under this setting.  Instead, it will use a mixture of 80-bit and
>     64-bit IEEE arithmetic depending rather unpredictably on compiler
>     register allocations and optimizations.
> 
> 2.  Second, PC=3 is a mostly *useless* setting for GCC-compiled
>     programs.  There can obviously be no way to guarantee reliable
>     IEEE 80-bit arithmetic in GCC-compiled code when "double"s are
>     only 64 bits, so our only hope is to guarantee reliable IEEE
>     64-bit arithmetic.  But, then we should have set PC=2 in the first
>     place.

So you change it to 2... but what about the "float" type? It gets
a mixture of 64-bit and 32-bit IEEE arithmetic depending rather
unpredictably on compiler register allocations and optimizations???

If a "float" will have excess precision, then a "double" might
as well have it too. Usually it helps, but sometimes it hurts.
This is life with C on x86.

> So, on a related note, is it reasonable to consider resurrecting the
> "sys_setfpucw" idea at this point, to push the decision on the correct
> initial control word up to the C library level where it belongs?  (For
> those who don't remember the proposal, the idea is that the C library
> can use "sys_setfpucw" to set the desired initial control word.

Ugh, more start-up crud.
