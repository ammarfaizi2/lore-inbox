Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318804AbSH1MzP>; Wed, 28 Aug 2002 08:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318805AbSH1MzP>; Wed, 28 Aug 2002 08:55:15 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:62649 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S318804AbSH1MzO>; Wed, 28 Aug 2002 08:55:14 -0400
Date: Wed, 28 Aug 2002 14:23:56 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: readsw/writesw readsl/writesl
Message-ID: <20020828142356.B4464@linux-m68k.org>
References: <200208271600.SAA17957@faui02b.informatik.uni-erlangen.de> <20020827092908.31569@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020827092908.31569@192.168.4.1>; from benh@kernel.crashing.org on Tue, Aug 27, 2002 at 11:29:07AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 11:29:07AM +0200, Benjamin Herrenschmidt wrote:
> >> ...... However, if we decide to go the way
> >> you describe, the we should probably also provide the raw_{in,out}*
> >> ones.
> >
> >carefull, m68k already has them for other purposes. Original intention
> >was that raw_{in,out} should never be used outside architecture specific 
> >stuff anyway.
> 
> Then we have a problem... Either we chose to keep 2 different interfaces
> for MMIO and "PIO" with the "s" versions on PIO and not on MMIO, the
> raw versions on MMIO but not PIO, etc...
> 
> Or we decide to unify this properly.
> 
> In all cases, the current abstraction doesn't allow to re-implement
> {in,out}s{b,w,l}. This is already a problem as if a driver need to
> pump a fifo with some udelay's (like doing a _p version of one of
> the above), it can't or has to do some arch specific crap to deal
> with byteswap, barriers, etc...


it is a bit ugly right now, in asm-m68/ide.h we have to include io.h
and redefine some of the defs. Even more fun with some net drivers (eg 8390)
which on m68k can accessed over ISA bus, Zorro bus, or Zorro bus +
ISA bridge and maybe a few other methods. Byteswaps are the smallest
problem here, we have also to translate adresses and deal with sparsely
mapped io regions.

A decent solution should use a per device "busops" struct that would
define in/out and other access methods for the underlying bus.

Richard
