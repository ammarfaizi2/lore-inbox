Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263799AbVBDXbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbVBDXbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbVBDXbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:31:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:28385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S264147AbVBDXbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:31:06 -0500
Subject: Re: 2.6.11-rc3-mm1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1107553914.14618.12.camel@cherrypit.pdx.osdl.net>
References: <20050204103350.241a907a.akpm@osdl.org>
	 <1107549858.14618.2.camel@cherrypit.pdx.osdl.net>
	 <20050204131325.542c610c.akpm@osdl.org>
	 <1107553914.14618.12.camel@cherrypit.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 15:31:45 -0800
Message-Id: <1107559905.14618.23.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 13:51 -0800, John Cherry wrote:
> On Fri, 2005-02-04 at 13:13 -0800, Andrew Morton wrote:
> > John Cherry <cherry@osdl.org> wrote:
> > >
> > >  Errors in the build relate to an undefined reference to
> > >  "randomize_va_space"...
> > > 
> > >    LD      init/built-in.o
> > >    LD      .tmp_vmlinux1
> > >  arch/i386/kernel/built-in.o(.text+0xf92): In function `arch_align_stack':
> > >  : undefined reference to `randomize_va_space'
> > >  make: [.tmp_vmlinux1] Error 1 (ignored)
> > 
> > hm.  You must have CONFIG_SYSCTL=n?
> > 
> > I'll fix that up.
> 
> CONFIG_SYSCTL=n in the allnoconfig build, which I would expect.
>  
> http://developer.osdl.org/cherry/compile/2.6/linux-2.6.11-rc3-mm1.results/2.6.11-rc3-mm1.allnoconfig.bzImage.txt
> 
> However, CONFIG_SYSCTL=y in the defconfig with similar errors...
> 
> http://developer.osdl.org/cherry/compile/2.6/linux-2.6.11-rc3-mm1.results/2.6.11-rc3-mm1.defconfig.bzImage.txt

The errors in the defconfig build (with CONFIG_SYSCTL=y) are unrelated
to the undefined reference found in the allnoconfig build.  The errors
in this build are..

kernel/power/swsusp.c: In function `alloc_pagedir':
kernel/power/swsusp.c:608: sorry, unimplemented: inlining failed in call to 'free_pagedir': function body not available
kernel/power/swsusp.c:646: sorry, unimplemented: called from here
make[2]: [kernel/power/swsusp.o] Error 1 (ignored)

Adrian Bunk has submitted a patch for this.

> 
> I suspect the problem may be fixed with Frank Sorenson's patch.  I'll
> kick off a rebuild with his patch and see what happens.

Frank's patch did not fix the undefined reference to randomize_va_space.
I suspect it is a CONFIG_SYSCTL=n problem as well since it only appears
in the allnoconfig build.

John

> 
> John
> 
> -------------------------------------------------------------------
> 
> The stack randomization patches that went into 2.6.11-rc3-mm1 broke 
> compilation of ARCH=um.  This patch fixes compiling by adding 
> arch_align_stack back in.
> 
> Signed-off-by: Frank Sorenson <frank@tuxrocks.com>
> Acked-By: Jeff Dike <jdike@addtoit.com>
> 
> Frank
> 
> <patch removed>
> 

