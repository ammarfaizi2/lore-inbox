Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbTEFEPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbTEFEPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:15:42 -0400
Received: from granite.he.net ([216.218.226.66]:4361 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262341AbTEFEPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:15:41 -0400
Date: Mon, 5 May 2003 21:25:52 -0700
From: Greg KH <greg@kroah.com>
To: David Ford <david+powerix@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       apcupsd-devel@apcupsd.org
Subject: Re: APC USB ups, Back-UPS ES series, 2.5.68
Message-ID: <20030506042552.GA5612@kroah.com>
References: <3EB331B5.4080306@blue-labs.org> <20030503063632.GA2769@kroah.com> <3EB39463.2080307@blue-labs.org> <3EB7130D.6080802@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB7130D.6080802@blue-labs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 09:42:37PM -0400, David Ford wrote:
> I haven't had time to look at it and try to debug it.  The 96 v.s. 192 
> minor look like it's exactly 128 too high.  Perhaps it's a simple fix?

Can you try this patch and let me know if it works or not?

thanks,

greg k-h


--- a/drivers/usb/input/hiddev.c	Sun May  4 23:49:54 2003
+++ b/drivers/usb/input/hiddev.c	Mon May  5 21:23:42 2003
@@ -714,9 +714,9 @@
 	hiddev->hid = hid;
 	hiddev->exist = 1;
 
-	sprintf(devfs_name, "usb/hid/hiddev%d", minor);
+	sprintf(devfs_name, "usb/hid/hiddev%d", minor - HIDDEV_MINOR_BASE);
 	devfs_register(NULL, devfs_name, 0,
-		USB_MAJOR, minor + HIDDEV_MINOR_BASE,
+		USB_MAJOR, minor,
 		S_IFCHR | S_IRUGO | S_IWUSR, &hiddev_fops, NULL);
 	hid->minor = minor;
 	hid->hiddev = hiddev;
