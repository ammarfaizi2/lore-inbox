Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUBEA4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUBEApl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:45:41 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22477 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265071AbUBEAbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:31:45 -0500
Date: Thu, 5 Feb 2004 01:31:36 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Greg KH <greg@kroah.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Andre Noll <noll@mathematik.tu-darmstadt.de>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove USB_SCANNER
Message-ID: <20040205003136.GQ26093@fs.tum.de>
References: <20040126215036.GA6906@kroah.com> <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de> <slrnc1l72v.9m.noll@localhost.mathematik.tu-darmstadt.de> <20040130230633.GZ6577@stop.crashing.org> <20040202214326.GA574@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202214326.GA574@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 01:43:26PM -0800, Greg KH wrote:
> On Fri, Jan 30, 2004 at 04:06:33PM -0700, Tom Rini wrote:
> > 
> > Greg, I think this now makes 2 distinct bugs in the scanner kernel
> > driver.  Maybe it should be protected with a BROKEN:
> 
> Very good idea, I've applied this patch.

USB_SCANNER is obsolete, and it's now marked as BROKEN.

I there a good reason to keep it in the kernel?

If not, please apply the patch below plus do a
  rm drivers/usb/image/scanner.{c,h}

> thanks,
> 
> greg k-h

cu
Adrian

--- linux-2.6.2-rc3-mm1/drivers/usb/Makefile.old	2004-02-05 01:27:52.000000000 +0100
+++ linux-2.6.2-rc3-mm1/drivers/usb/Makefile	2004-02-05 01:28:08.000000000 +0100
@@ -46,7 +46,6 @@
 obj-$(CONFIG_USB_HPUSBSCSI)	+= image/
 obj-$(CONFIG_USB_MDC800)	+= image/
 obj-$(CONFIG_USB_MICROTEK)	+= image/
-obj-$(CONFIG_USB_SCANNER)	+= image/
 
 obj-$(CONFIG_USB_SERIAL)	+= serial/
 
--- linux-2.6.2-rc3-mm1/drivers/usb/image/Makefile.old	2004-02-05 01:27:52.000000000 +0100
+++ linux-2.6.2-rc3-mm1/drivers/usb/image/Makefile	2004-02-05 01:28:15.000000000 +0100
@@ -5,4 +5,3 @@
 obj-$(CONFIG_USB_MDC800)	+= mdc800.o
 obj-$(CONFIG_USB_HPUSBSCSI)	+= hpusbscsi.o
 obj-$(CONFIG_USB_MICROTEK)	+= microtek.o
-obj-$(CONFIG_USB_SCANNER)	+= scanner.o
--- linux-2.6.2-rc3-mm1/drivers/usb/image/Kconfig.old	2004-02-05 01:27:52.000000000 +0100
+++ linux-2.6.2-rc3-mm1/drivers/usb/image/Kconfig	2004-02-05 01:28:21.000000000 +0100
@@ -17,19 +17,6 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called mdc800.
 
-config USB_SCANNER
-	tristate "USB Scanner support (OBSOLETE)"
-	depends on USB && BROKEN
-	help
-	  Say Y here if you want to connect a USB scanner to your computer's
-	  USB port. Please read <file:Documentation/usb/scanner.txt> for more
-	  information.
-
-	  This driver has been obsoleted by support via libusb.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called scanner.
-
 config USB_MICROTEK
 	tristate "Microtek X6USB scanner support"
 	depends on USB && SCSI
