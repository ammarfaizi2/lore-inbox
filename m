Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965647AbWFYXNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965647AbWFYXNX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 19:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWFYXNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 19:13:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15379 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932415AbWFYXNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 19:13:23 -0400
Date: Mon, 26 Jun 2006 01:13:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/cs4232.c: fix section mismatch
Message-ID: <20060625231320.GJ23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

probe_cs4232() is called from the non-__init cs4232_pnp_probe().

bss is used in probe_cs4232().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/oss/cs4232.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm2-full/sound/oss/cs4232.c.old	2006-06-25 21:40:11.000000000 +0200
+++ linux-2.6.17-mm2-full/sound/oss/cs4232.c	2006-06-25 21:41:59.000000000 +0200
@@ -72,7 +72,7 @@
 #define CS_OUT2(a, b)		{CS_OUT(a);CS_OUT(b);}
 #define CS_OUT3(a, b, c)	{CS_OUT(a);CS_OUT(b);CS_OUT(c);}
 
-static int __initdata bss       = 0;
+static int bss       = 0;
 static int mpu_base, mpu_irq;
 static int synth_base, synth_irq;
 static int mpu_detected;
@@ -127,7 +127,7 @@
         outb(((unsigned char) (ENABLE_PINS | regd)), baseio + INDEX_DATA );
 }
 
-static int __init probe_cs4232(struct address_info *hw_config, int isapnp_configured)
+static int probe_cs4232(struct address_info *hw_config, int isapnp_configured)
 {
 	int i, n;
 	int base = hw_config->io_base, irq = hw_config->irq;

