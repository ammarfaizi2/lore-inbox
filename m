Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSJTJV2>; Sun, 20 Oct 2002 05:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbSJTJV2>; Sun, 20 Oct 2002 05:21:28 -0400
Received: from ns.suse.de ([213.95.15.193]:56328 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263143AbSJTJV1>;
	Sun, 20 Oct 2002 05:21:27 -0400
Date: Sun, 20 Oct 2002 11:27:30 +0200
From: Andi Kleen <ak@suse.de>
To: Elladan <elladan@eskimo.com>
Cc: Andi Kleen <ak@muc.de>, Andrea Arcangeli <andrea@suse.de>,
       Jeff Dike <jdike@karaya.com>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, discuss@x86-64.org, aj@suse.de
Subject: Re: [discuss] Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021020112730.A29357@wotan.suse.de>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019040238.GA21914@averell> <20021019041659.GK23930@dualathlon.random> <20021020025914.GB15342@averell> <20021020064433.GA32594@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020064433.GA32594@eskimo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 11:44:33PM -0700, Elladan wrote:
> The problem with modifying the executable code/pages in the vsyscall
> area is that it's going to be very tricky to implement, if I understand
> this discussion properly.

Modifying the pages or variables in the pages from the kernel is no
problem.  It just would affect all processes on the system

What's tricky is to give it per process state (which would 
be needed to make a vsyscall/novsyscall flag process local) 
> 
> There may be any number of user processes idling in these pages on the
> runqueue (or off it if say one received a SIGSTOP), and if you just go
> change the instruction code on them, unless you're incredibly careful
> and come up with some subtly safe machine code sequence, they're going
> crash when you call this sysctl().

Nobody proposed to use self modifying code, it would just be a global
variable located in the vsyscall area that is tested by the vsyscall
code.

-Andi
