Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbSK1Ttg>; Thu, 28 Nov 2002 14:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbSK1Ttg>; Thu, 28 Nov 2002 14:49:36 -0500
Received: from [213.171.53.133] ([213.171.53.133]:17157 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S266716AbSK1Ttf>;
	Thu, 28 Nov 2002 14:49:35 -0500
Date: Thu, 28 Nov 2002 22:57:01 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <15801829670.20021128225701@wr.miee.ru>
To: perex@suse.cz
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA with CONFIG_SND_SB16_CSP compiling problems in 2.5.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I think it's just typing error.

--- sound/isa/sb/sb16.c.orig    Thu Nov 28 21:54:22 2002
+++ sound/isa/sb/sb16.c Thu Nov 28 21:55:23 2002
@@ -502,7 +502,7 @@

 #ifdef CONFIG_SND_SB16_CSP
        /* CSP chip on SB16ASP/AWE32 */
-       if ((chip->hardware == SB_HW_16) && csp[dev]) {
+       if ((chip->hardware == SB_HW_16CSP) && csp[dev]) {
                snd_sb_csp_new(chip, synth != NULL ? 1 : 0, &xcsp);
                if (xcsp) {
                        chip->csp = xcsp->private_data;

And here is problem with CONFIG_SND_SB16_CSP turned on,
I think it must be something like this

--- sound/isa/sb/sb16.c.orig    Thu Nov 28 22:28:07 2002
+++ sound/isa/sb/sb16.c Thu Nov 28 22:51:48 2002
@@ -664,7 +664,6 @@
 {
        static unsigned __initdata nr_dev = 0;
        int __attribute__ ((__unused__)) pnp = INT_MAX;
-       int __attribute__ ((__unused__)) csp = INT_MAX;

        if (nr_dev >= SNDRV_CARDS)
                return 0;
@@ -692,10 +691,6 @@
 #ifdef __ISAPNP__
        if (pnp != INT_MAX)
                isapnp[nr_dev] = pnp;
-#endif
-#ifdef CONFIG_SND_SB16_CSP
-       if (csp != INT_MAX)
-               csp[nr_dev] = csp;
 #endif
        nr_dev++;
        return 1;
I can mistake.
Best regards.
             Ruslan

