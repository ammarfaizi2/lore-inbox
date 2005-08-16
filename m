Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbVHPLW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbVHPLW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 07:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVHPLW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 07:22:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2962 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932637AbVHPLW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 07:22:56 -0400
Date: Tue, 16 Aug 2005 13:22:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: [patch] Cleanups/debugging fixes in pcmcia/soc_common.c
Message-ID: <20050816112254.GA2630@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes debugging in soc_common.c (vprintk, not printk may be used
at that point), makes "no cpufreq" hooks a little bit safer and fixes
whitespace a tiny bit. Please apply,
								Pavel

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -66,7 +67,7 @@ void soc_pcmcia_debug(struct soc_pcmcia_
 	if (pc_debug > lvl) {
 		printk(KERN_DEBUG "skt%u: %s: ", skt->nr, func);
 		va_start(args, fmt);
-		printk(fmt, args);
+		vprintk(fmt, args);
 		va_end(args);
 	}
 }
@@ -655,8 +656,8 @@ static void soc_pcmcia_cpufreq_unregiste
 }
 
 #else
-#define soc_pcmcia_cpufreq_register()
-#define soc_pcmcia_cpufreq_unregister()
+static int soc_pcmcia_cpufreq_register(void) { return 0; }
+static void soc_pcmcia_cpufreq_unregister(void) {}
 #endif
 
 int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops, int first, int nr)
@@ -738,7 +739,7 @@ int soc_common_drv_pcmcia_probe(struct d
 			goto out_err_5;
 		}
 
-		if ( list_empty(&soc_pcmcia_sockets) )
+		if (list_empty(&soc_pcmcia_sockets))
 			soc_pcmcia_cpufreq_register();
 
 		list_add(&skt->node, &soc_pcmcia_sockets);

-- 
if you have sharp zaurus hardware you don't need... you know my address
