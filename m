Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUAZVQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUAZVQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:16:23 -0500
Received: from palrel10.hp.com ([156.153.255.245]:1995 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265282AbUAZVQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:16:04 -0500
Date: Mon, 26 Jan 2004 13:16:03 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: [patch] 2.6.2-rc2: link error with IrDA drivers
Message-ID: <20040126211603.GA17646@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.LNX.4.58.0401251844440.32583@home.osdl.org> <20040126205829.GF513@fs.tum.de> <20040126.125713.39171691.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126.125713.39171691.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 12:57:13PM -0800, David S. Miller wrote:
>    From: Adrian Bunk <bunk@fs.tum.de>
>    Date: Mon, 26 Jan 2004 21:58:29 +0100
> 
>    This change causes the following compile error when trying to compile 
>    an old plus a new version of one driver statically into the kernel:
> 
> That's not the right fix, just mark these init routines static.
> 
> I'll do that, thanks for the report.

	I've just sent the following patch to Andrew (following his
bug report), and I think it's slightly better and safer. Sorry I
forgot to cc you.

	Jean

---------------------------------------------------------

diff -u -p linux/drivers/net/irda.d6b/act200l-sir.c linux/drivers/net/irda/act200l-sir.c
--- linux/drivers/net/irda.d6b/act200l-sir.c	Thu Jan 22 16:43:35 2004
+++ linux/drivers/net/irda/act200l-sir.c	Mon Jan 26 09:42:08 2004
@@ -93,12 +93,12 @@ static struct dongle_driver act200l = {
 	.set_speed	= act200l_change_speed,
 };
 
-int __init act200l_init(void)
+int __init act200l_sir_init(void)
 {
 	return irda_register_dongle(&act200l);
 }
 
-void __exit act200l_cleanup(void)
+void __exit act200l_sir_cleanup(void)
 {
 	irda_unregister_dongle(&act200l);
 }
@@ -254,5 +254,5 @@ MODULE_DESCRIPTION("ACTiSYS ACT-IR200L d
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-10"); /* IRDA_ACT200L_DONGLE */
 
-module_init(act200l_init);
-module_exit(act200l_cleanup);
+module_init(act200l_sir_init);
+module_exit(act200l_sir_cleanup);
diff -u -p linux/drivers/net/irda.d6b/girbil-sir.c linux/drivers/net/irda/girbil-sir.c
--- linux/drivers/net/irda.d6b/girbil-sir.c	Thu Jan 22 16:43:39 2004
+++ linux/drivers/net/irda/girbil-sir.c	Mon Jan 26 09:39:51 2004
@@ -72,12 +72,12 @@ static struct dongle_driver girbil = {
 	.set_speed	= girbil_change_speed,
 };
 
-int __init girbil_init(void)
+int __init girbil_sir_init(void)
 {
 	return irda_register_dongle(&girbil);
 }
 
-void __exit girbil_cleanup(void)
+void __exit girbil_sir_cleanup(void)
 {
 	irda_unregister_dongle(&girbil);
 }
@@ -254,5 +254,5 @@ MODULE_DESCRIPTION("Greenwich GIrBIL don
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-4"); /* IRDA_GIRBIL_DONGLE */
 
-module_init(girbil_init);
-module_exit(girbil_cleanup);
+module_init(girbil_sir_init);
+module_exit(girbil_sir_cleanup);
diff -u -p linux/drivers/net/irda.d6b/mcp2120-sir.c linux/drivers/net/irda/mcp2120-sir.c
--- linux/drivers/net/irda.d6b/mcp2120-sir.c	Thu Jan 22 16:43:49 2004
+++ linux/drivers/net/irda/mcp2120-sir.c	Mon Jan 26 09:41:41 2004
@@ -49,12 +49,12 @@ static struct dongle_driver mcp2120 = {
 	.set_speed	= mcp2120_change_speed,
 };
 
-int __init mcp2120_init(void)
+int __init mcp2120_sir_init(void)
 {
 	return irda_register_dongle(&mcp2120);
 }
 
-void __exit mcp2120_cleanup(void)
+void __exit mcp2120_sir_cleanup(void)
 {
 	irda_unregister_dongle(&mcp2120);
 }
@@ -226,5 +226,5 @@ MODULE_DESCRIPTION("Microchip MCP2120");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-9"); /* IRDA_MCP2120_DONGLE */
 
-module_init(mcp2120_init);
-module_exit(mcp2120_cleanup);
+module_init(mcp2120_sir_init);
+module_exit(mcp2120_sir_cleanup);
diff -u -p linux/drivers/net/irda.d6b/old_belkin-sir.c linux/drivers/net/irda/old_belkin-sir.c
--- linux/drivers/net/irda.d6b/old_belkin-sir.c	Thu Jan 22 16:43:52 2004
+++ linux/drivers/net/irda/old_belkin-sir.c	Mon Jan 26 09:41:06 2004
@@ -78,12 +78,12 @@ static struct dongle_driver old_belkin =
 	.set_speed	= old_belkin_change_speed,
 };
 
-int __init old_belkin_init(void)
+int __init old_belkin_sir_init(void)
 {
 	return irda_register_dongle(&old_belkin);
 }
 
-void __exit old_belkin_cleanup(void)
+void __exit old_belkin_sir_cleanup(void)
 {
 	irda_unregister_dongle(&old_belkin);
 }
@@ -152,5 +152,5 @@ MODULE_DESCRIPTION("Belkin (old) SmartBe
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-7"); /* IRDA_OLD_BELKIN_DONGLE */
 
-module_init(old_belkin_init);
-module_exit(old_belkin_cleanup);
+module_init(old_belkin_sir_init);
+module_exit(old_belkin_sir_cleanup);
