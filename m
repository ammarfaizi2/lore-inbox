Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUFFQG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUFFQG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUFFQG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:06:27 -0400
Received: from may.priocom.com ([213.156.65.50]:35324 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263766AbUFFQGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:06:13 -0400
Subject: [PATCH] 2.6.6 memory allocation checks in
	cs46xx_dsp_proc_register_scb_desc()
From: Yury Umanets <torque@ukrpost.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086537990.2793.68.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 19:06:42 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds memory allocation checks in cs46xx_dsp_proc_register_scb_desc()

 ./linux-2.6.6-modified/sound/pci/cs46xx/dsp_spos_scb_lib.c |    3 +++
 1 files changed, 3 insertions(+)

diff -rupN ./linux-2.6.6/sound/pci/cs46xx/dsp_spos_scb_lib.c
./linux-2.6.6-modified/sound/pci/cs46xx/dsp_spos_scb_lib.c
--- ./linux-2.6.6/sound/pci/cs46xx/dsp_spos_scb_lib.c	Mon May 10
05:33:20 2004
+++ ./linux-2.6.6-modified/sound/pci/cs46xx/dsp_spos_scb_lib.c	Wed Jun 
2 14:57:41 2004
@@ -246,6 +246,9 @@ void cs46xx_dsp_proc_register_scb_desc (
 		if ((entry = snd_info_create_card_entry(ins->snd_card, scb->scb_name,
 							ins->proc_dsp_dir)) != NULL) {
 			scb_info = kmalloc(sizeof(proc_scb_info_t), GFP_KERNEL);
+			if (!scb_info)
+				return;
+                                
 			scb_info->chip = chip;
 			scb_info->scb_desc = scb;
       



-- 
umka

