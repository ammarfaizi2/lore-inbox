Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVAHIrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVAHIrE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVAHIrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:47:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:59013 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261890AbVAHFsa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:30 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632633234@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:43 -0800
Message-Id: <11051632632994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.33, 2004/12/22 13:50:21-08:00, davej@redhat.com

[PATCH] driver core: Fix up vesafb failure probing.

bus.c file invokes a probe callback for most devices in a list, then checks
for -ENODEV return ("no such device"), if so it remains silent. However, some
drivers (including vesafb.c) may return -ENXIO ("no such device or address"),
which is indeed error -6.

I shut up the warning with the attached patch, that basically ignores
both -ENODEV and -ENXIO.

>From https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=125890

original patch by:  Alessandro Suardi <alessandro.suardi@oracle.com>
Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2005-01-07 15:39:53 -08:00
+++ b/drivers/base/bus.c	2005-01-07 15:39:53 -08:00
@@ -326,7 +326,7 @@
 			if (!error)
 				/* success, driver matched */
 				return 1;
-			if (error != -ENODEV)
+			if (error != -ENODEV && error != -ENXIO)
 				/* driver matched but the probe failed */
 				printk(KERN_WARNING
 				    "%s: probe of %s failed with error %d\n",

