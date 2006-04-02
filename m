Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWDBKdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWDBKdC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 06:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWDBKdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 06:33:02 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17851 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932253AbWDBKdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 06:33:00 -0400
Date: Sun, 2 Apr 2006 12:32:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header infrastructure
Message-ID: <20060402103223.GD13503@elf.ucw.cz>
References: <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <1143376351.3064.9.camel@laptopd505.fenrus.org> <A6491D09-3BCF-4742-A367-DCE717898446@mac.com> <20060329222640.GA2755@ucw.cz> <20060401162213.dc68d120.rdunlap@xenotime.net> <EB70C0D0-4961-4F78-B245-69C962F8B52E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB70C0D0-4961-4F78-B245-69C962F8B52E@mac.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>__KABI_ everywhere will just make your headers totally  
> >>unreadable.  Please don't do that.
> >
> >Ack, I agree.
> 
> Let me reiterate two facts:
> 
> (1)  The various C standards state that the implementation should  
> restrict itself to symbols prefixed with "__", everything else is  
> reserved for user code (Including symbols prefixed with a single  
> underscore).
> (2)  GCC predefines a large collection of symbols, macros, and  
> functions for its own use, and this set is not constant (just look at  
> the number of new __-prefixed symbols added between GCC 3 and 4.  In  
> addition, we're not just compiling this code under GCC, but people  
> will also be using it (hopefully unmodified) under tiny-cc, intel-cc,  
> PGI, PathScale, Lahey, ARM Ltd, lcc, and possibly others.  It  
> probably does not need to be stated that for something as userspace- 
> sensitive as the KABI headers we should not risk colliding with  
> predefined builtins in any of those compilers.
> 
> So my question to the list is this:
> Can you come up with any way other than using a "__kabi_" prefix to  
> reasonably avoid namespace collisions with that large list of  
> compilers?  If you have some way, I'd be interested to hear it, but  
> as a number of those compilers are commercial I'd have no way to test  
> on them (and I suspect most people on this list would not either).

No, you should just not care about anything but
gcc. intel-cc-version-0.3.2.1.2.5 could use __kabi_struct_dirent or
whatever, and collide anyway. By adding __kabi you just make it less
likely.

I believe __ is enough. If there's one conflict with some obscure
compiler, we can simply fix the conflict (or even fix the compiler
:-).

If you feel __ is too dangerous, you may go __k ... It will not look
as ugly as __kabi_ , and should be very safe.
								Pavel

-- 
Picture of sleeping (Linux) penguin wanted...
