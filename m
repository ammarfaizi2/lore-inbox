Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbTDHWyj (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTDHWyi (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:54:38 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:38018 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262426AbTDHWyf (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:54:35 -0400
Date: Tue, 8 Apr 2003 19:09:17 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: bwindle-kbt@fint.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 276] reading legacy_device_resources gives msg "Unexpected status"
Message-ID: <20030408190917.GA12637@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, bwindle-kbt@fint.org,
	linux-kernel@vger.kernel.org
References: <200304071759.h37HxqI01703@bugme.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304071759.h37HxqI01703@bugme.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ------- Additional Comments From bwindle-kbt@fint.org  2003-04-07 10:59 -------
> Just an update... on 2.5.66-bk13, doing a cat 
> of /proc/bus/pnp/legacy_device_resources prints these four message to console:
> 
> PnPBIOS: get_stat_res: use ESCD instead
> PnPBIOS: get_stat_res: the message is unsupported
> PnPBIOS: get_stat_res: a hardware failure has occured
> PnPBIOS: get_stat_res: unexpected status 0x8d
> 

This is due to a simple thinko.  Here's the trivial fix.

Regards,
Adam


--- a/drivers/pnp/pnpbios/core.c	2003-04-03 11:20:36.000000000 +0000
+++ b/drivers/pnp/pnpbios/core.c	2003-04-08 19:00:15.000000000 +0000
@@ -252,41 +252,59 @@
 {
 	switch(status) {
 	case PNP_SUCCESS:
-	printk(KERN_ERR "PnPBIOS: %s: function successful\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: function successful\n", module);
+		break;
 	case PNP_NOT_SET_STATICALLY:
-	printk(KERN_ERR "PnPBIOS: %s: unable to set static resources\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: unable to set static resources\n", module);
+		break;
 	case PNP_UNKNOWN_FUNCTION:
-	printk(KERN_ERR "PnPBIOS: %s: invalid function number passed\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: invalid function number passed\n", module);
+		break;
 	case PNP_FUNCTION_NOT_SUPPORTED:
-	printk(KERN_ERR "PnPBIOS: %s: function not supported on this system\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: function not supported on this system\n", module);
+		break;
 	case PNP_INVALID_HANDLE:
-	printk(KERN_ERR "PnPBIOS: %s: invalid handle\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: invalid handle\n", module);
+		break;
 	case PNP_BAD_PARAMETER:
-	printk(KERN_ERR "PnPBIOS: %s: invalid parameters were passed\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: invalid parameters were passed\n", module);
+		break;
 	case PNP_SET_FAILED:
-	printk(KERN_ERR "PnPBIOS: %s: unable to set resources\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: unable to set resources\n", module);
+		break;
 	case PNP_EVENTS_NOT_PENDING:
-	printk(KERN_ERR "PnPBIOS: %s: no events are pending\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: no events are pending\n", module);
+		break;
 	case PNP_SYSTEM_NOT_DOCKED:
-	printk(KERN_ERR "PnPBIOS: %s: the system is not docked\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: the system is not docked\n", module);
+		break;
 	case PNP_NO_ISA_PNP_CARDS:
-	printk(KERN_ERR "PnPBIOS: %s: no isapnp cards are installed on this system\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: no isapnp cards are installed on this system\n", module);
+		break;
 	case PNP_UNABLE_TO_DETERMINE_DOCK_CAPABILITIES:
-	printk(KERN_ERR "PnPBIOS: %s: cannot determine the capabilities of the docking station\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: cannot determine the capabilities of the docking station\n", module);
+		break;
 	case PNP_CONFIG_CHANGE_FAILED_NO_BATTERY:
-	printk(KERN_ERR "PnPBIOS: %s: unable to undock, the system does not have a battery\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: unable to undock, the system does not have a battery\n", module);
+		break;
 	case PNP_CONFIG_CHANGE_FAILED_RESOURCE_CONFLICT:
-	printk(KERN_ERR "PnPBIOS: %s: could not dock due to resource conflicts\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: could not dock due to resource conflicts\n", module);
+		break;
 	case PNP_BUFFER_TOO_SMALL:
-	printk(KERN_ERR "PnPBIOS: %s: the buffer passed is too small\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: the buffer passed is too small\n", module);
+		break;
 	case PNP_USE_ESCD_SUPPORT:
-	printk(KERN_ERR "PnPBIOS: %s: use ESCD instead\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: use ESCD instead\n", module);
+		break;
 	case PNP_MESSAGE_NOT_SUPPORTED:
-	printk(KERN_ERR "PnPBIOS: %s: the message is unsupported\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: the message is unsupported\n", module);
+		break;
 	case PNP_HARDWARE_ERROR:
-	printk(KERN_ERR "PnPBIOS: %s: a hardware failure has occured\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: a hardware failure has occured\n", module);
+		break;
 	default:
-	printk(KERN_ERR "PnPBIOS: %s: unexpected status 0x%x\n", module, status);
+		printk(KERN_ERR "PnPBIOS: %s: unexpected status 0x%x\n", module, status);
+		break;
 	}
 }
 
