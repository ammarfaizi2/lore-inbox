Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUAHSd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUAHSd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:33:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:52430 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263923AbUAHSdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:33:55 -0500
Date: Thu, 8 Jan 2004 10:34:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc2-mm1: drm/sis_mm.c compile error
Message-Id: <20040108103404.1a90d34f.akpm@osdl.org>
In-Reply-To: <20040108153656.GF13867@fs.tum.de>
References: <20040107232831.13261f76.akpm@osdl.org>
	<20040108153656.GF13867@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> drivers/char/drm/sis_mm.c:37:25: linux/sisfb.h: No such file or directory
>  drivers/char/drm/sis_mm.c: In function `sis_fb_alloc':
>  drivers/char/drm/sis_mm.c:92: error: storage size of `req' isn't known
>  drivers/char/drm/sis_mm.c:98: warning: implicit declaration of function `sis_malloc'
>  drivers/char/drm/sis_mm.c:105: warning: implicit declaration of function `sis_free'
>  drivers/char/drm/sis_mm.c:92: warning: unused variable `req'

Yes.  The video header files were moved.  I assume this code is also
designed to build under 2.4.  If so, something like this is the way to go:

---

 drivers/char/drm/sis_mm.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN drivers/char/drm/sis_mm.c~drm-include-fix drivers/char/drm/sis_mm.c
--- 25/drivers/char/drm/sis_mm.c~drm-include-fix	2004-01-08 10:14:41.000000000 -0800
+++ 25-akpm/drivers/char/drm/sis_mm.c	2004-01-08 10:16:49.000000000 -0800
@@ -34,8 +34,12 @@
 #include "sis_drv.h"
 #include "sis_ds.h"
 #if defined(__linux__) && defined(CONFIG_FB_SIS)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+#include <video/sisfb.h>
+#else
 #include <linux/sisfb.h>
 #endif
+#endif
 
 #define MAX_CONTEXT 100
 #define VIDEO_TYPE 0 

_

