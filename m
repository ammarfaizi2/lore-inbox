Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSIJKO1>; Tue, 10 Sep 2002 06:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSIJKO1>; Tue, 10 Sep 2002 06:14:27 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:18188 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317366AbSIJKO0>; Tue, 10 Sep 2002 06:14:26 -0400
Date: Tue, 10 Sep 2002 12:17:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Question about pseudo filesystems
In-Reply-To: <E17oh7j-00079w-00@starship>
Message-ID: <Pine.LNX.4.44.0209101201280.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 10 Sep 2002, Daniel Phillips wrote:

> There's a simple solution though: examine the module->count under the same
> spinlock as try_inc_mod_count, which is what sys_delete_module does.  We just
> encapsulate that check in a handy wrapper and define it as part of the
> try_inc_mod_count interface.  At this point the thing is generalized to the
> point where the module count isn't used at all by module.c, so the same
> interface will also accomodate the still-under-construction magic wait for
> quiescent state(), needed for modules that don't fit the mod_count model.

I implemented something like this some time ago. If module->count isn't
used by module.c anymore, why should it be in the module structure?
Consequently I removed it from the module struct (what breaks of course
unloading of all modules, so I'll probably reintroduce it with big a
warning). If the count isn't in the module structure, the locking will
become quite simpler. More info is here
http://marc.theaimsgroup.com/?l=linux-kernel&m=102754132716703&w=2

bye, Roman

