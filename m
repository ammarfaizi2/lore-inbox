Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbTHWXsh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 19:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTHWXsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 19:48:37 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:54798 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263348AbTHWXsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 19:48:31 -0400
Date: Sun, 24 Aug 2003 09:33:23 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [AMD76X]
Message-ID: <20030823233323.GA7989@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

amd76x_pm.c will crash if no chipsets are found and CONFIG_HOTPLUG is
turned on.  This patch makes it return with a failure instead.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.4/drivers/char/amd76x_pm.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/char/amd76x_pm.c,v
retrieving revision 1.2
diff -u -r1.2 amd76x_pm.c
--- kernel-source-2.4/drivers/char/amd76x_pm.c	1 Dec 2002 05:52:05 -0000	1.2
+++ kernel-source-2.4/drivers/char/amd76x_pm.c	23 Aug 2003 23:30:11 -0000
@@ -577,16 +577,18 @@
 	int found;
 
 	/* Find northbridge */
-	found = pci_module_init(&amd_nb_driver);
-	if (found < 0) {
+	found = pci_register_driver(&amd_nb_driver);
+	if (found <= 0) {
 		printk(KERN_ERR "amd76x_pm: Could not find northbridge\n");
+		pci_unregister_driver(&amd_nb_driver);
 		return 1;
 	}
 
 	/* Find southbridge */
-	found = pci_module_init(&amd_sb_driver);
-	if (found < 0) {
+	found = pci_register_driver(&amd_sb_driver);
+	if (found <= 0) {
 		printk(KERN_ERR "amd76x_pm: Could not find southbridge\n");
+		pci_unregister_driver(&amd_sb_driver);
 		pci_unregister_driver(&amd_nb_driver);
 		return 1;
 	}

--zhXaljGHf11kAtnf--
