Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267722AbRGPW0k>; Mon, 16 Jul 2001 18:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267724AbRGPW0a>; Mon, 16 Jul 2001 18:26:30 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:16135 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267722AbRGPW0U>; Mon, 16 Jul 2001 18:26:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>, Jussi Laako <jlaako@pp.htv.fi>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
Date: Tue, 17 Jul 2001 00:28:46 +0200
X-Mailer: KMail [version 1.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E15LopT-0004Cm-00@the-village.bc.nu> <3B53221B.28B8D5A1@pp.htv.fi> <3B533D98.B9D1074@namesys.com>
In-Reply-To: <3B533D98.B9D1074@namesys.com>
MIME-Version: 1.0
Message-Id: <0107170028460E.06482@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 July 2001 21:16, Hans Reiser wrote:
> Jussi Laako wrote:
> > Daniel Phillips wrote:
> > > We are not that far away from being able to handle 8K blocks, so
> > > that would bump it up to 32 TB.
> >
> > That's way too small. Something like 32 PB would be better... ;)
> > We need at least one extra bit in volume/file size every year.
>
> Daniel, if I was real sure that 64k blocks were the right answer, I
> would agree with you.  I think nobody knows what will happen with
> reiserfs if we go to 64k blocks.

For 32 bit block numbers:

    Logical Block Size	    Largest Volume
    ------------------	    --------------

	   4K			 16 TB
	   8K			 32 TB
	  16K			 64 TB
	  32K			128 TB
	  64K			256 TB    

You don't have to go to the extreme of 64K blocksize to get big 
volumes.  Anyway, with tailmerging there isn't really a downside to big 
blocks, assuming the tailmerging code is fairly mature and efficient.  
Maybe that's where we're still guessing?

> It could be great.  On the other
> hand, the average number of bytes memcopied with every small file
> insertion increases with node size.  Scalable integers (Xanadu
> project idea in which the last bit of an integer indicates whether
> the integer is longer than the base size by an amount equal to the
> base size, chain can be infinitely long, they used a base size of 1
> byte, but we could use a base size of 32 bits, and limit it to 64
> bits rather than allowing infinite scaling) seem like more
> conservative coding.

Yes, I've used similar things in the past, but only in serialized 
structures.  In a fixed sized field it doesn't make a lot of sense.

--
Daniel
