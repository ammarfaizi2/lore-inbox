Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbUBONWz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 08:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUBONWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 08:22:55 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3018 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264605AbUBONWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 08:22:45 -0500
Date: Sun, 15 Feb 2004 14:22:38 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, zippel@linux-m68k.org
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-rc3: twice defined symbols with new radeonfb
Message-ID: <20040215132237.GS1308@fs.tum.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org> <20040215074106.GQ1308@fs.tum.de> <1076831240.6960.35.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076831240.6960.35.camel@gaston>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 06:47:21PM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2004-02-15 at 18:41, Adrian Bunk wrote:
> > On Sat, Feb 14, 2004 at 07:33:45PM -0800, Linus Torvalds wrote:
> > >...
> > > Summary of changes from v2.6.3-rc2 to v2.6.3-rc3
> > > ============================================
> > >...
> > > Benjamin Herrenschmidt:
> > >...
> > >   o New radeonfb
> > >...
> > 
> > I'm getting the following compile error (no module support in the 
> > kernel):
> 
> Yes, you can't build both old and new radeonfb's at the same time,
> I should do some Kconfig stuff to check that I beleive. It make
> no sense as you don't know which one will pick up anyway.

Something like the patch below?

@Roman:
With the patch below, "make menuconfig" shows
       [ ]   ATI Radeon display support
         [*]     ATI Radeon display support (Old driver)
 
How can I void that the old driver is shown as if it was an option for 
the new driver?  

> Ben.

cu
Adrian

--- linux-2.6.3-rc3-full/drivers/video/Kconfig.old	2004-02-15 14:13:28.000000000 +0100
+++ linux-2.6.3-rc3-full/drivers/video/Kconfig	2004-02-15 14:20:00.000000000 +0100
@@ -614,16 +614,6 @@
 	  There is no need for enabling 'Matrox multihead support' if you have
 	  only one Matrox card in the box.
 
-config FB_RADEON_OLD
-	tristate "ATI Radeon display support (Old driver)"
-	depends on FB && PCI
-	help
-	  Choose this option if you want to use an ATI Radeon graphics card as
-	  a framebuffer device.  There are both PCI and AGP versions.  You
-	  don't need to choose this to run the Radeon in plain VGA mode.
-	  There is a product page at
-	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
-
 config FB_RADEON
 	tristate "ATI Radeon display support"
 	depends on FB && PCI
@@ -650,6 +640,16 @@
 	help
 	  Say Y here if you want DDC/I2C support for your Radeon board. 
 
+config FB_RADEON_OLD
+	tristate "ATI Radeon display support (Old driver)"
+	depends on FB && PCI && FB_RADEON!=y
+	help
+	  Choose this option if you want to use an ATI Radeon graphics card as
+	  a framebuffer device.  There are both PCI and AGP versions.  You
+	  don't need to choose this to run the Radeon in plain VGA mode.
+	  There is a product page at
+	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
+
 config FB_ATY128
 	tristate "ATI Rage128 display support"
 	depends on FB && PCI
