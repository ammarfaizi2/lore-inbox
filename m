Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268987AbUJELry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268987AbUJELry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUJELrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:47:53 -0400
Received: from mail.convergence.de ([212.227.36.84]:61603 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268987AbUJELrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:47:51 -0400
Message-ID: <416289B9.2080208@linuxtv.org>
Date: Tue, 05 Oct 2004 13:47:05 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6] Fix error path in Video4Linux dpc7146 driver
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020300090409060907040406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020300090409060907040406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch fixes an error path in my dpc7146 Video4Linux driver.

The I2C adapter wasn't de-registered correctly in case the video card 
wasn't found. When the I2C subsystem tried to speak with the dangling 
I2C adapter later on, usually an oops happened.

Please apply.

Regards
Michael Hunold.

--------------020300090409060907040406
Content-Type: text/plain;
 name="v4l_dpc7146_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_dpc7146_fix.diff"

diff -ura linux-2.6.9-rc3/drivers/media/video/dpc7146.c b/drivers/media/video/dpc7146.c
--- linux-2.6.9-rc3/drivers/media/video/dpc7146.c	2004-10-05 13:34:45.000000000 +0200
+++ b/drivers/media/video/dpc7146.c	2004-10-05 13:40:54.000000000 +0200
@@ -123,6 +123,7 @@
 	/* check if all devices are present */
 	if( 0 == dpc->saa7111a ) {
 		DEB_D(("dpc_v4l2.o: dpc_attach failed for this device.\n"));	
+		i2c_del_adapter(&dpc->i2c_adapter);
 		kfree(dpc);
 		return -ENODEV;
 	}

--------------020300090409060907040406--
