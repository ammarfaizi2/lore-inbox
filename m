Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUHVMig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUHVMig (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 08:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUHVMig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 08:38:36 -0400
Received: from the-village.bc.nu ([81.2.110.252]:45198 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266741AbUHVMic convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 08:38:32 -0400
Subject: Re: DTrace-like analysis possible with future Linux kernels?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Julien Oster <usenet-20040502@usenet.frodoid.org>,
       Miles Lane <miles.lane@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
	 <87hdqyogp4.fsf@killer.ninja.frodoid.org>
	 <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1093174557.24319.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 12:35:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-21 at 07:03, Tomasz Kłoczko wrote:
> Again: DTrace is *ALSO* admininstration tool and this is why I can't
> understand why in IBM KProbe/DProbe patch it is marked as "depends on
> DEBUG_KERNEL" which is IMO bigest mistake on thinking level about this :>

Because its a debugging feature

> In Solaris DTrace is enabled in _normal production_ kernel and you can 
> hang any probe or probes set without restarting system or any runed
> application which was compiled withoud debug info.

Solaris only runs on large computers. You don't want kprobes randomly on
your phone, pda, wireless router. Solaris deals with an extremely narrow
market segment of "big computers for people with lots of money".

> [1] Remember: if you want profile some part of code you mast _first_
> (re)compile them with profiling enabled. If you wand debug some code

OProfile doesn't require this. 

> Some enterprise systems have limited summary time to few hours per year 
> and restart cycle can take houre or more (checking and initialize hardware
> components). If you will try say for admin this kind system "restat your

Enterprise users generally get kernels from vendors who have done the
analysis of needs for them (and hopefully got it right). They generally
don't ftp 2.6.8.1 type make config and try it out.

> For bring few levels up kernel *development* speed on finding some bugs 
> source and measure some consequences adding/modifing some part of code
> it will be good have two very well prepared on Solaris things:
> - crash dumps,
> - DTrace.

We have crash dumps - at least all the enterprise vendors do. Linus
doesn't seem to like that stuff so much.

> When you see some strange behavior without system destabization 
> current/cassic Linux kernel development look now like:
> 1) if you have good kernel knowledge you can imagine which part of them
>     is source of same observed strange behavior,
> 2) after looking on kernel source you can cut of area to part where bug
>     exist,
> 3) after few recompilations you can say in which area bug exist and after
>     few other iteration stage 3) you can say what maust be fixed.

Actually I generally
-	Glance across the load meters
-	Ask ps where everything is waiting
-	Potentially turn on oprofile
-	Potentially use netfilter to see who is causing all my traffic
-	Maybe strace a few apps to see what is up
-	Educate the user concerned (if needed)

I've already got the symbols (and they are in the debuginfo package from
the rpm build too). I could insmod kgdb but that level of
debugging is generally inappropriate. 

DTrace value is ease of use value.

> http://blogs.sun.com/roller/page/bmc/20040820#dtrace_on_lkml
> Bryan blog is also yet another Dtrace knowledge source ..

Coo I thought only the Sun CEO spent his life making inappropriate
comments 8)

