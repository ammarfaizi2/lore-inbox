Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVKMVvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVKMVvy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVKMVvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:51:54 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:34259
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750728AbVKMVvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:51:53 -0500
Subject: Re: [PATCH] rt11 Fill out default_simple_type
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, trini@kernel.crashing.org,
       sdietrich@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051112144816.GA24942@elte.hu>
References: <Pine.LNX.4.64.0511120639420.15898@dhcp153.mvista.com>
	 <20051112144816.GA24942@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 13 Nov 2005 22:56:15 +0100
Message-Id: <1131918975.32542.61.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 15:48 +0100, Ingo Molnar wrote:
> doesnt apply. Also, the set_type line has whitespace damage.
> 
> 	Ingo

I have integrated the initial patch from Tom Rini into the arm generic
irq patch set.

http://www.tglx.de/projects/armirq/

	tglx

-------- Forwarded Message --------
From: Tom Rini <trini@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ARM genirqs on OMAP
Date: Thu, 10 Nov 2005 10:11:12 -0700

Here it all is.  I've been talking with Daniel right now and got it all
trimmed down:

Signed-off-by: Tom Rini <trini@kernel.crashing.org>
Signed-off-by: Daniel Walker <dwalker@mvista.com>
 arch/arm/mach-omap1/board-osk.c |    2 +-
 arch/arm/plat-omap/gpio.c       |    2 +-
 kernel/irq/handle.c             |    5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.14/arch/arm/mach-omap1/board-osk.c
===================================================================
--- linux-2.6.14.orig/arch/arm/mach-omap1/board-osk.c
+++ linux-2.6.14/arch/arm/mach-omap1/board-osk.c
@@ -29,7 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>
-#include <linux/interrupt.h>
+#include <linux/irq.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
Index: linux-2.6.14/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-2.6.14.orig/arch/arm/plat-omap/gpio.c
+++ linux-2.6.14/arch/arm/plat-omap/gpio.c
@@ -736,7 +736,7 @@ static void gpio_irq_handler(unsigned in
 
        desc->chip->ack(irq);
 
-       bank = (struct gpio_bank *) desc->data;
+       bank = (struct gpio_bank *) desc->handler_data;
        if (bank->method == METHOD_MPUIO)
                isr_reg = bank->base + OMAP_MPUIO_GPIO_INT;
 #ifdef CONFIG_ARCH_OMAP1510
Index: linux-2.6.14/kernel/irq/handle.c
===================================================================
--- linux-2.6.14.orig/kernel/irq/handle.c
+++ linux-2.6.14/kernel/irq/handle.c
@@ -196,8 +196,9 @@ struct irq_type default_level_type = {
  */
 struct irq_type default_simple_type = {
        .typename       = "default_simple",
-       .enable         = noop,
-       .disable        = noop,
+       .enable         = default_enable,
+       .disable        = default_disable,
+       .set_type       = default_set_type,
        .handle_irq     = handle_simple_irq,
 };


