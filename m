Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUG2PG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUG2PG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267991AbUG2PDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:03:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13564 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265200AbUG2OPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:15:36 -0400
Date: Thu, 29 Jul 2004 16:15:30 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: atlka@pg.gda.pl, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] radio-maestro.c: remove an inline (fwd)
Message-ID: <20040729141530.GZ2349@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
The patch forwarded below is still required in 2.6.8-rc2-mm1.



----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Tue, 13 Jul 2004 20:17:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: atlka@pg.gda.pl
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] radio-maestro.c: remove an inline

Trying to compile drivers/media/radio/radio-maestro.c with gcc 3.4 and
  # define inline         __inline__ __attribute__((always_inline))
results in the following compile error:

<--  snip  -->

...
  CC      drivers/media/radio/radio-maestro.o
drivers/media/radio/radio-maestro.c: In function `maestro_radio_init':
drivers/media/radio/radio-maestro.c:273: sorry, unimplemented: inlining 
failed in call to 'radio_install': function body not available
drivers/media/radio/radio-maestro.c:291: sorry, unimplemented: called from here
drivers/media/radio/radio-maestro.c:273: sorry, unimplemented: inlining 
failed in call to 'radio_install': function body not available
drivers/media/radio/radio-maestro.c:295: sorry, unimplemented: called from here
make[3]: *** [drivers/media/radio/radio-maestro.o] Error 1

<--  snip  -->
 
The patch below removes the radio_install inline from radio-maestro.c.

An alternative approach to removing the inline would be to move the
function above the first function calling it.

 drivers/media/radio/radio-maestro.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/drivers/media/radio/radio-maestro.c.old	2004-07-09 00:44:57.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/drivers/media/radio/radio-maestro.c	2004-07-09 00:46:04.000000000 +0200
@@ -270,7 +270,7 @@
 	return ret;
 }
 
-inline static __u16 radio_install(struct pci_dev *pcidev);
+static __u16 radio_install(struct pci_dev *pcidev);
 
 MODULE_AUTHOR("Adam Tlalka, atlka@pg.gda.pl");
 MODULE_DESCRIPTION("Radio driver for the Maestro PCI sound card radio.");
@@ -324,7 +324,7 @@
 	return (ofreq == radio_bits_get(dev));
 }
 
-inline static __u16 radio_install(struct pci_dev *pcidev)
+static __u16 radio_install(struct pci_dev *pcidev)
 {
 	if(((pcidev->class >> 8) & 0xffff) != PCI_CLASS_MULTIMEDIA_AUDIO)
 		return 0;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----


