Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSGUDbx>; Sat, 20 Jul 2002 23:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317632AbSGUDbx>; Sat, 20 Jul 2002 23:31:53 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:5133 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S317628AbSGUDbw>;
	Sat, 20 Jul 2002 23:31:52 -0400
Date: Sun, 21 Jul 2002 05:34:51 +0200
Message-Id: <200207210334.g6L3YpS12993@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dan writes:
> Alan Cox wrote:
> > > <http://www.opengroup.org/onlinepubs/007904975/functions/select.html>
> > > says that 'select' may modify its timeout argument only "upon
> > > successful completion".  However, the Linux kernel sometimes modifies
> > > the timeout argument even when 'select' fails or is interrupted.
> > 
> > This is extremely useful behaviour. POSIX is broken here. 
> 
> I tried to make use of this behavior back in 2.2 days, I think,
> and ran into trouble.  The time remaining wasn't quite right, I seem
> to recall, making this nifty feature less useful.  I've since
> given up on it.
> 
> > Fix it in the C library or somewhere it doesn't harm the clueful
> 
> Can you give an example of a clueful package that makes
> use of this feature and would be harmed if select() suddenly
> became posix-compliant?

Daemons that I've written for linux-specific tasks all 
use the select timeout in order to wait for an event for a fixed
amount of time, across possible interrupts.

That is to say, they watch the errno after return from select, and if
it was EINTR, then they reenter the select without further ado.
Since the timeout has changed to reflect the time remaining, that's
quite right.

This is typical of deamons doing tcp/ip. I guess one answer would be to
make tcp timeout more configurable.


Peter
