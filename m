Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSHMIfc>; Tue, 13 Aug 2002 04:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSHMIfc>; Tue, 13 Aug 2002 04:35:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63505 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313060AbSHMIfb>;
	Tue, 13 Aug 2002 04:35:31 -0400
Message-ID: <3D58C81D.4DAA3FBE@zip.com.au>
Date: Tue, 13 Aug 2002 01:49:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] __func__ -> __FUNCTION__
References: <3D58A45F.A7F5BDD@zip.com.au> <20020813092043.A1859@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Mon, Aug 12, 2002 at 11:17:03PM -0700, Andrew Morton wrote:
> >
> > It is a requirement of the SPARC port that Linux be compilable
> > by egcs-1.1.2, aka gcc-2.91.66.
> >
> > That compiler does not support __func__.
> 
> Is there any reason to not use __FUNCTION__?  According to the gcc folks
> that there is no plan to retire it, and as long as all known-good kernel
> compilers support it a gccism is a lot better than a standard feature that
> is not supported by most of the kernel compilers.

Sounds fine to me.

--- linux-2.5.31/include/linux/kernel.h	Wed Jul 24 14:31:31 2002
+++ 25/include/linux/kernel.h	Tue Aug 13 01:48:36 2002
@@ -13,6 +13,8 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 
+#define __func__ use.__FUNCTION__.not.__func__
+
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
 #define barrier() __asm__ __volatile__("": : :"memory")

It affects

drivers/char/drm/mga_dma.c
drivers/char/drm/mga_drv.h
drivers/char/drm/mga_state.c
drivers/char/drm/r128_cce.c
drivers/char/drm/r128_drv.h
drivers/char/drm/r128_state.c
drivers/char/drm/radeon_cp.c
drivers/char/drm/radeon_drv.h
drivers/char/drm/radeon_state.c
include/net/bluetooth/bluetooth.h
