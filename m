Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUAHPhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUAHPhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:37:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36076 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265127AbUAHPhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:37:03 -0500
Date: Thu, 8 Jan 2004 16:36:56 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, dri-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.1-rc2-mm1: drm/sis_mm.c compile error
Message-ID: <20040108153656.GF13867@fs.tum.de>
References: <20040107232831.13261f76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107232831.13261f76.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 11:28:31PM -0800, Andrew Morton wrote:
>...
> - Added the latest code drop from DRM CVS.  People who use DRM, please test
>   it.
>...

I got the following compile error:

<--  snip  -->

...
  CC      drivers/char/drm/sis_mm.o
drivers/char/drm/sis_mm.c:37:25: linux/sisfb.h: No such file or directory
drivers/char/drm/sis_mm.c: In function `sis_fb_alloc':
drivers/char/drm/sis_mm.c:92: error: storage size of `req' isn't known
drivers/char/drm/sis_mm.c:98: warning: implicit declaration of function `sis_malloc'
drivers/char/drm/sis_mm.c:105: warning: implicit declaration of function `sis_free'
drivers/char/drm/sis_mm.c:92: warning: unused variable `req'
make[3]: *** [drivers/char/drm/sis_mm.o] Error 1

<--  snip  -->


This is caused by the following part of the patch to sis_mm.c:


--- linux-2.6.1-rc2/drivers/char/drm/sis_mm.c	2003-09-27 18:57:44.000000000 -0700
+++ 25/drivers/char/drm/sis_mm.c	2004-01-07 22:17:56.000000000 -0800
@@ -34,7 +34,7 @@
 #include "sis_drv.h"
 #include "sis_ds.h"
 #if defined(__linux__) && defined(CONFIG_FB_SIS)
-#include <video/sisfb.h>
+#include <linux/sisfb.h>
 #endif
 
 #define MAX_CONTEXT 100


Reverting this chunk fixes the compilation.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

