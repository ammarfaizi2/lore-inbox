Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272219AbRHWIPV>; Thu, 23 Aug 2001 04:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272233AbRHWIPN>; Thu, 23 Aug 2001 04:15:13 -0400
Received: from ltgp.iram.es ([150.214.224.138]:1408 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id <S272219AbRHWIO6>;
	Thu, 23 Aug 2001 04:14:58 -0400
Date: Thu, 23 Aug 2001 10:15:04 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: adding accuracy to random timers on PPC - new config option or
 runtime  overhead?
In-Reply-To: <3B83EC7B.B10F59C6@nortelnetworks.com>
Message-ID: <Pine.LNX.4.21.0108231004580.2015-100000@ltgp.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Chris Friesen wrote:

> 
> I'm looking at putting in PPC-specific code in add_timer_randomness() that would
> be similar to the x86-specific stuff.
> 
> The problem is that the PPC601 uses real time clock registers while the other
> PPC chips use a timebase register, so two different versions will be required.
> Should I try and identify at runtime which it is (which would be extra
> overhead), or should I add another config option to the kernel?

Look at how it's done in do_gettimeofday (expand the macros). Note that
the USE_RTC was not yet perfect last time I looked at it: it should only
perform a test whenever 601 support is enabled (there are so many problems
with 601).

Don't forget that in the case of a 601, you have to shift the least
significant word right by 7 bits since the register increments by 128
every 128 nanoseconds. But the upper word changes more often...

However, it would perhaps be better to define the code as a macro in
asm-${ARCH}/whatever.h and fall back to jiffies in case the macro is not
defined. Arch dependent ifdef'ed code should be avoided.

	Gabriel.

