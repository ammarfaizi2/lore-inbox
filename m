Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSHAW7W>; Thu, 1 Aug 2002 18:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317306AbSHAW7W>; Thu, 1 Aug 2002 18:59:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6288 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317302AbSHAW7V>;
	Thu, 1 Aug 2002 18:59:21 -0400
Date: Thu, 1 Aug 2002 19:02:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Martin Dalecki <dalecki@cs.net.pl>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: IDE from current bk tree, UDMA and two channels...
In-Reply-To: <CF125D0F09@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0208011856080.12627-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Petr Vandrovec wrote:

> On  1 Aug 02 at 18:45, Alexander Viro wrote:
> > 
> > On Thu, 1 Aug 2002, Linus Torvalds wrote:
> > 
> > > You probably saw this. Looks like blocksize has been buggered somehow.
> > > Apparently Petr has a 1kB blocksize optical device..
> 
> Just to correct you: it is normal magnetic disk with 512 byte sectors,
> from notebook. It works with 512B UDMA requests if we talk to the drive
> slowly, with pauses here and there. If we talk to it back-to-back, it
> dies. Apparently it forgets that it is doing UDMA transfers and tries
> to do normal PIO or MDMA or what - host terminates transfer in the middle,
> and disk is signaling that it has more data to go.

_Ouch_.  Then I have to agree with Martin - it's a blacklist time.  There's
not much partition code could do with that - you really have a partition
with a chunk that _can't_ be handled by 1Kb request.

Old code (pretty much by accident) hid it from you, so I'd suggest just
decrementing partition size - it's not that you had anything in that last
half-Kb.  At least nothing that could be accessed by old kernels.

