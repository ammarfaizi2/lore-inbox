Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWAYTpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWAYTpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWAYTpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:45:08 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:53441 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932145AbWAYTpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:45:07 -0500
Date: Wed, 25 Jan 2006 13:45:01 -0600
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Rocky Craig <rocky.craig@hp.com>
Subject: [PATCH] IPMI remove invalid acpi register spacing check
Message-ID: <20060125194501.GA949@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could this go in for 2.6.16?  It has been well-tested.

At the 2.6.12 timeframe ipmi_si_intf.c was patched to provide
default register spacings in try_init_acpi() if the register
spacing was set to zero, similar to code in other routines.
Unfortunately, another patch was simultaneously added that
exits early from try_init_acpi() if the register spacings
are set to zero, circumventing the new defaults.  This patch
removes the early exit code and some incorrect comments that
aren't present in other common code snippets.

Signed-off-by: Rocky Craig <rocky.craig@hp.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.15/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.15.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.15/drivers/char/ipmi/ipmi_si_intf.c
@@ -1580,11 +1580,6 @@ static int try_init_acpi(int intf_num, s
 	if (! is_new_interface(-1, addr_space, spmi->addr.address))
 		return -ENODEV;
 
-	if (! spmi->addr.register_bit_width) {
-		acpi_failure = 1;
-		return -ENODEV;
-	}
-
 	/* Figure out the interface type. */
 	switch (spmi->InterfaceType)
 	{
@@ -1634,9 +1629,6 @@ static int try_init_acpi(int intf_num, s
 		regspacings[intf_num] = spmi->addr.register_bit_width / 8;
 		info->io.regspacing = spmi->addr.register_bit_width / 8;
 	} else {
-		/* Some broken systems get this wrong and set the value
-		 * to zero.  Assume it is the default spacing.  If that
-		 * is wrong, too bad, the vendor should fix the tables. */
 		regspacings[intf_num] = DEFAULT_REGSPACING;
 		info->io.regspacing = DEFAULT_REGSPACING;
 	}
