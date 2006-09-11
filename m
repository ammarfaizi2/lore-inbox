Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWIKP3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWIKP3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWIKP3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:29:10 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:25795 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751295AbWIKP3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:29:09 -0400
Date: Mon, 11 Sep 2006 11:27:39 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: i.r.wezeman@hetnet.nl, user-mode-linux-devel@lists.sourceforge.net,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML linux-2.6 latest BK doesn't compile
Message-ID: <20060911152739.GA4443@ccure.user-mode-linux.org>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <200503132106.35599.blaisorblade@yahoo.it> <EBD0B8CF381E8B44BB99E8EA137E27C0021AD010@CPEXBE-EML06.kpnsp.local> <200609091131.36909.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609091131.36909.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 11:31:36AM +0200, Blaisorblade wrote:
> On Saturday 09 September 2006 00:25, i.r.wezeman@hetnet.nl wrote:
> > Hi there.
> > 
> > I got a error undefined reference to `__bb_init_func' when
> > compiling uml with kernel 2.6.17.6, gcc 4.1.1 and glibc-2.4

Happens to me with -rc6.

> Try removing from arch/um/kernel/gmon_syms.c these 2 lines:
> 
> extern void __bb_init_func(void *);
> EXPORT_SYMBOL(__bb_init_func);

And this seems to fix it.

> Better yet, try if adding the weak attribute like below fixes 
> the problem:
> 
> extern void __bb_init_func(void *) __attribute__((weak));
> EXPORT_SYMBOL(__bb_init_func);

And this fixes it even better.

				Jeff
