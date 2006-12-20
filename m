Return-Path: <linux-kernel-owner+w=401wt.eu-S1030317AbWLTVVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWLTVVH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWLTVTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:19:43 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:41333 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030324AbWLTVTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:19:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=fg1JIapLvQ0SIiNBmlzFYdVtBboJQLrlpDu+/wEbZFbvZrkKcN2ABDdz+YMHzXVkGY3fTJ6cTusz2Kyukc2JY6+Ur31a2Dfbf72w9x1k4qMqC4Wq8CMHPvrCzyU6GrBYy2YyYcQIfoeaBN44kOwNHbyIfeCAH8cbzeb9P8zBXJo=  ;
X-YMail-OSG: VlX9R6EVM1kU9lJI8npb90o1i8CAUrLsryUaVUVgygNculC0qk1bUOuTq2srxamk3oxiZdgbdFKCi27k.9unLQ1KBH0sz.00ToHhpZZCUFXmEHAjeUFYcP4Riwf.0zY6brQHpH7gbmvNZm7_hJ27SI6I_gE_3KsLi.d3
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.20-rc1 6/6] S3C2410 GPIO wrappers
Date: Wed, 20 Dec 2006 13:14:18 -0800
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
Message-Id: <200612201314.19905.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arch-neutral GPIO calls for S3C24xx.

From: Philipp Zabel <philipp.zabel@gmail.com>

Index: at91/include/asm-arm/arch-s3c2410/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ at91/include/asm-arm/arch-s3c2410/gpio.h	2006-12-19 02:05:52.000000000 -0800
@@ -0,0 +1,65 @@
+/*
+ * linux/include/asm-arm/arch-pxa/gpio.h
+ *
+ * S3C2400 GPIO wrappers for arch-neutral GPIO calls
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
+	s3c2410_gpio_cfgpin(gpio, S3C2410_GPIO_INPUT);
+	return 0;
+}
+
+static inline int gpio_direction_output(unsigned gpio)
+{
+	s3c2410_gpio_cfgpin(gpio, S3C2410_GPIO_OUTPUT);
+	return 0;
+}
+
+#define gpio_get_value(gpio)		s3c2410_gpio_getpin(gpio)
+#define gpio_set_value(gpio,value)	s3c2410_gpio_setpin(gpio, value)
+
+#include <asm-generic/gpio.h>			/* cansleep wrappers */
+
+/* FIXME or maybe s3c2400_gpio_getirq() ... */
+#define gpio_to_irq(gpio)		s3c2410_gpio_getirq(gpio)
+
+/* FIXME implement irq_to_gpio() */
+
+#endif
