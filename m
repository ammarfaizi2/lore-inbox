Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVHIT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVHIT3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVHIT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:29:22 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:21436 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S932220AbVHIT3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:29:21 -0400
Date: Tue, 9 Aug 2005 12:29:20 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Marc Singer <elf@buici.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi
Message-ID: <20050809192920.GC23389@hexapodia.org>
References: <20050808174721.GA2853@buici.com> <20050809175434.GA23389@hexapodia.org> <20050809190500.GA6551@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809190500.GA6551@buici.com>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code in question is

On Tue, Aug 09, 2005 at 12:05:00PM -0700, Marc Singer wrote:
> > > On Mon, Aug 08, 2005 at 07:35:36PM +0200, Marcel Holtmann wrote:
> > > > > > +	if (NULL == dev || NULL == driver) {
> > > > 	if (!dev || !driver) {
> > > 

You said:

> > > That's not a guaranteed equivalence in the C standard.  Null pointers
> > > may not be zero.  I don't think we have any targets that work this
> > > way, however there is nothing wrong with explicitly testing for NULL.

I quoted chapter and verse why that statement is not true:

> > [1] ISO/IEC 9899:1999 6.5.3.3 Unary arithmetic operators
> > 
> >   (5) The result of the logical negation operator ! is 0 if the value of
> >   its operand compares unequal to 0, 1 if the value of its operand
> >   compares equal to 0. The result has type int.  The expression !E is
> >   equivalent to (0==E).
> > 
> > [2] ISO/IEC 9899:1999 7.17
> > 
> >   The following types and macros are defined in the standard header
> >   <stddef.h>.  ...
> >          NULL
> >   which expands to an implementation-defined null pointer constant...
> > 
> >  and 6.3.2.3 Pointers
> >   (3) An integer constant expression with the value 0, or such an
> >   expression cast to type void *, is called a null pointer constant.
> 
> It was explained to me that the !pointer test wasn't guaranteed to be
> equivalent because of the way that the test is handled.

Whoever explained that to you was wrong.  6.5.3.3 is the final word on
how "!x" is interpreted, and it *says* in the *text* that
"!x" === "x!=0".  I don't see how this could be any clearer.

> The spec fragments above don't address how the boolean test is
> coerced.  Does it cast pointer to an integer and perform the test, or
> does it cast the 0 to a pointer and perform the test.  The C++ spec I
> have is vague on this point.  The only reference it makes to pointers
> is that the operand for ! may be a pointer.

Because of the equivalence *given in the text of 6.5.3.3* we can simply
follow the money.  (I'm not concerned, here, about what ambiguities the
C++ folks may or may not have introduced into their monstrosity.  The
Linux kernel is written in C, and the C standard is unambiguous on this
point.  Though frankly I'd be suprised if C++ breaks something so
straightforward and useful.)

The section that defines != says

6.5.9 Equality operators
  Syntax
(1)      equality-expression:
                relational-expression
                equality-expression == relational-expression
                equality-expression != relational-expression
  Constraints

(2) One of the following shall hold:
  ...
  -- one operand is a pointer and the other is a null pointer constant.

(5) ... If one operand is a pointer and the other is a null pointer
  constant, the null pointer constant is converted to the type of the
  pointer. ...

So:
1. !x is defined equivalent to x!=0.
2. 0 is a "null pointer constant".
3. (assuming x is a pointer) 0 will be promoted to pointer type in the
   expression "x!=0".



With the facts taken care of, we can move on to

> No, I'm not confused about the representation of a NULL.  Keep in mind
> that telling someone what they do or don't
> understand/believe/think/feel is the fast track to being flamed.

On Linux-kernel, being wrong is the fast track to being flamed.  When
I'm wrong, I expect to be corrected.  (Frankly, I'm wrong and *not*
corrected much more frequently than I find comfortable.)  Adjust your
expectations accordingly and you may be more comfortable here.

Your original statement was wrong, so I corrected you (as much to keep
the disinformation level to a low roar, as anything).  The code
transformation quoted at the top of this message is both
(1) well-defined by the C standard and (2) in keeping with kernel coding
standards.

HTH, HAND.
-andy
