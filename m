Return-Path: <linux-kernel-owner+w=401wt.eu-S965164AbWLTVUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWLTVUQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWLTVTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:19:47 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:41296 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030290AbWLTVTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:19:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Nm7BDR0H9hG2sLick8BEXUAYX4/CojXwqPQME8JeJRo+4ApYIKcME8NkTugghaxheWoTz53Zh+Y8RjWcqroNrgJNlPlJWsfqrtpOXZI2HA965wmaAK3wE/wQigWSw9Z3pS/FTSVKTwNdM10GM4McdkllS4jY03unrOo+2LiPcHg=  ;
X-YMail-OSG: crbOizQVM1lnj2GsaLFAacdAQToRCGp5zGQ14ODA5ZqXukDYMorWz0FZx2L1qa.gI3rXY3pv_hIJFjfACSbGLEozVGqLuF9W96DJNMyqRzSgPIPnXlhtdG13MJfs43MS07L0hMNCs.qdAwAy46XVJ9m0nKOGng3gzEA-
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Date: Wed, 20 Dec 2006 13:12:35 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612201304.03912.david-b@pacbell.net>
In-Reply-To: <200612201304.03912.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612201312.36616.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arch-neutral GPIO calls for PXA.

From: Philipp Zabel <philipp.zabel@gmail.com>

Index: at91/include/asm-arm/arch-pxa/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ at91/include/asm-arm/arch-pxa/gpio.h	2006-12-19 02:06:39.000000000 -0800
@@ -0,0 +1,72 @@
+/*
+ * linux/include/asm-arm/arch-pxa/gpio.h
+ *
+ * PXA GPIO wrappers for arch-neutral GPIO calls
+ *
+ * Written by Philipp Zabel <philipp.zabel@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#ifndef __ASM_ARCH_PXA_GPIO_H
+#define __ASM_ARCH_PXA_GPIO_H
+
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/irqs.h>
+#include <asm/arch/hardware.h>
+
+#include <asm/errno.h>
+
+static inline int gpio_request(unsigned gpio, const char *label)
+{
+	return 0;
+}
+
+static inline void gpio_free(unsigned gpio)
+{
+	return;
+}
+
+static inline int gpio_direction_input(unsigned gpio)
+{
+	if (gpio > PXA_LAST_GPIO)
+		return -EINVAL;
+	pxa_gpio_mode(gpio | GPIO_IN);
+}
+
+static inline int gpio_direction_output(unsigned gpio)
+{
+	if (gpio > PXA_LAST_GPIO)
+		return -EINVAL;
+	pxa_gpio_mode(gpio | GPIO_OUT);
+}
+
+/* REVISIT these macros are correct, but suffer code explosion
+ * for non-constant parameters.  Provide out-line versions too.
+ */
+#define gpio_get_value(gpio) \
+	(GPLR(gpio) & GPIO_bit(gpio))
+
+#define gpio_set_value(gpio,value) \
+	((value) ? (GPSR(gpio) = GPIO_bit(gpio)):(GPCR(gpio) = GPIO_bit(gpio)))
+
+#include <asm-generic/gpio.h>			/* cansleep wrappers */
+
+#define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
+#define irq_to_gpio(irq)	IRQ_TO_GPIO(irq)
+
+
+#endif
