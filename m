Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWA3SiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWA3SiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWA3SiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:38:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55493 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751290AbWA3SiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:38:12 -0500
Date: Mon, 30 Jan 2006 13:38:08 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Subject: fix saa7146 kobject register failure.
Message-ID: <20060130183808.GA14899@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops.

kobject_register failed for hexium HV-PCI6/Orion (-13)
[<c01d3eb6>] kobject_register+0x31/0x47
[<c023a996>] bus_add_driver+0x4a/0xfd
[<c01de3c1>] __pci_register_driver+0x82/0xa4
[<d083400a>] hexium_init_module+0xa/0x47 [hexium_orion]
[<c013bdae>] sys_init_module+0x167b/0x1822
[<c01633f7>] do_sync_read+0xb8/0xf3
[<c0133fa3>] autoremove_wake_function+0x0/0x2d
[<c0145390>] audit_syscall_entry+0x118/0x13f
[<c0106ae2>] do_syscall_trace+0x104/0x14a
[<c0103d21>] syscall_call+0x7/0xb

slashes in kobject names aren't allowed.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/drivers/media/video/hexium_orion.c~	2006-01-30 13:36:05.000000000 -0500
+++ linux-2.6.15.noarch/drivers/media/video/hexium_orion.c	2006-01-30 13:36:24.000000000 -0500
@@ -484,7 +484,7 @@ static struct saa7146_ext_vv vv_data = {
 };
 
 static struct saa7146_extension extension = {
-	.name = "hexium HV-PCI6/Orion",
+	.name = "hexium HV-PCI6 Orion",
 	.flags = 0,		// SAA7146_USE_I2C_IRQ,
 
 	.pci_tbl = &pci_tbl[0],
