Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbTEaUyk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 16:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTEaUyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 16:54:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4325 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264445AbTEaUyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 16:54:38 -0400
Date: Sat, 31 May 2003 23:07:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>
Subject: [patch] 2.5.70-mm3: usb_gadget_* several times defined
Message-ID: <20030531210752.GK29425@fs.tum.de>
References: <20030531013716.07d90773.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531013716.07d90773.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following compile error comes from Linus' tree:

<--  snip  -->

...
  LD      drivers/built-in.o
drivers/usb/gadget/built-in.o(.text+0x2d00): In function 
`net2280_set_fifo_mode':
: multiple definition of `net2280_set_fifo_mode'
drivers/usb/built-in.o(.text+0xb9460): first defined here
drivers/usb/gadget/built-in.o(.text+0x6040): In function 
`usb_gadget_get_string':
: multiple definition of `usb_gadget_get_string'
drivers/usb/built-in.o(.text+0xbc7a0): first defined here
drivers/usb/gadget/built-in.o(.text+0x32c0): In function 
`usb_gadget_register_driver':
: multiple definition of `usb_gadget_register_driver'
drivers/usb/built-in.o(.text+0xb9a20): first defined here
drivers/usb/gadget/built-in.o(.text+0x3620): In function 
`usb_gadget_unregister_driver':
: multiple definition of `usb_gadget_unregister_driver'
drivers/usb/built-in.o(.text+0xb9d80): first defined here
make[1]: *** [drivers/built-in.o] Error 1

<--  snip  -->


The following patch fixes it (drivers/usb/Makefile now includes gadget/
entries):


--- linux-2.5.70-mm3/drivers/Makefile.old	2003-05-31 23:00:25.000000000 +0200
+++ linux-2.5.70-mm3/drivers/Makefile	2003-05-31 23:00:44.000000000 +0200
@@ -37,7 +37,6 @@
 obj-$(CONFIG_PARIDE) 		+= block/paride/
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
-obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_SERIO)		+= input/serio/



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

