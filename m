Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265783AbSKFQCu>; Wed, 6 Nov 2002 11:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265784AbSKFQCu>; Wed, 6 Nov 2002 11:02:50 -0500
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:43272 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S265783AbSKFQCt>;
	Wed, 6 Nov 2002 11:02:49 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
References: <200211061503.gA6F3DW02053@localhost.localdomain>
	<1036597115.10238.40.camel@irongate.swansea.linux.org.uk>
From: Christer Weinigel <christer@weinigel.se>
Date: 06 Nov 2002 17:09:25 +0100
In-Reply-To: <1036597115.10238.40.camel@irongate.swansea.linux.org.uk>
Message-ID: <871y5yel3e.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > What I need is an option simply not to compile in the TSC code and use the PIT 
> > instead.  What I'm trying to do with the TSC and PIT options is give three 
> > choices:
> > 
> > 1. Don't use TSC (don't compile TSC code): X86_TSC=n, X86_PIT=y
> > 
> > 2. May use TSC but check first (blacklist, notsc kernel option).  X86_TSC=y, 
> > X86_PIT=y
> > 
> > 3. TSC is always OK so don't need PIT.  X86_TSC=y, X86_PIT=n
> 
> [Plus we need X86_CYCLONE and we may need X86_SOMETHING else for some
> pending stuff]

Yes, for example the NatSemi SC2200 has a 32+1 bit "High Resolution
Timer" that can be clocked either at 1MHz or 27MHz and that can
generate an interrupt whenever it wraps around.

Just using the High Resolution timer would avoid the known problems
with the TSC (stops on HLT, a bug when the low 32 bits of the TSC wrap
around) and the PIT (something somewhere, maybe SMM mode, seems to
mess upp the latch values).

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
