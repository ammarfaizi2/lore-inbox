Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTJTFux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 01:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTJTFux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 01:50:53 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:40836
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262303AbTJTFuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 01:50:50 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Date: Mon, 20 Oct 2003 00:47:52 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200310180018.21818.rob@landley.net> <200310191900.47300.rob@landley.net> <20031020042837.GA4994@alpha.home.local>
In-Reply-To: <20031020042837.GA4994@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310200047.53468.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 October 2003 23:28, Willy Tarreau wrote:
> I don't know how the tests above were done. But what I know for sure is
> that there are excessive open source zealots who would only download the
> OSS version of UPX which uses the UCL library while the closed source
> version uses the NRV one which is a jewel.

Good for you.  And arj beat pkzip for years, no a number of metrics.  I 
honestly do not care.

> > And no, gzip -9 does not add anything to decompression time, only
> > compression time.
>
> Where did you get this interesting idea ? every decompressor needs
> decompression time.

I mean that the -9 version of gzip does not take any more time to decompress 
than the -1 version does, it only affects how many matches are checked in the 
dictionary before it stops looking for a shorter match.  During decompression 
the offsets are all stored, it doesn't matter how they were calculated.

That's where I got the "interesting idea" that the -9 option to the gzip 
compressor does not add anything to the decompression time.

> You need the compressed kernel to be in memory, then
> you decompress it, then you boot it. On my old 386sx which was still my
> home firewall 6 months ago, the kernel would take 2-3 seconds to decompress
> with gzip while it was almost unnoticeable with upx (which did it in place,
> BTW).

Interesting.  So you're suggesting that your algorithm is optimized for a 
processor with no L1 or L2 cache whatsoever?  Or are you suggesting that an 
algorithm that takes upwards of 3 seconds on a system that maxed out at 16 
mhz and had a 16 bit data path, a system with a maximum memory throughput 
slower than modern low-end hard drives (16mhz*2 bytes is 32 megabyts per 
second, and half for read and half for write is 16 megabytes per second when 
copying data without actually PROCESSING any of it, and this glosses over the 
fact that with no instruction cache you'll never see even close to that 
theoretical throughput on any code snippet longer than "rep movsw")...  That 
this algorithm is slow enough to be a legitimate optimization target and 
worth using closed source software to optimize this bottleneck.

Are you really suggesting that gzip isn't fast enough?  (Out of morbid 
curiosity, how long did it take the bios code to boot up this straw man to 
the point where it loaded the boot sector?)

> Now don't get me wrong, I'm not advertising for upx.

No comment.

> But bzip2 was proposed

No, I posted a link to code.  And I offered to use that code to update an 
existing kernel patch if I could track it down, which I did.  (And I'm 
working on a 2.6 port with the new engine, albeit not at a particularly high 
priority seeing as we're in the middle of a code freeze...)

You're welcome to code up your own patch to do whatever you darn well please.  
I'm not interested.

> and will always be criticized because of its decompression time and cost in
> terms of memory. So I simply suggested to take a look at other solutions
> which seem interesting.

You suggested I spend my free time to code up a patch to support a closed 
source compressor I'd never heard of.  I've taken it under advisement, and 
filed it appropriately.

>  An UPX-based implementation seems interesting to me
> only if the decompression code is free and can be put in the kernel.

Good for you.  Code up a patch, so I can start ignoring code instead of just 
ignoring suggestions.

> Otherwise it is not. If the numbers above come from the UCL lib, then we at
> least know that this one doesn't interest us for this matter.

I presume you're using the editorial "we".  Because I, myself, find the 
qualifier "for this matter" to be superfluous.

> Some people
> would also suggest taking a look at other compression algorithms which can
> be of interest, but I don't know their sources status (open/close).

If some people code up a patch, then the matter moves out of the realm of pure 
philosophical arguments.

> > I can make bunzip work in-place if you'd like
>
> That's very important for low-memory systems.

Really?  Wow.

> Regards,
> Willy

Rob
