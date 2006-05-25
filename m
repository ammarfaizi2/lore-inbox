Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWEYB1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWEYB1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWEYB1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:27:11 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31374 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964825AbWEYB1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:27:04 -0400
Message-Id: <20060525003420.147932000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:44 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] atyfb_base compile fix for CONFIG_PCI=n
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The atyfb_driver structure is only available if CONFIG_PCI is set.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 drivers/video/aty/atyfb_base.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6-mm/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6-mm.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6-mm/drivers/video/aty/atyfb_base.c
@@ -3861,7 +3861,9 @@ static int __init atyfb_init(void)
     atyfb_setup(option);
 #endif
 
+#ifdef CONFIG_PCI
     pci_register_driver(&atyfb_driver);
+#endif
 #ifdef CONFIG_ATARI
     atyfb_atari_probe();
 #endif
@@ -3870,7 +3872,9 @@ static int __init atyfb_init(void)
 
 static void __exit atyfb_exit(void)
 {
+#ifdef CONFIG_PCI
 	pci_unregister_driver(&atyfb_driver);
+#endif
 }
 
 module_init(atyfb_init);

--

