Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135785AbRDYBOh>; Tue, 24 Apr 2001 21:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135786AbRDYBO2>; Tue, 24 Apr 2001 21:14:28 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:14093 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135785AbRDYBOT>; Tue, 24 Apr 2001 21:14:19 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200104250110.DAA10347@green.mif.pg.gda.pl>
Subject: Re: Linux 2.4.3ac13
To: meissner@spectacle-pond.org, alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
Date: Wed, 25 Apr 2001 03:10:27 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Also, I initially built ac13 with:
> 
> 	make mrproper
> 	make menuconfig
> 
> and it doesn't ask whether I want to build the normal USHI USB driver either as
> a module or builtin to the kernel, only whether I want to build the alternative
> USHI USB dirver (the JE driver).  Make xconfig asks whether you want to build
> both drivers.  I'm not sure whether this was a bug in previous versions or
> not.

It is an old problem, probably caused by ugly hack in drivers/usb/Config.in
(using a variable before it is defined).
The following patch should fix it in some way...


diff -u drivers/usb/Config.in~ drivers/usb/Config.in
--- drivers/usb/Config.in~	Sat Feb 10 23:16:30 2001
+++ drivers/usb/Config.in	Sat Feb 17 00:06:34 2001
@@ -22,6 +22,8 @@
    fi
    if [ "$CONFIG_USB_UHCI" != "y" ]; then
       dep_tristate '  UHCI Alternate Driver (JE) support' CONFIG_USB_UHCI_ALT $CONFIG_USB
+   else
+      define_bool CONFIG_USB_UHCI_ALT n
    fi
    dep_tristate '  OHCI (Compaq, iMacs, OPTi, SiS, ALi, ...) support' CONFIG_USB_OHCI $CONFIG_USB
 

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
