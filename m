Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbTIGSMH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTIGSMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:12:07 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:51179 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261252AbTIGSL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:11:58 -0400
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, bunk@fs.tum.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       robert@schwebel.de, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20030907174341.GA21260@mail.jlokier.co.uk>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se>
	 <20030907174341.GA21260@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 07 Sep 2003 19:09:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-07 at 18:43, Jamie Lokier wrote:
> 	2. The CPU types are not a total order.  Say I want a kernel
> 	   that supports Athlons and a Centaur for my cluster.  What
> 	   CPU setting should I use?  What CPU setting will give my the best
> 	   performing kernel - and is that the same as the one for smallest
> 	   kernel?

You'd use two kernels. There is no sane other answer to that specific
case 8)

> 	   But I don't want to compile in support for every x86,
> 	   because space is tight, and I want it to run as fast as it
> 	   can given that it could run on either of the two chips.

The code size differential is noise except for FPU emulation, and thats
in part sloppy because we could have __fpuseg and eject it at boot if
not needed ;)

386 kernels are slow because of user space handling and lack of bswap
486 kernels basically work on anything just fine

> I'm not sure if an Athlon is "lower" than a PII or not....  Which do I
> option do I pick, to run on either of those without including
> redundant stuff for older CPUs?

Right now its ordered

386 - 486 - 586 - 586+TSC - 686 - PPro - PII - PIII - PIV

Geode is a branch off 586+TSC and supports 686+ too
Athlon branches off from PIII if I remember rightly
Winchip branches off from 586 and supports all later x86 too
ELAN is its own weird world
Xmeta comes off 686 somewhere depending how you handle PGE

