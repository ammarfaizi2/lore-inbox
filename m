Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbUKQT5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUKQT5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUKQTyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:54:54 -0500
Received: from colino.net ([213.41.131.56]:15602 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262515AbUKQTwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:52:18 -0500
Date: Wed, 17 Nov 2004 20:51:48 +0100
From: Colin Leroy <colin.lkml@colino.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Switch therm_adt746x to new module_param
Message-ID: <20041117205148.23413d38.colin.lkml@colino.net>
In-Reply-To: <419B9BDD.7030805@osdl.org>
References: <20041117193416.52a86d03.colin.lkml@colino.net>
	<419B9BDD.7030805@osdl.org>
X-Mailer: Sylpheed-Claws 0.9.12cvs142.2 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Nov 2004 at 10h11, Randy.Dunlap wrote:

Hi, 

> The last parameter here (64) is not an init. value nor a
> suggested parameter value.
> It's a permission for an entry in /sys (sysfs).
> 0 means not visible there.
> If it should be visible there, use something like
> 0444 (read-only by anyone) or 0644 (read-write by root).

Uh, thank you :)
Updated patch follows:

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/drivers/macintosh/therm_adt746x.c	2004-11-17 19:26:16.908413504 +0100
+++ b/drivers/macintosh/therm_adt746x.c	2004-11-17 19:28:01.193559752 +0100
@@ -23,6 +23,8 @@
 #include <linux/smp_lock.h>
 #include <linux/wait.h>
 #include <linux/suspend.h>
+#include <linux/kthread.h>
+#include <linux/moduleparam.h>
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -30,7 +32,6 @@
 #include <asm/system.h>
 #include <asm/sections.h>
 #include <asm/of_device.h>
-#include <linux/kthread.h>
 
 #undef DEBUG
 
@@ -56,11 +57,11 @@
 		   "Powerbook G4 Alu");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(limit_adjust,"i");
+module_param(limit_adjust, int, 0644);
 MODULE_PARM_DESC(limit_adjust,"Adjust maximum temperatures (50 cpu, 70 gpu) "
 		 "by N degrees.");
 
-MODULE_PARM(fan_speed,"i");
+module_param(fan_speed, int, 0644);
 MODULE_PARM_DESC(fan_speed,"Specify starting fan speed (0-255) "
 		 "(default 64)");
 
