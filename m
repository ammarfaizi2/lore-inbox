Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269934AbTGKMuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 08:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269936AbTGKMuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 08:50:18 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:45762 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269934AbTGKMuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 08:50:12 -0400
Date: Fri, 11 Jul 2003 15:03:18 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Paul Mackerras <paulus@samba.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre3
In-Reply-To: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0307111459300.8989-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jul 2003, Marcelo Tosatti wrote:
> Summary of changes from v2.4.22-pre2 to v2.4.22-pre3
> ============================================
> Benjamin Herrenschmidt <benh@kernel.crashing.org>:
>   o ppc32: Update adbhid driver

This change breaks the build for Mac/m68k (cfr. 2.5.x). The patch below cures
that, cfr. the similar so-far-unapplied patch for 2.5.x (it's CONFIG_ALL_PPC in
2.4.x and CONFIG_PPC_PMAC in 2.5.x, right)?

--snip--

ADB HID: Exclude PowerMac-specific things on classic Macs

--- linux-2.4.x/drivers/macintosh/adbhid.c	Tue Jul  8 13:30:28 2003
+++ linux-m68k-2.4.x/drivers/macintosh/adbhid.c	Fri Jul 11 14:39:56 2003
@@ -44,7 +44,9 @@
 #include <linux/pmu.h>
 
 #include <asm/machdep.h>
+#ifdef CONFIG_ALL_PPC
 #include <asm/pmac_feature.h>
+#endif
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
@@ -158,6 +160,7 @@
 		return;
 	case 0x3f: /* ignore Powerbook Fn key */
 		return;
+#ifdef CONFIG_ALL_PPC
 	case 0x7e: /* Power key on PBook 3400 needs remapping */
 		switch(pmac_call_feature(PMAC_FTR_GET_MB_INFO,
 			NULL, PMAC_MB_INFO_MODEL, 0)) {
@@ -167,6 +170,7 @@
 			keycode = 0x7f;
 		}
 		break;
+#endif /* CONFIG_ALL_PPC */
 	}
 
 	if (adbhid[id]->keycode[keycode])

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

