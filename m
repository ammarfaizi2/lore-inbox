Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269260AbUJKVbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269260AbUJKVbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUJKVbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:31:13 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:6228 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S269260AbUJKVbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:31:07 -0400
Date: Mon, 11 Oct 2004 23:30:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Antonino Daplas <adaplas@pol.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] FrameMaster II build fix (was: Re: Linux 2.6.9-rc2)
In-Reply-To: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410112328340.11223@anakin>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Linus Torvalds wrote:
> Summary of changes from v2.6.9-rc1 to v2.6.9-rc2
> ============================================
> 
> Antonino Daplas:
>   o fbdev: Add module_init() and fb_get_options() per driver

To: linus, akpm
Cc: lkml
Subject: [PATCH] FrameMaster II build fix

fm2fb: Trivial fix for the breakage introduced by the addition of
fb_get_options() in 2.6.9-rc2.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc4/drivers/video/fm2fb.c	2004-09-30 12:53:50.000000000 +0200
+++ linux-m68k-2.6.9-rc4/drivers/video/fm2fb.c	2004-10-11 23:06:38.000000000 +0200
@@ -292,18 +292,7 @@ static int __devinit fm2fb_probe(struct 
 	return 0;
 }
 
-int __init fm2fb_setup(char *options);
-
-int __init fm2fb_init(void)
-{
-	char *option = NULL;
-
-	if (fb_get_options("fm2fb", &option))
-		return -ENODEV;
-	fm2fb_setup(option);
-	return zorro_register_driver(&fm2fb_driver);
-}
-
+int __init fm2fb_setup(char *options)
 {
 	char *this_opt;
 
@@ -319,5 +308,15 @@ int __init fm2fb_init(void)
 	return 0;
 }
 
+int __init fm2fb_init(void)
+{
+	char *option = NULL;
+
+	if (fb_get_options("fm2fb", &option))
+		return -ENODEV;
+	fm2fb_setup(option);
+	return zorro_register_driver(&fm2fb_driver);
+}
+
 module_init(fm2fb_init);
 MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
