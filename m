Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbVLMIb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVLMIb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVLMIbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:31:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:41603 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932551AbVLMIYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:48 -0500
Date: Tue, 13 Dec 2005 00:23:19 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       igor.popik@gmail.com, linux@dominikbrodowski.net
Subject: [patch 17/26] i82365: release all resources if no devices are found
Message-ID: <20051213082319.GQ5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i82365-release-all-resources-if-no-devices-are-found.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Igor Popik <igor.popik@gmail.com>

The i82365 driver does not release all the resources when the device is not
found. This can cause an oops when reading /proc/ioports after module
unload (e.g. bug #5657).

Signed-off-by: Igor Popik <igor.popik@gmail.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pcmcia/i82365.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.14.3.orig/drivers/pcmcia/i82365.c
+++ linux-2.6.14.3/drivers/pcmcia/i82365.c
@@ -1382,6 +1382,7 @@ static int __init init_i82365(void)
     if (sockets == 0) {
 	printk("not found.\n");
 	platform_device_unregister(&i82365_device);
+	release_region(i365_base, 2);
 	driver_unregister(&i82365_driver);
 	return -ENODEV;
     }

--
