Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270040AbRHGC0u>; Mon, 6 Aug 2001 22:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270039AbRHGC0k>; Mon, 6 Aug 2001 22:26:40 -0400
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:49602 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S270040AbRHGC0d>; Mon, 6 Aug 2001 22:26:33 -0400
Subject: Re: [LONGish] Brief analysis of VMAs (was: /proc/<n>/maps getting
From: David Luyer <david_luyer@pacific.net.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15Tk4u-0000wy-00@the-village.bc.nu>
In-Reply-To: <E15Tk4u-0000wy-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 07 Aug 2001 12:26:40 +1000
Message-Id: <997151200.10551.15.camel@typhaon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Aug 2001 14:05:52 +0100, Alan Cox wrote:
> > Yes, that's what's happening above.  And it's what's causing the
> > splits in the vmas.  So basically evolution-mail is doing exactly what
> > your test program was doing, and causing exactly the same thing.
> > 
> > Seems strange that glibc would do this unless there was some performance
> > reason on past kernels to do it?
> 
> Are you sure thats not evolution being built with a debugging malloc of
> some kind ?

Yes, as per cw's e-mail it's just how malloc() works in some cases on
glibc.  Allocate 2 * sz (where sz is a relatively large amount compared
to the amount being malloc()'d), free up the 'sz' which is not aligned
to a multiple of 'sz', and the gradually mprotect(PROT_READ|PROT_WRITE)
the memory it's allocated initially with PROT_NONE and MAP_NORESERVE.

And mprotect() responds by splitting up the vmas and never merging them
back together.
-- 
David Luyer                                     Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C    Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                      NASDAQ:  PCNTF
