Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbRBMMrl>; Tue, 13 Feb 2001 07:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129577AbRBMMrd>; Tue, 13 Feb 2001 07:47:33 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:35594 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129536AbRBMMrV>; Tue, 13 Feb 2001 07:47:21 -0500
Date: Tue, 13 Feb 2001 06:47:13 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org
Subject: [PATCH] Via audio users please test...
In-Reply-To: <20010212134359.4905.qmail@inbox.net>
Message-ID: <Pine.LNX.3.96.1010213064044.31857C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Attached is a patch against 2.4.1-ac-XX which changes the initialization
of SigmaTel audio codecs.  All recent reports of "no sound at all" with
Via audio have been users with this codec.  With the Via audio driver,
you can find out if you have one of the problematic Sigmatel codecs like
so:

> [root@bivius via82cxxx-1.1.14]# cat /proc/driver/via/0/ac97 
> Vendor name      : SigmaTel STAC????
> Vendor id        : 8384 7600

I would greatly appreciate any testing of this patch by those users, to
let me know if this patch works...

Thanks,

	Jeff





Index: drivers/sound/ac97_codec.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/sound/ac97_codec.c,v
retrieving revision 1.1.1.15.2.1
diff -u -r1.1.1.15.2.1 ac97_codec.c
--- drivers/sound/ac97_codec.c	2001/02/09 23:52:28	1.1.1.15.2.1
+++ drivers/sound/ac97_codec.c	2001/02/13 12:37:32
@@ -103,7 +103,7 @@
 	{0x574D4C00, "Wolfson WM9704",		wolfson_init},
 	{0x574D4C03, "Wolfson WM9703/9704",	wolfson_init},
 	{0x574D4C04, "Wolfson WM9704 (quad)",	wolfson_init},
-	{0x83847600, "SigmaTel STAC????",	NULL},
+	{0x83847600, "SigmaTel STAC????",	sigmatel_9744_init},
 	{0x83847604, "SigmaTel STAC9701/3/4/5", NULL},
 	{0x83847605, "SigmaTel STAC9704",	NULL},
 	{0x83847608, "SigmaTel STAC9708",	sigmatel_9708_init},

