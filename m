Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291279AbSAaUbb>; Thu, 31 Jan 2002 15:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291278AbSAaUbX>; Thu, 31 Jan 2002 15:31:23 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:31878 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291277AbSAaUbS>;
	Thu, 31 Jan 2002 15:31:18 -0500
Date: Thu, 31 Jan 2002 15:31:15 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        pavel@atrey.karlin.mff.cuni.cz
Subject: Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does not
Message-ID: <20020131153115.A5370@havoc.gtf.org>
In-Reply-To: <107F105A2B71@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <107F105A2B71@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Jan 31, 2002 at 09:27:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 09:27:35PM +0100, Petr Vandrovec wrote:
> On 31 Jan 02 at 13:47, Jeff Garzik wrote:
> > On Thu, Jan 31, 2002 at 02:24:46PM +0100, Petr Vandrovec wrote:
> > >     I've got strange idea and tried to build diskless machine around
> > > 2.5.3... Besides problem with segfaulting crc32 (it is initialized after 
> > > net/ipv4/ipconfig.c due to lib/lib.a being a library... I had to hardcode
> > > lib/crc32.o before --start-group in main Makefile, but it is another
> > > story)
> > 
> > Would you be willing to cook up a patch for this problem?
> > 
> > I ran into this too.  It was solved by setting CONFIG_CRC32=n and
> > letting the Makefile rules pull it in...  but lib/lib.a needs to be
> > lib/lib.o really.
> 
> Unfortunately during conversion I found that there is lib/bust_spinlocks.c,
> which is always included in lib.a, is always compiled, even if architecture
> provides its own bust_spinlocks function.

Yep


> As no other module in lib/ uses module_init() initalization, it looks
> to me like that we should move crc32.c from lib/ to kernel/, instead of
> turning lib.a into lib.o.

Having lib.a is really a special case, and we can easily fix that by
fixing bust_spinlocks, not by moving what is truly a library routine to
somewhere other than lib/


> But of course if there is consensus that I should convert lib/lib.a
> into lib/lib.o, I can either create Config.in symbol 
> CONFIG_NEED_GENERIC_BUST_SPINLOCK, or add HAVE_ARCH_BUST_SPINLOCK #define
> into some of i386, ia64, mips64, s390 and s390x architecture dependent
> headers.

Implementing HAVE_ARCH_BUST_SPINLOCK would follow kernel convention
quite nicely...

	Jeff


