Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265075AbUFAOxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbUFAOxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUFAOxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:53:09 -0400
Received: from aun.it.uu.se ([130.238.12.36]:56459 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265075AbUFAOxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:53:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16572.38987.239160.819836@alkaid.it.uu.se>
Date: Tue, 1 Jun 2004 16:52:59 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
In-Reply-To: <c892nk$5pf$1@terminus.zytor.com>
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se>
	<c892nk$5pf$1@terminus.zytor.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > Followup to:  <200404292146.i3TLkfI0019612@harpo.it.uu.se>
 > By author:    Mikael Pettersson <mikpe@csd.uu.se>
 > In newsgroup: linux.dev.kernel
 > > 
 > > 'ptr' _is_ a char pointer, and the code (visible in the part of
 > > the patch you didn't include) already performed pointer arithmetic
 > > on it relying on it being a char pointer. The old code had no
 > > sane reason at all for updating 'ptr' via a cast-as-lvalue.
 > > 
 > > cast-as-lvalue is not proper C, has dodgey semantics, and can
 > > always be replaced by proper C.
 > > 
 > 
 > I don't see how it has dodgey semantics for cast of pointers or
 > [u]intptr_t to pointers.

You're assuming pointers have uniform representation.
C makes no such guarantees, and machines _have_ had
different types of representations in the past.
Some not-so-obsolete 64-bit machines in effect use fat
representations for pointers to functions (descriptors),
but they usually cheat and use pointers to the descriptors
instead. However, a C implementation could legally
represent a function pointer as a 128-bit value, while
data pointers remain 64 bits.

A cast fundamentally involves an assignment conversion,
a copy to a temporary, and it yields an rvalue.
Even if we allow its use as an lvalue, the semantics
would still be to assign the copy not the original.
So cast-as-lvalue as gcc implemented it changed two
major aspects of the semantics. Call me conservative
if you like, but that's simply not C any more.

Other gcc extensions, such as __inline__, __attribute__,
and __asm__, do provide useful and sensible features.
The issue with cast-as-lvalue is that it is neither
necessary nor does it promote maintainable and portable code.

Remember "the world's not a VAX" and "the world's not
a 68K with 24-bit addresses" lessons of the 80s,

 > IMNSHO the fact that it breaks C++ isn't a good reason to outlaw a
 > long-documented extension for C.

I couldn't care less about C++. There are ample reasons
why it's a bad idea in C itself.

/Mikael
