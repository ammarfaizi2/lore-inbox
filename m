Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268022AbTAIWFR>; Thu, 9 Jan 2003 17:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268015AbTAIWFR>; Thu, 9 Jan 2003 17:05:17 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:21724 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268022AbTAIWEW>; Thu, 9 Jan 2003 17:04:22 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk, Bjorn Helgaas <bjorn_helgaas@hp.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: [2.5.55] [PATCH] AGP: missing includes on Alpha
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 09 Jan 2003 23:12:36 +0100
Message-ID: <87k7hegegb.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

the following patch, which only adds some includes, is needed to
compile AGP support on Alpha. After that, it works fine with my AMD
Irongate chipset and a Radeon 7500 card.

-- 
	Falk


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=alpga-agp-includes.patch

diff -Nurp linux-2.5.55/drivers/char/agp/amd-k7-agp.c linux-2.5.55.hacked/drivers/char/agp/amd-k7-agp.c
--- linux-2.5.55/drivers/char/agp/amd-k7-agp.c	2003-01-09 05:04:28.000000000 +0100
+++ linux-2.5.55.hacked/drivers/char/agp/amd-k7-agp.c	2003-01-09 22:45:37.000000000 +0100
@@ -6,6 +6,10 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/agp_backend.h>
+#include <linux/gfp.h>
+#include <linux/page-flags.h>
+#include <linux/mm.h>
+#include <asm/io.h>
 #include "agp.h"
 
 static int agp_try_unsupported __initdata = 0;
diff -Nurp linux-2.5.55/drivers/char/agp/backend.c linux-2.5.55.hacked/drivers/char/agp/backend.c
--- linux-2.5.55/drivers/char/agp/backend.c	2003-01-09 05:04:19.000000000 +0100
+++ linux-2.5.55.hacked/drivers/char/agp/backend.c	2003-01-09 22:48:16.000000000 +0100
@@ -34,6 +34,8 @@
 #include <linux/miscdevice.h>
 #include <linux/pm.h>
 #include <linux/agp_backend.h>
+#include <linux/vmalloc.h>
+#include <asm/io.h>
 #include "agp.h"
 
 /* Due to XFree86 brain-damage, we can't go to 1.0 until they
diff -Nurp linux-2.5.55/drivers/char/agp/frontend.c linux-2.5.55.hacked/drivers/char/agp/frontend.c
--- linux-2.5.55/drivers/char/agp/frontend.c	2003-01-09 05:03:55.000000000 +0100
+++ linux-2.5.55.hacked/drivers/char/agp/frontend.c	2003-01-09 22:40:36.000000000 +0100
@@ -34,7 +34,10 @@
 #include <linux/miscdevice.h>
 #include <linux/agp_backend.h>
 #include <linux/agpgart.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
 #include <asm/uaccess.h>
+#include <asm/pgtable.h>
 
 #include "agp.h"
 
diff -Nurp linux-2.5.55/drivers/char/agp/generic.c linux-2.5.55.hacked/drivers/char/agp/generic.c
--- linux-2.5.55/drivers/char/agp/generic.c	2003-01-09 05:04:00.000000000 +0100
+++ linux-2.5.55.hacked/drivers/char/agp/generic.c	2003-01-09 22:42:20.000000000 +0100
@@ -34,6 +34,8 @@
 #include <linux/miscdevice.h>
 #include <linux/pm.h>
 #include <linux/agp_backend.h>
+#include <linux/vmalloc.h>
+#include <asm/io.h>
 #include "agp.h"
 
 __u32 *agp_gatt_table; 

--=-=-=--
