Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753927AbWKFXcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbWKFXcu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 18:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbWKFXcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 18:32:50 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:26379 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1753927AbWKFXct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 18:32:49 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Wolfgang =?iso-8859-2?q?M=FCes?= <wolfgang@iksw-muees.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc4] usb auerswald possible memleak fix
Date: Tue, 7 Nov 2006 00:31:51 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <gregkh@suse.de>
References: <200611061903.09320.m.kozlowski@tuxland.pl>
In-Reply-To: <200611061903.09320.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611070031.52051.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witam, 

> Hello,
> 
> 	There is possible memleak in auerbuf_setup(). Fix is to replace kfree() with auerbuf_free().
> An argument to usb_free_urb() does not need a check as usb_free_urb() already does that. Not sure if I should
> send this in two separate patches. The patch is against 2.6.19-rc4 (not -mm).

As I posted the bigger usb_free_urb() patch in another mail this one should do only one 
thing which is to fix possible memory leak in auerbuf_setup().

Regards,

	Mariusz Kozlowski

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

diff -up linux-2.6.19-rc4-orig/drivers/usb/misc/auerswald.c linux-2.6.19-rc4/drivers/usb/misc/auerswald.c 
--- linux-2.6.19-rc4-orig/drivers/usb/misc/auerswald.c  2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/auerswald.c     2006-11-07 00:26:25.000000000 +0100
@@ -780,7 +780,7 @@ static int auerbuf_setup (pauerbufctl_t 
 
 bl_fail:/* not enough memory. Free allocated elements */
         dbg ("auerbuf_setup: no more memory");
-       kfree(bep);
+        auerbuf_free (bep);
         auerbuf_free_buffers (bcp);
         return -ENOMEM;
 }
