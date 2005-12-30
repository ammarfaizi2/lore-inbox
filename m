Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVL3JWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVL3JWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 04:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVL3JWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 04:22:24 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751225AbVL3JWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 04:22:23 -0500
Date: Fri, 30 Dec 2005 10:20:15 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230092015.GA30681@w.ods.org>
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229231615.GV15993@alpha.home.local> <1135929917.2941.0.camel@laptopd505.fenrus.org> <20051230081536.GA30503@alpha.home.local> <1135931072.2941.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135931072.2941.9.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 09:24:32AM +0100, Arjan van de Ven wrote:
> On Fri, 2005-12-30 at 09:15 +0100, Willy Tarreau wrote:
> > 
> > 
> > I trust your experience on this, but wasn't the lack of testing
> > primarily due to the use of a "special" version of the compiler ?
> > For instance, if we put a short howto in Documentation/ explaining
> > how to build a kgcc toolchain describing what versions to use, there
> > are chances that most LKML users will use the exact same version.
> > Distro maintainers may want to follow the same version too. Also,
> > the fact that the kernel would be designed to work with *that*
> > compiler will limit the maintenance trouble you certainly have
> > encountered trying to keep the compiler up-to-date with more recent
> > kernel patches and updates.
> 
> it's not that easy. Simply put: the gcc people release an update every 6
> months; distros "jump ahead" the bugfixes on that usually. (think of it
> like -stable, where distros would ship patches accepted for -stable but
> before -stable got released). Taking an older compiler from gcc.gnu.org
> doesn't mean it's bug free. It just means you're not getting bugfixes.

OK, but precisely, we don't have any bug free version of gcc anyway. The
kernel has a long history of workaround for gcc bugs. So probably there
will be less work with a -possibly buggy- old gcc version than with a
constantly changing one. For instance, if we stick to 3.4 for 2 years,
we will of course encounter a lot of bugs. But they will be worked around
just like gcc-2.95 bugs have been, and we will be able to keep the same
compiler very long at virtually zero maintenance work.

A few years ago, I had to work on a mainframe system with gcc 1.37.
Yes, 1.37 !!! It was very limited, but I could adapt my code to it
without thinking about what would happen when they update it precisely
because it was not meant to evolve at all. It had been shipped like
this with the OS for 5 years and that was OK. With stable tools like
this, any bug becomes a feature because you don't risk someone fixing
it and breaking your workaround.

While it would be a real problem for user-space tools, I think it
is compatible with kernel needs. The kernel already has strict
requirements to be built and does not need the same level of
portability as pdksh or openssh for instance.

Willy

