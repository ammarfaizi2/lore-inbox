Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRCPIzb>; Fri, 16 Mar 2001 03:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRCPIzW>; Fri, 16 Mar 2001 03:55:22 -0500
Received: from www.wen-online.de ([212.223.88.39]:24845 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129346AbRCPIzC>;
	Fri, 16 Mar 2001 03:55:02 -0500
Date: Fri, 16 Mar 2001 09:54:09 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Russell King <rmk@arm.linux.org.uk>
cc: Art Boulatov <art@ksu.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root & linuxrc problem
In-Reply-To: <20010315224125.C7500@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0103160822350.1057-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Russell King wrote:

> On Thu, Mar 15, 2001 at 10:11:55PM +0100, Mike Galbraith wrote:
> > On Thu, 15 Mar 2001, Art Boulatov wrote:
> >
> > > How can I "exec /sbin/init" from "/linuxrc", whatever it is,
> > > if "linuxrc" does not get PID=1?
> > >
> > > Actually, why does NOT "linuxrc" get PID=1?
> >
> > That's the question.. the first task started gets pid=1, and when
> > that is true, exec /sbin/init has no problem.  What else is your
> > system starting?.. it must be starting something.
>
> Linux always forks from PID1 before executing /linuxrc automagically.
> Check init/main.c.

Aha.. so that's it.  I've never been able to get /linuxrc to execute
automagically.  I wonder why /linuxrc executes on Art's system, but
not on mine.  I can call it whatever I want and it doesn't run unless
I explicitly start it with init=whatever.

If it does execute though, that explains init complaining.. pid is
going to be whatever comes after the last thread started (would be
8 here).  It looks like you're only supposed to do setup things in
magic filename /linuxrc and not exec /sbin/init from there.

In any case, it looks like renaming linuxrc to whatever.sh and booting
with init=/whatever.sh instead will likely make init happy.

	-Mike

