Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319599AbSH2XSM>; Thu, 29 Aug 2002 19:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319602AbSH2XSM>; Thu, 29 Aug 2002 19:18:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:26122 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S319599AbSH2XSJ>; Thu, 29 Aug 2002 19:18:09 -0400
Date: Fri, 30 Aug 2002 01:22:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, Luca Barbieri <ldb@ldb.ods.org>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
Message-ID: <20020829232233.GA18573@atrey.karlin.mff.cuni.cz>
References: <1030506106.1489.27.camel@ldb> <20020828121129.A35@toy.ucw.cz> <1030663192.1326.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030663192.1326.20.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > Unfortunately with this patch executing invalid code will cause the
> > > processor to enter an infinite exception loop rather than panic. Fixing
> > > this is not trivial for SMP+preempt so it's not done at the moment.
> > 
> > Using 0xcc for everything should fix that, right?
> 
> Except you can't do the fixup on SMP without risking hitting the CPU
> errata. You also break debugging tools that map kernel code pages r/o
> and people who ROM it.
> 
> The latter aren't a big problem (they can compile without runtime
> fixups). For the other fixups though you -have- to do them before you
> run the code. That isnt hard (eg sparc btfixup). You generate a list of
> the addresses in a segment, patch them all and let the init freeup blow 
> the table away

Aha, making a list and just patching early at boot is even simpler
than method I was thinking about.... Why not do it that way?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
