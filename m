Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271207AbRH3CFx>; Wed, 29 Aug 2001 22:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271208AbRH3CFo>; Wed, 29 Aug 2001 22:05:44 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:65343 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S271207AbRH3CF0>; Wed, 29 Aug 2001 22:05:26 -0400
Date: Wed, 29 Aug 2001 22:05:09 -0400
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: David Lang <david.lang@digitalinsight.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010829220509.A26395@ead45>
In-Reply-To: <Pine.LNX.4.33.0108290858410.19372-100000@dlang.diginsite.com> <20010829234316Z16134-32384+1075@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010829234316Z16134-32384+1075@humbolt.nl.linux.org>; from phillips@bonn-fries.net on Thu, Aug 30, 2001 at 01:49:54AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 01:49:54AM +0200, Daniel Phillips wrote:
> On August 29, 2001 06:02 pm, David Lang wrote:
> > when you write a signed/unsigned comparison is it defined in any standard
> > which type the compiler should generate or is it somethign that could be
> > different in different compilers (and versions)
> 
> Yes, in the signed/unsigned case the comparison generated is always
> unsigned.  This is something that all c programmers are supposed to have 
> tattoed on the insides of their eyelids, because if you don't know it
> there are all kinds of situations that can bite you, not just min and
> max.
> 
> > (also when comparing different size items same question)
> 
> The narrower is expanded to the size of the wider before being compared.

Careful.  Operands of relational operators undergo "usual arithmetic
conversions," which are value-preserving, so unsigned char and unsigned
short are promoted to int on platforms where int is value-preserving.
Similarly, unsigned int is promoted to long where long is value-preserving,
as I pointed out earlier in this thread.  (This wasn't always the case,
see below.)

The problem here, of course, is that if you don't know the widths of the
operands, you can't determine the type of the compare.  Change the width
of the operand (to steal some bits in a structure, say) and the signedness
of the comparison changes.

> 
> > if there are cases that are not defined in a standard and could vary by
> > compiler/version then we definantly need to have the current version with
> > the type argument.
> 
> No, these cases are defined perfectly clearly and have been at least
> since K&R.

K&R 1st Edition and the UNIX 7th Edition C reference manual specify that
unsigned dominates.  The "value-preserving" language was crafted for
C89, and appears in K&R, 2nd Edition.  C99 introduces the notion of
integer type "rank" to generalize the rules to extended precision types.

Regards,

   Bill Rugolsky
