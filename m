Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319676AbSIMPJU>; Fri, 13 Sep 2002 11:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319677AbSIMPJU>; Fri, 13 Sep 2002 11:09:20 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:49169 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S319676AbSIMPJS>; Fri, 13 Sep 2002 11:09:18 -0400
Date: Fri, 13 Sep 2002 17:13:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17pqsx-00089B-00@starship>
Message-ID: <Pine.LNX.4.44.0209131705040.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Daniel Phillips wrote:

> > The exit function should always be called after the init function (even if
> > it failed, I don't do it in the patch, that's a bug). The fs init/exit
> > would like this then:
>
> Perhaps, but if so, the module itself should call the exit function in
> its failure path itself.  Doing the full exit whether it needs to be
> done or not is wasteful and opens up new DoS opportunities.

The exit itself can fail as well, so it has to be done by the module code
anyway (until it suceeds).
What DoS opportunities are there? Module init failure is the exception
case and usally needs further attention, so we could actually disable
further attempts to load this module, unless the user tells us
specifically so.

> In the example you give below you must rely on register_filesystem
> tolerating unregistering a nonexistent filesystem.  That's sloppy at
> best, and you will have to ensure *every* helper used by ->exit is
> similarly sloppy.

Why is that sloppy? E.g. kfree() happily accepts NULL pointers as well.

bye, Roman

