Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbTIUS7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 14:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTIUS7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 14:59:39 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:5044 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S262534AbTIUS7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 14:59:38 -0400
Date: Sun, 21 Sep 2003 22:59:22 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [PATCH] [2.4] devio.c memleak on unexpected disconnect
Message-ID: <20030921185922.GA1185@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  There is a memleak in devio.c (User space communication with USB devices)
  recently added, it forgets to free the buffer if device was disconnected.

  The patch is trivial, please apply.
  Found with help of smatch.


===== drivers/usb/devio.c 1.17 vs edited =====
--- 1.17/drivers/usb/devio.c	Mon Aug 19 20:49:38 2002
+++ edited/drivers/usb/devio.c	Sun Sep 21 22:51:15 2003
@@ -1114,7 +1114,7 @@
                        usb_driver_release_interface (driver, ifp);
                        up (&driver->serialize);
                } else
-                       return -ENODATA;
+                       retval = -ENODATA;
                break;
 
        /* let kernel drivers try to (re)bind to the interface */
