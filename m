Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316416AbSE3Gkt>; Thu, 30 May 2002 02:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316422AbSE3Gks>; Thu, 30 May 2002 02:40:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8966 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316416AbSE3Gks>; Thu, 30 May 2002 02:40:48 -0400
Date: Thu, 30 May 2002 08:40:48 +0200
From: Jan Hubicka <jh@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Dave Jones <davej@suse.de>, Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        "J.A. Magallon" <jamagallon@able.es>, Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4}
Message-ID: <20020530064048.GJ19308@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.44.0205260128110.2047-100000@Expansa.sns.it> <Pine.LNX.4.44.0205260044270.10923-100000@sharra.ivimey.org> <20020526023009.G16102@suse.de> <20020527085301.A38@toy.ucw.cz> <20020529134202.F27463@suse.de> <20020529195727.GC31266@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
> 
> >  > > I would be (pleasantly) surprised to see gcc turn a C memcpy into faster
> >  > > assembly than our current implementation. And I'll bet
> >  > 
> >  > gcc has hand-coded assembly inside itself, if gcc compiled memcpy is slower
> >  > than hand-optimized one, you found a compiler bug.
> > 
> > Not at all. gcc compiled memcpy just has no knowledge of things like
> > non-temporal stores, and using mmx/sse to move 64 bits at a time
> 
> non-temporal stores are bypassing cache? Is it always good idea?

The strategy GCC uses is to emit memcpy/memset for short blocks and call
function for others expecting that the function will contain all nasty
tricks possible.  For large blocks this is a win concerning code size
bloat caused by inlining MMX loops.

Nontemporal stores is definitly win for large blocks that does not fit
into cache as a whole, I am not sure whether this is the case of kernel.
I think kernel itself is usually zeroing memory just before it is used,
but I may be mistaken.
> 
> > instead
> > of 32 bit registers. (It's only recently it got prefetch abilities
> > too).
> 
> gcc knows about mmx/sse, and could decide to use it.

I don't do that at the moment.  I am thinking about teaching it to use
SSE moves for moving/clearing 64bit and larger values in memory.
(ie for inlining constantly sized string operations)

Honza
> 									Pavel
> -- 
> Casualities in World Trade Center: ~3k dead inside the building,
> cryptography in U.S.A. and free speech in Czech Republic.
