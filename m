Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVFVQgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVFVQgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFVQeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:34:08 -0400
Received: from p-mail1.rd.francetelecom.com ([195.101.245.15]:55301 "EHLO
	p-mail1.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S261589AbVFVQcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:32:47 -0400
Subject: [PATCH] Adapt drivers/char/vt_ioctl.c to non-x86.
From: zze-COLBUS Emmanuel RD-MAPS-GRE 
	<emmanuel.colbus@rd.francetelecom.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 22 Jun 2005 18:32:41 +0200
Message-Id: <1119457961.4372.19.camel@g-xw4200-6.rd.francetelecom.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2005 16:32:42.0284 (UTC) FILETIME=[0312C6C0:01C57748]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I think there is a bug in drivers/char/vt_ioctl.c. This code uses the
x86 (non-AMD-ELAN) value of CLOCK_TICK_RATE instead of CLOCK_TICK_RATE
itself, which is wrong for other archs.

This patch fixes it.

BTW, who is the maintainer of the text-mode console code? I couldn't
find it in the MAINTAINER file.

Signed-off-by: Emmanuel Colbus <emmanuel.colbus@ensimag.imag.fr>


--- drivers/char/vt_ioctl_old.c 2005-06-22 18:04:21.912145025 +0200
+++ drivers/char/vt_ioctl.c     2005-06-22 17:59:54.867498294 +0200
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/console.h>
 #include <linux/signal.h>
+#include <linux/timex.h>

 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -386,7 +387,7 @@
 		if (!perm)
 			return -EPERM;
 		if (arg)
-			arg = 1193182 / arg;
+			arg = CLOCK_TICK_RATE / arg;
 		kd_mksound(arg, 0);
 		return 0;

@@ -403,7 +404,7 @@
 		ticks = HZ * ((arg >> 16) & 0xffff) / 1000;
 		count = ticks ? (arg & 0xffff) : 0;
 		if (count)
-			count = 1193182 / count;
+			count = CLOCK_TICK_RATE / count;
 		kd_mksound(count, ticks);
 		return 0;
 	}



