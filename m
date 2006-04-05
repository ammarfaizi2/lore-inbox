Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWDEAHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWDEAHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWDEABM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:01:12 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:19088
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750966AbWDEABD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:03 -0400
Date: Tue, 4 Apr 2006 17:00:20 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/26] opti9x - Fix compile without CONFIG_PNP
Message-ID: <20060405000020.GK27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="opti9x-fix-compile-without-config_pnp.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

Modules: Opti9xx drivers

Fix compile errors without CONFIG_PNP.

This patch was already included in Linus' tree.
 
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/isa/opti9xx/opti92x-ad1848.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.16.1.orig/sound/isa/opti9xx/opti92x-ad1848.c
+++ linux-2.6.16.1/sound/isa/opti9xx/opti92x-ad1848.c
@@ -2088,9 +2088,11 @@ static int __init alsa_card_opti9xx_init
 	int error;
 	struct platform_device *device;
 
+#ifdef CONFIG_PNP
 	pnp_register_card_driver(&opti9xx_pnpc_driver);
 	if (snd_opti9xx_pnp_is_probed)
 		return 0;
+#endif
 	if (! is_isapnp_selected()) {
 		error = platform_driver_register(&snd_opti9xx_driver);
 		if (error < 0)
@@ -2102,7 +2104,9 @@ static int __init alsa_card_opti9xx_init
 		}
 		platform_driver_unregister(&snd_opti9xx_driver);
 	}
+#ifdef CONFIG_PNP
 	pnp_unregister_card_driver(&opti9xx_pnpc_driver);
+#endif
 #ifdef MODULE
 	printk(KERN_ERR "no OPTi " CHIP_NAME " soundcard found\n");
 #endif
@@ -2115,7 +2119,9 @@ static void __exit alsa_card_opti9xx_exi
 		platform_device_unregister(snd_opti9xx_platform_device);
 		platform_driver_unregister(&snd_opti9xx_driver);
 	}
+#ifdef CONFIG_PNP
 	pnp_unregister_card_driver(&opti9xx_pnpc_driver);
+#endif
 }
 
 module_init(alsa_card_opti9xx_init)

--
