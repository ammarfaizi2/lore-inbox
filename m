Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264163AbTCXMAH>; Mon, 24 Mar 2003 07:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264166AbTCXMAH>; Mon, 24 Mar 2003 07:00:07 -0500
Received: from exzh001.alcatel.ch ([212.243.156.171]:36869 "HELO
	exzh001.alcatel.ch") by vger.kernel.org with SMTP
	id <S264163AbTCXMAE> convert rfc822-to-8bit; Mon, 24 Mar 2003 07:00:04 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jaroslav Kysela <perex@suse.cz>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] fix memleak in sound/isa/als100.c
Date: Mon, 24 Mar 2003 13:11:04 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303241311.04325.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a one-liner to fix a mem leak on error path. against 2.5.65-bk.
please include in next ALSA update.

rgds
-daniel


===== sound/isa/als100.c 1.9 vs edited =====
--- 1.9/sound/isa/als100.c	Mon Mar 10 00:44:14 2003
+++ edited/sound/isa/als100.c	Mon Mar 24 13:03:56 2003
@@ -151,6 +151,7 @@
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
+		kfree(cfg);
 		return err;
 	}
 	port[dev] = pnp_port_start(pdev, 0);

