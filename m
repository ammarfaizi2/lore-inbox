Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWFZKbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWFZKbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 06:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWFZKbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 06:31:48 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38663 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932173AbWFZKbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 06:31:48 -0400
Date: Mon, 26 Jun 2006 12:31:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/hamradio/dmascc.c: fix section mismatch
Message-ID: <20060626103146.GP23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dev_setup() is using the __initdata variables ax25_broadcast and 
ax25_test.

Since the only caller of dev_setup() (setup_adapter()) is already 
__init, the solution is to make dev_setup() __init, too.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm2-full/drivers/net/hamradio/dmascc.c.old	2006-06-26 01:56:37.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/net/hamradio/dmascc.c	2006-06-26 01:56:55.000000000 +0200
@@ -436,7 +436,7 @@
 module_init(dmascc_init);
 module_exit(dmascc_exit);
 
-static void dev_setup(struct net_device *dev)
+static void __init dev_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_AX25;
 	dev->hard_header_len = AX25_MAX_HEADER_LEN;

