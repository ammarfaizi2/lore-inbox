Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSKISpQ>; Sat, 9 Nov 2002 13:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbSKISpQ>; Sat, 9 Nov 2002 13:45:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28434 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262446AbSKISpO>; Sat, 9 Nov 2002 13:45:14 -0500
Date: Sat, 9 Nov 2002 10:51:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
In-Reply-To: <Pine.LNX.4.44.0211091308250.10475-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0211091044060.12487-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Nov 2002, Zwane Mwaikambo wrote:
> This is all very confusing, notsc isnn't supposed to work with cpus with 
> TSCs?

No.

You have two different cases:

 - a kernel compiled for TSC-only. This one simply will not _work_ without 
   a TSC, since it is statically compiled for the TSC case. Here, "notsc"
   simply cannot do anything, so it just prints a message saying that it 
   doesn't work.

 - a "generic" kernel, which can do the TSC decision dynamically, will use 
   the TSC flag in the CPU features field to decide whether to use the TSC
   or not. Here, "notsc" will clear the flag unconditionally, so even if 
   your CPU claims to have a TSC, it won't get used.

NOTE! We used to do a lot more statically, and on the whole the hard-coded
CONFIG_X86_TSC usage has pretty much disappeared in modern kernels. It's 
used mainly by the "get_cycles()" macro, which is not all that commonly 
used any more (it used to be used by the scheduler, I think that's gone 
too these days).

		Linus

