Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbTLaWnM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbTLaWnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:43:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1551 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265276AbTLaWm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:42:59 -0500
Date: Wed, 31 Dec 2003 22:42:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix "echo -n 3 > /sys/.../power/state"
Message-ID: <20031231224255.A23414@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix what seems to be a typo preventing .../power/state from working.

--- orig/drivers/base/power/sysfs.c	Sat Aug 23 10:10:37 2003
+++ linux/drivers/base/power/sysfs.c	Wed Dec 31 22:39:08 2003
@@ -36,7 +36,7 @@
 	int error = 0;
 
 	state = simple_strtoul(buf,&rest,10);
-	if (rest)
+	if (*rest)
 		return -EINVAL;
 	if (state)
 		error = dpm_runtime_suspend(dev,state);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
