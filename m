Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbVIBVpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbVIBVpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbVIBVo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:44:59 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:20870 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1161060AbVIBVo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:44:59 -0400
Date: Fri, 2 Sep 2005 23:44:54 +0200
Message-Id: <200509022144.j82Lis1O031338@wscnet.wsc.cz>
In-reply-to: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Subject: [PATCH 3/6] include, sound: pci_find_device remove (s/pci/ali5451/ali5451.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, alsa-devel@alsa-project.org,
       perex@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Generated in 2.6.13-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 ali5451.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -326,13 +326,12 @@ static void ali_read_regs(ali_t *codec, 
 static void ali_read_cfg(unsigned int vendor, unsigned deviceid)
 {
 	unsigned int dwVal;
-	struct pci_dev *pci_dev = NULL;
+	struct pci_dev *pci_dev;
 	int i,j;
 
-
-        pci_dev = pci_find_device(vendor, deviceid, pci_dev);
-        if (pci_dev == NULL)
-                return ;
+	pci_dev = pci_get_device(vendor, deviceid, NULL);
+	if (pci_dev == NULL)
+		return ;
 
 	printk("\nM%x PCI CFG\n", deviceid);
 	printk("    ");
@@ -349,6 +348,7 @@ static void ali_read_cfg(unsigned int ve
 		}
 		printk("\n");
 	}
+	pci_dev_put(pci_dev);
  }
 static void ali_read_ac97regs(ali_t *codec, int secondary)
 {
@@ -2112,6 +2112,8 @@ static int snd_ali_free(ali_t * codec)
 #ifdef CONFIG_PM
 	kfree(codec->image);
 #endif
+	pci_dev_put(codec->pci_m1533);
+	pci_dev_put(codec->pci_m7101);
 	kfree(codec);
 	return 0;
 }
@@ -2301,7 +2303,7 @@ static int __devinit snd_ali_create(snd_
 	codec->chregs.data.ainten = 0x00;
 
 	/* M1533: southbridge */
-       	pci_dev = pci_find_device(0x10b9, 0x1533, NULL);
+	pci_dev = pci_get_device(0x10b9, 0x1533, NULL);
 	codec->pci_m1533 = pci_dev;
 	if (! codec->pci_m1533) {
 		snd_printk(KERN_ERR "ali5451: cannot find ALi 1533 chip.\n");
@@ -2309,7 +2311,7 @@ static int __devinit snd_ali_create(snd_
 		return -ENODEV;
 	}
 	/* M7101: power management */
-       	pci_dev = pci_find_device(0x10b9, 0x7101, NULL);
+	pci_dev = pci_get_device(0x10b9, 0x7101, NULL);
 	codec->pci_m7101 = pci_dev;
 	if (! codec->pci_m7101 && codec->revision == ALI_5451_V02) {
 		snd_printk(KERN_ERR "ali5451: cannot find ALi 7101 chip.\n");
