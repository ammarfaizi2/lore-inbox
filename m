Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUDOSpx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUDOSnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:43:14 -0400
Received: from witte.sonytel.be ([80.88.33.193]:3034 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263137AbUDOSkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:40:02 -0400
Date: Thu, 15 Apr 2004 20:39:07 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 427] Amiga Zorro8390 Ethernet section conflict
In-Reply-To: <407C16CA.6010503@pobox.com>
Message-ID: <Pine.GSO.4.58.0404152038360.10525@waterleaf.sonytel.be>
References: <200404130838.i3D8c6pa018442@callisto.of.borg> <407C16CA.6010503@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004, Jeff Garzik wrote:
> Geert Uytterhoeven wrote:
> > Zorro8390: const data cannot be in the init data section (from Roman Zippel)
>
> ACK, but this patch highlights a bug:
>
> one is __initdata:
>
> 	static const struct card_info {
> 	    zorro_id id;
> 	    const char *name;
> 	    unsigned int offset;
> 	} cards[] __initdata = {
>
> and the lone caller is __devinit:
>
> static int __devinit zorro8390_init_one(struct zorro_dev *z,
>                                        const struct zorro_device_id *ent)

You're right. Here's a fix:

--- linux-2.6.6-rc1/drivers/net/zorro8390.c	2004-04-15 11:44:14.000000000 +0200
+++ linux-m68k-2.6.6-rc1/drivers/net/zorro8390.c	2004-04-15 20:28:54.000000000 +0200
@@ -64,7 +64,7 @@
     zorro_id id;
     const char *name;
     unsigned int offset;
-} cards[] __initdata = {
+} cards[] __devinitdata = {
     { ZORRO_PROD_VILLAGE_TRONIC_ARIADNE2, "Ariadne II", 0x0600 },
     { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, "X-Surf", 0x8600 },
 };

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
