Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSHGWvy>; Wed, 7 Aug 2002 18:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSHGWvx>; Wed, 7 Aug 2002 18:51:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23688 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S314096AbSHGWvu>;
	Wed, 7 Aug 2002 18:51:50 -0400
Date: Thu, 8 Aug 2002 00:54:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] tls-2.5.30-A1
In-Reply-To: <1028759766.11774.281.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208080050300.7410-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 8 Aug 2002, Luca Barbieri wrote:

> > I would suggest:
> >  - move all kernel-related (and thus non-visible to user space) segments 
> >    up, and make the cacheline optimizations _there_. 
> Done.
> >  - keep the TLS entries contiguous, and make sure that segment 0040 (ie
> >    GDT entry #8) is available to a TLS entry, since if I remember
> >    correctly, that one is also magical for old Windows binaries for all
> >    the wrong reasons (ie it was some system data area in DOS and in 
> >    Windows 3.1)
> Done. Segment 0x40 set to CPL 3.
> >  - and for cleanliness bonus points: make the regular user data segments 
> >    just another TLS segment that just happens to have default values. If 
> >    the user wants to screw with its own segments, let it.
> Bad idea: makes task switch slower without any practical advantage.
> The user may load a TLS or LDT selector in %ds to get the same effect.

your patch looks good to me - as long as we want to keep those 2 TLS
entries and nothing more. (which i believe we want.) If even more TLS
entries are to be made possible then a cleaner TLS enumeration interface
has to be used like Christoph mentioned - although i dont think we really
want that, 3 or more entries would be a stretch i think.

	Ingo

