Return-Path: <linux-kernel-owner+w=401wt.eu-S1030290AbWLTVUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWLTVUQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWLTVTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:19:46 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:41315 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030317AbWLTVTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:19:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=AwzHPmG8j0Cq+i1fXbMk1Izk7gTa7yLBU4H+fi4v0wKun5PXMz84vwzRNDEwXbgHzCr53T/UVtJgfZzJ69d4GdirvE2pW67Fj/iTFZ9oTppzrpWRbhxcu7FbXoqTm8PX7zgI6OOVXcy9SEUk9DUnTSCcLTBdH2do/rwli+1jVWA=  ;
X-YMail-OSG: u87PDu4VM1ky7D6M4dM4skZDHK83NM7L8ZRm6bOy7n2x3_gw20LCsq6U.0puLklG.3nYzRJzayHaysybRPGvlUmvVqemG3yQ7AY8wituqnXqJtd0xrJiyKf4uur.pAxuCsxy3v7ZHjSL3EffdFDyFSB5XtBZc7S2EEdwIE_UE732qpR8.QX97doNlPfc
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
Date: Wed, 20 Dec 2006 13:13:21 -0800
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
Message-Id: <200612201313.22572.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arch-neutral GPIO calls for SA-1100.

From: Philipp Zabel <philipp.zabel@gmail.com>

Index: at91/include/asm-arm/arch-sa1100/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ at91/include/asm-arm/arch-sa1100/gpio.h	2006-12-19 02:09:08.000000000 -0800
@@ -0,0 +1,81 @@
+/*
+ * linux/include/asm-arm/arch-pxa/gpio.h
+ *
+ * SA1100 GPIO wrappers for arch-neutral GPIO calls
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
+#ifndef __ASM_ARCH_SA1100_GPIO_H
+#define __ASM_ARCH_SA1100_GPIO_H
+
+#include <asm/arch/SA-1100.h>
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
+	if (gpio > GPIO_MAX)
+		return -EINVAL;
+	GPDR = (GPDR_In << gpio) 0
+}
+
+static inline int gpio_direction_output(unsigned gpio)
+{
+	if (gpio > GPIO_MAX)
+		return -EINVAL;
+	GPDR = (GPDR_Out << gpio) 0
+}
+
+#define gpio_get_value(gpio) \
+	(GPLR & GPIO_GPIO(gpio))
+
+#define gpio_set_value(gpio,value) \
+	((value) ? (GPSR = GPIO_GPIO(gpio)) : (GPCR(gpio) = GPIO_GPIO(gpio)))
+
+#include <asm-generic/gpio.h>			/* cansleep wrappers */
+
+static inline unsigned gpio_to_irq(unsigned gpio)
+{
+	if (gpio < 11)
+		return IRQ_GPIO0 + gpio;
+	else
+		return IRQ_GPIO11 - 11 + gpio;
+}
+
+static inline unsigned irq_to_gpio(unsigned irq)
+{
+	if (irq < IRQ_GPIO11_27)
+		return irq - IRQ_GPIO0;
+	else
+		return irq - IRQ_GPIO11 + 11;
+}
+
+#endif
