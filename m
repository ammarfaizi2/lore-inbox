Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289100AbSAVQk0>; Tue, 22 Jan 2002 11:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288814AbSAVQkR>; Tue, 22 Jan 2002 11:40:17 -0500
Received: from oker.escape.de ([194.120.234.254]:13856 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id <S288944AbSAVQkH>;
	Tue, 22 Jan 2002 11:40:07 -0500
To: lkml <linux-kernel@vger.kernel.org>, Fritz Elfert <fritz@isdn4linux.de>
Subject: PATCH: Undefined behavior in ISDN code
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 22 Jan 2002 17:39:04 +0100
Message-ID: <m2k7uamjbr.fsf@isnogud.escape.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've already sent this patch a couple of years ago.  Obviously, it got
lost, since the code in 2.4.17 still has the undefined behavior in it.

urs



diff -ru linux-2.4.17/drivers/isdn/isdn_audio.c linux/drivers/isdn/isdn_audio.c
--- linux-2.4.17/drivers/isdn/isdn_audio.c	Sat Dec 22 07:54:42 2001
+++ linux/drivers/isdn/isdn_audio.c	Tue Jan 22 16:31:53 2002
@@ -228,7 +228,7 @@
 	:	"memory", "ax");
 #else
 	while (n--)
-		*buff++ = table[*(unsigned char *)buff];
+		*buff = table[*(unsigned char *)buff], buff++;
 #endif
 }
 
