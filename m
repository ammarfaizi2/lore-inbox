Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWCVTH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWCVTH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWCVTHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:07:55 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:55036 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932355AbWCVTHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:07:54 -0500
Date: Wed, 22 Mar 2006 12:08:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Stephane@artesyncp.com, rmk+serial@arm.linux.org.uk
Subject: [PATCH 2.6.16-rc6-mm2] serial: mpsc driver has definition of SUPPORT_SYSRQ below include of serial_core.h
Message-ID: <20060322190828.GA22208@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of SUPPORT_SYSRQ must come before #include of serial_core.h.
This patch moves the definition of SUPPORT_SYSRQ to be just after the
#include of config.h to make it consistent with 8250.c.

Reported-by: Stephane Chazelas <Stephane@artesyncp.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 mpsc.h |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)
---

diff -Nurp linux-2.6.16-rc6-mm2-mpsc_namefix/drivers/serial/mpsc.h linux-2.6.16-rc6-mm2-mpsc_sysrq/drivers/serial/mpsc.h
--- linux-2.6.16-rc6-mm2-mpsc_namefix/drivers/serial/mpsc.h	2006-03-11 15:12:55.000000000 -0700
+++ linux-2.6.16-rc6-mm2-mpsc_sysrq/drivers/serial/mpsc.h	2006-03-22 11:50:28.000000000 -0700
@@ -13,6 +13,11 @@
 #define	__MPSC_H__
 
 #include <linux/config.h>
+
+#if defined(CONFIG_SERIAL_MPSC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/tty.h>
@@ -31,10 +36,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#if defined(CONFIG_SERIAL_MPSC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #define	MPSC_NUM_CTLRS		2
 
 /*
