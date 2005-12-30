Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVL3Ja2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVL3Ja2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 04:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVL3Ja1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 04:30:27 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:1548 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751231AbVL3Ja1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 04:30:27 -0500
Date: Fri, 30 Dec 2005 10:28:00 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230092800.GB30681@w.ods.org>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229231615.GV15993@alpha.home.local> <9a8748490512300033occeec40xab3b4f49624c08c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490512300033occeec40xab3b4f49624c08c5@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 09:33:14AM +0100, Jesper Juhl wrote:
> On 12/30/05, Willy Tarreau <willy@w.ods.org> wrote:
> <!-- snip -->
> >
> > Can't we elect a recommended gcc version that distro makers could
> > ship under the name kgcc as it has been the case for some time,
> > and try to stick to that version for as long as possible ? The only
> > real reason to upgrade it would be to support newer archs, while at
> > the moment, we try to support compilers which are shipped as default
> > *user-space* compilers.
> >
> As I see it, doing that would
>  - put extra work on distributors.

In the short term, yes. In the mid-term, I don't think so. Having one package
which does not need to change and another one which evolves regardless of
kernel needs is less work than ensuring that a single package is still
compatible with everyone's needs. Think about support too : "what gcc version
did you use ?" would simply become "did you build with kgcc ?"

>  - bloat users systems with the need to have two gcc versions installed.

$ size /usr/lib/gcc-lib/i586-pc-linux-gnu/3.3.6/cc1
   text    data     bss     dec     hex filename
3430228    2680  746688 4179596  3fc68c /usr/lib/gcc-lib/i586-pc-linux-gnu/3.3.6/cc1

You don't even need libgcc nor c++ to build the kernel. Anyway, it should
not be an absolute requirement, but the *recommended* and *supported* version.

>  - decrease testing with different gcc versions, which sometimes uncover bugs.

gcc testing should not consume kernel developpers' time, but gcc's users.
How many kernel bugs have finally been attributed to a recent change in gcc ?
A lot I think. Uncovering bugs in gcc is useful but not the primary goal of
kernel developpers.

> Jesper Juhl <jesper.juhl@gmail.com>

Willy

