Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136735AbREHBrJ>; Mon, 7 May 2001 21:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136743AbREHBrA>; Mon, 7 May 2001 21:47:00 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:58896
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S136742AbREHBqv>; Mon, 7 May 2001 21:46:51 -0400
Date: Mon, 7 May 2001 18:43:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010507184315.A2378@opus.bloom.county>
In-Reply-To: <20010505192731.A2374@thyrsus.com> <E14wO7g-000240-00@the-village.bc.nu> <20010507105950.A771@opus.bloom.county> <20010507213140.I16535@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010507213140.I16535@thyrsus.com>; from esr@thyrsus.com on Mon, May 07, 2001 at 09:31:40PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 09:31:40PM -0400, Eric S. Raymond wrote:
> Tom Rini <trini@kernel.crashing.org>:
[snip]
> Exactly.  In fact we can be more specific -- the "Macintoshes" in
> question are the old-fashioned NuBus-based 68k toaster boxes, not the
> more recent designs with a PCI bus.  Relevant stuff in the
> Configure.help implies that MAC_SCC and MAC_SCSI enable support for
> the on-board hardware built into those puppies.
>  
> > But Alan's point is a good one.  There are _lots_ of cases you can't get away
> > with things like this, unless you get very fine grained.  In fact, it would
> > be much eaiser to do this seperately from the kernel.  Ie another, 
> > possibly/probably _not_ inkernel config tool which asks what machine you
> > have, picks lots of sane defaults and setups a kernel config for you.  This
> > is _sort of_ what PPC does right now with the large number of 'default 
> > configs' (arch/ppc/configs).
> 
> You're really talking about a different issue here,  autoconfiguration
> rather than static dependencies.  Giacomo Catenazzi is working on that.

Only sort-of.  There are some cases where you can get away with that.  
Probably.  eg If you ask for PARPORT, on x86 that means yes to PARPORT_PC,
always (right?)  On other arches (someone brought this up before) it could
be PC, it could be something else.  My point is there are only some cases
where you can get away with asking for serial and knowing the driver.  I've
given this some thought before, and at least on PPC, you can at best segment
off some drivers as depending on family X, but family X doesn't mean you
have part Y.  The other thing to keep in mind is I'm sure there's lots of
unintentionally correct bits.  In short, please be very careful when you
change a symbol from a question to a derive.  You're bound to piss off 
someone :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
