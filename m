Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265846AbUATWOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbUATWOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:14:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:57498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265846AbUATWOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:14:15 -0500
Subject: Re: 2.6.1-mm5 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20040120215705.GG12027@fs.tum.de>
References: <20040120000535.7fb8e683.akpm@osdl.org>
	 <1074614919.31724.0.camel@cherrypit.pdx.osdl.net>
	 <20040120215705.GG12027@fs.tum.de>
Content-Type: text/plain
Message-Id: <1074636910.16765.14.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 20 Jan 2004 14:15:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 13:57, Adrian Bunk wrote:
> On Tue, Jan 20, 2004 at 08:08:40AM -0800, John Cherry wrote:
> 
> > The patch for better i386 CPU selection still impacts the allnoconfig
> > build.
> > In this case, there is no default CPU.  Kconfig patches should be tested
> > against defconfig, allnoconfig, allyesconfig, and allmodconfig.
> >...
> 
> I'm testing all my patches with both a complete non-modular and a 
> completely modular .config [1], and additionally I mix these testings 
> with using CONFIG_SMP=n and/or using gcc 2.95 which often find even more 
> problems.
> 
> Regarding defconfig:
> Although several options were added and/or changed, there was not a 
> single update to the i386 defconfig since August last year.
> Below is a patch that updates defconfig for 2.6.1-mm5.

Thanks for the patch.  I realize that defconfig is just ONE
configuration that can be built, but it has been used for a couple years
in automated build regressions.  And, it actually boots on a number of
desktop computers!

> 
> Regarding allnoconfig:
> allnoconfig is a completely pathological case. It says "n" to support 
> for ISA, MCA and PCI, and neither networking nor any block devices.
> Besides, it says "n" to ELF, a.out and other binary formats.
> Demanding that allnoconfig should compile (although the resulting kernel 
> is completely useless) sounds a bit like demanding that no change in the 
> kernel is allowed to cause regressions in the dbench results...
> It is useful to omit a common option like e.g. PCI and check whether the 
> kernel still compiles, but allnoconfig removes nearly everything and 
> compiles such a small part of the kernel, that it's hardly useful.

I realize that allnoconfig is pathological, but it has caught several
config errors.  One would never try to boot from such a config.  Builds
based on allnoconfig have one purpose and that purpose is to validate
that defines are not used in cases where they are NOT defined in the
configuration.  Developers will quite often code a feature or
architecture with the config parameters always ON.  When the config
option is turned OFF, I will find compile errors, undefined variables,
and the like. This is actually quite a valuable screen.

If developers feel that this has outlived its usefulness, I'll remove it
from the compile regressions.  However, all I have received at this
point have been requests to put an allnoconfig build into the
regressions.

John



