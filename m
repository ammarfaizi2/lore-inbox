Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSLAEeX>; Sat, 30 Nov 2002 23:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSLAEeX>; Sat, 30 Nov 2002 23:34:23 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:23816 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S261433AbSLAEeW>; Sat, 30 Nov 2002 23:34:22 -0500
Date: Sun, 1 Dec 2002 15:40:19 +1100
To: vojtech@suse.cz
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4 double PCI unregistration with pcigame
Message-ID: <20021201044019.GA965@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

pcigame.c calls pci_unregister_driver() a second time when it is unloaded
without finding any devices.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/char/joystick/pcigame.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/char/joystick/pcigame.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 pcigame.c
--- drivers/char/joystick/pcigame.c	28 Nov 2002 23:53:12 -0000	1.1.1.7
+++ drivers/char/joystick/pcigame.c	1 Dec 2002 02:32:08 -0000
@@ -195,7 +195,7 @@
 
 int __init pcigame_init(void)
 {
-	pci_module_init(&pcigame_driver);
+	pci_register_driver(&pcigame_driver);
 	/* Needed by other modules */
 	return 0;
 }

--vkogqOf2sHV7VnPd--
