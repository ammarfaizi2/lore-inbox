Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132513AbRDUGzF>; Sat, 21 Apr 2001 02:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDUGyz>; Sat, 21 Apr 2001 02:54:55 -0400
Received: from puffin.external.hp.com ([192.25.206.4]:60175 "EHLO
	puffin.external.hp.com") by vger.kernel.org with ESMTP
	id <S132513AbRDUGyp>; Sat, 21 Apr 2001 02:54:45 -0400
Message-Id: <200104210648.AAA01233@puffin.external.hp.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention? 
In-Reply-To: Your message of "Fri, 20 Apr 2001 15:47:43 EDT."
             <20010420154743.A19618@thyrsus.com> 
Date: Sat, 21 Apr 2001 00:48:19 -0600
From: Grant Grundler <grundler@puffin.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> Here's what I have for you guys:

...
> CONFIG_DMB_TRAP: arch/parisc/kernel/sba_iommu.c
> CONFIG_FUNC_SIZE: arch/parisc/kernel/sba_iommu.c
> 
> Would you please take these out of the CONFIG_ namespace?  Changing the 
> prefix to CONFIGURE would do nicely.

As willy noted, both mine. I'll remove or rename them rename them so
they aren't in the CONFIG_ name space. Probably s/CONFIG_/SBA_/ for
those two.

I'm going to submit a "wishlist" bug to our debian BTS
(bugs.parisc-linux.org) for "Data Memory Break Trap" support.
It's a damn good Hammer! :^)
(GDB will probably want to use this too)

I once had a working "Data Memory Break Trap" handler to catch other
parts of the kernel when they corrupted the IO Pdirs. Hooks in sba_ccio.c
helped mark which pages would trap and define which code was allowed to
touch the page. My implementation had issues and I never bothered to
re-implement as suggested by our parisc CPU god, John Marvin.

CONFIG_FUNC_SIZE is just a bad choice of name (asking for trouble).
One might consider this a bug that hasn't happened yet - thanks Eric!

#define CONFIG_FUNC_SIZE 4096   /* SBA configuration function reg set */


> CONFIG_KWDB: arch/parisc/Makefile arch/parisc/config.in arch/parisc/defconfig
>    arch/parisc/kernel/entry.S arch/parisc/kernel/traps.c arch/parisc/mm/init.
>   c

This ones actually mine too. It could be replaced with the SGI debugger
CONFIG option if/when that ever gets supported. The hooks will have to
be in the same place. I'm pretty sure now the HP KWBD team will never give me
permission to publish KWDB sources (they've had almost a year now).
I sorta almost had the damn thing working too...*sigh*.
Willy should do whatever he thinks is right in this case.

> CONFIG_PCI_LBA: arch/parisc/config.in arch/parisc/defconfig arch/parisc/kerne
>   l/Makefile
...
> Looks like these need Configure.help entries.

That's mine too.
We've been lazy about documentation since the getting the code working
has been a higher priority.  I think having them documented will be a
prerequisite to merging upstream (either to Alan Cox or Linus).

thanks,
grant

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
