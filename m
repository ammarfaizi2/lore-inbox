Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265955AbUFDTja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUFDTja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUFDTja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:39:30 -0400
Received: from [82.228.82.76] ([82.228.82.76]:3826 "EHLO
	paperstreet.colino.net") by vger.kernel.org with ESMTP
	id S265955AbUFDTj0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:39:26 -0400
Date: Fri, 4 Jun 2004 21:39:07 +0200
From: Colin Leroy <colin@colino.net>
To: akpm@asdl.org
Cc: Michel D_nzer <michel@daenzer.net>, Benjamin <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sf.net
Subject: [PATCH] 2.6.7-rc2: fix agpgart
Message-Id: <20040604213907.395b01aa@jack.colino.net>
In-Reply-To: <1086366108.4243.117.camel@localhost>
References: <20040604174818.03a4f795@jack.colino.net>
	<1086366108.4243.117.camel@localhost>
Organization: 
X-Mailer: Sylpheed version 0.9.10claws67.4 (GTK+ 2.4.0; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Jun 2004 at 18h06, Michel Dänzer wrote:

Hi, 

> Paulus brought this up on IRC, it seems to be a bad DRM merge: The
> code
> 
> #ifndef VMAP_4_ARGS
>        if ( dev->agp->cant_use_aperture )
>                return -EINVAL;
> #endif
> 
> in DRM(agp_acquire) should be removed altogether in a 2.6 kernel
> because its vmap() takes 4 arguments; however, only the guards seem to
> have been removed, which causes this function to erroneously fail if
> the AGP aperture can't be directly accessed by the CPU.

Looks like. Removing it fixes the problem. Here's the patch...
Signed-off-by: Colin Leroy <colin@colino.net>

--- a/drivers/char/drm/drm_agpsupport.h	2004-06-04 17:44:23.000000000 +0200
+++ b/drivers/char/drm/drm_agpsupport.h	2004-06-04 21:01:03.000000000 +0200
@@ -109,8 +109,6 @@
 		return -EBUSY;
 	if (!drm_agp->acquire)
 		return -EINVAL;
-	if ( dev->agp->cant_use_aperture )
-		return -EINVAL;
 	if ((retcode = drm_agp->acquire()))
 		return retcode;
 	dev->agp->acquired = 1;
