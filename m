Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264173AbRGGNAn>; Sat, 7 Jul 2001 09:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266151AbRGGNAX>; Sat, 7 Jul 2001 09:00:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3968 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264173AbRGGNAQ>;
	Sat, 7 Jul 2001 09:00:16 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15175.2003.773317.101601@pizda.ninka.net>
Date: Sat, 7 Jul 2001 06:00:03 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), bcrl@redhat.com (Ben LaHaise),
        jes@sunsite.dk (Jes Sorensen),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
In-Reply-To: <E15Ir5R-0005lR-00@the-village.bc.nu>
In-Reply-To: <3B46FDF1.A38E5BB6@mandrakesoft.com>
	<E15Ir5R-0005lR-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > I see no good way to optimise for 64bit dma on a 32bit box.

I'm actually not only talking about DAC device on 32-bit cpus.  Just
as much, I'm talking about drivers for SAC-only devices even on 64-bit
cpus.

I took a lot of crap from driver authors when we started pushing the
PCI dma stuff on people, because of the dma_addr_t people now had to
keep around to unmap the thing later.

To a certain extent I agreed with these folks.  I'll be gutting myself
if I make everyone eat twice as much space just to add DAC support to
the kernel :-)

>From yet another perspective, my proposals have also to do with what
API can actually work on all platforms.  This is pretty important to
me.  I remember yesteryear when I used to give myself the privilege
of being self-arch-centric in my work, a Sparc hack here, a Sparc hack
there.  But I simply cannot operate this way anymore.  My conscious
will no longer allow me to crap up things like that :-)

 > I don't agree with Dave's desire to write another whole concoction.

It needs to be a new set of interfaces (and at that point, why not use
a different dma64_addr_t type and save overhead for SAC-only devices
while we're at it :-) because the proper inputs for a DAC mapping
involve page/off/len pairs.

Ignoring addressing limits of 32-bit cpus for a moment, consider that
this page/off/len triplet is the natural currency the kernel uses for
this kind of stuff anyways.

I think it is interesting to note that Jens noticed this immediately,
him being the first person to actually try and implement something
that would work on 32-bit platforms.

Later,
David S. Miller
davem@redhat.com
