Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291729AbSBHSyO>; Fri, 8 Feb 2002 13:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291732AbSBHSyE>; Fri, 8 Feb 2002 13:54:04 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:13724 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S291729AbSBHSxq>; Fri, 8 Feb 2002 13:53:46 -0500
Date: Fri, 8 Feb 2002 19:49:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Troy Benjegerdes <hozer@drgw.net>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, wli@holomorphy.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <20020208115726.U17426@altus.drgw.net>
Message-ID: <Pine.GSO.3.96.1020208190416.15044F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Troy Benjegerdes wrote:

> Several people I have talked to on the issue specifically asked for the 
> panic(), as people using do_div() should really know better than to do 64 
> bit divides in the kernel.

 There are legitimate cases where you cannot avoid a double-precision
division and the inefficiency is negligible.  For example for MIPS it's
used in do_*_gettimeoffset() and at most once a jiffy (actually we use
do_div64_32() to reduce work, as we know the quotient will *always* fit in
32 bits).

> The generic C algorithm only handles base < 65536.
> 
> I can think of a couple ways around this..
> 
> 1) Make the base argument be a 'u16 base', and people with too large a
>    base would get compile warnings/errors.
> 
> 2) run-time check on base, and panic if too large
> 
> 3) run-time check on base, print dmesg warning if too large

 4) Use a generic division algorithm using shifts and subtracts such as
one of these described in academic books.  You may port the implementation
from include/asm-mips/div64.h. ;-) 

Note that in do_*_gettimeoffset() the divisor is an arbitrary 32-bit
number, mostly depending on the uptime.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

