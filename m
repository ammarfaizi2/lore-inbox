Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbTBTUQK>; Thu, 20 Feb 2003 15:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTBTUQH>; Thu, 20 Feb 2003 15:16:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52487 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265126AbTBTUPJ>; Thu, 20 Feb 2003 15:15:09 -0500
Date: Thu, 20 Feb 2003 12:20:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       Dave Hansen <haveblue@us.ibm.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <1045776104.3790.34.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302201218080.12127-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Feb 2003, Alan Cox wrote:
> On Thu, 2003-02-20 at 16:54, Linus Torvalds wrote:
> > Ok, the 4kB stack definitely won't work in real life, but that's because 
> > we have some hopelessly bad stack users in the kernel. But the debugging 
> > part would be good to try (in fact, it might be a good idea to keep the 
> > 8kB stack, but with rather anal debugging. Just the "mcount" part should 
> > do that).
> 
> You also need IRQ stacks to get down to 4K. The wrong pattern of ten
> different IRQ handlers using a mere 200 bytes each will eventually
> happen and eventually kill you otherwise.

Martin's patch set included the per-IRQ stacks, so that part should be ok. 
However, since even a single function will overflow the stack depth test 
of "half the stack", I'm just saying that right now the 4kB stacks 
obviously shouldn't be used for overflow testing (and the 8kB stack 
version right now is way too permissive).

> > That ide_unregister() thing uses up >2kB in just one call! And there are 
> > several in the 1.5kB range too, with a long list of ~500 byte offenders.
> 
> ide_unregister is a really stupid one. Its copying a struct mostly to
> restore fields it shouldnt be restoring but should be setting in the 
> allocator. I hadn't realised quite how bad it was. Added to the ide
> shitlist

Well, ide_unregister() was only the worst of a fairly large bunch of crap. 

Although I guess nobody is really surprised.

		Linus

