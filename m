Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318378AbSGaN55>; Wed, 31 Jul 2002 09:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318379AbSGaN54>; Wed, 31 Jul 2002 09:57:56 -0400
Received: from 209-166-240-202.cust.walrus.com.240.166.209.in-addr.arpa ([209.166.240.202]:9375
	"EHLO ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id <S318378AbSGaN5v>; Wed, 31 Jul 2002 09:57:51 -0400
Date: Wed, 31 Jul 2002 10:01:07 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: blp@cs.stanford.edu, linux-kernel@vger.kernel.org
Subject: extended integer types (was Re: [patch] Input cleanups for 2.5.29 [2/2])
Message-ID: <20020731100107.A14404@ti18>
References: <Pine.LNX.4.33.0207301433480.2051-100000@penguin.transmeta.com> <Pine.GSO.4.21.0207301738090.6010-100000@weyl.math.psu.edu> <87znw8anje.fsf@pfaff.Stanford.EDU> <1028122978.8510.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1028122978.8510.59.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Jul 31, 2002 at 02:42:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 02:42:58PM +0100, Alan Cox wrote:
> On Tue, 2002-07-30 at 22:55, Ben Pfaff wrote:
> > 1    The typedef name intN_t designates a signed integer type with
> >      width N, no padding bits, and a two's complement
> >      representation. Thus, int8_t denotes a signed integer type
> >      with a width of exactly 8 bits.
> 
> And arbitary alignment requirements. At least I see nothing in C99
> saying that
> 
> 	uint8_t foo;
> 	uint8_t bar;
> 
> isnt allowed to give you interesting suprises

The problem here is footnote 215, which says "Some of these types may
denote implementation-defined extended integer types."  The rest of
section 7.18 is built around a conceptual model of the extended integer
types as aliases to the standard types.

The standard almost surely means the smallest such type, but does
not in fact say that.  The standards language appears to conflate the
value semantics with the representation width.  (However, see the
description of int_leastN.) I will consider filing a defect report.

The C99 <stdint.h> types are the bastard child of a paper by Frank
Farance and myself on extended integer type semantics, combined with an
earlier [u]intN_t proposal.  Our input to the C9x process largely ended
with the discussion of the original paper, for unrelated reasons.

The intention was to remove the ambiguity in much legacy code that used
"long" in two ways: as the largest integral type, and as an exact 32-bit
container.  IIRC, the original proposal described integral types with the
following semantics:

   exact<n>

      exact [un]signed n-bit arithmetic in the smallest supported
      integral container, so that if a standard type of width <n> bits
      exists, then exact<n> corresponds to it.  Hence sizeof(exact<8>)
      == 1 on all sane platforms.  Think bitfields in auto-sized
      containers.

   least<n> -

      [un]signed arithmetic with the smallest integral type >= n bits
      that is "natural" to the platform, typically half-register,
      register, or double-register width.  least<n> corresponds to exact<m>
      for some m >= n.

   fast<n>

      the fastest "natural" (i.e., [half-]register)  width for the platform,
      to be used for accumulators, etc., where external representation
      is unimportant.

Humbly,

    Bill Rugolsky

