Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTI2TXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTI2TXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:23:17 -0400
Received: from havoc.gtf.org ([63.247.75.124]:54707 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264546AbTI2TXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:23:14 -0400
Date: Mon, 29 Sep 2003 15:23:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Brian Gerst <bgerst@didntduck.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 do_machine_check() is redundant.
Message-ID: <20030929192307.GA24740@gtf.org>
References: <1064775868.5045.4.camel@laptop.fenrus.com> <Pine.LNX.4.44.0309291142430.3626-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309291142430.3626-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 11:46:12AM -0700, Linus Torvalds wrote:
> Has anybody checked out whether the kernel works with -mregparm=3? I
> forget who did a lot of the work on it originally, and it certainly _used_
> to work fine. The improvements to both code size and performance were, if 
> I remember correctly, measurable but not huge.

That jibes with what I would expect (I missed the older threads, but
was nonetheless toying with this idea myself)...

Function arguments on the stack are likely to be in L1 cache anyway,
so accessing arguments is already pretty cheap.  And storing the
parameters in registers might increase the number of spills slightly,
for cases, where an argument isn't used much, or at all.

Ideally unit-at-a-time could figure out the optimal -mregparm value :)


> One worry (apart from just broken compilers and missing "asmlinkage" 
> annotations) is that having compiler-version-dependent calling conventions 
> makes for another variable to take into account when chasing down bugs and 
> worrying about things like the Nvidia module etc. So it's probably not 
> worth doing unless the advantages are clear.

Well...  even with completely open source, you're never gonna have a
working system with modules built using compiler versions and options
that differ from the main kernel image.  In the past, changing compiler
versions would definitely affect the module interfaces adversely.

So while I agree with your overall conservatism, worrying about
supporting miscompiled modules is the road to Hades...

	Jeff



