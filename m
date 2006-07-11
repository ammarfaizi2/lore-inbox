Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbWGKEuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWGKEuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWGKEuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:50:07 -0400
Received: from xenotime.net ([66.160.160.81]:42888 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965110AbWGKEuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:50:05 -0400
Date: Mon, 10 Jul 2006 21:52:53 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt Reuther <mreuther@umich.edu>
Cc: adaplas@gmail.com, akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] appledisplay/backlight (Depmod errors on
 2.6.17.4/2.6.18-rc1/2.6.18-rc1-mm1)
Message-Id: <20060710215253.1fcaab57.rdunlap@xenotime.net>
In-Reply-To: <200607102327.38426.mreuther@umich.edu>
References: <200607100833.00461.mreuther@umich.edu>
	<20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>
	<44B27931.30609@gmail.com>
	<200607102327.38426.mreuther@umich.edu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >> CONFIG_FB=n, CONFIG_BACKLIGHT_CLASS_DEVICE=m should not be possible in
> > >> 2.6.18-rc1-mm1 and 2.6.18-rc1.  Can you run kconfig again?
> > >>
> > >> Tony
> >
> > I tested with make menuconfig, and it's not possible to set lcd/backlight
> > options if CONFIG_FB is not set.

Tony, it is possiblle when the USB APPLEDISPLAY option is set and it selects
backlight options without regard for FB.
 
> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/drivers/video/backlight/backlight.ko 
> needs unknown symbol fb_unregister_client
> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/drivers/video/backlight/backlight.ko 
> needs unknown symbol fb_register_client

This patch fixes it for me.  Is it the right thing to do?
---

From: Randy Dunlap <rdunlap@xenotime.net>

appledisplay calls fb_register_client() so needs to depend on FB.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/usb/misc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2618-rc1mm1.orig/drivers/usb/misc/Kconfig
+++ linux-2618-rc1mm1/drivers/usb/misc/Kconfig
@@ -163,7 +163,7 @@ config USB_IDMOUSE
 
 config USB_APPLEDISPLAY
 	tristate "Apple Cinema Display support"
-	depends on USB
+	depends on USB && FB
 	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	help

