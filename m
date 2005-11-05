Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVKELCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVKELCc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 06:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVKELCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 06:02:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55562 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751320AbVKELCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 06:02:31 -0500
Date: Sat, 5 Nov 2005 11:02:27 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [DRIVER MODEL] Make other buggy drivers warn
Message-ID: <20051105110226.GG30315@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105105628.GE28438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105105628.GE28438@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously just to provoke comment from these driver authors to point
out the error of their ways, and _not_ for merging.

diff -u b/drivers/net/depca.c b/drivers/net/depca.c
--- b/drivers/net/depca.c
+++ b/drivers/net/depca.c
@@ -2083,6 +2083,7 @@ static int __init depca_module_init (voi
         err |= eisa_driver_register (&depca_eisa_driver);
 #endif
 	err |= driver_register (&depca_isa_driver);
+#warning FIXME: what if one of the above registeration functions fails
 	depca_platform_probe ();
 	
         return err;
diff -u b/drivers/net/tokenring/proteon.c b/drivers/net/tokenring/proteon.c
--- b/drivers/net/tokenring/proteon.c
+++ b/drivers/net/tokenring/proteon.c
@@ -384,6 +384,7 @@ static int __init proteon_init(void)
 	/* Probe for cards. */
 	if (num == 0) {
 		printk(KERN_NOTICE "proteon.c: No cards found.\n");
+#warning FIXME: what about unregistering the platform driver?
 		return (-ENODEV);
 	}
 	return (0);
diff -u b/drivers/net/tokenring/skisa.c b/drivers/net/tokenring/skisa.c
--- b/drivers/net/tokenring/skisa.c
+++ b/drivers/net/tokenring/skisa.c
@@ -394,6 +394,7 @@ static int __init sk_isa_init(void)
 	/* Probe for cards. */
 	if (num == 0) {
 		printk(KERN_NOTICE "skisa.c: No cards found.\n");
+#warning FIXME: what about unregistering the platform driver?
 		return (-ENODEV);
 	}
 	return (0);
diff -u b/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
--- b/drivers/usb/gadget/dummy_hcd.c
+++ b/drivers/usb/gadget/dummy_hcd.c
@@ -1981,9 +1981,11 @@
  * statically allocated. */
 static void
 dummy_udc_release (struct device *dev) {}
+#warning FIXME: device release code in the module which unregisters the device is buggy

 static void
 dummy_hcd_release (struct device *dev) {}
+#warning FIXME: device release code in the module which unregisters the device is buggy
 
 static struct platform_device		the_udc_pdev = {
 	.name		= (char *) gadget_name,
diff -u b/sound/core/init.c b/sound/core/init.c
--- b/sound/core/init.c
+++ b/sound/core/init.c
@@ -694,6 +694,7 @@
 
 void snd_generic_device_release(struct device *dev)
 {
+#warning FIXME: release functions must not be empty
 }
 
 static int snd_generic_device_register(snd_card_t *card)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
