Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbUDBNmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 08:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbUDBNmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 08:42:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52753 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264043AbUDBNmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 08:42:22 -0500
Date: Fri, 2 Apr 2004 14:42:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.4: disabling SCSI support not possible
Message-ID: <20040402144216.A12306@flint.arm.linux.org.uk>
Mail-Followup-To: Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <406D65FE.9090001@broadnet-mediascape.de> <6uad1uv7kr.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <6uad1uv7kr.fsf@zork.zork.net>; from sneakums@zork.net on Fri, Apr 02, 2004 at 02:21:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 02:21:40PM +0100, Sean Neakums wrote:
> Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de> writes:
> 
> > I cannot disable SCSI completely in 2.6.4's 'menuconfig'.
> 
> I believe that some kernel components require SCSI to be useful and so
> force SCSI to be activated.  One example that springs to mind is
> usb-storage.

usb-storage should depend on SCSI rather than forcing SCSI to be
enabled.

Using 'select' is all very well for the case where the target
configuration symbol is not user selectable, but in the case that
it is, it leads to the confusion shown above.

Maybe USB_STORAGE help text should say that it needs SCSI support?

Therefore, I propose this patch:

--- orig/drivers/usb/storage/Kconfig	Sat Mar 20 09:22:45 2004
+++ linux/drivers/usb/storage/Kconfig	Fri Apr  2 14:41:05 2004
@@ -4,8 +4,7 @@
 
 config USB_STORAGE
 	tristate "USB Mass Storage support"
-	depends on USB
-	select SCSI
+	depends on USB && SCSI
 	---help---
 	  Say Y here if you want to connect USB mass storage devices to your
 	  computer's USB port. This is the driver you need for USB floppy drives,
@@ -13,6 +12,9 @@ config USB_STORAGE
 	  similar devices. This driver may also be used for some cameras and
 	  card readers.
 
+	  Please select SCSI support before enabling USB Mass Storage
+	  support.
+
 	  To compile this driver as a module, choose M here: the
 	  module will be called usb-storage.
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
