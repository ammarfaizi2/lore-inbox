Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275938AbSIUUMh>; Sat, 21 Sep 2002 16:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275939AbSIUUMh>; Sat, 21 Sep 2002 16:12:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46327 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S275938AbSIUUMf>; Sat, 21 Sep 2002 16:12:35 -0400
Date: Sat, 21 Sep 2002 22:17:36 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: James Simmons <jsimmons@infradead.org>
cc: Burton Samograd <kruhft@kruhft.dyndns.org>, <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] fix .text.exit error in tdfxfb.c
Message-ID: <Pine.NEB.4.44.0209212214010.10334-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Burton Samograd reported a .text.exit error at the final linking in
2.5.37. The problem is that tdfxfb_remove is __devexit but the pointer to
the function didn't use __devexit_p. The following patch fixes it:


--- linux-2.5.37/drivers/video/tdfxfb.c.old	2002-09-21 22:06:55.000000000 +0200
+++ linux-2.5.37/drivers/video/tdfxfb.c	2002-09-21 22:07:47.000000000 +0200
@@ -146,7 +146,7 @@
 	.name =		"tdfxfb",
 	.id_table =	tdfxfb_id_table,
 	.probe =	tdfxfb_probe,
-	.remove =	tdfxfb_remove,
+	.remove =	__devexit_p(tdfxfb_remove),
 };

 MODULE_DEVICE_TABLE(pci, tdfxfb_id_table);


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


