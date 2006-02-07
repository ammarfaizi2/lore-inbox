Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWBGPmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWBGPmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWBGPlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:41:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23234 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751123AbWBGPlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:41:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 14/16] fix saa7146 kobject register failure
Date: Tue, 07 Feb 2006 13:33:34 -0200
Message-id: <20060207153334.PS23095400014@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>

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

 drivers/media/video/hexium_orion.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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

