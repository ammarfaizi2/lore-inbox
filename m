Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbTEONqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTEONqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:46:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25350 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264021AbTEONqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 09:46:34 -0400
Date: Thu, 15 May 2003 14:59:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@osdl.org>
Subject: [PATCH] IRQ and resource for platform_device
Message-ID: <20030515145920.B31491@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The location and interrupt of some platform devices are only known by
platform specific code.  In order to avoid putting platform specific
parameters into drivers, place resource and irq members into struct
platform_device.

Discussion point: is one resource and one irq enough?

--- orig/include/linux/device.h	Mon May  5 17:40:10 2003
+++ linux/include/linux/device.h	Wed May 14 15:35:40 2003
@@ -29,6 +29,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/ioport.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
 
@@ -388,6 +389,8 @@
 	char		* name;
 	u32		id;
 	struct device	dev;
+	struct resource	res;
+	unsigned int	irq;
 };
 
 extern int platform_device_register(struct platform_device *);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

