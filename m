Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVAPOA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVAPOA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVAPOAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:00:23 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:10988 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262511AbVAPNxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:53:20 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135317.30109.91919.74357@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 8/13] ite_gpio: remove cli()/sti() in drivers/char/ite_gpio.c
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:53:17 -0600
Date: Sun, 16 Jan 2005 07:53:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/ite_gpio.c linux-2.6.11-rc1-mm1/drivers/char/ite_gpio.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/ite_gpio.c	2004-12-24 16:35:15.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/ite_gpio.c	2005-01-16 07:32:19.328552523 -0500
@@ -218,11 +218,10 @@
 	if (ite_gpio_irq_pending[i]==1)
 		return -EFAULT;
 
-	save_flags (flags);
-	cli();
+	local_irq_save(flags);
 	ite_gpio_irq_pending[i] = 1;
 	ret = interruptible_sleep_on_timeout(&ite_gpio_wait[i], 3*HZ);
-	restore_flags (flags);
+	local_irq_restore(flags);
 	ite_gpio_irq_pending[i] = 0;
 
 	return ret;
