Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTJFVNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTJFVNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:13:30 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:44777 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S261838AbTJFVN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:13:29 -0400
Message-ID: <3F81DBC1.4010003@terra.com.br>
Date: Mon, 06 Oct 2003 18:16:49 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: lethal@chaoticdreams.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] memory leak in imsttfb video driver
Content-Type: multipart/mixed;
 boundary="------------090906050606070600030002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090906050606070600030002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Paul,

	Patch against 2.6.0-test6.

	- Fixes 2 leaks in imsttfb driver: Frees the info struct imstt_par 
and releases the mem region if the device type is unknown.

	Found by smatch.

	Please consider applying,

	Thanks.

Felipe

--------------090906050606070600030002
Content-Type: text/plain;
 name="imsttfb-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="imsttfb-leak.patch"

--- linux-2.6.0-test6/drivers/video/imsttfb.c.orig	2003-10-06 18:03:53.000000000 -0300
+++ linux-2.6.0-test6/drivers/video/imsttfb.c	2003-10-06 18:12:30.000000000 -0300
@@ -1495,6 +1495,8 @@
 		default:
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
+			kfree(info);
+			release_mem_region(addr, size);
 			return -ENODEV;
 	}
 

--------------090906050606070600030002--

