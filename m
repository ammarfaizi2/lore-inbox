Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290376AbSAXWWC>; Thu, 24 Jan 2002 17:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290389AbSAXWVy>; Thu, 24 Jan 2002 17:21:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3081 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290376AbSAXWVk>; Thu, 24 Jan 2002 17:21:40 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RFC: booleans and the kernel
Date: 24 Jan 2002 14:21:28 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2q1d8$vuj$1@cesium.transmeta.com>
In-Reply-To: <200201242141.g0OLfjL06681@home.ashavan.org.> <Pine.LNX.4.44.0201241545120.2839-100000@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0201241545120.2839-100000@waste.org>
By author:    Oliver Xymoron <oxymoron@waste.org>
In newsgroup: linux.dev.kernel
> 
> > It doesn't fix  "if ( x = true)". If would
> > just make it more legit to use "if (x)".
> 
> It's been legit and idiomatic since day 1, if not sooner.
> 

The main reasons for bool is:

a) The ability to save space.  No need to waste a 32- or 64-bit word
   to hold a single bit.  If you're on an architecture that has flags
   or predicates you may be able to carry a boolean in such a value
   instead of in a full register.

b) Compatibility with other languages, including but not limited to
   C++ (there is a standard under development for inter-language linking,
   incidentally.)  C++, of course, needs bool for overloading reasons.

c) The ability to cast to bool and get an unambiguous true or false:

     b = (bool)a;

   This replaces the idiomatic but occationally confusing

     b = !!a;

d) Similarly, you can avoid doing booleanization multiple times:

   /* Highly artificial example */
   int foo(bool a)
   {
       return a ? 55 : 47;
   }

   ... could be implemented by the compiler as 47 + (a << 3), or
   depending on your ABI convention, perhaps a caller calling
   foo(x < 4) could be implemented as foo(x-4) without needing to
   convert it into an integer of exactly 1 and 0.

   Given the way C currently does it, you pretty much have do
   booleanize both in the caller and the callee to be on the safe
   side.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
