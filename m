Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261871AbTCYWBA>; Tue, 25 Mar 2003 17:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261625AbTCYWA7>; Tue, 25 Mar 2003 17:00:59 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:55561 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S261461AbTCYWAi> convert rfc822-to-8bit;
	Tue, 25 Mar 2003 17:00:38 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.5] fix OSS cs4232 linking when compiled-in
Date: Tue, 25 Mar 2003 23:11:32 +0100
User-Agent: KMail/1.4.3
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, bwindle-kbt@fint.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303252311.32261.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

this patch fixes the linking of sound/oss/cs4232.c.
unload_cs4232 can't be __exit since it's called from cs_4232_pnp_remove
which isn't __exit.

against 2.5.66-bk. please apply.
[fixes bugzilla.kernel.org #499]

rgds
-daniel


===== sound/oss/cs4232.c 1.10 vs edited =====
--- 1.10/sound/oss/cs4232.c	Wed Feb 26 11:52:04 2003
+++ edited/sound/oss/cs4232.c	Tue Mar 25 22:55:07 2003
@@ -313,7 +313,7 @@
 	}
 }
 
-static void __exit unload_cs4232(struct address_info *hw_config)
+static void unload_cs4232(struct address_info *hw_config)
 {
 	int base = hw_config->io_base, irq = hw_config->irq;
 	int dma1 = hw_config->dma, dma2 = hw_config->dma2;

