Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUFZSzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUFZSzu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 14:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUFZSzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 14:55:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:22506 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264305AbUFZSzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 14:55:48 -0400
Date: Sat, 26 Jun 2004 11:54:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
In-Reply-To: <20040626182820.GA3723@ucw.cz>
Message-ID: <Pine.LNX.4.58.0406261140360.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
 <1088268405.1942.25.camel@mulgrave> <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
 <1088270298.1942.40.camel@mulgrave> <Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
 <20040626182820.GA3723@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Jun 2004, Vojtech Pavlik wrote:
> 
> At least input pretty much relies on the fact that bitops don't need
> locking and act as memory barriers.

Well, plain test_bit() has always been more relaxed than the others, and
has never implied a memory barrier. Only the "test_and_set/clear()" things
imply memory barriers.

What we _could_ do (without changing any existing rules) is to add a
"__test_bit()" that is the relaxed version that doesn't do any of the
volatile etc. That would match the "__"  versions of the other bit
operations.

Then people who know that they use the bits without any volatility issues 
can use that one, and let the compiler optimize more. 

Hmm?

		Linus
