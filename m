Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265871AbUFDQW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUFDQW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUFDQW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:22:58 -0400
Received: from netline-mail1.netline.ch ([195.141.226.27]:34571 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S265881AbUFDQVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:21:53 -0400
Subject: Re: 2.6.7-rc2: no more AGP?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Colin Leroy <colin@colino.net>
Cc: Benjamin <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sf.net
In-Reply-To: <20040604174818.03a4f795@jack.colino.net>
References: <20040604174818.03a4f795@jack.colino.net>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jun 2004 18:21:48 +0200
Message-Id: <1086366108.4243.117.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-04 at 17:48 +0200, Colin Leroy wrote:
> 
> just a lousy bugreport... I noticed that agpgart doesn't work anymore on
> 2.6.7-rc2. Xorg reports that AGP isn't supported, and dmesg doesn't show
> the
> agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
> 
> It only shows
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected Apple UniNorth 2 chipset
> agpgart: Maximum main memory to use for agp memory: 565M
> agpgart: configuring for size idx: 4
> agpgart: AGP aperture is 16M @ 0x0
> 
> Using 2.6.6, it works fine. 

Paulus brought this up on IRC, it seems to be a bad DRM merge: The code

#ifndef VMAP_4_ARGS
       if ( dev->agp->cant_use_aperture )
               return -EINVAL;
#endif

in DRM(agp_acquire) should be removed altogether in a 2.6 kernel because
its vmap() takes 4 arguments; however, only the guards seem to have been
removed, which causes this function to erroneously fail if the AGP
aperture can't be directly accessed by the CPU.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

