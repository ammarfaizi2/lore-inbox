Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWAALJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWAALJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 06:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWAALJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 06:09:43 -0500
Received: from mail.gmx.de ([213.165.64.21]:10929 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750734AbWAALJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 06:09:42 -0500
X-Authenticated: #1226656
Date: Sun, 1 Jan 2006 12:13:03 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Howto set kernel makefile to use particular gcc
Message-ID: <20060101121303.488e634b@vaio.gigerstyle.ch>
In-Reply-To: <dp89d4$u0i$1@sea.gmane.org>
References: <3AEC1E10243A314391FE9C01CD65429B2239C2@mail.esn.co.in>
	<200512301624.24229.chriswhite@gentoo.org>
	<dp89d4$u0i$1@sea.gmane.org>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Jan 2006 19:03:15 +0900
Kalin KOZHUHAROV <kalin@thinrope.net> wrote:

> Chris White wrote:
> > On Friday 30 December 2005 16:04, Mukund JB. wrote:
> > 
> >>Dear Alessandro,
> >>
> >>Thanks for the reply.
> >>What does that the make CC=<path_to_your_gcc_3.3> do?
> >>Will it set my gcc default build configuration to gcc 3.3?
> > 
> > 
> > Not Alessandro but,
> > 
> > CC sets the CC makefile variable.  When the kernel build system goes
> > to  compile something, it doesn't call on gcc directly, but rather
> > what the  variable CC is set to.  By setting it to your gcc 3.3
> > compiler, it will use  that instead.
> > 
> > 
> >>I mean the general procedure is make bzImage; make modules....
> >>How do I do these:
> >>
> >>Will I have to do it like:
> >>	make bzImage cc=<gcc path>
> > 
> > 
> > make CC=<gcc path> bzImage
> > 
> > note the case sensitivity, which tends to be somewhat of a pain for
> > new *nix  users.
> 
> As I just stumbeled into a similar problem, I am going to ask here.
> 
> I know the "trick" of `make -j8 CC=distcc` and I always use it. But is
> there a way to hardwire "CC=distcc" insie the Makefile? Just setting
> it there does not help it seems.

Why would you "hardwire" it?
#export CC="distcc"
should do it.

It seems you forgot to specify the compiler:
#export CC="distcc <arch-blablabla->gcc" should be the correct way. What
I do is:

#export DISTCC_HOSTS="localhost <machine1 machine2 machineN>"
#make CC="distcc ccache gcc" -j5 bzImage modules

Marc
