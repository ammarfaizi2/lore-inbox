Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUJXNZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUJXNZS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUJXNXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:23:03 -0400
Received: from verein.lst.de ([213.95.11.210]:12966 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261472AbUJXNUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:20:23 -0400
Date: Sun, 24 Oct 2004 15:20:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport: kill dead code and exports
Message-ID: <20041024132014.GA19867@lst.de>
References: <20041024131446.GA19658@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024131446.GA19658@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 03:14:46PM +0200, Christoph Hellwig wrote:
> there's lots of exports in parport that aren't used by any drivers.
> Behind many of them there's actually dead code.

And here's the missing parport.h bits:

--- 1.18/include/linux/parport.h	2004-03-03 13:45:18 +01:00
+++ edited/include/linux/parport.h	2004-10-23 14:51:46 +02:00
@@ -466,7 +466,6 @@
 				    int usec);
 
 /* For architectural drivers */
-extern void parport_ieee1284_wakeup (struct parport *port);
 extern size_t parport_ieee1284_write_compat (struct parport *,
 					     const void *, size_t, int);
 extern size_t parport_ieee1284_read_nibble (struct parport *,
@@ -500,20 +499,8 @@
 extern void parport_close (struct pardevice *dev);
 extern ssize_t parport_device_id (int devnum, char *buffer, size_t len);
 extern int parport_device_num (int parport, int mux, int daisy);
-extern int parport_device_coords (int devnum, int *parport, int *mux,
-				  int *daisy);
 extern void parport_daisy_deselect_all (struct parport *port);
 extern int parport_daisy_select (struct parport *port, int daisy, int mode);
-
-/* For finding devices based on their device ID.  Example usage:
-   int devnum = -1;
-   while ((devnum = parport_find_class (PARPORT_CLASS_DIGCAM, devnum)) != -1) {
-       struct pardevice *dev = parport_open (devnum, ...);
-       ...
-   }
-*/
-extern int parport_find_device (const char *mfg, const char *mdl, int from);
-extern int parport_find_class (parport_device_class cls, int from);
 
 /* Lowlevel drivers _can_ call this support function to handle irqs.  */
 static __inline__ void parport_generic_irq(int irq, struct parport *port,
