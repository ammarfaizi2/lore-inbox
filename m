Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUATMkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 07:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUATMkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 07:40:20 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:56278 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265476AbUATMkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 07:40:08 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 20 Jan 2004 13:44:52 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] new module args for ir-kbd-*.c
Message-ID: <20040120124452.GA19988@bytesex.org>
References: <20040115115611.GA16266@bytesex.org> <20040120020710.8F8F62C280@lists.samba.org> <20040120093054.GC18096@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120093054.GC18096@bytesex.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 20, 2004 at 12:55:39PM +1100, Rusty Russell wrote:
> > Please replace the MODULE_PARM lines with the modern form:
> > 
> > 	module_param(repeat, bool, 0644);
> > 	module_param(debug, int, 0644);
> 
> I'll do for the bttv ir support, that is 2.6 only anyway due to the
> usage of tasklets.

Here we go.

  Gerd

==============================[ cut here ]==============================
diff -u linux-2.6.1-mm5/drivers/media/video/ir-kbd-i2c.c linux/drivers/media/video/ir-kbd-i2c.c
--- linux-2.6.1-mm5/drivers/media/video/ir-kbd-i2c.c	2004-01-20 12:59:51.491270352 +0100
+++ linux/drivers/media/video/ir-kbd-i2c.c	2004-01-20 13:03:04.982855160 +0100
@@ -25,6 +25,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -55,8 +56,7 @@
 /* ----------------------------------------------------------------------- */
 /* insmod parameters                                                       */
 
-static int debug = 0;    /* debug level (0,1,2) */
-MODULE_PARM(debug,"i");
+module_param(debug, int, 0644);    /* debug level (0,1,2) */
 
 #define DEVNAME "ir-kbd-i2c"
 #define dprintk(level, fmt, arg...)	if (debug >= level) \
diff -u linux-2.6.1-mm5/drivers/media/video/ir-kbd-gpio.c linux/drivers/media/video/ir-kbd-gpio.c
--- linux-2.6.1-mm5/drivers/media/video/ir-kbd-gpio.c	2004-01-20 12:59:51.490270504 +0100
+++ linux/drivers/media/video/ir-kbd-gpio.c	2004-01-20 13:03:05.080840264 +0100
@@ -18,6 +18,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/delay.h>
@@ -170,8 +171,7 @@
 	struct timer_list       timer;
 };
 
-static int debug = 0;    /* debug level (0,1,2) */
-MODULE_PARM(debug,"i");
+module_param(debug, int, 0644);    /* debug level (0,1,2) */
 
 #define DEVNAME "ir-kbd-gpio"
 #define dprintk(fmt, arg...)	if (debug) \
