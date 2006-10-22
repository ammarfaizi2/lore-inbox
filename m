Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWJVO50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWJVO50 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 10:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWJVO50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 10:57:26 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:50705 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751122AbWJVO5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 10:57:25 -0400
Date: Sun, 22 Oct 2006 15:57:18 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: [PATCH] Remove __must_check for device_for_each_child()
Message-ID: <20061022145718.GA2156@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate more __must_check madness.

The return code from device_for_each_child() depends on the values
which the helper function returns.  If the helper function always
returns zero, it's utterly pointless to check the return code from
device_for_each_child().

The only code which knows if the return value should be checked is
the caller itself, so forcing the return code to always be checked
is silly.  Hence, remove the __must_check annotation.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/include/linux/device.h b/include/linux/device.h
index 662e6a1..9d4f6a9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -393,7 +393,7 @@ extern void device_unregister(struct dev
 extern void device_initialize(struct device * dev);
 extern int __must_check device_add(struct device * dev);
 extern void device_del(struct device * dev);
-extern int __must_check device_for_each_child(struct device *, void *,
+extern int device_for_each_child(struct device *, void *,
 		     int (*fn)(struct device *, void *));
 extern int device_rename(struct device *dev, char *new_name);
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
