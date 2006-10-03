Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWJCTqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWJCTqh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWJCTqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:46:36 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:43944 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S964893AbWJCTqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:46:36 -0400
Message-ID: <4522BE19.1070103@free.fr>
Date: Tue, 03 Oct 2006 21:46:33 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: [PATCH 1/3] UEAGLE : be suspend friendly
Content-Type: multipart/mixed;
 boundary="------------040703050103070407090707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040703050103070407090707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


this patch avoid that the kernel thread block the suspend process.
Some work is still need to recover after a resume.


Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>



--------------040703050103070407090707
Content-Type: text/plain;
 name="eagle-suspend"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eagle-suspend"

this patch avoid that the kernel thread block the suspend process.
Some work is still need to recover after a resume.

Signed-off-by: matthieu castet <castet.matthieu@free.fr>
Index: linux/drivers/usb/atm/ueagle-atm.c
===================================================================
--- linux.orig/drivers/usb/atm/ueagle-atm.c	2006-09-22 21:39:56.000000000 +0200
+++ linux/drivers/usb/atm/ueagle-atm.c	2006-09-22 21:40:45.000000000 +0200
@@ -1177,6 +1177,9 @@
 			ret = uea_stat(sc);
 		if (ret != -EAGAIN)
 			msleep(1000);
+ 		if (try_to_freeze())
+			uea_err(INS_TO_USBDEV(sc), "suspend/resume not supported, "
+				"please unplug/replug your modem\n");
 	}
 	uea_leaves(INS_TO_USBDEV(sc));
 	return ret;

--------------040703050103070407090707--
