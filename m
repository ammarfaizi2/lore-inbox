Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932422AbWFEFm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWFEFm1 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 01:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWFEFm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 01:42:26 -0400
Received: from xenotime.net ([66.160.160.81]:15843 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932422AbWFEFm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 01:42:26 -0400
Date: Sun, 4 Jun 2006 22:45:12 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: barryn@pobox.com, linux-kernel@vger.kernel.org, bunk@stusta.de,
        greg@kroah.com
Subject: Re: [PATCH] sisusb: fix build (Re: 2.6.17-rc5-mm3: sisusbvga build
 failure)
Message-Id: <20060604224512.56a194ff.rdunlap@xenotime.net>
In-Reply-To: <20060604221117.b9dfdcfc.akpm@osdl.org>
References: <986ed62e0606042140v78dc2c7cpb3cf7793954d2dce@mail.gmail.com>
	<20060604220347.6f963375.rdunlap@xenotime.net>
	<20060604221117.b9dfdcfc.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 22:11:17 -0700 Andrew Morton wrote:

> OK, but with that applied it still fails:
> 
> In file included from drivers/usb/misc/sisusbvga/sisusb.c:56:
> drivers/usb/misc/sisusbvga/sisusb_init.h:837: warning: 'struct vc_data' declared inside parameter list
> drivers/usb/misc/sisusbvga/sisusb_init.h:837: warning: its scope is only this definition or declaration, which is probably not what you want
> drivers/usb/misc/sisusbvga/sisusb.c:1339: error: static declaration of 'sisusb_setidxreg' follows non-static declaration
> drivers/usb/misc/sisusbvga/sisusb_init.h:819: error: previous declaration of 'sisusb_setidxreg' was here
> drivers/usb/misc/sisusbvga/sisusb.c:1351: error: static declaration of 'sisusb_getidxreg' follows non-static declaration
> drivers/usb/misc/sisusbvga/sisusb_init.h:821: error: previous declaration of 'sisusb_getidxreg' was here
> drivers/usb/misc/sisusbvga/sisusb.c:1364: error: static declaration of 'sisusb_setidxregandor' follows non-static declaration
> drivers/usb/misc/sisusbvga/sisusb_init.h:823: error: previous declaration of 'sisusb_setidxregandor' was here
> drivers/usb/misc/sisusbvga/sisusb.c:1395: error: static declaration of 'sisusb_setidxregor' follows non-static declaration
> drivers/usb/misc/sisusbvga/sisusb_init.h:825: error: previous declaration of 'sisusb_setidxregor' was here
> drivers/usb/misc/sisusbvga/sisusb.c:1404: error: static declaration of 'sisusb_setidxregand' follows non-static declaration
> drivers/usb/misc/sisusbvga/sisusb_init.h:827: error: previous declaration of 'sisusb_setidxregand' was here
> make[1]: *** [drivers/usb/misc/sisusbvga/sisusb.o] Error 1
> 
> Culprit is gregkh-usb-usb-sisusbvga-possible-cleanups.patch

Adrian might have other methods here...



From: Randy Dunlap <rdunlap@xenotime.net>

Fix build errors caused by agressive static attributes.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/usb/misc/sisusbvga/sisusb.c |   17 +----------------
 drivers/usb/misc/sisusbvga/sisusb.h |    2 --
 2 files changed, 1 insertion(+), 18 deletions(-)

--- linux-2617-rc5mm3.orig/drivers/usb/misc/sisusbvga/sisusb.h
+++ linux-2617-rc5mm3/drivers/usb/misc/sisusbvga/sisusb.h
@@ -62,11 +62,9 @@
 #define INCL_SISUSB_CON		1
 #endif
 
-#ifdef INCL_SISUSB_CON
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include "sisusb_struct.h"
-#endif
 
 /* USB related */
 
--- linux-2617-rc5mm3.orig/drivers/usb/misc/sisusbvga/sisusb.c
+++ linux-2617-rc5mm3/drivers/usb/misc/sisusbvga/sisusb.c
@@ -1331,9 +1331,6 @@ sisusb_getreg(struct sisusb_usb_data *si
 }
 #endif
 
-#ifndef INCL_SISUSB_CON
-static
-#endif
 int
 sisusb_setidxreg(struct sisusb_usb_data *sisusb, int port, u8 index, u8 data)
 {
@@ -1343,9 +1340,6 @@ sisusb_setidxreg(struct sisusb_usb_data 
 	return ret;
 }
 
-#ifndef INCL_SISUSB_CON
-static
-#endif
 int
 sisusb_getidxreg(struct sisusb_usb_data *sisusb, int port, u8 index, u8 *data)
 {
@@ -1355,9 +1349,6 @@ sisusb_getidxreg(struct sisusb_usb_data 
 	return ret;
 }
 
-#ifndef INCL_SISUSB_CON
-static
-#endif
 int
 sisusb_setidxregandor(struct sisusb_usb_data *sisusb, int port, u8 idx,
 							u8 myand, u8 myor)
@@ -1373,7 +1364,7 @@ sisusb_setidxregandor(struct sisusb_usb_
 	return ret;
 }
 
-static int
+int
 sisusb_setidxregmask(struct sisusb_usb_data *sisusb, int port, u8 idx,
 							u8 data, u8 mask)
 {
@@ -1387,18 +1378,12 @@ sisusb_setidxregmask(struct sisusb_usb_d
 	return ret;
 }
 
-#ifndef INCL_SISUSB_CON
-static
-#endif
 int
 sisusb_setidxregor(struct sisusb_usb_data *sisusb, int port, u8 index, u8 myor)
 {
 	return(sisusb_setidxregandor(sisusb, port, index, 0xff, myor));
 }
 
-#ifndef INCL_SISUSB_CON
-static
-#endif
 int
 sisusb_setidxregand(struct sisusb_usb_data *sisusb, int port, u8 idx, u8 myand)
 {
