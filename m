Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281458AbRLGODE>; Fri, 7 Dec 2001 09:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281473AbRLGOCy>; Fri, 7 Dec 2001 09:02:54 -0500
Received: from uisge.3dlabs.com ([193.133.230.45]:49363 "EHLO uisge.3dlabs.com")
	by vger.kernel.org with ESMTP id <S281458AbRLGOCl>;
	Fri, 7 Dec 2001 09:02:41 -0500
Date: Fri, 7 Dec 2001 14:01:29 +0000
From: Paul Sargent <Paul.Sargent@3dlabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2GB process crashing on 2.4.14
Message-ID: <20011207140128.F31161@3dlabs.com>
In-Reply-To: <20011207132317.E31161@3dlabs.com> <E16CLM9-0005rf-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16CLM9-0005rf-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 01:48:00PM +0000, Alan Cox wrote:
> > > Most probably the process is running out of address space to allocate from.
> > > There is 3Gb of available space. 
> > 
> > That would be from 0x00000000 to 0xC0000000, Right?
> 
> Correct (0xBFFFFFFF)
> 
> > > binary, some your libraries.  Getting above 3Gb/process on x86 is very hairy
> > > with a bad performance hit
> > 
> > So if I was hitting this limit then I should see no / very few gaps, in the
> > /proc/<pid>/maps. Is that true?
> 
> Providing the memory allocator it is using is sufficiently smart

Where "it" is the app?

OK, well looking at the maps output, there seems to be three distinct
sections:

1) from 0x00000000 to 0x01c6a000 (30MB-ish) are mappings of the executable.

2) from 0xbca9a000 to 0xbfffffff (56MB-ish) are the libs, plus a few other
   areas, which I've assumed are stack, and scratch areas for the libs.

3) a single mapping, (was 1.1GB-ish in the map output I attached) which
   starts at the end of section 1, and is continually growing, and which I
   can see has no reason to stop until it gets to the start of section 2
   (some 3GB - 86MB later).

Now admittedly, it's possible that some of the other mappings may grow by a
factor of 20 to suddenly eat up 1GB of address space, but I doubt it. So I'm
not buying the address space idea at the moment. That said, I'm not going to
discount it and will keep a log of what happens on the mappings while this
process is running, just in case something really wacky like that happens.

Paul
-- 
Paul Sargent
mailto: Paul.Sargent@3Dlabs.com
