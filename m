Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbUKSOmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUKSOmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 09:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUKSOmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 09:42:04 -0500
Received: from soundwarez.org ([217.160.171.123]:4816 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261429AbUKSOl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 09:41:58 -0500
Subject: Re: [ANNOUNCE] udev 046 release
From: Kay Sievers <kay.sievers@vrfy.org>
To: Mathieu Segaud <matt@minas-morgul.org>
Cc: Greg KH <greg@kroah.com>,
       Hotplug Devel <linux-hotplug-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87sm76oz9z.fsf@barad-dur.crans.org>
References: <20041118224411.GA10876@kroah.com>
	 <87sm76oz9z.fsf@barad-dur.crans.org>
Content-Type: multipart/mixed; boundary="=-yXzIELDcXJB7zFcFMBnv"
Date: Fri, 19 Nov 2004 15:42:19 +0100
Message-Id: <1100875339.18701.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yXzIELDcXJB7zFcFMBnv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-11-19 at 12:26 +0100, Mathieu Segaud wrote:
> seems like these changes broke something in rules applying to eth* devices.
> the rules put and still working with udev 045 have no effect, now....
> not so inconvenient now that I've got just one card in my box, but I guess
> it could be a show-stopper for laptop users.
> 
> My rules which can be found at the end of /etc/udev/rules.d/50-udev.rules are:
> 
> KERNEL="eth*", SYSFS{address}="00:10:5a:49:36:d8", NAME="external"
> KERNEL="eth*", SYSFS{address}="00:50:04:69:db:56", NAME="private"
> KERNEL="eth*", SYSFS{address}="00:0c:6e:e4:2c:81", NAME="dmz"

This should fix it.

Thanks,
Kay
 

--=-yXzIELDcXJB7zFcFMBnv
Content-Disposition: inline; filename=udev-device-type-01.patch
Content-Type: text/x-patch; name=udev-device-type-01.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -Nru a/udev_lib.c b/udev_lib.c
--- a/udev_lib.c	2004-11-19 15:40:52 +01:00
+++ b/udev_lib.c	2004-11-19 15:40:52 +01:00
@@ -40,6 +40,7 @@
 		     const char *subsystem, const char* action)
 {
 	memset(udev, 0x00, sizeof(struct udevice));
+
 	if (devpath)
 		strfieldcpy(udev->devpath, devpath);
 	if (subsystem)
@@ -49,17 +50,13 @@
 
 	if (strcmp(udev->subsystem, "block") == 0)
 		udev->type = 'b';
-
-	if (strcmp(udev->subsystem, "net") == 0)
+	else if (strcmp(udev->subsystem, "net") == 0)
 		udev->type = 'n';
-
-	if (strncmp(udev->devpath, "/block/", 7) == 0)
+	else if (strncmp(udev->devpath, "/block/", 7) == 0)
 		udev->type = 'b';
-
-	if (strncmp(udev->devpath, "/class/net/", 11) == 0)
+	else if (strncmp(udev->devpath, "/class/net/", 11) == 0)
 		udev->type = 'n';
-
-	if (strncmp(udev->devpath, "/class/", 7) == 0)
+	else if (strncmp(udev->devpath, "/class/", 7) == 0)
 		udev->type = 'c';
 }
 

--=-yXzIELDcXJB7zFcFMBnv--

