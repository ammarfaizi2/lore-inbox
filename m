Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUFZTNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUFZTNX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 15:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266387AbUFZTNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 15:13:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:59522 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266386AbUFZTNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 15:13:20 -0400
Date: Sat, 26 Jun 2004 21:13:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040626191320.GA3850@ucw.cz>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <1088268405.1942.25.camel@mulgrave> <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org> <1088270298.1942.40.camel@mulgrave> <Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org> <20040626182820.GA3723@ucw.cz> <Pine.LNX.4.58.0406261140360.16079@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406261140360.16079@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 11:54:24AM -0700, Linus Torvalds wrote:

> On Sat, 26 Jun 2004, Vojtech Pavlik wrote:
> > 
> > At least input pretty much relies on the fact that bitops don't need
> > locking and act as memory barriers.
> 
> Well, plain test_bit() has always been more relaxed than the others, and
> has never implied a memory barrier. Only the "test_and_set/clear()" things
> imply memory barriers.

Ouch. I'll have to revisit some code then.

> What we _could_ do (without changing any existing rules) is to add a
> "__test_bit()" that is the relaxed version that doesn't do any of the
> volatile etc. That would match the "__"  versions of the other bit
> operations.
> 
> Then people who know that they use the bits without any volatility issues 
> can use that one, and let the compiler optimize more. 
> 
> Hmm?
 
That makes a lot of sense to me, as we already have the __ variants for
most of the other bitops already.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
