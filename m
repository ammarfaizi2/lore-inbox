Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUH1VHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUH1VHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267977AbUH1VHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:07:15 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:54664 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267891AbUH1VFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:05:44 -0400
Date: Sat, 28 Aug 2004 22:05:33 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm Kconfig fixes
Message-ID: <20040828210533.GD6301@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408280309.i7S39PPv000756@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408280309.i7S39PPv000756@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 02:13:44AM +0000, Linux Kernel wrote:
 > ChangeSet 1.1892, 2004/08/27 19:13:44-07:00, viro@www.linux.org.uk
 > 
 > 	[PATCH] arm Kconfig fixes
 > 	
 > 	ARM dependency and makefile fixes (ACKed by rmk)
 > 	
 > diff -Nru a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
 > --- a/drivers/char/agp/Kconfig	2004-08-27 20:09:34 -07:00
 > +++ b/drivers/char/agp/Kconfig	2004-08-27 20:09:34 -07:00
 > @@ -1,5 +1,5 @@
 >  config AGP
 > -	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU && !M68K
 > +	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU && !M68K && !ARM
 >  	default y if GART_IOMMU
 >  	---help---
 >  	  AGP (Accelerated Graphics Port) is a bus system mainly used to

This has the opportunity to grow and grow and make things really ugly
in all the driver specific Kconfigs each time a new arch switches
over to use drivers/Kconfig.  Is this really any better than doing
this checking in drivers/Kconfig itself and keeping the subdir'd kconfig's
somewhat cleaner ?

Even if not,  I think I'd actually prefer a whitelist of drivers that *do*
support agpgart in the Kconfig, than the above which needs to be added to
all the time.  Something like if X86 && ALPHA && IA64 should cover it currently.
It just seems to me to be a lot more sensible than listing a bunch
of stuff which is completely irrelevant.

		Dave

