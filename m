Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUGOV4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUGOV4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUGOV4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:56:32 -0400
Received: from colin2.muc.de ([193.149.48.15]:57618 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266389AbUGOVzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:55:54 -0400
Date: 15 Jul 2004 23:55:52 +0200
Date: Thu, 15 Jul 2004 23:55:52 +0200
From: Andi Kleen <ak@muc.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, irda-users@lists.sourceforge.net, jt@hpl.hp.com,
       the_nihilant@autistici.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop ISA dependencies from IRDA drivers
Message-ID: <20040715215552.GA46635@muc.de>
References: <m34qo96x8m.fsf@averell.firstfloor.org> <40F6B547.7050800@pobox.com> <20040715205001.GA2527@muc.de> <40F6F076.2080001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F6F076.2080001@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 05:00:38PM -0400, Jeff Garzik wrote:
> >There is great value. Basically most ISA drivers are not 64bit 
> >clean (if they even still work on i386 which is also often doubtful
> >in 2.6) and it is a great way for 64bit archs to get rid of a lot 
> >of not working code.
> 
> I file that under "hiding bugs", since it will not be immediately 
> obvious to a bug hunter or maintainer what the real problem is.

They should be already aware that most ISA drivers are just 
not maintained anymore and very likely broken. I doubt there is any bug 
hunter or maintainer who is not aware of this fact.

> If a driver is broken on 64-bit, please add "&& !64BIT" to the Kconfig.
> 
> As you yourself just explained, your wish is to use CONFIG_ISA, but your 
> intent is only coincedentally related to ISA.

There are no x86-64 machines with ISA slots. I think it is very related
to ISA to disable drivers that are not used since the hardware has 
no physical mean to support it (yes, I am aware of PCMCIA, but that
is not included in CONFIG_ISA). Same reason to not support
CONFIG_EISA. LPC devices in southbridges are a different thing, but
there doesn't seem to be any reason right now to add a CONFIG_LPC.
If there was one I would have no problems with setting it.

Anyways, this is only tangential to the original reason for the patch.
Can you please drop the bogus ISA dependencies. Jean has clearly stated
that the drivers have nothing to do with ISA itself.

Here's the patch again for your convenience.

-Andi


--------------------------------------------------------------------

Remove wrong ISA dependencies for IRDA drivers.


diff -u linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig-o linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig
--- linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig-o	2004-07-12 06:09:05.000000000 +0200
+++ linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig	2004-07-15 18:33:48.000000000 +0200
@@ -310,7 +310,7 @@
 
 config NSC_FIR
 	tristate "NSC PC87108/PC87338"
-	depends on IRDA && ISA
+	depends on IRDA
 	help
 	  Say Y here if you want to build support for the NSC PC87108 and
 	  PC87338 IrDA chipsets.  This driver supports SIR,
@@ -321,7 +321,7 @@
 
 config WINBOND_FIR
 	tristate "Winbond W83977AF (IR)"
-	depends on IRDA && ISA
+	depends on IRDA
 	help
 	  Say Y here if you want to build IrDA support for the Winbond
 	  W83977AF super-io chipset.  This driver should be used for the IrDA
@@ -347,7 +347,7 @@
 
 config SMC_IRCC_FIR
 	tristate "SMSC IrCC (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && IRDA && ISA
+	depends on EXPERIMENTAL && IRDA
 	help
 	  Say Y here if you want to build support for the SMC Infrared
 	  Communications Controller.  It is used in a wide variety of
@@ -357,7 +357,7 @@
 
 config ALI_FIR
 	tristate "ALi M5123 FIR (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && IRDA && ISA
+	depends on EXPERIMENTAL && IRDA
 	help
 	  Say Y here if you want to build support for the ALi M5123 FIR
 	  Controller.  The ALi M5123 FIR Controller is embedded in ALi M1543C,
@@ -385,7 +385,7 @@
 
 config VIA_FIR
 	tristate "VIA VT8231/VT1211 SIR/MIR/FIR"
-	depends on IRDA && ISA
+	depends on IRDA
 	help
 	  Say Y here if you want to build support for the VIA VT8231
 	  and VIA VT1211 IrDA controllers, found on the motherboards using
