Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTEQUez (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 16:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTEQUez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 16:34:55 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7110 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261823AbTEQUey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 16:34:54 -0400
Date: Sat, 17 May 2003 16:35:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
In-Reply-To: <1053200826.586.3.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.50.0305171626410.2356-100000@montezuma.mastecende.com>
References: <20030514193300.58645206.akpm@digeo.com> 
 <Pine.LNX.4.44.0305141935440.9816-100000@cherise>  <20030514231414.42398dda.akpm@digeo.com>
  <1053000426.605.4.camel@teapot.felipe-alfaro.com> 
 <Pine.LNX.4.50.0305171107090.2356-100000@montezuma.mastecende.com>
 <1053200826.586.3.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 May 2003, Felipe Alfaro Solana wrote:

> The machine is a NEC (Packard Bell) Chrom@. Could an lspci be of
> interest?

Hmm perhaps /var/log/dmesg, also can you try this ugly patch?

Index: linux-2.5.69-mm6/drivers/acpi/hardware/hwsleep.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/drivers/acpi/hardware/hwsleep.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 hwsleep.c
--- linux-2.5.69-mm6/drivers/acpi/hardware/hwsleep.c	6 May 2003 12:20:11 -0000	1.1.1.1
+++ linux-2.5.69-mm6/drivers/acpi/hardware/hwsleep.c	17 May 2003 20:33:20 -0000
@@ -306,7 +306,7 @@ acpi_enter_sleep_state (
 		 * still read the right value. Ideally, this entire block would go
 		 * away entirely.
 		 */
-		acpi_os_stall (10000000);
+		/* acpi_os_stall (10000000); */
 
 		status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1_CONTROL,
 				 sleep_enable_reg_info->access_bit_mask);
Index: linux-2.5.69-mm6/drivers/acpi/sleep/poweroff.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/drivers/acpi/sleep/poweroff.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 poweroff.c
--- linux-2.5.69-mm6/drivers/acpi/sleep/poweroff.c	6 May 2003 12:20:12 -0000	1.1.1.1
+++ linux-2.5.69-mm6/drivers/acpi/sleep/poweroff.c	17 May 2003 20:35:11 -0000
@@ -15,6 +15,7 @@ acpi_power_off (void)
 	printk("%s called\n",__FUNCTION__);
 	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
 	ACPI_DISABLE_IRQS();
+	printk("%s:%d\n", __FUNCTION__, __LINE__);
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
-- 
function.linuxpower.ca
