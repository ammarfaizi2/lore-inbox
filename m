Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272227AbTG3V16 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272259AbTG3V15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:27:57 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:56969 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S272227AbTG3V1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:27:34 -0400
Date: Wed, 30 Jul 2003 23:27:18 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Joe Thornber <thornber@sistina.com>, Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: dm: v4 ioctl interface (was: Re: Linux v2.6.0-test2)
In-Reply-To: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
Message-ID: <Pine.GSO.4.21.0307302314370.29569-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003, Linus Torvalds wrote:
> Summary of changes from v2.6.0-test1 to v2.6.0-test2
> ============================================
> 
> Andrew Morton:
>   o dm: v4 ioctl interface

This interface code contains a local `resume()' routine, which conflicts with
the `resume()' defined by many architectures in <asm/*.h>. The patch below
fixes this by renaming the local routine to `do_resume()'.

However, after this change it still doesn't compile...

--- linux-2.6.0-test2/drivers/md/dm-ioctl-v4.c.orig	Tue Jul 29 23:23:17 2003
+++ linux-2.6.0-test2/drivers/md/dm-ioctl-v4.c	Wed Jul 30 23:17:16 2003
@@ -613,7 +613,7 @@
 	return r;
 }
 
-static int resume(struct dm_ioctl *param)
+static int do_resume(struct dm_ioctl *param)
 {
 	int r = 0;
 	struct hash_cell *hc;
@@ -678,7 +678,7 @@
 	if (param->flags & DM_SUSPEND_FLAG)
 		return suspend(param);
 
-	return resume(param);
+	return do_resume(param);
 }
 
 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


