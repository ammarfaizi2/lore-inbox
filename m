Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbUJYEto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUJYEto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 00:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUJYEto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 00:49:44 -0400
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:23175 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261361AbUJYEth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 00:49:37 -0400
Date: Mon, 25 Oct 2004 00:51:08 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP Fixes for 2.6.10-rc1
Message-ID: <20041025045108.GD3989@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#   2004/10/24 23:07:32-04:00 ambx1@neo.rr.com
#   [PNPBIOS] disable if ACPI is active
#   
#   As further ACPI pnp functionaility is implemented it is no longer
#   safe to run ACPI and PNPBIOS concurrently.
#   
#   We therefore take the following approach:
#   - attempt to enable ACPI support
#   - if ACPI fails (blacklist etc.) enable pnpbios support
#   - if ACPI support is not compiled in the kernel enable pnpbios support
#   
#   Signed-off-by: Adam Belay <ambx1@neo.rr.com>

diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	2004-10-25 00:08:19 -04:00
+++ b/drivers/pnp/pnpbios/core.c	2004-10-25 00:08:19 -04:00
@@ -538,6 +538,12 @@
 		return -ENODEV;
 	}
 
+	if (!acpi_disabled) {
+		pnpbios_disabled = 1;
+		printk(KERN_INFO "PnPBIOS: Disabled by ACPI\n");
+		return -ENODEV;
+	}
+
 	/* scan the system for pnpbios support */
 	if (!pnpbios_probe_system())
 		return -ENODEV;
