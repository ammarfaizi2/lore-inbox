Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUIUTmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUIUTmH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUIUTmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:42:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:27371 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268025AbUIUTmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:42:03 -0400
Date: Tue, 21 Sep 2004 12:41:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <roland@topspin.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
In-Reply-To: <523c1bpghm.fsf@topspin.com>
Message-ID: <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
References: <1095758630.3332.133.camel@gaston> <1095761113.30931.13.camel@localhost.localdomain>
 <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Sep 2004, Roland Dreier wrote:
>
> Is it possible to use __raw_*() in portable code?  I have some places
> in my code where non-byte-swap IO functions would be useful, but on
> ppc64, __raw_*() doesn't know about EEH.

I don't think normal readb/writeb should know about EEH either. If you 
want error handling, there's a separate interface being worked on, so that 
normal accesses don't have to pay the cost..

> Clearly I don't want to
> teach portable code about IO_TOKEN_TO_ADDR etc. so it seems I'm out of
> luck.  I end up doing the fairly insane:
> 
> 	writel(swab32(val), addr);

Ok, so that _is_ insane. Mind telling what kind of insane hardware is BE 
in this day and age?

That said, I think

> instead of what I really mean, which is:
> 
> 	__raw_writel(cpu_to_be32(val), addr);

should work, and if you start using it, and the driver is relevant, I'm 
sure other architectures will implement the __raw_ interfaces too. In the 
meantime, please just make it conditional on the proper architectures.

		Linus
