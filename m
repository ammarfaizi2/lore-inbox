Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133031AbRDRQRL>; Wed, 18 Apr 2001 12:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135215AbRDRQRA>; Wed, 18 Apr 2001 12:17:00 -0400
Received: from ns.caldera.de ([212.34.180.1]:14089 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S133031AbRDRQQy>;
	Wed, 18 Apr 2001 12:16:54 -0400
Date: Wed, 18 Apr 2001 18:16:47 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pci enable nm256 audio
Message-ID: <20010418181647.A23776@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, linux-kernel,

Some of our customer reported a hang when modprobing nm256_audio, 
this patch should fix the problem.

Ciao, Marcus

Index: nm256_audio.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/nm256_audio.c,v
retrieving revision 1.1
diff -u -r1.1 nm256_audio.c
--- nm256_audio.c	2001/04/17 14:50:30	1.1
+++ nm256_audio.c	2001/04/18 16:13:38
@@ -1042,6 +1042,9 @@
     struct pm_dev *pmdev;
     int x;
 
+    if (pci_enable_device(pcidev))
+	    return 0;
+
     card = kmalloc (sizeof (struct nm256_info), GFP_KERNEL);
     if (card == NULL) {
 	printk (KERN_ERR "NM256: out of memory!\n");
