Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267308AbUGNDBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267308AbUGNDBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 23:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267309AbUGNDBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 23:01:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38564 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267308AbUGNDBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 23:01:07 -0400
To: Andi Kleen <ak@muc.de>
Cc: ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it>
	<2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it>
	<2fPfF-2Dv-19@gated-at.bofh.it>
	<m34qohrdel.fsf@averell.firstfloor.org>
	<1089349003.4861.17.camel@nigel-laptop.wpcb.org.au>
	<orr7rjo8cr.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20040711055216.GA87770@muc.de>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 14 Jul 2004 00:00:54 -0300
In-Reply-To: <20040711055216.GA87770@muc.de>
Message-ID: <orsmbvpa1l.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 11, 2004, Andi Kleen <ak@muc.de> wrote:

>> Meanwhile, you should probably distinguish between must-inline,
>> should-inline, may-inline, should-not-inline and must-not-inline
>> functions.  Attribute always_inline covers the must-inline case; the

> You're asking us to do a lot of work just to work around compiler bugs?

Not asking.  Just suggesting that you make your request to the
compiler clearer.  This may enable the compiler to do a better job for
you.  You don't have to switch it all at once.  Keep inline as
always_inline, if you like, and downgrade other inline requests as you
see fit.

Of course having inline expand to something containing always_inline
will take a bit of preprocessor hackery to get other macros to expand
to the inline keyword without this attribute.

> I can see the point of having must-inline - that's so rare that
> it can be declared by hand. May inline is also done, except
> for a few misguided people who use -O3. should not inline seems
> like overkill.

`should not inline' is the default: a function not declared as inline
won't be inlined unless several conditions are met, e.g., compiling
with -O3 and/or -finline-all-functions.  It's the other cases to tune
inlining directives that would be useful.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
