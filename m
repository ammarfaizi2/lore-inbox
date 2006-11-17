Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424775AbWKQFmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424775AbWKQFmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424773AbWKQFmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:42:07 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:29055 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1424770AbWKQFlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:41:50 -0500
Date: Thu, 16 Nov 2006 21:40:54 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: perex@suse.cz
Subject: [PATCH -mm] korg1212: fix printk format warning
Message-Id: <20061116214054.427c713a.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix printk format warning:
sound/pci/korg1212/korg1212.c:2359: warning: format '%d' expects type 'int', but 
argument 4 has type 'size_t'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 sound/pci/korg1212/korg1212.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-rc5mm2.orig/sound/pci/korg1212/korg1212.c
+++ linux-2619-rc5mm2/sound/pci/korg1212/korg1212.c
@@ -2356,7 +2356,7 @@ static int __devinit snd_korg1212_create
 
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				dsp_code->size, &korg1212->dma_dsp) < 0) {
-		snd_printk(KERN_ERR "korg1212: can not allocate dsp code memory (%d bytes)\n", dsp_code->size);
+		snd_printk(KERN_ERR "korg1212: cannot allocate dsp code memory (%zd bytes)\n", dsp_code->size);
                 snd_korg1212_free(korg1212);
 #ifdef FIRMWARE_IN_THE_KERNEL
 		if (dsp_code != &static_dsp_code)


---
