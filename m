Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbTBLGTQ>; Wed, 12 Feb 2003 01:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbTBLGTQ>; Wed, 12 Feb 2003 01:19:16 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24076
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266936AbTBLGTO>; Wed, 12 Feb 2003 01:19:14 -0500
Subject: [patch] used but uninitialized variable in ac97_codec
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1045031351.786.92.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 12 Feb 2003 01:29:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell, nothing initializes `err' prior to the
snd_printk() that uses it.  It is used later on, however.

So just do not print it out here.

Patch is against 2.5.60.

	Robert Love

 sound/pci/ac97/ac97_codec.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.5.60/sound/pci/ac97/ac97_codec.c linux/sound/pci/ac97/ac97_codec.c
--- linux-2.5.60/sound/pci/ac97/ac97_codec.c	2003-02-10 13:38:19.000000000 -0500
+++ linux/sound/pci/ac97/ac97_codec.c	2003-02-12 00:46:51.000000000 -0500
@@ -1887,7 +1887,7 @@
 		udelay(50);
 		if (ac97_reset_wait(ac97, HZ/2, 0) < 0 &&
 		    ac97_reset_wait(ac97, HZ/2, 1) < 0) {
-			snd_printk("AC'97 %d:%d does not respond - RESET [REC_GAIN = 0x%x]\n", ac97->num, ac97->addr, err);
+			snd_printk("AC'97 %d:%d does not respond - RESET\n", ac97->num, ac97->addr);
 			snd_ac97_free(ac97);
 			return -ENXIO;
 		}



