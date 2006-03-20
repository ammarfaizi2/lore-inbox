Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWCTP2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWCTP2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965324AbWCTP2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:28:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57272 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965323AbWCTP2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:28:36 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 071/141] V4L/DVB (3318c): fix saa7146 kobject register
	failure
Date: Mon, 20 Mar 2006 12:08:48 -0300
Message-id: <20060320150848.PS870631000071@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: 1139302155 -0200

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
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/hexium_orion.c b/drivers/media/video/hexium_orion.c
diff --git a/drivers/media/video/hexium_orion.c b/drivers/media/video/hexium_orion.c
index 0b6c209..aad4a18 100644
--- a/drivers/media/video/hexium_orion.c
+++ b/drivers/media/video/hexium_orion.c
@@ -484,7 +484,7 @@ static struct saa7146_ext_vv vv_data = {
 };
 
 static struct saa7146_extension extension = {
-	.name = "hexium HV-PCI6/Orion",
+	.name = "hexium HV-PCI6 Orion",
 	.flags = 0,		// SAA7146_USE_I2C_IRQ,
 
 	.pci_tbl = &pci_tbl[0],

