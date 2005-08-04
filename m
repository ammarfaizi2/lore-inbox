Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVHDTIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVHDTIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVHDTIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:08:49 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:43701 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262593AbVHDTIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:08:49 -0400
Date: Thu, 4 Aug 2005 12:08:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, amitkale@linsyssoft.com
Subject: Re: [patch 07/15] Basic x86_64 support
Message-ID: <20050804190847.GF3337@smtp.west.cox.net>
References: <resend.7.2972005.trini@kernel.crashing.org> <20050803130531.GR10895@wotan.suse.de> <20050803133756.GA3337@smtp.west.cox.net> <20050804123900.GR8266@wotan.suse.de> <20050804140445.GB3337@smtp.west.cox.net> <20050804140620.GW8266@wotan.suse.de> <20050804141437.GC3337@smtp.west.cox.net> <20050804142806.GX8266@wotan.suse.de> <20050804150636.GD3337@smtp.west.cox.net> <20050804185632.GD8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804185632.GD8266@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 08:56:32PM +0200, Andi Kleen wrote:
> On Thu, Aug 04, 2005 at 08:06:36AM -0700, Tom Rini wrote:
> > > 
> > > Why can't you run on x86-64 early? 
> > 
> > As I said earlier:
> > "
> > > If you want to run gdb earlier you need to do it without a tasklet.
> > 
> > We really would like to try again once stacks are setup (IOW, once
> > if ((&__get_cpu_var(init_tss))[0].ist[0])) is true).
> > "
> > 
> > IOW, when we parse the params on x86_64 this isn't true (or rather it
> > wasn't true as of 2.6.9'ish, if this has changed I'd be glad to retest
> > things).
> 
> The ISTs are set up for the boot processor extremly early - even
> before start_kernel. But they are useless before trap_init()
> runs because you won't get any exceptions that need an IDT (or rather
> they will all still point to the early exception handler that just panics) 

I wonder if there was a reason we couldn't do what we did with i386 and
make an early_trap_init() so that we can get what we care about that
early at least.  I'll have to poke at this a bit more, thanks!

-- 
Tom Rini
http://gate.crashing.org/~trini/
