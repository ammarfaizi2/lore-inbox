Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268889AbUIMT3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268889AbUIMT3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268892AbUIMT3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:29:10 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:51368 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268889AbUIMT3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:29:01 -0400
Date: Mon, 13 Sep 2004 21:29:00 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix allnoconfig on arm with small tweak to kconfig?
Message-ID: <20040913192900.GC4317@MAIL.13thfloor.at>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <414551FD.4020701@kegel.com> <20040913091534.B27423@flint.arm.linux.org.uk> <4145BB30.60309@kegel.com> <20040913195119.B4658@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913195119.B4658@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 07:51:19PM +0100, Russell King wrote:
> On Mon, Sep 13, 2004 at 08:22:24AM -0700, Dan Kegel wrote:
> > Russell King wrote:
> > > On Mon, Sep 13, 2004 at 12:53:33AM -0700, Dan Kegel wrote:
> > > 
> > >>'make allnoconfig' generates a broken .config on arm because
> > >>none of the boolean CPU types get selected.
> > >>ARCH_RPC *does* get selected ok, and I can make CPU_SA110 the
> > >>default if ARCH_RPC, but that doesn't help, since allnoconfig
> > >>sets all booleans that are exposed to the user to false, so
> > >>CPU_SA110 remains false.
> > > 
> > > 
> > > allnoconfig is broken.  It doesn't generate a legal configuration on
> > > this platform.
> > 
> > I think that's what I said.  I guess you're saying it more forcefully;
> > you seem to be implying "the basic idea of allnoconfig is broken."
> 
> Indeed - we can go around fixing the configuration to work on each
> individual machine type, but... have you checked how many platforms
> there are, and are you volunteering to test the kernel configuration
> for each one?
> 
> I can tell you that, eg, IDE makes sense on SA1100 platform X but
> not Y or Z.  Do we _really_ want to express this level of complexity
> in the kernel configuration?
> 
> On ARM, there are over 500 platform types in the database (ok, not
> all of them are merged or even exist anymore, but that's still a
> substantial number.)  It is obviously completely impossible to rig
> up the Kconfig subsystem such that every platform has a valid
> configuration.
> 
> > I guess it depends on your goals.  My goal is to use allnoconfig
> > as a toolchain regression test.  For each arch, I want an easy way
> > to build some kernel (any kernel!) for that arch.  ARCH_RPC
> > is the default on arm (yes, I know you think the whole
> > concept of defaults on arm is broken), so it's the only one that
> > needs fixing.
> 
> Well, you're going to run into the same problem with Versatile and
> the Integrator class of platforms as well.
> 
> Basically, there's a fair amount of conditions under which Kconfig
> fails to perform reasonably, and these (little used) targets are
> an example of that.
> 
> If you want something that's guaranteed to work, use one of the
> per-platform default configurations.  Nothing else carries any
> guarantee what so ever on ARM.
> 
> (Also, I have no interest in all*config myself so even if someone
> does fix it, chances are it'll get broken again.  I believe that
> the concept of all*config is a fundamentally broken concept for an
> architecture with numerous platform configurations.)

what about providing a reasonable (not necessarily useful)
configuration for a minimal arm setup (maybe for each endianess)
and one for a maximal (read: as many as possible) options
selected which - and this is the important part - are known
and supposed to compile (regardless if they make sense or are
used in actual systems)?

this would allow regression tests, which in turn, might provide
valuable info about the involved subsystems, for both tollchain
and arm folks ...

if this isn't in _your_ interest, then maybe some specific
(considered representative) system defaults can be used instead

best,
Herbert

> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
>                  2.6 Serial core
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
