Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271612AbRHZXBQ>; Sun, 26 Aug 2001 19:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271609AbRHZXBG>; Sun, 26 Aug 2001 19:01:06 -0400
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:52410 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S271573AbRHZXAx>; Sun, 26 Aug 2001 19:00:53 -0400
Date: Mon, 27 Aug 2001 00:40:07 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: VCool - cool your Athlon/Duron during idle
Message-ID: <20010827004006.A10483@storm.local>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010826181315Z271401-760+6195@vger.kernel.org> <E15b5W8-0002cC-00@the-village.bc.nu> <20010826220023.G2994@cerebro.laendle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010826220023.G2994@cerebro.laendle>
User-Agent: Mutt/1.3.20i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 10:00:23PM +0200,  Marc A. Lehmann  wrote:
> On Sun, Aug 26, 2001 at 08:24:20PM +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Well my German isnt that good,
>    
> the page is in english (at least the one you get while clicking on
> linux, which is german and english alike, and gthe source code is rather
> international ;)
> 
> > but it appears to be just another variant
> > on CPU idling.
> 
> The linux version only fiddles with a single bit in the northbridge that
> is claimed to be necessary so the cpu goes into the "real" idle mode. It
> also warns that some streaming applications might react to this with frame
> drops or similar.

According to c't 18/2001 p.36, the real power saving in halt and STPCLK
is only in effect when the CPU disconnects from the FSB.  In the VIA
north bridges there is one bit (bit 7 at offset 0x52) which controls
whether the north bridge performs the disconnect protocol.  For various
reasons, this is usually disabled by the BIOS:

1. Lower quality power supplies and motherboard voltage regulators may
   not be able to deal with the large and fast current changes.

2. Disconnect costs 2% - 3% on common benchmarks.  Incidentally, this is
   also the difference between the fastest and slowest Athlon
   motherboards.  Disconnect doesn't sell, benchmarks do.

3. The internal clock generator of the CPU may lose sync or something on
   reconnect.  (erratum #11, can be worked around by software)

4. In rare cases, Athlons with non-integer frequency multipliers (e.g.
   7.5) may fail to reconnect altogether.  (erratum #14, work around:
   don't sleep in C1 or C2 with disconnect)

Errata as quoted from the article, referring to "AMD Athlon Processor
Model 4 Revision Guide",
http://www.amd.com/products/cpg/athlon/techdocs/pdf/23614.pdf

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
