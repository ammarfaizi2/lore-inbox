Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272789AbTG3Ha1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272794AbTG3Ha0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:30:26 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:9996 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S272789AbTG3HaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:30:21 -0400
Date: Wed, 30 Jul 2003 09:29:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.22-pre9 : ACPI poweroff fix
Message-ID: <20030730072919.GA5773@alpha.home.local>
References: <F760B14C9561B941B89469F59BA3A847E97074@orsmsx401.jf.intel.com> <Pine.LNX.4.55L.0307241801260.7875@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307241801260.7875@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 06:02:15PM -0300, Marcelo Tosatti wrote:
> 
> Great. I`ll apply it to the 2.4 tree later and it will be present in
> -pre9.

Hi Marcelo,

it seems you forgot the patch in -pre9. Never mind, I've just rediffed it,
here it is.

Cheers,
Willy


diff -urN linux-2.4.22-pre9/drivers/acpi/system.c linux-2.4.22-pre9-fix/drivers/acpi/system.c
--- linux-2.4.22-pre9/drivers/acpi/system.c	Wed Jul 30 09:18:40 2003
+++ linux-2.4.22-pre9-fix/drivers/acpi/system.c	Wed Jul 30 09:21:56 2003
@@ -90,9 +90,7 @@
 static void
 acpi_power_off (void)
 {
-	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
-	ACPI_DISABLE_IRQS();
-	acpi_enter_sleep_state(ACPI_STATE_S5);
+	acpi_suspend(ACPI_STATE_S5);
 }
 
 #endif /*CONFIG_PM*/
@@ -180,7 +178,7 @@
 			return AE_ERROR;
 	}
 
-	if (state < ACPI_STATE_S5) {
+	if (state <= ACPI_STATE_S5) {
 		/* Tell devices to stop I/O and actually save their state.
 		 * It is theoretically possible that something could fail,
 		 * so handle that gracefully..


