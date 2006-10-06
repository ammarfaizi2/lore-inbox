Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWJFFfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWJFFfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWJFFfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:35:33 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:15030 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751360AbWJFFfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:35:32 -0400
Subject: [PATCH 1/9] sound/oss/btaudio.c: ioremap balanced with iounmap
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:08:52 +0530
Message-Id: <1160113132.19143.128.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only):
- using allmodconfig
- making sure the files are compiling without any warning/error due to
new changes

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
Forwarding to lkml as got no response from linux-sound
---
 btaudio.c |    2 ++
 1 files changed, 2 insertions(+)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/oss/btaudio.c linux-2.6.19-rc1/sound/oss/btaudio.c
--- linux-2.6.19-rc1-orig/sound/oss/btaudio.c	2006-09-21 10:15:52.000000000 +0530
+++ linux-2.6.19-rc1/sound/oss/btaudio.c	2006-10-05 15:21:32.000000000 +0530
@@ -1013,6 +1013,7 @@ static int __devinit btaudio_probe(struc
         return 0;
 
  fail4:
+	iounmap(bta->mmio);
 	unregister_sound_dsp(bta->dsp_analog);
  fail3:
 	if (digital)
@@ -1051,6 +1052,7 @@ static void __devexit btaudio_remove(str
         free_irq(bta->irq,bta);
 	release_mem_region(pci_resource_start(pci_dev,0),
 			   pci_resource_len(pci_dev,0));
+	iounmap(bta->mmio);
 
 	/* remove from linked list */
 	if (bta == btaudios) {


