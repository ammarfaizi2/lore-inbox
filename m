Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316234AbSEKQlq>; Sat, 11 May 2002 12:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316236AbSEKQlp>; Sat, 11 May 2002 12:41:45 -0400
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:11915 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S316234AbSEKQln>;
	Sat, 11 May 2002 12:41:43 -0400
Date: Sat, 11 May 2002 12:41:24 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: george anzinger <george@mvista.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2
Message-ID: <20020511164124.GA13642@nevyn.them.org>
Mail-Followup-To: george anzinger <george@mvista.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205101538400.25826-100000@penguin.transmeta.com> <3CDC6906.B0288387@mvista.com> <20020511092935.A16828@flint.arm.linux.org.uk> <3CDD324E.4E1C4FB6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 08:01:34AM -0700, george anzinger wrote:
> Russell King wrote:
> > 
> > On Fri, May 10, 2002 at 05:42:46PM -0700, george anzinger wrote:
> > > diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/arm/vmlinux-armo.lds.in linux/arch/arm/vmlinux-armo.lds.in
> > > --- linux-2.5.14-org/arch/arm/vmlinux-armo.lds.in     Tue May  7 15:59:35 2002
> > > +++ linux/arch/arm/vmlinux-armo.lds.in        Fri May 10 17:07:31 2002
> > > @@ -4,6 +4,7 @@
> > >   */
> > >  OUTPUT_ARCH(arm)
> > >  ENTRY(stext)
> > > +jiffies = jiffies_64 + 4;
> > >  SECTIONS
> > >  {
> > >       . = TEXTADDR;
> > > diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/arm/vmlinux-armv.lds.in linux/arch/arm/vmlinux-armv.lds.in
> > > --- linux-2.5.14-org/arch/arm/vmlinux-armv.lds.in     Tue May  7 15:59:35 2002
> > > +++ linux/arch/arm/vmlinux-armv.lds.in        Fri May 10 17:07:34 2002
> > > @@ -4,6 +4,7 @@
> > >   */
> > >  OUTPUT_ARCH(arm)
> > >  ENTRY(stext)
> > > +jiffies = jiffies_64 + 4;
> > >  SECTIONS
> > >  {
> > >       . = TEXTADDR;
> > 
> > Eurgh.  This seems to be a popular misconception.  What makes you think
> > ARM is big endian, or was it just a guess?
> > 
> 
> >From byteorder.h:
> 
> #ifdef __ARMEB__
> #include <linux/byteorder/big_endian.h>
> #else
> #include <linux/byteorder/little_endian.h>
> #endif
> 
> So, yes, given no hints on who or what configures __ARMEB__.  Is it always little endian?

The compiler does; that's true of most __*__ macros used in the kernel. 
If you build a big-endian compiler, you'll get __ARMEB__.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
