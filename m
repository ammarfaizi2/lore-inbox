Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262115AbSJNT1K>; Mon, 14 Oct 2002 15:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSJNT1K>; Mon, 14 Oct 2002 15:27:10 -0400
Received: from faui80.informatik.uni-erlangen.de ([131.188.38.1]:41434 "EHLO
	faui80.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S262115AbSJNT1I>; Mon, 14 Oct 2002 15:27:08 -0400
Date: Mon, 14 Oct 2002 14:26:54 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Mark Mielke <mark@mark.mielke.cc>, "David S. Miller" <davem@redhat.com>,
       Russell King <rmk@arm.linux.org.uk>, simon@baydel.com,
       alan@lxorguk.ukuu.org.uk, lkml <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
Message-ID: <20021014142654.B518@linux-m68k.org>
References: <20021007165345.GA3068@mark.mielke.cc> <Pine.LNX.4.44.0210071307420.913-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210071307420.913-100000@xanadu.home>; from nico@cam.org on Mon, Oct 07, 2002 at 01:45:35PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 01:45:35PM -0400, Nicolas Pitre wrote:
 
> Here's the IO macro issue:  On some embedded platforms the IO bus is only 8
> bit wide or only 16 bit wide, or address lines are shifted so registers
> offsets are not the same, etc.  All this because embedded platforms are
> often using standard ISA peripheral chipsets since they can be easily glued
> to any kind of bare buses or static memory banks.
> 
> The nice thing here is the fact that only by modifying inb() and friends you
> can reuse most current kernel drivers without further modifications.  
> However the modifs to inb() are often different whether the peripheral in
> question is wired to a static memory bank, to the PCMCIA space or onto some
> expansion board via a CPLD or other weirdness some hardware designers are
> pleased to come with.  Hence no global inb() and friend tweaking is possible
> without some performance hit by using a runtime fixup based on the address
> passed to them.

we have all this problems on m68k as well (except that our speed
constraints aren't so terribly strict), don't give up too quickly.

A possible solution is to generate multiple object file from the
same source using a different set of defines for each one. The kbuild
system can already handle it using the CFLAGS_$@ rule and asm/io.h
can then select the appropriate macros for inb etc.

Where it starts to be more interesting is when there are module 
interdependecies (like ne.c and e8390.c) or all the object files 
are to be be linked into kernel. Perhaps EXPORT_SYMBOL() and 
INIT_MODULE() could be tweaked to mangle the names according to 
some special define.

Richard
