Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318057AbSGWNDD>; Tue, 23 Jul 2002 09:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSGWNDD>; Tue, 23 Jul 2002 09:03:03 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:41223 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S318057AbSGWNDC>; Tue, 23 Jul 2002 09:03:02 -0400
Subject: [PATCH] 2.4.18-rc3  Minor LDM fix
From: Richard Russon <rich@flatcap.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 23 Jul 2002 14:06:11 +0100
Message-Id: <1027429572.4258.1383.camel@whiskey.something.uk.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Please can you apply this minor patch to fs/partitions/ldm.c
(support for Windows Dynamic Disks)

Cheers,
  FlatCap (Rich)
  ldm@flatcap.org


Some people have problems reading the end of the LDM database
which is at the end of the physical disk.  This patch reduces
a couple of minor checks, to just debug output.


diff -urN linux-2.4.18-rc3/fs/partitions/ldm.c linux-2.4.18-rc3-ldm/fs/partitions/ldm.c
--- linux-2.4.18-rc3/fs/partitions/ldm.c	Tue Jul 23 13:19:23 2002
+++ linux-2.4.18-rc3-ldm/fs/partitions/ldm.c	Tue Jul 23 13:29:28 2002
@@ -796,7 +796,7 @@
 	err = parse_privhead(data, ph3);
 	put_dev_sector(sect);
 	if (err != 1)
-		goto out;
+		printk(LDM_DEBUG "Couldn't read the third PRIVHEAD.\n");
 	err = compare_privheads(ph1, ph2);
 	if (err != 1) {
 		printk(LDM_CRIT "First and second PRIVHEADs don't match.\n");
@@ -804,7 +804,7 @@
 	}
 	err = compare_privheads(ph1, ph3);
 	if (err != 1)
-		printk(LDM_CRIT "First and third PRIVHEADs don't match.\n");
+		printk(LDM_DEBUG "First and third PRIVHEADs don't match.\n");
 	else
 		/* We _could_ have checked more. */
 		ldm_debug("Validated PRIVHEADs successfully.\n");



