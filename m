Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUHDLO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUHDLO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 07:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUHDLO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 07:14:26 -0400
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:1750 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264923AbUHDLOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 07:14:08 -0400
From: Eric Bambach <eric@cisu.net>
Reply-To: eric@cisu.net
To: Jens Axboe <axboe@suse.de>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Date: Wed, 4 Aug 2004 06:14:30 -0500
User-Agent: KMail/1.6.2
Cc: Con Kolivas <kernel@kolivas.org>, "Barry K. Nathan" <barryn@pobox.com>,
       Steve Snyder <swsnyder@insightbb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408021602.34320.swsnyder@insightbb.com> <410FA145.70701@kolivas.org> <20040804060625.GE10340@suse.de>
In-Reply-To: <20040804060625.GE10340@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408040614.30820.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 August 2004 01:06 am, Jens Axboe wrote:
> On Wed, Aug 04 2004, Con Kolivas wrote:
> > Jens Axboe wrote:
> > >On Mon, Aug 02 2004, Barry K. Nathan wrote:
> > >>On Mon, Aug 02, 2004 at 04:02:34PM -0500, Steve Snyder wrote:
> > >>>There seems to be a controversy about the use of the CONFIG_HIGHMEM4G
> > >>>kernel configuration.  After reading many posts on the subject, I
> > >>> still don't know which setting is best for me.
> >
> > No idea what the performance hit is of highmem these days - it seems
> > insignificant compared to 2.4 so I've had it enabled for 1Gb ram.
> >
> > >There's also the option of moving the mapping only slightly, so that all
> > >of the 1G fits in low memory. That's the best option for 1G desktop
> > >machines, imho. Changing PAGE_OFFSET from 0xc0000000 to 0xb0000000 would
> > >probably be enough.
> > >
> > >Then you can have your cake and eat it too.
> >
> > Something like this attached patch? Seems to work nicely. Thanks!
> >
> > Cheers,
> > Con
> >
> > Index: linux-2.6.8-rc2-mm2/arch/i386/kernel/vmlinux.lds.S
> > ===================================================================
> > --- linux-2.6.8-rc2-mm2.orig/arch/i386/kernel/vmlinux.lds.S	2004-05-23
> > 12:54:46.000000000 +1000 +++
> > linux-2.6.8-rc2-mm2/arch/i386/kernel/vmlinux.lds.S	2004-08-04
> > 00:20:02.219462913 +1000 @@ -11,7 +11,7 @@
> >  jiffies = jiffies_64;
> >  SECTIONS
> >  {
> > -  . = 0xC0000000 + 0x100000;
> > +  . = 0xB0000000 + 0x100000;
> >    /* read-only */
> >    _text = .;			/* Text and read-only data */
> >    .text : {
> > Index: linux-2.6.8-rc2-mm2/include/asm-i386/page.h
> > ===================================================================
> > --- linux-2.6.8-rc2-mm2.orig/include/asm-i386/page.h	2004-08-03
> > 01:29:28.000000000 +1000 +++
> > linux-2.6.8-rc2-mm2/include/asm-i386/page.h	2004-08-03 23:58:16.000000000
> > +1000 @@ -123,9 +123,9 @@
> >  #endif /* __ASSEMBLY__ */
> >
> >  #ifdef __ASSEMBLY__
> > -#define __PAGE_OFFSET		(0xC0000000)
> > +#define __PAGE_OFFSET		(0xB0000000)
> >  #else
> > -#define __PAGE_OFFSET		(0xC0000000UL)
> > +#define __PAGE_OFFSET		(0xB0000000UL)
> >  #endif
>
> Yup precisely. I agree that there probably isn't a whole lot of
> performance hit on a 1GB, it just seems silly that we need highmem on
> such a standard memory configuration these days. Especially when just
> moving the offset slightly removes that need.

As a desktop user with 1024MB ram I agree that HIMEM has a silly threshold and 
should not need to be enabled in this case. Its becoming common, especially 
with dual channel memory systems to use 2x512MB sticks. On a hunch I bet 
2x512 is more common that 1x512 and 1x256 so why not merge this up? Who would 
we submit this patch to?
-- 

-EB
