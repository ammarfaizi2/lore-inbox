Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbUJYEwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUJYEwJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 00:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUJYEwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 00:52:09 -0400
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:24711 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261376AbUJYEvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 00:51:51 -0400
Date: Mon, 25 Oct 2004 00:53:16 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.10-rc1
Message-ID: <20041025045316.GF3989@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20041025045108.GD3989@neo.rr.com> <20041025045221.GE3989@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025045221.GE3989@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#   2004/10/24 23:42:57-04:00 ambx1@neo.rr.com
#   [PNPBIOS] acpi compile fix
#   
#   Allow PNPBIOS to compile if ACPI support is not enabled.
#   
#   Signed-off-by: Adam Belay <ambx1@neo.rr.com>

diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	2004-10-25 00:08:09 -04:00
+++ b/drivers/pnp/pnpbios/core.c	2004-10-25 00:08:09 -04:00
@@ -538,11 +538,13 @@
 		return -ENODEV;
 	}
 
+#ifdef CONFIG_ACPI
 	if (!acpi_disabled) {
 		pnpbios_disabled = 1;
 		printk(KERN_INFO "PnPBIOS: Disabled by ACPI\n");
 		return -ENODEV;
 	}
+#endif /* CONFIG_ACPI */
 
 	/* scan the system for pnpbios support */
 	if (!pnpbios_probe_system())
