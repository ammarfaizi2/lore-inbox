Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVHDPKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVHDPKC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVHDPHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:07:30 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:54934 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262559AbVHDPGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:06:38 -0400
Date: Thu, 4 Aug 2005 08:06:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, amitkale@linsyssoft.com
Subject: Re: [patch 07/15] Basic x86_64 support
Message-ID: <20050804150636.GD3337@smtp.west.cox.net>
References: <resend.6.2972005.trini@kernel.crashing.org> <1.2972005.trini@kernel.crashing.org> <resend.7.2972005.trini@kernel.crashing.org> <20050803130531.GR10895@wotan.suse.de> <20050803133756.GA3337@smtp.west.cox.net> <20050804123900.GR8266@wotan.suse.de> <20050804140445.GB3337@smtp.west.cox.net> <20050804140620.GW8266@wotan.suse.de> <20050804141437.GC3337@smtp.west.cox.net> <20050804142806.GX8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804142806.GX8266@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 04:28:06PM +0200, Andi Kleen wrote:
> On Thu, Aug 04, 2005 at 07:14:37AM -0700, Tom Rini wrote:
> > On Thu, Aug 04, 2005 at 04:06:20PM +0200, Andi Kleen wrote:
> > > On Thu, Aug 04, 2005 at 07:04:45AM -0700, Tom Rini wrote:
> > > > On Thu, Aug 04, 2005 at 02:39:00PM +0200, Andi Kleen wrote:
> > > > > > > That doesn't make much sense here. tasklet will only run when interrupts
> > > > > > > are enabled, and that is much later. You could move it to there.
> > > > > > 
> > > > > > Where?  Keep in mind it's really only x86_64 that isn't able to break
> > > > > > sooner.
> > > > > 
> > > > > The local_irq_enable() call in init/main.c:start_kernel()
> > > > 
> > > > But as I say, only x86_64 needs this kind of delay.
> > > 
> > > I don't think that's correct. Interrupts should be disabled on all
> > > architectures until that.
> > 
> > Right, but we can run sooner elsewhere.  It's only x86_64 where we can't
> > run when our commandline bits are parsed and need to wait.
> 
> Why can't you run on x86-64 early? 

As I said earlier:
"
> If you want to run gdb earlier you need to do it without a tasklet.

We really would like to try again once stacks are setup (IOW, once
if ((&__get_cpu_var(init_tss))[0].ist[0])) is true).
"

IOW, when we parse the params on x86_64 this isn't true (or rather it
wasn't true as of 2.6.9'ish, if this has changed I'd be glad to retest
things).

-- 
Tom Rini
http://gate.crashing.org/~trini/
