Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbTH2Uw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTH2UvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:51:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:54408 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263477AbTH2Uu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:50:29 -0400
Date: Fri, 29 Aug 2003 13:50:34 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (5/8): common i/o layer.
Message-ID: <20030829205034.GA2649@kroah.com>
References: <pV54.523.43@gated-at.bofh.it> <pX6U.7Vu.35@gated-at.bofh.it> <200308292032.h7TKWats006188@post.webmailer.de> <20030829204017.GA2580@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829204017.GA2580@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 01:40:17PM -0700, Greg KH wrote:
> On Fri, Aug 29, 2003 at 10:31:47PM +0200, Arnd Bergmann wrote:
> > OGAWA Hirofumi wrote:
> > 
> > > Shouldn't the above use BUS_ID_SIZE instead of DEVICE_ID_SIZE?
> > 
> > Right. Actually, all uses of DEVICE_ID_SIZE in drivers/s390 are wrong.
> > I'll take care of that.
> > 
> > The only other user of DEVICE_ID_SIZE right now is drivers/usb/core/file.c
> > and I'm not sure if it's used in the intended way there.
> > Greg, maybe you want to get rid of it as well, or move the definition
> > into file.c.
> 
> I'm deleting it right now... :)

And here's the patch that I added to my trees.

thanks,

greg k-h


# USB: remove usage of DEVICE_ID_SIZE from usb core as it should not be used.

diff -Nru a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c	Fri Aug 29 13:49:19 2003
+++ b/drivers/usb/core/file.c	Fri Aug 29 13:49:20 2003
@@ -129,7 +129,7 @@
 	int retval = -EINVAL;
 	int minor_base = class_driver->minor_base;
 	int minor = 0;
-	char name[DEVICE_ID_SIZE];
+	char name[BUS_ID_SIZE];
 	struct class_device *class_dev;
 	char *temp;
 
@@ -166,7 +166,7 @@
 	intf->minor = minor;
 
 	/* handle the devfs registration */
-	snprintf(name, DEVICE_ID_SIZE, class_driver->name, minor - minor_base);
+	snprintf(name, BUS_ID_SIZE, class_driver->name, minor - minor_base);
 	devfs_mk_cdev(MKDEV(USB_MAJOR, minor), class_driver->mode, name);
 
 	/* create a usb class device for this usb interface */
@@ -211,7 +211,7 @@
 			struct usb_class_driver *class_driver)
 {
 	int minor_base = class_driver->minor_base;
-	char name[DEVICE_ID_SIZE];
+	char name[BUS_ID_SIZE];
 
 #ifdef CONFIG_USB_DYNAMIC_MINORS
 	minor_base = 0;
@@ -226,7 +226,7 @@
 	usb_minors[intf->minor] = NULL;
 	spin_unlock (&minor_lock);
 
-	snprintf(name, DEVICE_ID_SIZE, class_driver->name, intf->minor - minor_base);
+	snprintf(name, BUS_ID_SIZE, class_driver->name, intf->minor - minor_base);
 	devfs_remove (name);
 
 	if (intf->class_dev) {
