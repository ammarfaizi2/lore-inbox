Return-Path: <linux-kernel-owner+w=401wt.eu-S1030218AbWL3CVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWL3CVs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 21:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWL3CVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 21:21:48 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:24690 "HELO
	smtp104.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030218AbWL3CVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 21:21:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Message-Id;
  b=tPD0jZOSLvUyWrttPAMn+AtutjE47PgRS77cqjCdIonhjbzGp/Jfy1MgfVJTi5g+fK8Hqk8gSUN1284srbqwjhv8XUu+o0eOmrZ36f1zM+jpoChSsn8LbtpasbM/8Gg7spB+pqW7ztNaBLc9Yj62ap3ig1KVayXlfSWJ9wPS/4k=  ;
X-YMail-OSG: IRdoejAVM1kKQCdZ8PQtiyXbVvA.3AQGt.6Xm.PWvO4oejS.n2eDfABXb2ZF0mhvZ9OWcsC4_2VFajYgFuvj.TF.7zE1iWPVv2qvpHtIJh7EHVZKxxQK0mQ2blWJi7.CcCTuVbfpDF2vy_6i3rwtm1rKQEuOoTS_WTCJw8y8EIpVOTFwlSnHD1umvIfM
From: David Brownell <david-b@pacbell.net>
To: "pHilipp Zabel" <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
Date: Fri, 29 Dec 2006 18:21:43 -0800
User-Agent: KMail/1.7.1
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>, "Nicolas Pitre" <nico@cam.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <20061220221328.ee3bfc5d.akpm@osdl.org> <74d0deb30612212316i12090ca0hfe8524a80f63475a@mail.gmail.com>
In-Reply-To: <74d0deb30612212316i12090ca0hfe8524a80f63475a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_40clF66rUNt0aVa"
Message-Id: <200612291821.44675.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_40clF66rUNt0aVa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a version that compiles ...

--Boundary-00=_40clF66rUNt0aVa
Content-Type: text/x-diff;
  charset="us-ascii";
  name="gen-gpio-sa1100.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="gen-gpio-sa1100.patch"

From: Philipp Zabel <philipp.zabel@gmail.com>

Arch-neutral GPIO calls for PXA.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: pxa/include/asm-arm/arch-sa1100/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ pxa/include/asm-arm/arch-sa1100/gpio.h	2006-12-29 18:21:00.000000000 -0800
@@ -0,0 +1,100 @@
+/*
+ * linux/include/asm-arm/arch-sa1100/gpio.h
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
+#include <asm/hardware.h>
+#include <asm/arch/irqs.h>
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
+	GPDR = (GPDR_In << gpio);
+	return 0;
+}
+
+static inline int gpio_direction_output(unsigned gpio)
+{
+	if (gpio > GPIO_MAX)
+		return -EINVAL;
+	GPDR = (GPDR_Out << gpio);
+	return 0;
+}
+
+extern int sa1100_gpio_get_value(unsigned gpio);
+extern void sa1100_gpio_set_value(unsigned gpio, int value);
+
+static inline int __gpio_get_value(unsigned gpio)
+{
+	return GPLR & GPIO_GPIO(gpio);
+}
+
+#define gpio_get_value(gpio)			\
+	(__builtin_constant_p(gpio)		\
+	? __gpio_get_value(gpio)		\
+	: sa1100_gpio_get_value(gpio))
+
+static inline void __gpio_set_value(unsigned gpio, int value)
+{
+	if (value)
+		GPSR = GPIO_GPIO(gpio);
+	else
+		GPCR = GPIO_GPIO(gpio);
+}
+
+#define gpio_set_value(gpio,value)		\
+	(__builtin_constant_p(gpio)		\
+	? __gpio_set_value(gpio, value)		\
+	: sa1100_gpio_set_value(gpio, value))
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
Index: pxa/arch/arm/mach-sa1100/generic.c
===================================================================
--- pxa.orig/arch/arm/mach-sa1100/generic.c	2006-12-10 01:30:42.000000000 -0800
+++ pxa/arch/arm/mach-sa1100/generic.c	2006-12-29 17:46:47.000000000 -0800
@@ -28,6 +28,8 @@
 #include <asm/mach/flash.h>
 #include <asm/irq.h>
 
+#include <asm/arch/gpio.h>
+
 #include "generic.h"
 
 #define NR_FREQS	16
@@ -139,6 +141,26 @@ unsigned long long sched_clock(void)
 }
 
 /*
+ * Return GPIO level
+ */
+int sa1100_gpio_get_value(unsigned gpio)
+{
+	return __gpio_get_value(gpio);
+}
+
+EXPORT_SYMBOL(sa1100_gpio_get_value);
+
+/*
+ * Set output GPIO level
+ */
+void sa1100_gpio_set_value(unsigned gpio, int value)
+{
+	__gpio_set_value(gpio, value);
+}
+
+EXPORT_SYMBOL(sa1100_gpio_set_value);
+
+/*
  * Default power-off for SA1100
  */
 static void sa1100_power_off(void)

--Boundary-00=_40clF66rUNt0aVa--
