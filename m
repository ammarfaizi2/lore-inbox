Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUFEDfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUFEDfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 23:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUFEDfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 23:35:09 -0400
Received: from ozlabs.org ([203.10.76.45]:12673 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264519AbUFEDe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 23:34:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16577.16335.438208.835040@cargo.ozlabs.ibm.com>
Date: Sat, 5 Jun 2004 13:36:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Colin Leroy <colin@colino.net>, Michel <daenzer@debian.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc2: no more AGP?
In-Reply-To: <1086365839.12665.0.camel@gaston>
References: <20040604174818.03a4f795@jack.colino.net>
	<1086365839.12665.0.camel@gaston>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> On Fri, 2004-06-04 at 10:48, Colin Leroy wrote:
> > Hi,
> > 
> > just a lousy bugreport... I noticed that agpgart doesn't work anymore on
> > 2.6.7-rc2. Xorg reports that AGP isn't supported, and dmesg doesn't show
> > the
> > agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
> > agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
> > 
> > It only shows
> > Linux agpgart interface v0.100 (c) Dave Jones
> > agpgart: Detected Apple UniNorth 2 chipset
> > agpgart: Maximum main memory to use for agp memory: 565M
> > agpgart: configuring for size idx: 4
> > agpgart: AGP aperture is 16M @ 0x0
> 
> Right, something seems broken. I'm also having problems with USB
> sleep & wakeup and with cpufreq. Argh, I've been away from ppc32 for
> too long !

You need this patch.  Michel Daenzer tells me that the
cant_use_aperture check isn't needed.

Paul.

diff -urN linux-2.5/drivers/char/drm/drm_agpsupport.h pmac-2.5/drivers/char/drm/drm_agpsupport.h
--- linux-2.5/drivers/char/drm/drm_agpsupport.h	2004-05-11 13:19:51.000000000 +1000
+++ pmac-2.5/drivers/char/drm/drm_agpsupport.h	2004-05-28 22:21:33.000000000 +1000
@@ -109,8 +109,6 @@
 		return -EBUSY;
 	if (!drm_agp->acquire)
 		return -EINVAL;
-	if ( dev->agp->cant_use_aperture )
-		return -EINVAL;
 	if ((retcode = drm_agp->acquire()))
 		return retcode;
 	dev->agp->acquired = 1;
