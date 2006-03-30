Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWC3Wgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWC3Wgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 17:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWC3Wgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 17:36:39 -0500
Received: from xenotime.net ([66.160.160.81]:7856 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750756AbWC3Wgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 17:36:38 -0500
Date: Thu, 30 Mar 2006 14:35:26 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Beber <beber.lkml@gmail.com>
cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org, beber@gna.org, akpm@osdl.org
Subject: [PATCH] isd200: limit to BLK_DEV_IDE
In-Reply-To: <4615f4910603301146x5496ccaai17bf5f4636c91c45@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0603301431560.26598@shark.he.net>
References: <20060328075629.GA8083@kroah.com>
 <4615f4910603301146x5496ccaai17bf5f4636c91c45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Beber wrote:

> On 3/28/06, Greg KH <gregkh@suse.de> wrote:
> > We (the -stable team) are announcing the release of the 2.6.16.1 kernel.
>
> I still get this error :
>
> # make
...
> drivers/built-in.o: In function `isd200_Initialization':
> : undefined reference to `ide_fix_driveid'
> make: *** [.tmp_vmlinux1] Error 1

Was this reported earlier?

Please test the patch below.
It works for me with your config and various others.



From: Randy Dunlap <rdunlap@xenotime.net>

Limit USB_STORAGE_ISD200 to whatever BLK_DEV_IDE and USB_STORAGE
are set to (y, m) since isd200 calls ide_fix_driveid() in the
BLK_DEV_IDE code.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/usb/storage/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2616-z.orig/drivers/usb/storage/Kconfig
+++ linux-2616-z/drivers/usb/storage/Kconfig
@@ -48,7 +48,7 @@ config USB_STORAGE_FREECOM

 config USB_STORAGE_ISD200
 	bool "ISD-200 USB/ATA Bridge support"
-	depends on USB_STORAGE && BLK_DEV_IDE
+	depends on USB_STORAGE && (BLK_DEV_IDE=y || BLK_DEV_IDE=m && USB_STORAGE=m)
 	---help---
 	  Say Y here if you want to use USB Mass Store devices based
 	  on the In-Systems Design ISD-200 USB/ATA bridge.
