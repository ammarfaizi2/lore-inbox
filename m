Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVKWBnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVKWBnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVKWBnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:43:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56032 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965077AbVKWBnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:43:09 -0500
Date: Tue, 22 Nov 2005 17:43:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@osdl.org>, jeffrey.hundstad@mnsu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc2
In-Reply-To: <20051123013244.GA3585@muc.de>
Message-ID: <Pine.LNX.4.64.0511221739380.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <43829ED2.3050003@mnsu.edu>
 <20051122150002.26adf913.akpm@osdl.org> <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
 <20051122170507.37ebbc0c.akpm@osdl.org> <20051123013244.GA3585@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Nov 2005, Andi Kleen wrote:
> 
> > 
> > No trivial fix was apparent - perhaps we should disable the compat wrappers
> > if CONFIG_EXT3=n and/or CONFIG_JBD=n.
> 
> That's already done for a lot of other wrappers, so would be fine too

That may be the right thing, but looking at compat-ioctl.c I don't see 
anything that really depends on ext3, it just wants to have the data 
structure definitions in _case_ ext3 migth be enabled. Or did I miss 
anything?

In general, I don't like code that depends on a module having been marked 
as a module. What if you compile the kernel and then decide later that you 
need the jbd/ext3 modules, so you compile and install those on an already 
running kernel? 

So almost all "#ifdef CONFIG_xyzzy_MODULE" usages tend to be fundamentally 
buggy: they expect all modules to come pre-configured, which may be ok for 
a distro kernel, but it's a bit against the whole point of being a module, 
isn't it?

		Linus
