Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318345AbSIPA2W>; Sun, 15 Sep 2002 20:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318348AbSIPA2W>; Sun, 15 Sep 2002 20:28:22 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64779 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318345AbSIPA2V>; Sun, 15 Sep 2002 20:28:21 -0400
Date: Sun, 15 Sep 2002 20:24:59 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17psOu-0008AW-00@starship>
Message-ID: <Pine.LNX.3.96.1020915202137.1893A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Daniel Phillips wrote:


> > What DoS opportunities are there?
> 
> Suppose the module exit relies on synchronize_kernel.  The attacker
> can force repeated synchronize_kernels, knowing that module.c will
> mindlessly do a synchronize_kernel every time a module init fails,
> whether needed or not.  Each synchronize_kernel takes an unbounded
> amount of time to complete, across which module.c holds a lock.

That's a good argument WRT the kernel autoloader, but not for manual load
by root. The system should not refuse to attempt an operation about which
root may have additional information (odd hardware or the like). We don't
want to have the kernel DOS itself, but root should be allowed to at least
try.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

