Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTEZEil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTEZEil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:38:41 -0400
Received: from dsl092-235-044.phl1.dsl.speakeasy.net ([66.92.235.44]:21120
	"EHLO grover.chaseplanet.us") by vger.kernel.org with ESMTP
	id S263824AbTEZEik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:38:40 -0400
Date: Mon, 26 May 2003 00:50:39 -0400
Message-Id: <200305260450.h4Q4odMt006006@grover.chaseplanet.us>
From: "David J. Chase" <david@chaseplanet.us>
To: linux-kernel@vger.kernel.org
Subject: 810_audio.c
Reply-to: david@chaseplanet.us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I could not use the built in ADI 1885 Audio on my Dell 4550, and after a great
deal of Googling, I found this single reference to the error I got (kernel
2.4.20, Slackware 9.0).  I tried it, and it worked.  If it is not in the current
kernels, I hope it will be.  I include the only e-mail archive reference I could
find.  I hope this helps.

David Chase
david@chaseplanet.us

--- from: http://www.cs.helsinki.fi/linux/linux-kernel/2002-30/0022.html ---

[PATCH] 2.4.19-rc3, i810_audio: ignoring ready status of ICH for
Mirko D?lle (mdoelle@linux-user.de)
Sun, 28 Jul 2002 05:00:06 +0200 (CEST)

    * Messages sorted by: [ date ][ thread ][ subject ][ author ]
    * Next message: Rusty Russell: "Re: [patch] scheduler, migration startup fixes, 2.5.29"
* Previous message: Timothy Murphy: "kernel-2.5.29"

Hello,

this patch for Kernel 2.4.19-rc3 removes the "break" that aborted the module
init of i810_audio.o in case of "not ready" status before probing (line
2656-2663).
On my Epox 4G4A+ mainboard with i845G chipset the ready status was always "0",
so the module could not be loaded. After removing the "break" in line 2663
the module works great: loading, playing serveral MP3s, removing and reloading
were no problem.

Perhaps someone can confirm this so the break could perhaps be removed in the
final Kernel 2.4.19.

diff -ru linux-2.4.19-rc3.orig/drivers/sound/i810_audio.c linux-2.4.19-rc3.patched/drivers/sound/i810_audio.c
--- linux-2.4.19-rc3.orig/drivers/sound/i810_audio.c Sun Jul 28 05:54:54 2002
+++ linux-2.4.19-rc3.patched/drivers/sound/i810_audio.c Sun Jul 28 06:06:06 2002
@@ -2660,7 +2660,10 @@
if (!i810_ac97_exists(card,num_ac97)) {
if(num_ac97 == 0)
printk(KERN_ERR "i810_audio: Primary codec not ready.\n");
- break; /* I think this works, if not ready stop */
+ /* Hack by dg2fer: On my Epox 4G4A+ with i845G we should just */
+ /* continue probing and *not* break. The status is always "not */
+ /* ready" but afterwards it works great. So I removed the break. */
+ /* break; */ /* I think this works, if not ready stop */
}

if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL)

With best regards,
Sincerely,
Mirko, dg2fer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.tux.org/lkml/

    * Next message: Rusty Russell: "Re: [patch] scheduler, migration startup fixes, 2.5.29"
* Previous message: Timothy Murphy: "kernel-2.5.29"

