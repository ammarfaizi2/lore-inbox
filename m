Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUFJPdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUFJPdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 11:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUFJPdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 11:33:43 -0400
Received: from witte.sonytel.be ([80.88.33.193]:48049 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261638AbUFJPdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 11:33:38 -0400
Date: Thu, 10 Jun 2004 17:33:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: ide-proc.c (was: Re: Linux 2.6.7-rc2)
In-Reply-To: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0406101709510.19315@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004, Linus Torvalds wrote:
> Summary of changes from v2.6.7-rc1 to v2.6.7-rc2
> ============================================
>
> Alexander Viro:
>   o sparse: ide-proc.c fixes

This change causes 2 warnings (`unused variables `val' and `reg') on m68k and
APUS.

However, the reason why this code was commented out on m68k and APUS is gone,
so it can be fixed like this:

--- linux-2.6.7-rc3/drivers/ide/ide-proc.c	2004-06-09 14:50:46.000000000 +0200
+++ linux-m68k-2.6.7-rc3/drivers/ide/ide-proc.c	2004-06-10 11:08:02.000000000 +0200
@@ -233,27 +233,6 @@ static int proc_ide_write_config(struct
 			}
 #endif	/* CONFIG_BLK_DEV_IDEPCI */
 		} else {	/* not pci */
-#if !defined(__mc68000__) && !defined(CONFIG_APUS)
-
-/*
-* Geert Uytterhoeven
-*
-* unless you can explain me what it really does.
-* On m68k, we don't have outw() and outl() yet,
-* and I need a good reason to implement it.
-*
-* BTW, IMHO the main remaining portability problem with the IDE driver
-* is that it mixes IO (ioport) and MMIO (iomem) access on different platforms.
-*
-* I think all accesses should be done using
-*
-*     ide_in[bwl](ide_device_instance, offset)
-*     ide_out[bwl](ide_device_instance, value, offset)
-*
-* so the architecture specific code can #define ide_{in,out}[bwl] to the
-* appropriate function.
-*
-*/
 			switch (r->size) {
 				case 1:	hwif->OUTB(val, reg);
 					break;
@@ -262,7 +241,6 @@ static int proc_ide_write_config(struct
 				case 4:	hwif->OUTL(val, reg);
 					break;
 			}
-#endif /* !__mc68000__ && !CONFIG_APUS */
 		}
 	}
 	spin_unlock_irqrestore(&ide_lock, flags);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
