Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751038AbWFEVlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWFEVlA (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWFEVlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:41:00 -0400
Received: from xenotime.net ([66.160.160.81]:17092 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751032AbWFEVk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:40:59 -0400
Date: Mon, 5 Jun 2006 14:43:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, barryn@pobox.com, linux-kernel@vger.kernel.org,
        greg@kroah.com, thomas@winischhofer.net
Subject: Re: [PATCH] sisusb: fix build (Re: 2.6.17-rc5-mm3: sisusbvga build
 failure)
Message-Id: <20060605144343.201d6cfd.rdunlap@xenotime.net>
In-Reply-To: <20060605210013.GS3955@stusta.de>
References: <986ed62e0606042140v78dc2c7cpb3cf7793954d2dce@mail.gmail.com>
	<20060604220347.6f963375.rdunlap@xenotime.net>
	<20060604221117.b9dfdcfc.akpm@osdl.org>
	<20060604224512.56a194ff.rdunlap@xenotime.net>
	<20060605210013.GS3955@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 23:00:14 +0200 Adrian Bunk wrote:

> Thanks for fixing this.
> 
> It looks good with the exception of:
> 
> > -static int
> > +int
> >  sisusb_setidxregmask(struct sisusb_usb_data *sisusb, int port, u8 idx,
> >  							u8 data, u8 mask)
> >  {
> >...
> 
> This hunk doesn't seem to be required.

Agreed, verified.  Andrew, this patch replaces the one from last night.
---

From: Randy Dunlap <rdunlap@xenotime.net>

Fix build errors caused by agressive static attributes.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/usb/misc/sisusbvga/sisusb.c |   15 ---------------
 drivers/usb/misc/sisusbvga/sisusb.h |    2 --
 2 files changed, 17 deletions(-)

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
