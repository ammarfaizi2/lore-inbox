Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291271AbSAaU2v>; Thu, 31 Jan 2002 15:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291272AbSAaU2m>; Thu, 31 Jan 2002 15:28:42 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:19979 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S291271AbSAaU2X>;
	Thu, 31 Jan 2002 15:28:23 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jeff Garzik <garzik@havoc.gtf.org>
Date: Thu, 31 Jan 2002 21:27:35 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does not 
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        pavel@atrey.karlin.mff.cuni.cz
X-mailer: Pegasus Mail v3.50
Message-ID: <107F105A2B71@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 02 at 13:47, Jeff Garzik wrote:
> On Thu, Jan 31, 2002 at 02:24:46PM +0100, Petr Vandrovec wrote:
> >     I've got strange idea and tried to build diskless machine around
> > 2.5.3... Besides problem with segfaulting crc32 (it is initialized after 
> > net/ipv4/ipconfig.c due to lib/lib.a being a library... I had to hardcode
> > lib/crc32.o before --start-group in main Makefile, but it is another
> > story)
> 
> Would you be willing to cook up a patch for this problem?
> 
> I ran into this too.  It was solved by setting CONFIG_CRC32=n and
> letting the Makefile rules pull it in...  but lib/lib.a needs to be
> lib/lib.o really.

Unfortunately during conversion I found that there is lib/bust_spinlocks.c,
which is always included in lib.a, is always compiled, even if architecture
provides its own bust_spinlocks function.

As no other module in lib/ uses module_init() initalization, it looks
to me like that we should move crc32.c from lib/ to kernel/, instead of
turning lib.a into lib.o.

But of course if there is consensus that I should convert lib/lib.a
into lib/lib.o, I can either create Config.in symbol 
CONFIG_NEED_GENERIC_BUST_SPINLOCK, or add HAVE_ARCH_BUST_SPINLOCK #define
into some of i386, ia64, mips64, s390 and s390x architecture dependent
headers.
                                        Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
