Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132909AbRDUUe6>; Sat, 21 Apr 2001 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132912AbRDUUes>; Sat, 21 Apr 2001 16:34:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26118 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132901AbRDUUef>;
	Sat, 21 Apr 2001 16:34:35 -0400
Date: Sat, 21 Apr 2001 21:34:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jochen Striepe <jochen@tolot.escape.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4-pre6 does not compile
Message-ID: <20010421213430.D7576@flint.arm.linux.org.uk>
In-Reply-To: <20010421221728.C4077@tolot.escape.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010421221728.C4077@tolot.escape.de>; from jochen@tolot.escape.de on Sat, Apr 21, 2001 at 10:17:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 10:17:28PM +0200, Jochen Striepe wrote:
> 2.4.4-pre6 actually is the 4th 2.4.4pre-Patch that does not compile
> without further patching on my system. :-(
> rwsem.o(.text+0x30): undefined reference to `__builtin_expect'
> rwsem.o(.text+0x73): undefined reference to `__builtin_expect'

Its because you're using a version of gcc which doesn't have
__builtin_expect (eg, egcs 1.1.2, some versions of gcc 2.95).
I'm told that gcc 2.95.[12] are not suitable for kernel compilation...

I've currently got the following in my tree (sorry, no diff since I've
got other changes in this file).  lib/rwsem.c, line 9, add:

#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 96)
#define __builtin_expect(exp,c) (exp)
#endif

I'm not sure if this is correct, or which compilers work, which don't
(so don't anyone go and drop it into Linus/Alans kernels), but it
seems to work for me.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

