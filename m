Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTJJKEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 06:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbTJJKEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 06:04:09 -0400
Received: from gprs148-28.eurotel.cz ([160.218.148.28]:40320 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262770AbTJJKEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 06:04:07 -0400
Date: Fri, 10 Oct 2003 12:03:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: failing unregister_ioctl32 is pretty fatal condition -- fix up message level
Message-ID: <20031010100353.GA5481@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

AFAICS, kernel is likely to crash if someone does said ioctl after
failed unregister. Please apply,
							Pavel

Index: linux/drivers/ieee1394/video1394.c
===================================================================
--- linux.orig/drivers/ieee1394/video1394.c	2003-10-09 00:40:50.000000000 +0200
+++ linux/drivers/ieee1394/video1394.c	2003-09-09 12:59:48.000000000 +0200
@@ -1424,7 +1424,7 @@
 	ret |= unregister_ioctl32_conversion(VIDEO1394_IOC32_TALK_WAIT_BUFFER);
 	ret |= unregister_ioctl32_conversion(VIDEO1394_IOC32_LISTEN_POLL_BUFFER);
 	if (ret)
-		PRINT_G(KERN_INFO, "Error unregistering ioctl32 translations");
+		PRINT_G(KERN_CRIT, "Error unregistering ioctl32 translations");
 #endif
 
 	hpsb_unregister_protocol(&video1394_driver);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
