Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129992AbQLSMdC>; Tue, 19 Dec 2000 07:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbQLSMcx>; Tue, 19 Dec 2000 07:32:53 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:3061 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129573AbQLSMcm>;
	Tue, 19 Dec 2000 07:32:42 -0500
Date: Tue, 19 Dec 2000 13:01:48 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200012191201.NAA02004@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] fix emu10k1 init breakage in 2.2.18
Cc: aheitner@andrew.cmu.edu, juri.haberland@innominate.com,
        linux-kernel@vger.kernel.org, rsousa@grad.physics.sunysb.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

2.2.18 broke the emu10k1 driver when compiled into the kernel.
The problem is that 2.2.18 now implements 2.4-style module_init,
so emu10k1 ended up being initialised twice when built non-modular,
which rendered it dysfunctional. The fix is to remove the now
obsolete explicit init calls. Patch below. Please apply.

/Mikael

--- linux-2.2.19pre2/drivers/sound/emu10k1/main.c.~1~	Mon Dec 11 22:10:15 2000
+++ linux-2.2.19pre2/drivers/sound/emu10k1/main.c	Tue Dec 19 12:28:33 2000
@@ -784,10 +784,3 @@
 
 module_init(emu10k1_init_module);
 module_exit(emu10k1_cleanup_module);
-
-#ifndef MODULE
-int __init init_emu10k1(void)
-{
-        return emu10k1_init_module();
-}
-#endif
--- linux-2.2.19pre2/drivers/sound/sound_core.c.~1~	Mon Dec 11 22:10:15 2000
+++ linux-2.2.19pre2/drivers/sound/sound_core.c	Tue Dec 19 12:28:20 2000
@@ -63,7 +63,6 @@
 extern int init_solo1(void);
 extern int init_ymf7xxsb_module(void);
 extern int cs_probe(void);
-extern int init_emu10k1(void);
 extern int cs4281_probe(void);
 extern void init_vwsnd(void);
 extern int ymf_probe(void);
@@ -434,9 +433,6 @@
 #endif
 #ifdef CONFIG_SOUND_CS4281
 	cs4281_probe();
-#endif
-#ifdef CONFIG_SOUND_EMU10K1
-	init_emu10k1();
 #endif
 #ifdef CONFIG_SOUND_YMFPCI
 	ymf_probe();
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
