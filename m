Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266016AbRGGFfx>; Sat, 7 Jul 2001 01:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266019AbRGGFfo>; Sat, 7 Jul 2001 01:35:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53992 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266016AbRGGFfd>;
	Sat, 7 Jul 2001 01:35:33 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.40867.89472.953231@pizda.ninka.net>
Date: Fri, 6 Jul 2001 22:35:31 -0700 (PDT)
To: Ben LaHaise <bcrl@redhat.com>
Cc: Jes Sorensen <jes@sunsite.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
 achi ne
In-Reply-To: <Pine.LNX.4.33.0107062355070.26274-100000@toomuch.toronto.redhat.com>
In-Reply-To: <15174.19941.681583.314691@pizda.ninka.net>
	<Pine.LNX.4.33.0107062355070.26274-100000@toomuch.toronto.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben LaHaise writes:
 > Yes.  It's not an unreasonable overhead considering that it's configured
 > out for all the non-highmem kernels that will be shipped.  Keep in mind
 > that the expected lifespan for 32 bit systems is now less than 3 years, so
 > elaborate planning that delays implementation buys us nothing more than a
 > smaller window of usefulness.

Maybe by then only 64-bit cpus will matter.  Who knows.

 > > This says nothing about the real reason the IA64 solution is
 > > unacceptable, the inputs to the mapping functions which must
 > > be "page+offset+len" triplets as there is no logical "virtual
 > > address" to pass into the mapping routines on 32-bit systems.
 > 
 > On x86 a 64 bit DMA address cookie is fine.  If you've got concerns, tell
 > us what you have in mind for a design.

Things along the lines of what Jens Axboe's patches are what I'm
thinking about.

 > So what's the API?

See Jens's patches.

First it has to pass in page/off/len triplets, on all platforms.
This is addressed by Jens's interfaces.

Secondly it has to provide a query mechanism to delineate the
three cases:

1) DAC is faster and always preferred
2) SAC is faster
3) DAC may be slower but more desirable for certain devices
   due to large amounts of parallel address space usage

I have not designed an interface for this, but it ought to be
quite simple.

Thirdly seperate 32-bit/64-bit DMA address types.  Added to the
overhead concerns, I also think it sucks big donkey balls to cast the
things around, especially since different platforms would potentially
require different casts to eliminate the warnings.  In fact, with your
suggested scheme, the setting of highmem would determine a core
type.

In fact, I'm not going to bother to code one single bit of this myself
until I am convinced I have thought the whole problem over properly.
This is the part nobody else wants to do, but it is a prerequisite for
this sort of API.

Later,
David S. Miller
davem@redhat.com
