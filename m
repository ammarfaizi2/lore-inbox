Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbVLEU1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbVLEU1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVLEU1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:27:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1290 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751451AbVLEU1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:27:17 -0500
Date: Mon, 5 Dec 2005 20:27:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Message-ID: <20051205202707.GH15201@flint.arm.linux.org.uk>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
References: <20051205212337.74103b96.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205212337.74103b96.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 09:23:37PM +0100, Jean Delvare wrote:
> The name parameter of platform_device_register_simple should be of
> type const char * instead of char *, as we simply pass it to
> platform_device_alloc, where it has type const char *.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

However, I've been wondering whether we want to keep this "simple"
interface around long-term given that we now have a more flexible
platform device allocation interface - I don't particularly like
having superfluous interfaces for folk to get confused with.

---
 drivers/base/platform.c         |    2 +-
 include/linux/platform_device.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc2.orig/drivers/base/platform.c	2005-11-13 21:02:31.000000000 +0100
+++ linux-2.6.15-rc2/drivers/base/platform.c	2005-12-05 20:44:43.000000000 +0100
@@ -327,7 +327,7 @@
  *	to be unloaded iwithout waiting for the last reference to the device
  *	to be dropped.
  */
-struct platform_device *platform_device_register_simple(char *name, unsigned int id,
+struct platform_device *platform_device_register_simple(const char *name, unsigned int id,
 							struct resource *res, unsigned int num)
 {
 	struct platform_device *pdev;
--- linux-2.6.15-rc2.orig/include/linux/platform_device.h	2005-11-13 21:02:59.000000000 +0100
+++ linux-2.6.15-rc2/include/linux/platform_device.h	2005-12-05 20:44:30.000000000 +0100
@@ -35,7 +35,7 @@
 extern int platform_get_irq_byname(struct platform_device *, char *);
 extern int platform_add_devices(struct platform_device **, int);
 
-extern struct platform_device *platform_device_register_simple(char *, unsigned int, struct resource *, unsigned int);
+extern struct platform_device *platform_device_register_simple(const char *, unsigned int, struct resource *, unsigned int);
 
 extern struct platform_device *platform_device_alloc(const char *name, unsigned int id);
 extern int platform_device_add_resources(struct platform_device *pdev, struct resource *res, unsigned int num);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
