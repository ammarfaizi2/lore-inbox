Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318228AbSGWUZP>; Tue, 23 Jul 2002 16:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSGWUZP>; Tue, 23 Jul 2002 16:25:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3712 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318228AbSGWUZN>;
	Tue, 23 Jul 2002 16:25:13 -0400
Date: Tue, 23 Jul 2002 13:26:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Dave Jones <davej@suse.de>
cc: Markus Pfeiffer <profmakx@profmakx.org>, <linux-kernel@vger.kernel.org>
Subject: Re: CPU detection broken in 2.5.27?
In-Reply-To: <20020723212957.B16446@suse.de>
Message-ID: <Pine.LNX.4.44.0207231314390.954-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jul 2002, Dave Jones wrote:

> On Tue, Jul 23, 2002 at 12:14:08PM -0700, Patrick Mochel wrote:
> 
> There are some problems here.

Heh. They've always been there, then. I really did re-add the table from 
an older arch/i386/kernel/setup.c ;)

>  > +		{ X86_VENDOR_INTEL,     6,

> [4] is Deschutes according to the docs I used for x86info.

Ok, I added it. 

>  > +			  [5] "Pentium II (Deschutes)", 
> 
> What [5] is is dependant upon cache size & stepping.
> 
> stepping 0:
>     0KB - Celeron (Covington)
>     256KB - Mobile Pentium II (Dixon)
> stepping 1-3 Pentium II (Deschutes)

The Celeron detection happens in init_intel(). 

>  > +			  [6] "Mobile Pentium II",
> 
> cache size 128KB - Celeron (Mendocino)

Handled in init_intel().

> Stepping 0/5 - Celeron-A

Added to init_intel().

> Stepping A - Mobile PII

Um, leave as default? 

>  > +			  [8] "Pentium III (Coppermine)", 
> 
> L2 Cachesize == 128 == Celeron (Else P3)

Handled in init_intel().

>  > +			  [10] "Pentium III (Cascades)",
> 
> 6a0 is another P2 Deschutes aparently, but this seems
> odd, and I should double check this sometime.

Leaving unchanged.

>  > +			  [11] "Pentium III (Tualatin)",
> 
> Could be a celeron too. Not sure of cache size.

Ditto, for the sake of ignorance. 

>  > + [1] "Pentium 4 (Unknown)",
> 
> Model 5 = (Foster)

Added. Wait, isn't Foster the one with HT? The ones I have say that they 
support it, so wouldn't that be a Foster (as well as stepping 5)? 

Updated patch appended. This updated version hasn't been tested, as I
don't have any of those processors at my disposal...

	-pat

