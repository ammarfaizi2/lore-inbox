Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbSLETMV>; Thu, 5 Dec 2002 14:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267369AbSLETMV>; Thu, 5 Dec 2002 14:12:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:46586 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267368AbSLETMU>;
	Thu, 5 Dec 2002 14:12:20 -0500
Message-ID: <3DEFA6B8.98386781@mvista.com>
Date: Thu, 05 Dec 2002 11:19:20 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: how is the asm-generic to be used?
References: <3DEF1DB1.98CD4BB3@mvista.com> <3DEF86A2.2010704@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> george anzinger wrote:
> > Lets say there is a bit of code in the kernel ( i.e.
> > .../kernel/ ) that needs a function that is in an
> > asm-gneric/*.h file.  Now someone comes along and does an
> > asm-x386/*.h with the same functionality but much faster asm
> > functions.  How should the using code be set up to get the
> > faster asm version if it exists and the generic version if
> > it does not?
> 
> Can you be more specific?  :)
> 
> asm-generic is for things that belong in include/asm-$ARCH but are also
> shared across multiple architectures.
> 
What I have is a generic version of sc_math.h, a set of
inlines and defines that make it easy to access the mpy and
div instructions with 64-bit/32-bit arguments (for example
mpy takes 2 32-bit arguments and produces a 64-bit result). 
Individual archs would do these things with an sc_math.h
that uses asm (which I also have for the i386 arch).  So the
question is how things are set up so that the arch version
is used if available and the generic if not.

I think the answer (one of those, "it came to me in the
shower answers") is that it is handled by the make file
setting up the include file search paths so that first
asm-<arch> is search and then asm-generic.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
