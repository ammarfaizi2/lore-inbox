Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266661AbUHSQ1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266661AbUHSQ1h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUHSQ1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:27:37 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6348 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266661AbUHSQ1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:27:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16676.54504.957712.269455@alkaid.it.uu.se>
Date: Thu, 19 Aug 2004 18:27:20 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Corey Minyard <minyard@acm.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch to 2.6.8.1-mm2 to allow multiple NMI handlers to be registered
In-Reply-To: <4124D25C.20703@acm.org>
References: <4124BACB.30100@acm.org>
	<16676.51035.924323.992044@alkaid.it.uu.se>
	<4124D25C.20703@acm.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard writes:
 > > > +	/* 
 > > > +	 * If the timer has overflowed, this is certainly a watchdog
 > > > +	 * source
 > > > +	 */
 > > > +	source = (low & (1 << 31)) == 0;
 > > > +	if (source)
 > >
 > >Why not "if ((int)low >= 0)"?
 > >  
 > >
 > IIRC, the docs state that timer goes off if the high bit is cleared in 
 > the register.  I was just going with the documentation description.  Not 
 > a big deal either way, I don't think.

Which is the same as saying it occurs on the negative-to-non-negative
transition. The "if ((int)low >= 0)" test is just a test and branch
on sign, while your original requires either a (microcoded?) bit op,
or constructing a large-magnitude mask, followed by some tests.

Yes this is a micro-optimisation, but I find it actually simplifies the code.

/Mikael
