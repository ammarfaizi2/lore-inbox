Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUEPDot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUEPDot (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 23:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUEPDot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 23:44:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:43689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262756AbUEPDos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 23:44:48 -0400
Date: Sat, 15 May 2004 20:44:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
cc: Andrew Morton <akpm@osdl.org>, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
In-Reply-To: <Pine.LNX.4.58.0405151914280.10718@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0405152029110.10718@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com>
 <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14> <20040514204153.0d747933.akpm@osdl.org>
 <200405151923.41353.elenstev@mesatop.com> <Pine.LNX.4.58.0405151914280.10718@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 May 2004, Linus Torvalds wrote:
> 
> 
> On Sat, 15 May 2004, Steven Cole wrote:
> > 
> > In the spirit of 'rounding up the usual suspects', I'll unset CONFIG_PREEMT
> > and try again.
> 
> Or it could be any number of other config options. Do you have anything 
> else interesting enabled?

Ahh, looking at an earlier email I see that you have CONFIG_REGPARM=y too.

That could easily be pretty dangerous - there have been both compiler bugs
in this area, and just kernel bugs (missing "asmlinkage" things causing
bad calling conventions and really nasty bugs).

So please try without both PREEMPT and REGPARM. Considering that it's
apparently very repeatable for you, I'd be more inclined to worry about 
REGPARM than PREEMPT, but it's best to try with both disabled.

I also worry about that PDC202XX controller, but that 1352 is a strange
number (divisible by 8, but not by a cacheline or 512-byte sector or
something like that), so it doesn't _sound_ like something like DMA
failure or chipset programming, but who the hell knows..

		Linus
