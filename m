Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVCBHMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVCBHMG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 02:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVCBHMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 02:12:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:12179 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262205AbVCBHMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 02:12:03 -0500
Date: Tue, 1 Mar 2005 23:11:47 -0800
From: Greg KH <greg@kroah.com>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix module paramater permissions in radeon_base.c
Message-ID: <20050302071147.GA29444@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You really don't want -2 for the file mode in sysfs.  It creates:
  -rwsrwsrwT  1 root root 4096 Mar  1 22:59 /sys/module/radeonfb/parameters/default_dynclk

on my box.  Here's a fix against a clean 2.6.11-rc5 kernel, please
forward onward as you see fit.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


--- 1.27/drivers/video/aty/radeon_base.c	2005-02-24 11:40:00 -08:00
+++ edited/drivers/video/aty/radeon_base.c	2005-03-01 23:09:12 -08:00
@@ -2551,7 +2551,7 @@
 MODULE_DESCRIPTION("framebuffer driver for ATI Radeon chipset");
 MODULE_LICENSE("GPL");
 module_param(noaccel, bool, 0);
-module_param(default_dynclk, int, -2);
+module_param(default_dynclk, int, 0);
 MODULE_PARM_DESC(default_dynclk, "int: -2=enable on mobility only,-1=do not change,0=off,1=on");
 MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
 module_param(nomodeset, bool, 0);
